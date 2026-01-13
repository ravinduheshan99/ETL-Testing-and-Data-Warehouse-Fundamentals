-- Insert the new record into the source_db.sales_raw table
INSERT INTO source_db.sales_raw 
(order_id, customer_name, city, email, product_name, product_category, 
 sale_date, quantity, unit_price, load_timestamp)
VALUES 
('ORD093', 'Salem Deen', 'NY', 'sal.d@email.com', 'Wireless Earbuds', 
 'Electronics', '2025-06-01', 2, 149.99, '2025-06-01 14:22:00');
 
 SELECT MAX(load_timestamp) FROM dw_db.fact_sales;
 
 
 
 SELECT * FROM source_db.sales_raw;
  SELECT * FROM staging_db.sales_raw;
    SELECT * FROM staging_db.test_staging;
SELECT * FROM dw_db.dim_product;
SELECT * FROM dw_db.dim_customer;
SELECT * FROM dw_db.fact_sales;

SET FOREIGN_KEY_CHECKS = 0;

-- Now you can truncate in any order
TRUNCATE TABLE dw_db.dim_customer;
TRUNCATE TABLE dw_db.dim_product;
TRUNCATE TABLE dw_db.fact_sales;


-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

TRUNCATE TABLE staging_db.sales_raw;
TRUNCATE TABLE staging_db.test_staging;







