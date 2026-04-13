CREATE DATABASE olist;
use olist;

/*
    Author      : Akshaykumar Shinde
    Created On  : 2026-03-17
    Project     : Olist Database
*/

-- customers_dataser
CREATE TABLE customers_dataset (
customer_id VARCHAR(50),
customer_unique_id VARCHAR(50),
customer_zip_code_prefix INT,
customer_city VARCHAR(100),
customer_state VARCHAR(10)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers_dataset.csv'
INTO TABLE customers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id,
customer_unique_id,
customer_zip_code_prefix,
customer_city,
customer_state);

-- geoloacation_dataset

CREATE TABLE geolocation_dataset (
geolocation_zip_code_prefix INT,
geolocation_city VARCHAR(100),
geolocation_state VARCHAR(10)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/geolocation_dataset.csv'
INTO TABLE geolocation_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(geolocation_zip_code_prefix,
geolocation_city,
geolocation_state);

-- order_items_dataset

CREATE TABLE order_items_dataset (
order_id VARCHAR(50),
order_item_id INT,
product_id VARCHAR(50),
seller_id VARCHAR(50),
shipping_limit_date DATE,
price DECIMAL(10,2),
freight_value DECIMAL(10,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items_dataset.csv'
INTO TABLE order_items_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
order_item_id,
product_id,
seller_id,
shipping_limit_date,
price,
freight_value);

-- orders_dataset
CREATE TABLE orders_dataset (
order_id VARCHAR(50),
customer_id VARCHAR(50),
order_status VARCHAR(20),
order_purchase_timestamp DATE,
order_approved_at DATE,
order_delivered_carrier_date DATE,
order_delivered_customer_date DATE,
order_estimated_delivery_date DATE
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders_dataset.csv'
INTO TABLE orders_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
customer_id,
order_status,
@purchase,
@approved,
@carrier,
@customer,
@estimated)

SET
order_purchase_timestamp = IF(@purchase='',NULL,STR_TO_DATE(@purchase,'%d-%m-%Y')),
order_approved_at = IF(@approved='',NULL,STR_TO_DATE(@approved,'%d-%m-%Y')),
order_delivered_carrier_date = IF(@carrier='',NULL,STR_TO_DATE(@carrier,'%d-%m-%Y')),
order_delivered_customer_date = IF(@customer='',NULL,STR_TO_DATE(@customer,'%d-%m-%Y')),
order_estimated_delivery_date = IF(@estimated='',NULL,STR_TO_DATE(@estimated,'%d-%m-%Y'));

-- payment dataset
CREATE TABLE payments_dataset (
order_id VARCHAR(50),
payment_sequential INT,
payment_type VARCHAR(20),
payment_installments INT,
payment_value DECIMAL(10,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payments_dataset.csv'
INTO TABLE payments_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
payment_sequential,
payment_type,
payment_installments,
payment_value);

-- product name
CREATE TABLE product_category_name (
product_category_name VARCHAR(100),
product_category_name_english VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name.csv'
INTO TABLE product_category_name
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_category_name,
product_category_name_english);

--  products_dataset
CREATE TABLE products_dataset (
    product_id VARCHAR(50),
    product_category_name VARCHAR(255),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products_dataset.csv'
INTO TABLE products_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id,
 product_category_name,
 product_name_lenght,
 product_description_lenght,
 product_photos_qty,
 product_weight_g,
 product_length_cm,
 product_height_cm,
 product_width_cm);
 
 -- review dataset
CREATE TABLE reviews_dataset (
    review_id VARCHAR(200),
    order_id VARCHAR(200),
    review_score INT,
    review_creation_date DATE,
    review_answer_timestamp DATE
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reviews_dataset.csv'
INTO TABLE reviews_dataset
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(review_id,
 order_id,
 @review_score,
 @review_creation_date,
 @review_answer_timestamp)
SET
review_score = NULLIF(@review_score,''),
review_creation_date = NULLIF(@review_creation_date,''),
review_answer_timestamp = NULLIF(@review_answer_timestamp,'');

-- sellers_dataset
CREATE TABLE sellers_dataset (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sellers_dataset.csv'
INTO TABLE sellers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(seller_id,
 @seller_zip_code_prefix,
 seller_city,
 seller_state)
SET seller_zip_code_prefix = NULLIF(@seller_zip_code_prefix,'');