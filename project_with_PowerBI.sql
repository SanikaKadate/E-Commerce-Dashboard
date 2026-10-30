-- PROJECT: E-commerce Management System
-- STEP 1: Create the database

USE master;
GO

IF DB_ID('ECommerceDB') IS NULL
BEGIN
    CREATE DATABASE ECommerceDB;
END;
GO

USE ECommerceDB;
GO

-- 1. Categories
IF OBJECT_ID('dbo.categories', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.categories (
        category_id INT IDENTITY(1,1) PRIMARY KEY,
        category_name NVARCHAR(100) NOT NULL UNIQUE,
        description NVARCHAR(300),
        created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME()
    );
END;
GO

-- 2. Users / Customers
IF OBJECT_ID('dbo.users', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.users (
        user_id INT IDENTITY(1,1) PRIMARY KEY,
        full_name NVARCHAR(150) NOT NULL,
        email NVARCHAR(255) NOT NULL UNIQUE,
        city NVARCHAR(100),
        state_name NVARCHAR(100),
        signup_date DATE NOT NULL,
        is_active BIT NOT NULL DEFAULT 1
    );
END;
GO

-- 3. Products
IF OBJECT_ID('dbo.products', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.products (
        product_id INT IDENTITY(1,1) PRIMARY KEY,
        category_id INT NOT NULL,
        product_name NVARCHAR(150) NOT NULL,
        price DECIMAL(12,2) NOT NULL,
        stock_quantity INT NOT NULL DEFAULT 0,
        created_at DATE NOT NULL DEFAULT CONVERT(DATE, GETDATE()),

        CONSTRAINT FK_products_categories
            FOREIGN KEY (category_id)
            REFERENCES dbo.categories(category_id),

        CONSTRAINT CK_products_price CHECK (price >= 0),
        CONSTRAINT CK_products_stock CHECK (stock_quantity >= 0)
    );
END;
GO

-- 4. Orders
IF OBJECT_ID('dbo.orders', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.orders (
        order_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        order_date DATE NOT NULL,
        order_status NVARCHAR(30) NOT NULL DEFAULT 'Pending',
        payment_method NVARCHAR(30) NOT NULL,
        shipping_city NVARCHAR(100),

        CONSTRAINT FK_orders_users
            FOREIGN KEY (user_id)
            REFERENCES dbo.users(user_id),

        CONSTRAINT CK_orders_status CHECK
            (order_status IN
            ('Pending','Processing','Shipped','Delivered','Cancelled','Returned'))
    );
END;
GO

-- 5. Order Items
IF OBJECT_ID('dbo.order_items', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.order_items (
        order_item_id INT IDENTITY(1,1) PRIMARY KEY,
        order_id INT NOT NULL,
        product_id INT NOT NULL,
        quantity INT NOT NULL,
        unit_price DECIMAL(12,2) NOT NULL,

        CONSTRAINT FK_order_items_orders
            FOREIGN KEY (order_id)
            REFERENCES dbo.orders(order_id),

        CONSTRAINT FK_order_items_products
            FOREIGN KEY (product_id)
            REFERENCES dbo.products(product_id),

        CONSTRAINT CK_order_items_quantity CHECK (quantity > 0),
        CONSTRAINT CK_order_items_price CHECK (unit_price >= 0)
    );
END;
GO

PRINT 'Database and table creation script completed.';
GO

USE ECommerceDB;
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;


USE ECommerceDB;
GO

-- Categories
SET IDENTITY_INSERT dbo.categories ON;

INSERT INTO dbo.categories
    (category_id, category_name, description)
VALUES
    (1, 'Electronics', 'Electronic devices and accessories'),
    (2, 'Fashion', 'Clothing and accessories'),
    (3, 'Home & Kitchen', 'Home essentials and kitchen products'),
    (4, 'Books', 'Books and learning materials'),
    (5, 'Sports', 'Sports and fitness products');

SET IDENTITY_INSERT dbo.categories OFF;
GO

-- Customers
SET IDENTITY_INSERT dbo.users ON;

INSERT INTO dbo.users
    (user_id, full_name, email, city, state_name, signup_date)
VALUES
    (1, 'Aarav Sharma', 'aarav@example.com', 'Pune', 'Maharashtra', '2025-01-10'),
    (2, 'Diya Patil', 'diya@example.com', 'Mumbai', 'Maharashtra', '2025-02-15'),
    (3, 'Rohan Desai', 'rohan@example.com', 'Kolhapur', 'Maharashtra', '2025-03-12'),
    (4, 'Ananya Kulkarni', 'ananya@example.com', 'Nashik', 'Maharashtra', '2025-04-18'),
    (5, 'Vivaan Shah', 'vivaan@example.com', 'Ahmedabad', 'Gujarat', '2025-05-21'),
    (6, 'Meera Joshi', 'meera@example.com', 'Bengaluru', 'Karnataka', '2025-06-09'),
    (7, 'Ishaan Verma', 'ishaan@example.com', 'Delhi', 'Delhi', '2025-07-11'),
    (8, 'Saanvi Rao', 'saanvi@example.com', 'Hyderabad', 'Telangana', '2025-08-20'),
    (9, 'Kabir Singh', 'kabir@example.com', 'Jaipur', 'Rajasthan', '2025-09-03'),
    (10, 'Aditi More', 'aditi@example.com', 'Satara', 'Maharashtra', '2025-10-14'),
    (11, 'Arjun Nair', 'arjun@example.com', 'Kochi', 'Kerala', '2026-01-05'),
    (12, 'Sara Khan', 'sara@example.com', 'Bhopal', 'Madhya Pradesh', '2026-02-17');

SET IDENTITY_INSERT dbo.users OFF;
GO

-- Products
SET IDENTITY_INSERT dbo.products ON;

INSERT INTO dbo.products
    (product_id, category_id, product_name, price, stock_quantity, created_at)
VALUES
    (1, 1, 'Wireless Headphones', 2499.00, 120, '2025-01-01'),
    (2, 1, 'Smart Watch', 3999.00, 75, '2025-01-05'),
    (3, 1, 'Bluetooth Speaker', 1799.00, 90, '2025-02-01'),
    (4, 2, 'Casual T-Shirt', 599.00, 200, '2025-01-10'),
    (5, 2, 'Running Shoes', 2499.00, 65, '2025-02-15'),
    (6, 3, 'Coffee Maker', 3299.00, 40, '2025-03-01'),
    (7, 3, 'Storage Organizer', 899.00, 150, '2025-03-10'),
    (8, 4, 'SQL for Beginners', 699.00, 100, '2025-04-01'),
    (9, 4, 'Data Analytics Handbook', 999.00, 80, '2025-04-10'),
    (10, 5, 'Yoga Mat', 799.00, 110, '2025-05-01');

SET IDENTITY_INSERT dbo.products OFF;
GO

-- Orders
SET IDENTITY_INSERT dbo.orders ON;

INSERT INTO dbo.orders
    (order_id, user_id, order_date, order_status, payment_method, shipping_city)
VALUES
    (1, 1, '2025-01-15', 'Delivered', 'UPI', 'Pune'),
    (2, 2, '2025-02-10', 'Delivered', 'Card', 'Mumbai'),
    (3, 3, '2025-03-05', 'Delivered', 'UPI', 'Kolhapur'),
    (4, 4, '2025-04-12', 'Cancelled', 'UPI', 'Nashik'),
    (5, 5, '2025-05-20', 'Delivered', 'Card', 'Ahmedabad'),
    (6, 6, '2025-06-18', 'Delivered', 'COD', 'Bengaluru'),
    (7, 7, '2025-08-02', 'Returned', 'Card', 'Delhi'),
    (8, 8, '2025-10-15', 'Delivered', 'UPI', 'Hyderabad'),
    (9, 1, '2025-12-10', 'Delivered', 'Card', 'Pune'),
    (10, 9, '2026-01-08', 'Processing', 'UPI', 'Jaipur'),
    (11, 10, '2026-02-14', 'Delivered', 'COD', 'Satara'),
    (12, 2, '2026-03-10', 'Shipped', 'Card', 'Mumbai'),
    (13, 11, '2026-04-05', 'Delivered', 'UPI', 'Kochi'),
    (14, 12, '2026-05-20', 'Pending', 'UPI', 'Bhopal'),
    (15, 3, '2026-06-15', 'Delivered', 'Card', 'Kolhapur'),
    (16, 4, '2026-07-11', 'Delivered', 'UPI', 'Nashik'),
    (17, 5, '2026-08-05', 'Processing', 'COD', 'Ahmedabad'),
    (18, 6, '2026-08-20', 'Delivered', 'Card', 'Bengaluru'),
    (19, 8, '2026-09-09', 'Shipped', 'UPI', 'Hyderabad'),
    (20, 10, '2026-10-01', 'Delivered', 'UPI', 'Satara');

SET IDENTITY_INSERT dbo.orders OFF;
GO

-- Order Items
SET IDENTITY_INSERT dbo.order_items ON;

INSERT INTO dbo.order_items
    (order_item_id, order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 1, 2499.00),
    (2, 1, 8, 2, 699.00),
    (3, 2, 4, 3, 599.00),
    (4, 2, 5, 1, 2499.00),
    (5, 3, 2, 1, 3999.00),
    (6, 3, 10, 2, 799.00),
    (7, 4, 6, 1, 3299.00),
    (8, 5, 3, 2, 1799.00),
    (9, 5, 9, 1, 999.00),
    (10, 6, 5, 1, 2499.00),
    (11, 6, 7, 2, 899.00),
    (12, 7, 1, 1, 2499.00),
    (13, 8, 6, 1, 3299.00),
    (14, 8, 4, 2, 599.00),
    (15, 9, 2, 1, 3999.00),
    (16, 9, 8, 1, 699.00),
    (17, 10, 3, 1, 1799.00),
    (18, 10, 9, 2, 999.00),
    (19, 11, 5, 2, 2499.00),
    (20, 11, 10, 1, 799.00),
    (21, 12, 1, 1, 2499.00),
    (22, 12, 7, 3, 899.00),
    (23, 13, 6, 1, 3299.00),
    (24, 13, 8, 2, 699.00),
    (25, 14, 2, 1, 3999.00),
    (26, 15, 5, 1, 2499.00),
    (27, 15, 4, 2, 599.00),
    (28, 16, 3, 2, 1799.00),
    (29, 16, 9, 1, 999.00),
    (30, 17, 6, 1, 3299.00),
    (31, 18, 1, 2, 2499.00),
    (32, 18, 10, 2, 799.00),
    (33, 19, 2, 1, 3999.00),
    (34, 19, 8, 1, 699.00),
    (35, 20, 5, 1, 2499.00),
    (36, 20, 7, 1, 899.00);

SET IDENTITY_INSERT dbo.order_items OFF;
GO

PRINT 'Sample data inserted successfully.';
GO

-- 1. Detailed order dataset
CREATE OR ALTER VIEW dbo.v_OrderDetails
AS
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.payment_method,
    o.shipping_city,
    u.user_id,
    u.full_name,
    u.city AS customer_city,
    p.product_id,
    p.product_name,
    c.category_id,
    c.category_name,
    oi.quantity,
    oi.unit_price,
    CAST(oi.quantity * oi.unit_price AS DECIMAL(14,2))
        AS line_total,
    CAST(
        CASE WHEN o.order_status = 'Delivered'
             THEN oi.quantity * oi.unit_price
             ELSE 0 END
        AS DECIMAL(14,2)
    ) AS recognized_revenue
FROM dbo.orders AS o
INNER JOIN dbo.users AS u
    ON o.user_id = u.user_id
INNER JOIN dbo.order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.products AS p
    ON oi.product_id = p.product_id
INNER JOIN dbo.categories AS c
    ON p.category_id = c.category_id;
GO

-- 2. Monthly sales
CREATE OR ALTER VIEW dbo.v_MonthlySales
AS
SELECT
    DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
        AS sales_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(recognized_revenue) AS revenue,
    SUM(CASE WHEN order_status = 'Delivered'
             THEN quantity ELSE 0 END) AS units_sold
FROM dbo.v_OrderDetails
GROUP BY YEAR(order_date), MONTH(order_date);
GO

-- 3. Category performance
CREATE OR ALTER VIEW dbo.v_CategorySales
AS
SELECT
    category_id,
    category_name,
    SUM(recognized_revenue) AS revenue,
    SUM(CASE WHEN order_status = 'Delivered'
             THEN quantity ELSE 0 END) AS units_sold
FROM dbo.v_OrderDetails
GROUP BY category_id, category_name;
GO

-- 4. Best-selling products
CREATE OR ALTER VIEW dbo.v_TopProducts
AS
SELECT
    product_id,
    product_name,
    category_name,
    SUM(CASE WHEN order_status = 'Delivered'
             THEN quantity ELSE 0 END) AS units_sold,
    SUM(recognized_revenue) AS revenue
FROM dbo.v_OrderDetails
GROUP BY product_id, product_name, category_name;
GO

-- 5. Customer performance
CREATE OR ALTER VIEW dbo.v_CustomerSales
AS
SELECT
    user_id,
    full_name,
    customer_city,
    COUNT(DISTINCT CASE
        WHEN order_status = 'Delivered' THEN order_id
    END) AS delivered_orders,
    SUM(recognized_revenue) AS revenue
FROM dbo.v_OrderDetails
GROUP BY user_id, full_name, customer_city;
GO

PRINT 'Reporting views created successfully.';
GO

SELECT TOP 10 * FROM dbo.v_OrderDetails;

SELECT * FROM dbo.v_MonthlySales
ORDER BY sales_month;

SELECT * FROM dbo.v_CategorySales
ORDER BY revenue DESC;

SELECT TOP 10 * FROM dbo.v_TopProducts
ORDER BY revenue DESC;

SELECT * FROM dbo.v_CustomerSales
ORDER BY revenue DESC;

CREATE INDEX IX_orders_order_date
ON dbo.orders(order_date)
INCLUDE (order_status, user_id);
GO

CREATE INDEX IX_orders_status_date
ON dbo.orders(order_status, order_date);
GO

CREATE INDEX IX_order_items_order
ON dbo.order_items(order_id)
INCLUDE (product_id, quantity, unit_price);
GO

CREATE INDEX IX_order_items_product
ON dbo.order_items(product_id);
GO

CREATE INDEX IX_products_category
ON dbo.products(category_id);
GO

SELECT 'categories' AS table_name, COUNT(*) AS total_rows
FROM dbo.categories
UNION ALL
SELECT 'products', COUNT(*) FROM dbo.products
UNION ALL
SELECT 'users', COUNT(*) FROM dbo.users
UNION ALL
SELECT 'orders', COUNT(*) FROM dbo.orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM dbo.order_items;
GO

-- Revenue from delivered orders only
SELECT
    SUM(recognized_revenue) AS total_revenue,
    COUNT(DISTINCT CASE
        WHEN order_status = 'Delivered' THEN order_id
    END) AS delivered_orders,
    SUM(CASE
        WHEN order_status = 'Delivered' THEN quantity
        ELSE 0
    END) AS units_sold
FROM dbo.v_OrderDetails;
GO