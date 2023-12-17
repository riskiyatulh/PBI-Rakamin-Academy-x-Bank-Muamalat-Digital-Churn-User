-- CREATE TABLE
-- Customers
CREATE TABLE Customers (
	CustomerID character varying(50) NOT NULL,
	FirstName character varying(50) NULL,
	LastName character varying(50) NULL,
	CustomerEmail character varying(100) NULL,
	CustomerPhone character varying(50) NULL,
	CustomerAddress character varying(50) NULL,
	CustomerCity character varying(50) NULL,
	CustomerState character varying(50) NULL,
	CustomerZip integer NULL,
	CONSTRAINT customers_pkey PRIMARY KEY (CustomerID)
);

-- Orders
CREATE TABLE Orders (
	OrderID integer NULL,
	Datee date NULL,
	CustomerID character varying (50) NULL,
	ProdNumber character varying (50) NULL,
	Quantity integer NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (OrderID)
);

-- productcategory
CREATE TABLE ProductCategory (
	CategoryID integer NOT NULL,
	CategoryName character varying (50) NULL,
	CategoryAbbreviation character varying (50) NULL,
	CONSTRAINT productcategory_pkey PRIMARY KEY (CategoryID)
);

-- products
CREATE TABLE Products (
	ProdNumber character varying (50) NOT NULL,
	ProdName character varying (50) NULL,
	Category integer NULL,
	Price decimal NULL,
	CONSTRAINT products_pkey PRIMARY KEY (ProdNumber)
);

-- INPUT DATA CSV
-- Customers
COPY Customers (
	CustomerID,
	FirstName,
	LastName,
	CustomerEmail,
	CustomerPhone,
	CustomerAddress,
	CustomerCity,
	CustomerState,
	CustomerZip)
FROM 'E:\Bootcamp Data Science\Rakamin\PBI Bank Muamalat\Customers.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM Customers;

-- Orders
COPY Orders (
	OrderID,
	Datee,
	CustomerID,
	ProdNumber,
	Quantity)
FROM 'E:\Bootcamp Data Science\Rakamin\PBI Bank Muamalat\Orders.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM Orders;

-- productcategory
COPY ProductCategory (
	CategoryID,
	CategoryName,
	CategoryAbbreviation)
FROM 'E:\Bootcamp Data Science\Rakamin\PBI Bank Muamalat\ProductCategory.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM ProductCategory;

-- products
COPY Products (
	ProdNumber,
	ProdName,
	Category,
	Price)
FROM 'E:\Bootcamp Data Science\Rakamin\PBI Bank Muamalat\Products.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM Products;

-- Design Master Tabel
SELECT
    o.Datee AS order_date,
	pc.CategoryName AS category_name,
	p.ProdName AS product_name,
	p.Price AS product_price,
	o.Quantity AS order_qty,
	ROUND(SUM(p.Price * o.Quantity), 2) AS total_sales,
	c.CustomerEmail AS cust_email,
    c.CustomerCity AS cust_city
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProdNumber = p.ProdNumber
JOIN ProductCategory pc ON p.Category = pc.CategoryID
GROUP BY 1, 2, 3, 4, 5, 7, 8
ORDER BY 1 ASC