-- Data Quality Tests & Transformation Tests

SELECT COUNT(*) AS null_cities FROM staging_db.test_staging WHERE city is NULL;
SELECT COUNT(*) AS null_emails FROM staging_db.test_staging WHERE email is NULL;
SELECT COUNT(*) FROM staging_db.test_staging GROUP BY order_id HAVING count(*)>1;
SELECT COUNT(*) FROM staging_db.test_staging WHERE quantity<=0;


SELECT COUNT(*) FROM dw_db.dim_customer WHERE city = 'NY' OR city = 'HYD';

SELECT 
	CASE 
		WHEN COUNT(*) = 0 THEN 'PASS: NY and Hyd not exist in customer dimension'
		ELSE CONCAT('FAIL: ', COUNT(*), ' customers found with NY or Hyd cities')
	END AS validation_result
FROM dim_customer 
WHERE city = 'NY' OR city = 'Hyd';

SELECT 
	CASE
		WHEN COUNT(*) = 0 THEN 'PASS: Beauty type products not exists'
        ELSE CONCAT('FAIL: Beauty category type products found') 
	END AS validation_result
FROM dw_db.dim_product 
WHERE product_category = 'Beauty';

SELECT COUNT(*) AS missing_records
FROM source_db.sales_raw s
LEFT JOIN dw_db.fact_sales f
ON s.order_id = f.order_id
WHERE s.order_id = NULL;

SELECT * FROM source_db.sales_raw s
JOIN staging_db.test_staging st ON s.order_id = st.order_id
JOIN dw_db.fact_sales f ON s.order_id = f.order_id
WHERE s.customer_name != st.customer_name;

SELECT * FROM source_db.sales_raw s
JOIN staging_db.test_staging st ON s.order_id = st.order_id
JOIN dw_db.fact_sales f ON s.order_id = f.order_id
WHERE s.quantity != st.quantity;
   
SELECT order_id, COUNT(*) AS dup_count
FROM dw_db.fact_sales
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT * FROM dw_db.fact_sales f 
WHERE ABS(f.total_amount - (f.quantity * f.unit_price))>0.01;

SELECT * FROM dw_db.fact_sales f 
LEFT JOIN dw_db.dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dw_db.dim_product p ON f.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;

-- As a pre-requisites update city for any email id - (dimension table, email - 1 records)
SELECT COUNT(*)
FROM dw_db.dim_customer 
WHERE email = 'mike.b@email.com'
ORDER BY effective_date;

SELECT email, COUNT(*) as records, SUM(is_current) as current 
FROM dw_db.dim_customer  
GROUP BY email 
HAVING SUM(is_current) != 1;
