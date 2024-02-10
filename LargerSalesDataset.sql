-- 1. Basic Statistics:

SELECT COUNT(*) AS TotalOrders FROM larger_sales_dataset$;
--There are 10,000 orders

SELECT SUM(TotalPrice) AS TotalSalesAmount FROM LargerSalesDataset;
-- The total sales amount is $7,627,241.96

SELECT AVG(UnitPrice) AS AverageUnitPrice FROM LargerSalesDataset;
-- The average overall unit price is $253.27

--2. Aggregation:

SELECT ProductCategory, SUM(TotalPrice) AS TotalSales
FROM LargerSalesDataset
GROUP BY ProductCategory;
-- Of the 6 Product Categories: Clothing had a total sales amount of $1,303,679.18. 
-- Beauty & Health had $1,201,765.07
-- Electronics had $1,290,283.07
-- Sports & Outdoors had $1,313,735.42
-- Books had $1,249,307.25
-- Home & Kitchen had $1,268,471.94

SELECT OrderStatus, SUM(TotalPrice) AS TotalSales
FROM LargerSalesDataset
GROUP BY OrderStatus;
-- Of the 4 Order Statuses: Pending had a total sales amount of $1,970,902.18
-- Refunded had $1,840,770.62
-- Cancelled had $1,968,945.60
-- Completed had $1,846,623.54
-- This means that out of the 10,000 orders that occurred only $1,846,623.54 has actually exchanged hands from customer to the business and $1,970,902.18 has yet to.

--3. Time Series Analysis:

SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, SUM(TotalPrice) AS MonthlySales
FROM LargerSalesDataset
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;
-- January had a monthly sale of $681,775.81.
-- November had the lowest monthly sale at $552,576.78. 
-- December had the highest at $708,594.31.

-- 4. Customer Analysis:

SELECT CustomerID, SUM(TotalPrice) AS TotalSpending
FROM LargerSalesDataset
GROUP BY CustomerID;

SELECT CustomerID, SUM(TotalPrice) AS TotalSpending
FROM LargerSalesDataset
GROUP BY CustomerID
HAVING SUM(TotalPrice) = (
    SELECT MAX(TotalSpending)
    FROM (
        SELECT SUM(TotalPrice) AS TotalSpending
        FROM LargerSalesDataset
        GROUP BY CustomerID
    ) AS subquery
);
-- The Customer with the highest Total Spending is cd1472e9-2a12-484d-b496-fc6638dc948d at $2499.78.

-- 5. Product Analysis

SELECT ProductID, ProductCategory, SUM(Quantity) AS TotalQuantity, SUM(TotalPrice) AS TotalSalesAmount
FROM LargerSalesDataset
GROUP BY ProductID, ProductCategory;

SELECT ProductCategory, SUM(Quantity) AS TotalQuantity, SUM(TotalPrice) AS TotalSalesAmount
FROM LargerSalesDataset
GROUP BY ProductCategory;
-- 

-- 6. Payment Analysis

SELECT PaymentType, SUM(TotalPrice) AS TotalSalesAmount
FROM LargerSalesDataset
GROUP BY PaymentType;
--Among the 4 payment types PayPal had the highest total sales at $1,968,860.18.
-- Credit Card had the lowest at $1,857,316.95.
-- Gift Card had $1,864,970.43.
-- Credit Card had $1,857,316.95.

-- 7. Filtering

SELECT *
FROM LargerSalesDataset
WHERE CustomerID = 'specific_customer_id';

SELECT *
FROM LargerSalesDataset
WHERE OrderDate BETWEEN 'start_date' AND 'end_date';

SELECT *
FROM LargerSalesDataset
WHERE OrderStatus = 'specific_order_status';
