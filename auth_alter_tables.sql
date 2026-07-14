ALTER TABLE customer
ADD COLUMN password Varchar(255) NULL,
ADD COLUMN is_verified TINYINT(1) NOT NULL DEFAULT 0,
ADD COLUMN otp_code VARCHAR(6) NULL,
ADD COLUMN otp_expires_at DATETIME NULL;

ALTER TABLE customer
ADD CONSTRAINT uq_customer_email UNIQUE (email);

ALTER TABLE wishlist
ADD COLUMN customerId INT NULL,
ADD CONSTRAINT fk_wishlist_customer
FOREIGN KEY (customerId) References customer(customerId);