from django.contrib import admin
from .models import (
    Admin, Customer,
    Orders, OrderItem, ProductSymptom, Reviews, Categories, Payments, Products, Refund, Sale, Seller, Shipment, Wishlist,
    ProductVariant,Symptom
)

admin.site.register(Admin)
admin.site.register(Customer)
admin.site.register(Reviews)
admin.site.register(Payments)
admin.site.register(Refund)
admin.site.register(Sale)
admin.site.register(Seller)
admin.site.register(Shipment)
admin.site.register(Wishlist)
admin.site.register(Categories)


class OrderItemInline(admin.TabularInline):
    model = OrderItem
    extra = 0
    fields = ('product', 'variant', 'seller', 'quantity', 'unit_price')
    readonly_fields = ('product', 'variant', 'seller', 'quantity', 'unit_price')
    can_delete = False


@admin.register(Orders)
class OrdersAdmin(admin.ModelAdmin):
    list_display = ('orderid', 'customer', 'status', 'total_amount', 'created_at')
    list_filter = ('status',)
    inlines = [OrderItemInline]


class ProductVariantInline(admin.TabularInline):
    model = ProductVariant
    extra = 1
    fields = ('quantity', 'dosage_size', 'price', 'discounted_price', 'stock', 'photo')


def _get_seller(request):
    try:
        return request.user.seller_profile
    except (Seller.DoesNotExist, AttributeError):
        return None

class ProductSymptomInline(admin.TabularInline):
    model = ProductSymptom
extra = 1

@admin.register(Products)
class ProductsAdmin(admin.ModelAdmin):
    list_display = ('productname', 'catergoryid', 'price', 'discounted_prices')
    filter_horizotal = ('Symptom',)
    inlines = [ProductVariantInline, ProductSymptomInline]

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        seller = _get_seller(request)
        if seller is None:
            return qs.none()
        return qs.filter(sellerid=seller)

    def save_model(self, request, obj, form, change):
        if not request.user.is_superuser and not change:
            seller = _get_seller(request)
            if seller:
                obj.sellerid = seller
        super().save_model(request, obj, form, change)

    def has_change_permission(self, request, obj=None):
        if obj is None or request.user.is_superuser:
            return True
        seller = _get_seller(request)
        return seller is not None and obj.sellerid_id == seller.sellerid

    def has_delete_permission(self, request, obj=None):
        return self.has_change_permission(request, obj)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and 'sellerid' in form.base_fields:
            form.base_fields['sellerid'].disabled = True
            form.base_fields['sellerid'].required = False
        return form

@admin.register(Symptom)
class SymptomAdmin(admin.ModelAdmin):
    list_display = ('name',)
    prepopulated_fields = {'slug': ('name',)}

