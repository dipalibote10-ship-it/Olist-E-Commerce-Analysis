/*
    Author      : Akshaykumar Shinde
    Created On  : 2026-03-17
    Project     : Olist Database
*/
-- Weekday Vs Weekend Payment Statistics

SELECT 
    CASE 
        WHEN DAYOFWEEK(o.order_purchase_timestamp) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    
    CONCAT(ROUND(SUM(p.payment_value)/1000000,2),' M') AS total_payment,
    
    CONCAT(ROUND(COUNT(DISTINCT o.order_id)/1000,2),' K') AS total_orders,
    
    ROUND(AVG(p.payment_value),2) AS avg_payment,
    
    CONCAT(
        ROUND(
            (SUM(p.payment_value) / SUM(SUM(p.payment_value)) OVER ()) * 100
        ,2),' %'
    ) AS payment_percentage

FROM orders_dataset o
JOIN payments_dataset p 
ON o.order_id = p.order_id

GROUP BY day_type;

-- Number of Orders with review score 5 and payment type as credit card.

SELECT CONCAT(ROUND(COUNT(DISTINCT r.order_id)/1000,2),' K') AS total_orders
FROM reviews_dataset r
JOIN payments_dataset p
ON r.order_id = p.order_id
WHERE r.review_score = 5
AND p.payment_type = 'credit_card';

-- Average number of days taken for order_delivered_customer_date for pet_shop

SELECT 
ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,
                   o.order_purchase_timestamp))) 
AS avg_delivery_days
FROM orders_dataset o
JOIN order_items_dataset oi 
ON o.order_id = oi.order_id
JOIN products_dataset p 
ON oi.product_id = p.product_id
WHERE p.product_category_name = 'pet_shop'
AND o.order_delivered_customer_date IS NOT NULL;

-- Average price and payment values from customers of sao paulo city

SELECT 
ROUND(AVG(oi.price),2) AS avg_price,
ROUND(AVG(p.payment_value),2) AS avg_payment
FROM customers_dataset c
JOIN orders_dataset o
ON c.customer_id = o.customer_id
JOIN order_items_dataset oi
ON o.order_id = oi.order_id
JOIN payments_dataset p
ON o.order_id = p.order_id
WHERE c.customer_city = 'sao paulo'; 

-- Relationship between shipping days Vs review scores.

SELECT 
  CASE 
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) BETWEEN 1 AND 10 THEN '1-10 Days'
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) BETWEEN 11 AND 20 THEN '11-20 Days'
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) BETWEEN 21 AND 30 THEN '21-30 Days'
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) BETWEEN 31 AND 60 THEN '31-60 Days'
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) BETWEEN 61 AND 120 THEN '61-120 Days'
    ELSE '120+ Days'
  END AS shipping_range,

  ROUND(AVG(r.review_score)) AS avg_review_score

FROM orders_dataset o
JOIN reviews_dataset r
  ON o.order_id = r.order_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY shipping_range

ORDER BY 
  CASE 
    WHEN shipping_range = '1-10 Days' THEN 1
    WHEN shipping_range = '11-20 Days' THEN 2
    WHEN shipping_range = '21-30 Days' THEN 3
    WHEN shipping_range = '31-60 Days' THEN 4
    WHEN shipping_range = '61-120 Days' THEN 5
    ELSE 6
  END;