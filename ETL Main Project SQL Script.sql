SELECT * FROM source_db.sales_raw;
SELECT * FROM staging_db.sales_raw;
SELECT * FROM staging_db.test_staging;
TRUNCATE TABLE staging_db.sales_raw;
TRUNCATE TABLE staging_db.test_staging;

INSERT INTO source_db.sales_raw (order_id, customer_name, city, email, product_name, product_category, sale_date, quantity, unit_price, load_timestamp) 
VALUES ('ORD001', 'John Smith', 'New York', 'john.smith@email.com', 'Laptop', 'Electronics', '2023-01-15', 1, 1200.00, '2023-01-15 09:30:00');

-- Data Quality Tests & Transformation Tests

SELECT COUNT(*) as null_cities FROM staging_db.test_staging where city is NULL;
SELECT COUNT(*) as null_emails FROM staging_db.test_staging where email is NULL;
SELECT COUNT(*) FROM staging_db.test_staging GROUP BY order_id HAVING count(*)>1;
SELECT COUNT(*) FROM staging_db.test_staging WHERE quantity<=0;

