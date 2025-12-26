# ETL Testing & Data Warehouse Fundamentals

This repository documents my learning journey from the Udemy course  
**Learn ETL Testing & Data Warehouse Fundamentals – Be a Data Quality Assurance Engineer.**

The purpose of this README is to act as:
- A long-term personal reference for ETL and data warehousing concepts
- Interview preparation material for Data QA and ETL testing roles
- A hands-on recall guide when validating real ETL pipelines

---

## Section 1: Introduction to ETL & Data Warehouse and Their Significance

### 1. Course Objectives and Learning Outcomes

This course builds a strong foundation in how analytical data systems work and how data quality is ensured within them.

Key objectives:
- Understand why ETL pipelines exist and where they fit in system architecture
- Learn how data warehouses support reporting and analytics
- Identify where data quality issues originate
- Understand the responsibilities of a Data Quality Assurance Engineer

Data quality is a business-critical concern. Incorrect or incomplete data leads to poor decisions, misleading dashboards, and unreliable AI or ML models.

Interview note:  
ETL testing ensures that data entering analytics and reporting systems is accurate, complete, and aligned with business rules.

---

### 2. Introduction to Data Warehousing with Business Use Case

#### What is a Data Warehouse?

A Data Warehouse is a centralized repository that stores historical data collected from multiple source systems. It is optimized for analytical queries rather than transactional workloads.

![Architecture](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/2-i.png)

Key characteristics:
- Stores long-term historical data
- Integrates data from multiple systems
- Uses structured schemas designed for reporting
- Supports complex aggregations and trend analysis

Operational databases focus on inserts and updates, while data warehouses focus on reads and analysis.

#### Why a Data Warehouse Is Needed

![Challenges](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/2-ii.png)

Running analytical queries on operational systems can:
- Slow down production applications
- Return inconsistent or partial results
- Mix current and historical data incorrectly

A Data Warehouse solves this by:
- Separating analytics from transactional systems
- Standardizing data formats and definitions
- Acting as a single source of truth

#### Business Use Case Example

Retail sales analytics:

Source systems:
- Point-of-sale system for transactions
- CRM system for customer details
- Inventory system for product data

Business requirement:
- Analyze monthly and yearly sales trends
- Identify top-performing products
- Segment customers by region and spending behavior

Sample Data Warehouse tables:
- sales_fact
- product_dim
- customer_dim
- date_dim

---

### 3. What is ETL and How It Connects to a Data Warehouse

![Understanding Data Warehouses and ETL](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/3-i.png)

#### ETL Definition

ETL stands for:
- Extract: Collect data from databases, files, or APIs
- Transform: Clean, standardize, validate, and apply business rules
- Load: Insert transformed data into the Data Warehouse

ETL pipelines convert raw operational data into analytics-ready data.

![ETL Process Explained](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/3-ii.png)

#### ETL Flow Example

Source table:

customer_source  
- cust_id  
- cust_name  
- country  
- last_updated  

Common source issues:
- Inconsistent country values such as USA, US, United States
- Duplicate customer records
- Extra spaces in text fields

Transformation rules:
- Trim spaces from text columns
- Standardize country values
- Remove duplicates using business keys

Target table:

customer_dim  
- customer_key  
- cust_id  
- cust_name  
- country  

#### ETL Testing Focus Areas

- Source-to-target record count validation
- Duplicate record detection
- Null and invalid value checks
- Business rule validation
- Data type and format consistency

Testing example:  
Compare the count of unique cust_id values in customer_source with records loaded into customer_dim.

---

### 4. Important Notes from Section 1

- ETL pipelines must be tested at every stage
- Business logic errors are more damaging than technical failures
- Data issues become harder to fix downstream
- Strong SQL skills are essential for ETL testing

---

## Section 2: Data Models and ETL / ELT Roles in System Architecture

### 5. Overview of ETL Tools and Required Skills

#### Common ETL Tools

ETL tools help design, execute, and monitor data pipelines:
- Pentaho Data Integration
- Informatica
- Talend
- Apache NiFi
- Apache Airflow for orchestration

These tools provide components for extraction, transformation, and loading.

![ETL Tools](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/5-i.png)

#### Required Skills for ETL and Data QA Roles

Technical skills:
- Strong SQL knowledge
- Understanding relational databases
- Data transformation logic
- Basic scripting or expressions

Testing skills:
- Writing validation queries
- Reconciling data across layers
- Understanding data lineage
- Designing ETL test scenarios

---

### 6. Cloud Data Warehouses and ELT Concept

#### Cloud Data Warehouse Overview

Cloud Data Warehouses are managed analytical platforms that scale automatically based on workload.

![Data Warehouse Concept vs Platforms](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/6-i.png)

Examples:
- Snowflake
- Amazon Redshift
- Google BigQuery
- Azure Synapse

![Cloud Data Warehouses](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/7-i.png)

Advantages:
- High scalability
- Faster query performance
- Reduced infrastructure management

![Cloud Data Warehouse Platform Capabilities](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/6-ii.png)

#### ELT Architecture

ELT follows this sequence:
1. Extract data from source systems
2. Load raw data into the warehouse
3. Transform data using SQL inside the warehouse

Sample tables:
- orders_raw
- customers_raw
- orders_fact

Testing implication:
- Most validation happens after data is loaded
- SQL-based testing becomes the primary approach

![The Evolution from ETL to ELT](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/6-iii.png)

---

### 7. ETL vs ELT: Execution and Testing Differences

![ETL vs ELT](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/7-ii.png)

Aspect | ETL | ELT  
--- | --- | ---  
Transformation location | ETL server | Data Warehouse  
Compute usage | External | Warehouse engine  
Scalability | Limited | High  
Testing timing | Before load | After load  

Interview insight:  
ELT leverages cloud scalability and shifts transformation and testing closer to the data.

---

### 8. Star Schema Data Model

#### What is Star Schema?

Star Schema is a dimensional data model consisting of:
- One central fact table
- Multiple surrounding dimension tables

It simplifies analytical queries and improves performance.

![Star Schema Data Model](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/8-i.png)

![Star Schema Data Model2](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/8-ii.png)

#### Star Schema Example

sales_fact  
- date_key  
- product_key  
- customer_key  
- sales_amount  
- quantity

![Star Schema Example](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/8-iii.png)

product_dim  
- product_key  
- product_name  
- category  

customer_dim  
- customer_key  
- customer_name  
- country

![Star Schema Example2](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/8-iv.png)

This design allows analysis of sales by product, customer, or time.

---

### 9. Fact Tables and Dimension Tables

#### Fact Tables

![Fact Tables](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/9-i.png)

Fact tables store measurable metrics:
- Sales amount
- Quantity sold
- Revenue

Characteristics:
- Large in size
- Numeric fields
- Foreign keys to dimension tables

#### Dimension Tables

![Dimension Tables](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/9-ii.png)

Dimension tables store descriptive attributes:
- Customer details
- Product information
- Time attributes
- Location data

#### Relationships and ETL Testing Focus

- Fact tables reference dimensions using surrogate keys
- Referential integrity must be maintained
- Orphan fact records must not exist

ETL testing examples:
- Validate that every product_key in sales_fact exists in product_dim
- Ensure no duplicate records exist in dimension tables
- Verify correct joins between fact and dimension tables

![Real World Teaching Analogy](https://github.com/ravinduheshan99/ETL-Testing-and-Data-Warehouse-Fundamentals/blob/main/resources/9-iii.png)
