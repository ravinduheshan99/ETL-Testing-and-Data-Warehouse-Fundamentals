


-- delete data in facts & dimensions table 
SET FOREIGN_KEY_CHECKS = 0;

-- Now you can truncate in any order
TRUNCATE TABLE dw_db.dim_customer;
TRUNCATE TABLE dw_db.dim_product;
TRUNCATE TABLE dw_db.fact_sales;


-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;


-- Tests


select COUNT(*) as null_cities from staging_db.test_staging where city is NULL;

select COUNT(*) as null_emails from staging_db.test_staging where email is NULL;

select COUNT(*) from dw_db.dim_customer where city = 'NY' or city = 'HYD';

SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS: NY and Hyd DO NOT exist in customer dimension'
        ELSE CONCAT('FAIL: ', COUNT(*), ' customers found with NY or Hyd cities')
    END AS validation_result
FROM dim_customer 
WHERE city = 'NY' 
   OR city = 'Hyd';
   


SELECT order_id, COUNT(*) AS dup_count
FROM dw_db.fact_sales
GROUP BY order_id
HAVING COUNT(*) = 1;


select COUNT(*) as missing_records
from source_db.sales_raw s
LEFT JOIN dw_db.fact_sales f
ON s.order_id = f.order_id
where s.order_id = null;


select * from dw_db.fact_sales f where ABS(f.total_amount - (f.quantity * f.unit_price))>0.01;



SELECT 
 *
FROM source_db.sales_raw s
JOIN staging_db.test_staging st ON s.order_id = st.order_id
JOIN dw_db.fact_sales f ON s.order_id = f.order_id
WHERE s.customer_name != st.customer_name;



-- update city for any email id - (dimension table , email - 1 records)
SELECT 
   COUNT(*)
FROM dw_db.dim_customer 
WHERE email = 'mike.b@email.com'
ORDER BY effective_date;



SELECT email, COUNT(*) as records, SUM(is_current) as current 
FROM dw_db.dim_customer  
GROUP BY email 
HAVING SUM(is_current) != 1;







