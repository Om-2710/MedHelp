import json
import random
from datetime import timedelta

from django.contrib import messages
from django.contrib.auth.hashers import make_password, check_password
from django.core.mail import send_mail
from django.conf import Settings
from django.db.models import Sum, Count, Q, Avg
from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse
from django.utils import timezone

from .models import Products, Categories, ProductVariant, Reviews, Wishlist, Customer, CartItem, Orders, OrderItem, Symptom

# ─────────────────────────── shared helpers ────────────────────────────────

def _get_logged_in_customer(request):
    customer_id = request.session.get('customer_id')
    if not customer_id:
        return None
    return Customer.objects.filter(pk=customer_id).first()


def _login_required_redirect(request):
    messages.error(request, 'Please log in to continue.')
    return redirect(f"{reverse('store:login')}?next={request.path}")


def _variant_label(variant):
    if not variant:
        return None
    parts = []
    if variant.quantity:
        parts.append(f"{variant.quantity} units")
    if variant.dosage_size:
        parts.append(f"{variant.dosage_size}mg")
    return ' / '.join(parts) or None


def _generate_otp():
    return str(random.randint(100000, 999999))


def _send_otp_email(customer, otp):
    send_mail(
        subject='Your MedHelp verification code',
        message=f'Your verification code is {otp}. It expires in 10 minutes.',
        from_email=Settings.DEFAULT_FROM_EMAIL,
        recipient_list=[customer.email],
        fail_silently=False,
    )


# ─────────────────────────── auth: signup / otp / login / logout ──────────

def signup_view(request):
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        email = request.POST.get('email', '').strip().lower()
        phone = request.POST.get('phone', '').strip()
        address = request.POST.get('address', '').strip()
        password = request.POST.get('password', '')
        confirm_password = request.POST.get('confirm_password', '')

        errors = []
        if not name or not email or not password:
            errors.append('Name, email, and password are required.')
        if password and password != confirm_password:
            errors.append('Passwords do not match.')
        if password and len(password) < 8:
            errors.append('Password must be at least 8 characters.')
        if email and Customer.objects.filter(email=email).exists():
            errors.append('An account with that email already exists.')

        if errors:
            for e in errors:
                messages.error(request, e)
            return render(request, 'store/signup.html', {
                'name': name, 'email': email, 'phone': phone, 'address': address,
            })

        customer = Customer.objects.create(
            customername=name,
            email=email,
            phonenumber=phone or None,
            address=address or None,
            password=make_password(password),
            is_verified=False,
        )

        otp = _generate_otp()
        customer.otp_code = otp
        customer.otp_expires_at = timezone.now() + timedelta(minutes=10)
        customer.save()

        try:
            _send_otp_email(customer, otp)
        except Exception:
            messages.error(request, 'Could not send the verification email. Check your SMTP settings, then use "Resend code."')

        request.session['pending_customer_id'] = customer.customerid
        messages.success(request, f'A verification code was sent to {customer.email}.')
        return redirect('store:verify_otp')

    return render(request, 'store/signup.html')


def verify_otp_view(request):
    customer_id = request.session.get('pending_customer_id')
    if not customer_id:
        messages.error(request, 'Please sign up or log in first.')
        return redirect('store:signup')

    customer = get_object_or_404(Customer, pk=customer_id)

    if request.method == 'POST':
        if 'resend' in request.POST:
            otp = _generate_otp()
            customer.otp_code = otp
            customer.otp_expires_at = timezone.now() + timedelta(minutes=10)
            customer.save()
            try:
                _send_otp_email(customer, otp)
                messages.success(request, f'A new code was sent to {customer.email}.')
            except Exception:
                messages.error(request, 'Could not send the email. Check your SMTP settings in settings.py.')
            return redirect('store:verify_otp')

        entered = request.POST.get('otp', '').strip()
        if not customer.otp_code or not customer.otp_expires_at or timezone.now() > customer.otp_expires_at:
            messages.error(request, 'That code has expired. Please request a new one.')
        elif entered != customer.otp_code:
            messages.error(request, 'Incorrect code. Please try again.')
        else:
            customer.is_verified = True
            customer.otp_code = None
            customer.otp_expires_at = None
            customer.save()
            del request.session['pending_customer_id']
            request.session['customer_id'] = customer.customerid
            messages.success(request, f'Welcome, {customer.customername}!')
            return redirect('store:home')

    return render(request, 'store/verify_otp.html', {'email': customer.email})


def login_view(request):
    if request.method == 'POST':
        email = request.POST.get('email', '').strip().lower()
        password = request.POST.get('password', '')

        customer = Customer.objects.filter(email=email).first()

        if not customer or not customer.password or not check_password(password, customer.password):
            messages.error(request, 'Invalid email or password.')
            return render(request, 'store/login.html', {'email': email})

        if not customer.is_verified:
            otp = _generate_otp()
            customer.otp_code = otp
            customer.otp_expires_at = timezone.now() + timedelta(minutes=10)
            customer.save()
            try:
                _send_otp_email(customer, otp)
            except Exception:
                pass
            request.session['pending_customer_id'] = customer.customerid
            messages.info(request, 'Please verify your email first -- a new code was just sent.')
            return redirect('store:verify_otp')

        request.session['customer_id'] = customer.customerid
        messages.success(request, f'Welcome back, {customer.customername}!')
        next_url = request.POST.get('next') or request.GET.get('next') or 'store:home'
        return redirect(next_url)

    next_url = request.GET.get('next', '')
    return render(request, 'store/login.html', {'next': next_url})


def logout_view(request):
    request.session.pop('customer_id', None)
    messages.info(request, 'You have been logged out.')
    return redirect('store:home')


# ─────────────────────────── catalog pages ─────────────────────────────────

def home(request):
    products = Products.objects.all().order_by('-created_at')
    featured_products = products[:4]
    categories = Categories.objects.all()

    for c in categories:
        c.product_count = Products.objects.filter(catergoryid=c).count()

    return render(request, 'store/home.html', {
        'featured_products': featured_products,
        'all_products': products,
        'categories': categories,
    })


def product_list(request):
    query = request.GET.get('q', '').strip()
    products = Products.objects.all().order_by('-created_at')

    if query:
        products = products.filter(productname__icontains=query)

    return render(request, 'store/product_list.html', {
        'products': products,
        'query': query,
    })


def category_detail(request, pk):
    category = get_object_or_404(Categories, pk=pk)
    products = Products.objects.filter(catergoryid=category)
    category.product_count = products.count()

    sort = request.GET.get('sort', 'default')
    if sort == 'price-asc':
        products = products.order_by('price')
    elif sort == 'price-desc':
        products = products.order_by('-price')
    else:
        products = products.order_by('-created_at')

    return render(request, 'store/category_detail.html', {
        'category': category,
        'products': products,
        'sort': sort,
    })


from django.db.models import Avg, Count

def product_detail(request, pk):
    product = get_object_or_404(Products, pk=pk)
    variants_qs = product.variants.all().order_by('quantity', 'dosage_size')

    quantities = sorted({v.quantity for v in variants_qs if v.quantity})
    dosage_sizes = sorted({v.dosage_size for v in variants_qs if v.dosage_size})

    variants_data = []
    for v in variants_qs:
        image_url = None
        if v.photo:
            image_url = v.photo.url
        elif product.photo_path:
            image_url = product.photo_path.url

        variants_data.append({
            'id': v.id,
            'quantity': v.quantity,
            'dosage_size': v.dosage_size,
            'display_price': str(v.effective_price),
            'original_price': str(v.price) if v.has_discount else None,
            'stock': v.stock,
            'image': image_url,
        })

    default_variant = variants_qs.first()
    customer = _get_logged_in_customer(request)

    wishlisted_variant_ids = []
    wishlist_no_variant = False
    if customer:
        wishlisted_variant_ids = list(
            Wishlist.objects.filter(customer=customer, productid=product, variantid__isnull=False)
            .values_list('variantid_id', flat=True)
        )
        wishlist_no_variant = Wishlist.objects.filter(
            customer=customer, productid=product, variantid__isnull=True
        ).exists()

    if default_variant:
        is_wishlisted = default_variant.id in wishlisted_variant_ids
    else:
        is_wishlisted = wishlist_no_variant

    reviews_qs = product.reviews.select_related('customer').order_by('-created_at')
    rating_summary = reviews_qs.aggregate(avg_rating=Avg('rating'), count=Count('reviewid'))
    avg_rating = round(rating_summary['avg_rating'], 1) if rating_summary['avg_rating'] else None
    review_count = rating_summary['count']

    customer_review = None
    if customer:
        customer_review = reviews_qs.filter(customer=customer).first()

    if request.method == 'POST' and 'submit_review' in request.POST:
        if not customer:
            return _login_required_redirect(request)

        rating = request.POST.get('rating')
        review_text = request.POST.get('review_text', '').strip()

        if not rating or not (1 <= int(rating) <= 5):
            messages.error(request, 'Please select a star rating.')
        else:
            Reviews.objects.update_or_create(
                product=product, customer=customer,
                defaults={'rating': int(rating), 'review': review_text},
            )
            messages.success(request, 'Thanks for your review!')
        return redirect('store:product_detail', pk=pk)

    return render(request, 'store/product_detail.html', {
        'product': product,
        'variants': variants_qs,
        'quantities': quantities,
        'dosage_sizes': dosage_sizes,
        'variants_json': json.dumps(variants_data),
        'default_variant': default_variant,
        'wishlisted_variant_ids_json': json.dumps(wishlisted_variant_ids),
        'wishlist_no_variant': wishlist_no_variant,
        'is_wishlisted': is_wishlisted,
        'reviews': reviews_qs,
        'avg_rating': avg_rating,
        'review_count': review_count,
        'customer': customer,
        'customer_review': customer_review,
        'star_range': range(1, 6),
    })

from django.db.models import Avg, Count, Q

def compare_composition(request, composition):
    products = (
        Products.objects.filter(composition__iexact=composition)
        .select_related('sellerid')
        .annotate(avg_rating=Avg('reviews__rating'), review_count=Count('reviews'))
        .order_by('-avg_rating', 'price')
    )

    return render(request, 'store/compare_composition.html', {
        'composition': composition,
        'products': Products,
    })

def symptom_suggest(request):
    all_symptoms = Symptom.objects.all().order_by('name')
    selected_ids = request.GET.getlist('symptom')

    products = None
    if selected_ids:
        products = (
            Products.objects.filter(symptoms__id__in=selected_ids)
            .annotate(
                match_count=Count('symptoms', filter=Q(symptoms__id__in=selected_ids), distinct=True),
                avg_rating=Avg('reviews__rating', distinct=True),
                review_count=Count('reviews', distinct=True),
            )
            .distinct()
            .order_by('-match_count', '-avg_rating', 'productname')
        )

    return render(request, 'store/symptom_suggest.html', {
        'all_symptoms': all_symptoms,
        'selected_ids': [int(i) for i in selected_ids],
        'products': products,
    })

# ─────────────────────────── cart (DB-backed, requires login) ─────────────

def add_to_cart(request, pk):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    product = get_object_or_404(Products, pk=pk)

    variant_id = request.POST.get('variant_id') or None
    variant = None
    if variant_id:
        variant = get_object_or_404(ProductVariant, pk=variant_id, product=product)

    if product.variants.exists() and not variant:
        messages.error(request, 'Please select options before adding to cart.')
        next_url = request.POST.get('next') or reverse('store:product_detail', args=[pk])
        return redirect(next_url)

    try:
        qty = max(1, int(request.POST.get('quantity', 1)))
    except ValueError:
        qty = 1

    if variant and qty > variant.stock:
        qty = variant.stock

    item, created = CartItem.objects.get_or_create(
        customer=customer, product=product, variant=variant,
        defaults={'quantity': qty},
    )
    if not created:
        item.quantity += qty
        item.save()

    label = product.productname
    extra = _variant_label(variant)
    if extra:
        label += f" ({extra})"
    messages.success(request, f'Added "{label}" to your cart.')

    next_url = request.POST.get('next') or 'store:home'
    return redirect(next_url)


def cart_view(request):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    cart_items = CartItem.objects.filter(customer=customer).select_related('product', 'variant')
    items = []
    total = 0

    for ci in cart_items:
        if ci.variant:
            unit_price = ci.variant.effective_price
            image = ci.variant.photo if ci.variant.photo else ci.product.photo_path
            label_extra = _variant_label(ci.variant)
        else:
            if ci.product.discounted_prices and ci.product.discounted_prices < ci.product.price:
                unit_price = ci.product.discounted_prices
            else:
                unit_price = ci.product.price
            image = ci.product.photo_path
            label_extra = None

        subtotal = unit_price * ci.quantity
        total += subtotal
        items.append({
            'cart_item_id': ci.id,
            'product': ci.product,
            'variant': ci.variant,
            'label_extra': label_extra,
            'image': image,
            'qty': ci.quantity,
            'unit_price': unit_price,
            'subtotal': subtotal,
        })

    return render(request, 'store/cart.html', {'items': items, 'total': total})


def update_cart(request, cart_item_id):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    item = get_object_or_404(CartItem, pk=cart_item_id, customer=customer)
    try:
        qty = int(request.POST.get('quantity', 1))
    except ValueError:
        qty = 1

    if qty <= 0:
        item.delete()
    else:
        if item.variant and qty > item.variant.stock:
            qty = item.variant.stock
            messages.warning(request, f'Only {item.variant.stock} left in stock — quantity adjusted.')
        item.quantity = qty
        item.save()
    return redirect('store:cart')


def remove_from_cart(request, cart_item_id):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    CartItem.objects.filter(pk=cart_item_id, customer=customer).delete()
    return redirect('store:cart')


# ─────────────────────────── checkout (COD, requires login) ───────────────

def checkout_view(request):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    cart_items = CartItem.objects.filter(customer=customer).select_related('product', 'variant', 'product__sellerid')
    if not cart_items.exists():
        messages.error(request, 'Your cart is empty.')
        return redirect('store:cart')

    total = 0
    line_items = []
    for ci in cart_items:
        if ci.variant:
            unit_price = ci.variant.effective_price
        else:
            if ci.product.discounted_prices and ci.product.discounted_prices < ci.product.price:
                unit_price = ci.product.discounted_prices
            else:
                unit_price = ci.product.price
        subtotal = unit_price * ci.quantity
        total += subtotal
        line_items.append({'cart_item': ci, 'unit_price': unit_price, 'subtotal': subtotal})

    if request.method == 'POST':
        address = request.POST.get('address', '').strip() or customer.address

        order = Orders.objects.create(
            customer=customer,
            status='placed',
            total_amount=total,
            delivery_address=address,
        )

        for li in line_items:
            ci = li['cart_item']
            OrderItem.objects.create(
                order=order,
                product=ci.product,
                variant=ci.variant,
                seller=ci.product.sellerid,
                quantity=ci.quantity,
                unit_price=li['unit_price'],
            )

        cart_items.delete()

        messages.success(request, f'Order #{order.orderid} placed successfully! Pay on delivery.')
        return redirect('store:order_confirmation', order_id=order.orderid)

    return render(request, 'store/checkout.html', {
        'line_items': line_items,
        'total': total,
        'customer': customer,
    })


def order_confirmation(request, order_id):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    order = get_object_or_404(Orders, pk=order_id, customer=customer)
    return render(request, 'store/order_confirmation.html', {'order': order})


# ─────────────────────────── wishlist (requires login) ────────────────────

def wishlist_view(request):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    items = Wishlist.objects.filter(customer=customer).select_related('productid', 'variantid')
    return render(request, 'store/wishlist.html', {'items': items})


def add_to_wishlist(request, pk):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    product = get_object_or_404(Products, pk=pk)

    variantid = request.POST.get('variant_id') or None
    variant = None
    if variantid:
        variant = get_object_or_404(ProductVariant, pk=variantid, product=product)

    _, created = Wishlist.objects.get_or_create(
        customer=customer,
        productid=product,
        variantid=variant,
    )

    label = product.productname
    extra = _variant_label(variant)
    if extra:
        label += f" ({extra})"

    if created:
        messages.success(request, f'Added "{label}" to your wishlist.')
    else:
        messages.info(request, f'"{label}" is already in your wishlist.')

    next_url = request.POST.get('next') or request.GET.get('next') or 'store:home'
    return redirect(next_url)


def remove_from_wishlist(request, pk):
    customer = _get_logged_in_customer(request)
    if not customer:
        return _login_required_redirect(request)

    variant_id = request.POST.get('variant_id') or None
    qs = Wishlist.objects.filter(customer=customer, productid_id=pk)
    if variant_id:
        qs = qs.filter(variantid_id=variant_id)
    else:
        qs = qs.filter(variantid__isnull=True)
    qs.delete()

    next_url = request.POST.get('next') or request.GET.get('next') or 'store:wishlist'
    return redirect(next_url)

