CREATE DATABASE IF NOT EXISTS source_db;

CREATE DATABASE IF NOT EXISTS staging_db;

USE source_db;

CREATE TABLE sales_raw (
    order_id VARCHAR(20),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100),
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    load_timestamp TIMESTAMP
);

USE staging_db;

CREATE TABLE sales_raw (
    order_id VARCHAR(20),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100),
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    load_timestamp TIMESTAMP,
    is_processed BOOLEAN DEFAULT FALSE,
    process_timestamp TIMESTAMP NULL
);

USE staging_db;

CREATE TABLE test_staging (
    order_id VARCHAR(20),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100),
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    load_timestamp TIMESTAMP,
    is_processed BOOLEAN DEFAULT FALSE,
    process_timestamp TIMESTAMP NULL,
    total_amount DECIMAL(10,2)
);

USE source_db;

INSERT INTO source_db.sales_raw (
  order_id,
  customer_name,
  city,
  email,
  product_name,
  product_category,
  sale_date,
  quantity,
  unit_price,
  load_timestamp
) VALUES
  ('ORD001', 'John Smith', 'New York', 'john.smith@email.com', 'Laptop', 'Electronics', '2023-01-15', 1, 1200.00, '2023-01-15 09:30:00'),
  ('ORD002', 'Sarah Johnson', 'Chicago', 'sarah.j@email.com', 'Smartphone', 'Electronics', '2023-01-16', 2, 800.00, '2023-01-16 10:15:00'),
  ('ORD003', 'Mike Brown', 'Los Angeles', 'mike.b@email.com', 'Desk Chair', 'Furniture', '2023-01-17', 1, 250.00, '2023-01-17 11:20:00'),
  ('ORD004', 'Lisa Wong', 'San Francisco', 'lisa.wong@email.com', 'Coffee Maker', 'Appliances', '2023-01-18', 1, 150.00, '2023-01-18 14:00:00'),
  ('ORD005', 'David Lee', 'Boston', 'david.lee@email.com', 'Wireless Headphones', 'Electronics', '2023-01-19', 3, 100.00, '2023-01-19 16:30:00'),
  ('ORD006', 'John Smith', 'New York', 'john.smith@email.com', 'Monitor', 'Electronics', '2023-01-20', 1, 300.00, '2023-01-20 10:00:00'),
  ('ORD007', 'Sarah Johnson', 'Chicago', 'sarah.j@email.com', 'Smartphone', 'Electronics', '2023-01-20', 1, 800.00, '2023-01-20 10:05:00'),
  ('ORD008', 'Robert Chen', 'Seattle', 'robert.chen@email.com', 'Desk Lamp', 'Furniture', '2023-01-21', 2, 45.00, '2023-01-21 11:30:00'),
  ('ORD009', 'Emily Davis', NULL, 'emily.d@email.com', 'Blender', 'Appliances', '2023-01-22', 1, 80.00, '2023-01-22 13:15:00'),
  ('ORD010', 'Mike Brown', 'Los Angeles', 'invalid-email', 'Desk Chair', 'Furniture', '2023-01-23', 1, 250.00, '2023-01-23 15:00:00'),
  ('ORD011', 'John Smith', 'Boston', 'john.smith@email.com', 'Laptop', 'Electronics', '2023-01-24', 1, 1200.00, '2023-01-24 09:30:00'),
  ('ORD012', 'John', 'New Jersey', 'john.rough@email.com', 'Laptop', 'Electronics', '2023-05-15', 1, 1300.00, '2023-05-15 09:30:00'),
  ('ORD034', 'Ram', 'NY', 'ram.rough@email.com', 'Videogame', 'Electronics', '2023-05-15', 1, 1300.00, '2025-05-14 10:00:00'),
  ('ORD035', 'Sam', 'Chicago', 'sam.rough@email.com', 'Makeup', 'Beauty', '2023-05-15', 1, 1300.00, '2023-05-15 10:30:00'),
  ('ORD035', 'Tim', 'Chicago', 'tim.rough@email.com', 'Makeup', 'Beauty', '2023-05-16', 1, 1300.00, '2023-05-16 10:30:00'),
  ('ORD037', 'Serin dew', 'Delhi', 'john.rough@email.com', 'Laptop', 'Electronics', '2023-05-17', 1, 1300.00, '2023-05-17 09:30:00'),
  ('ORD089', 'Mike Brown', 'Brooklyn', 'mike.b@email.com', 'Wireless Earbuds', 'Electronics', '2025-05-20', 2, 129.99, '2025-05-20 14:22:00'),
  ('ORD090', 'Raj Deen', 'NY', 'raj.d@email.com', 'Wireless Earbuds', 'Electronics', '2025-05-21', 2, 139.99, '2025-05-21 14:22:00');
  
CREATE DATABASE IF NOT EXISTS dw_db;

USE dw_db;

CREATE TABLE dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    product_category VARCHAR(50)
);

CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100),  
    effective_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expiry_date TIMESTAMP NULL,
    is_current BOOLEAN DEFAULT TRUE,
    source_city VARCHAR(50)  -- Only for SCD Type 2 fields
);

CREATE TABLE fact_sales (
    sales_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_key INT,
    product_key INT,
    order_id VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    sale_date DATE,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);