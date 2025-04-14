-- Easy-Level Tasks

-- 1. Using Products table, find the total number of products available in each category.

SELECT 
	Category,
	COUNT(*) AS ProductNum
FROM Products
GROUP BY Category;


-- 2. Using Products table, get the average price of products in the 'Electronics' category.

SELECT
	Category,
	AVG(Price)
FROM Products
GROUP BY Category
HAVING Category = 'Electronics';


-- 3. Using Customers table, list all customers from cities that start with 'L'.

SELECT
	CustomerID,
	CONCAT_WS(' ', FirstName, LastName) AS Name,
	City
FROM Customers
WHERE UPPER(City) LIKE 'L%'
	

-- 4. Using Products table, get all product names that end with 'er'.

SELECT
	ProductName
FROM Products
WHERE ProductName LIKE '%er';


-- 5. Using Customers table, list all customers from countries ending in 'A'.

SELECT
	CustomerID,
	CONCAT_WS(' ', FirstName, LastName) AS Name,
	Country
FROM Customers
WHERE Country LIKE '%A'


-- 6. Using Products table, show the highest price among all products.

SELECT TOP 1
	ProductName,
	MAX(Price) AS Price
FROM Products
GROUP BY ProductName
ORDER BY Price DESC;

-- 7. Using Products table, use IIF to label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.

SELECT 
	ProductName,
	StockQuantity,
	IIF(StockQuantity < 30, 'Low Stock', 'Sufficient') AS StockSegment
FROM Products;


-- 8. Using Customers table, find the total number of customers in each country.

SELECT
	Country,
	COUNT(*)
FROM Customers
GROUP BY Country;


-- 9. Using Orders table, find the minimum and maximum quantity ordered.

SELECT
	MIN(Quantity) AS MinOrder,
	MAX(Quantity) AS MaxOrder
FROM Orders;


-- Medium-Level Tasks

-- 10. Using Orders and Invoices tables, list customer IDs who placed orders in 2023 (using EXCEPT) to find those who did not have invoices.

SELECT CustomerID, OrderDate FROM Orders
WHERE YEAR(OrderDate) = '2023'
EXCEPT
SELECT CustomerID, InvoiceDate FROM Invoices;


-- 11. Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.

SELECT * FROM Products
UNION ALL
SELECT * FROM Products_Discounted;


-- 12. Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.

SELECT * FROM Products
UNION
SELECT * FROM Products_Discounted;

-- 13. Using Orders table, find the average order amount by year.

SELECT
	YEAR(OrderDate) AS OrderDate,
	AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);


-- 14. Using Products table, use CASE to group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.

SELECT 
	ProductName,
	CASE WHEN Price < 100 THEN 'Low'
		 WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
		 Else 'High'
	END AS PriceGroup
FROM Products;


-- 15. Using Customers table, list all unique cities where customers live, sorted alphabetically.

SELECT DISTINCT City
FROM Customers
ORDER BY City ASC;


-- 16. Using Sales table, find total sales per product Id.

SELECT 
	ProductID,
	SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;


-- 17. Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';


-- 18. Using Products and Products_Discounted tables, compare product IDs using INTERSECT.

SELECT ProductID FROM Products
INTERSECT
SELECT ProductID FROM Products_Discounted;


-- Hard-Level Tasks

-- 19. Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.

SELECT TOP 3
	CustomerID,
	SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY SUM(TotalAmount) DESC;


-- 20. Find product ID and productname that are present in Products but not in Products_Discounted.

SELECT 
	ProductID,
	ProductName
FROM Products
EXCEPT 
SELECT 
	ProductID,
	ProductName
FROM Products_Discounted;


-- 21. Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)

SELECT
	p.ProductName,
	COUNT(SaleID) NumberOfSlaes
FROM Sales s
LEFT JOIN Products p
ON s.ProductID = p.ProductID
GROUP BY p.ProductName;


-- 22. Using Orders table, find top 5 products (by ProductID) with the highest order quantities.

SELECT TOP 5
	ProductID,
	SUM(Quantity) AS OrderQty
FROM Orders
GROUP BY ProductID
ORDER BY SUM(Quantity) DESC;