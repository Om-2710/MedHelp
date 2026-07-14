from django.db import models


class Admin(models.Model):
    adminid = models.IntegerField(primary_key=True)
    adminname = models.CharField(db_column='adminName', max_length=255, blank=True, null=True)
    adminnumber = models.IntegerField(db_column='adminNumber', blank=True, null=True)
    adminemail = models.CharField(db_column='adminEmail', max_length=255, blank=True, null=True)
    adminpwd = models.CharField(db_column='adminPwd', max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'admin'


class Categories(models.Model):
    catergoryid = models.IntegerField(db_column='catergoryId', primary_key=True)
    catergorytype = models.CharField(db_column='Catergorytype', max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'categories'


class Customer(models.Model):
    customername = models.CharField(db_column='CustomerName', max_length=255, blank=True, null=True)
    customerid = models.AutoField(db_column='customerId', primary_key=True)
    email = models.CharField(max_length=255, blank=True, null=True, unique=True)
    phonenumber = models.CharField(db_column='phoneNumber', max_length=255, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)

    password = models.CharField(max_length=255, blank=True, null=True)
    is_verified = models.BooleanField(default=False)
    otp_code = models.CharField(max_length=6, blank=True, null=True)
    otp_expires_at = models.DateTimeField(blank=True, null=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'customer'

    def __str__(self):
        return self.customername or self.email or f"Customer #{self.customerid}"


class Payments(models.Model):
    paymentid = models.IntegerField(db_column='paymentId', unique=True, blank=True, null=True)
    paymenttype = models.CharField(db_column='PaymentType', max_length=255, blank=True, null=True)
    transactionid = models.IntegerField(db_column='TransactionId', primary_key=True)
    orderid = models.IntegerField(db_column='OrderId', blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'payments'


class Products(models.Model):
    productid = models.AutoField(primary_key=True)
    productname = models.CharField(max_length=255)
    composition = models.CharField(max_length=255, blank=True, null=True)
    contraindications = models.TextField(blank=True, null=True)  # "Do not take if..."
    symptoms = models.ManyToManyField('Symptom', through='ProductSymptom', related_name='products')
    catergoryid = models.ForeignKey(Categories, models.DO_NOTHING, db_column='catergoryid', blank=True, null=True)
    sellerid = models.ForeignKey('Seller', models.DO_NOTHING, db_column='sellerid', blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    photo_path = models.ImageField(upload_to='products/')
    discounted_prices = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'products'


class ProductVariant(models.Model):
    product = models.ForeignKey(
        Products, on_delete=models.CASCADE, related_name='variants',
        db_column='product_id'
    )
    quantity = models.IntegerField(db_column='Quantity', blank=True, null=True)
    dosage_size = models.IntegerField(db_column='Dosage_size', blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    discounted_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    stock = models.PositiveIntegerField(default=0)
    photo = models.ImageField(upload_to='variants/', blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'product_variants'
        unique_together = ('product', 'quantity', 'dosage_size')

    def __str__(self):
        return f"{self.product.productname} - Variant #{self.pk}"

    @property
    def effective_price(self):
        if self.discounted_price and self.discounted_price < self.price:
            return self.discounted_price
        return self.price

    @property
    def has_discount(self):
        return bool(self.discounted_price and self.discounted_price < self.price)


class CartItem(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='cart_items')
    product = models.ForeignKey(Products, on_delete=models.CASCADE, related_name='in_carts')
    variant = models.ForeignKey(
        ProductVariant, on_delete=models.CASCADE, blank=True, null=True, related_name='in_carts'
    )
    quantity = models.PositiveIntegerField(default=1)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'cart_items'
        unique_together = ('customer', 'product', 'variant')

    def __str__(self):
        return f"{self.customer} - {self.product.productname} x{self.quantity}"


class Seller(models.Model):
    sellerid = models.AutoField(primary_key=True, db_column='sellerId')
    sellername = models.CharField(db_column='sellerName', max_length=255, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    user = models.OneToOneField(
        'auth.User', on_delete=models.CASCADE, null=True, blank=True, related_name='seller_profile'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'seller'


class Orders(models.Model):
    orderid = models.AutoField(primary_key=True)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='orders')
    status = models.CharField(max_length=20, default='placed', choices=[
        ('placed', 'Order Placed'),
        ('packed', 'Packed'),
        ('shipped', 'Shipped'),
        ('delivered', 'Delivered'),
    ])
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    delivery_address = models.CharField(max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'orders'

    def __str__(self):
        return f"Order #{self.orderid} — {self.customer}"


class OrderItem(models.Model):
    order = models.ForeignKey(Orders, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Products, on_delete=models.CASCADE)
    variant = models.ForeignKey(ProductVariant, on_delete=models.SET_NULL, blank=True, null=True)
    seller = models.ForeignKey(Seller, on_delete=models.SET_NULL, blank=True, null=True)
    quantity = models.PositiveIntegerField(default=1)
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 'order_items'

    def __str__(self):
        return f"{self.product.productname} x{self.quantity}"

    @property
    def subtotal(self):
        return self.unit_price * self.quantity


class Refund(models.Model):
    refundid = models.IntegerField(primary_key=True)
    transactionid = models.ForeignKey(Payments, models.DO_NOTHING, db_column='transactionid')
    amount = models.IntegerField()
    productid = models.ForeignKey(Products, models.DO_NOTHING, db_column='productid')
    refundtype = models.CharField(max_length=255)
    refundreason = models.CharField(db_column='refundReason', max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'refund'


class Reviews(models.Model):
    reviewid = models.AutoField(primary_key=True)
    product = models.ForeignKey(Products, on_delete=models.CASCADE, related_name='reviews')
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='reviews')
    rating = models.PositiveSmallIntegerField(choices=[(i, i) for i in range(1, 6)])
    review = models.TextField(blank=True, null=True)
    photo_path = models.CharField(max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'reviews'
        unique_together = ('product', 'customer')  # one review per customer per product

    def __str__(self):
        return f"{self.rating}★ — {self.product.productname} by {self.customer}"


class Sale(models.Model):
    saleid = models.IntegerField(primary_key=True)
    salename = models.CharField(db_column='saleName', max_length=255, blank=True, null=True)
    saleduration = models.IntegerField(blank=True, null=True)
    salestart_date = models.DateTimeField(blank=True, null=True)
    saleend_date = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    productid = models.ForeignKey(Products, models.DO_NOTHING, db_column='productId', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'sale'


class Shipment(models.Model):
    shipmentid = models.IntegerField(db_column='shipmentId', primary_key=True)
    shipmentcompany = models.CharField(db_column='shipmentCompany', max_length=255, blank=True, null=True)
    trackingid = models.CharField(db_column='trackingId', max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'shipment'


class Wishlist(models.Model):
    wishlistid = models.AutoField(primary_key=True, db_column='wishlistId')
    customer = models.ForeignKey(
        Customer, on_delete=models.CASCADE, db_column='customerId',
        related_name='wishlist_items'
    )
    productid = models.ForeignKey(
        Products, on_delete=models.CASCADE, db_column='productId',
        related_name='wishlisted_by'
    )
    variantid = models.ForeignKey(
        ProductVariant, on_delete=models.CASCADE, db_column='variantId',
        blank=True, null=True, related_name='wishlisted_by'
    )
    session_key = models.CharField(max_length=40, blank=True, null=True)
    wishlistitemquantity = models.IntegerField(db_column='wishlistItemQuantity', blank=True, null=True)
    itemnames = models.CharField(db_column='itemNames', max_length=255, blank=True, null=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'wishlist'
        unique_together = ('customer', 'productid', 'variantid')

    def __str__(self):
        label = self.productid.productname
        if self.variantid:
            label += f" (variant #{self.variantid.pk})"
        return f"{label} (wishlist)"


class Symptom(models.Model):
    name = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(max_length=100, unique=True, blank=True)

    class Meta:
        db_table = 'symptoms'

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.slug:
            from django.utils.text import slugify
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)


class ProductSymptom(models.Model):
    product = models.ForeignKey(Products, on_delete=models.CASCADE, related_name='symptom_links')
    symptom = models.ForeignKey(Symptom, on_delete=models.CASCADE, related_name='product_links')

    class Meta:
        db_table = 'product_symptoms'
        unique_together = ('product', 'symptom')