from django.db.models import Sum

from .models import Categories, Wishlist, CartItem, Customer


def store_context(request):
    """Makes categories, cart/wishlist counts, and the logged-in customer
    available in every template."""
    customer_id = request.session.get('customer_id')
    customer = Customer.objects.filter(pk=customer_id).first() if customer_id else None

    cart_count = 0
    wishlist_count = 0
    wishlist_product_ids = set()

    if customer:
        cart_count = CartItem.objects.filter(customer=customer).aggregate(
            total=Sum('quantity')
        )['total'] or 0

        wishlist_product_ids = set(
            Wishlist.objects.filter(customer=customer).values_list('productid_id', flat=True)
        )
        wishlist_count = len(wishlist_product_ids)

    return {
        'nav_categories': Categories.objects.all(),
        'cart_count': cart_count,
        'wishlist_count': wishlist_count,
        'wishlist_product_ids': wishlist_product_ids,
        'logged_in_customer': customer,
    }
