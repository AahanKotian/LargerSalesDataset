-- 1. Basic Statistics:

SELECT COUNT(*) AS TotalOrders FROM LargerSalesDataset$;
--There are 1,662,575 orders.

SELECT SUM(TotalPrice) AS TotalSalesAmount FROM LargerSalesDataset$;
-- The total sales amount is $1,268,009,935.05.

SELECT AVG(UnitPrice) AS AverageUnitPrice FROM LargerSalesDataset$;
-- The average overall unit price is $253.28.

--2. Aggregation:

SELECT ProductCategory, SUM(TotalPrice) AS TotalSales
FROM LargerSalesDataset$
GROUP BY ProductCategory;
-- Of the 6 Product Categories: Clothing had a total sales amount of $216,986,601.43
-- Beauty & Health had $199,430,360.05
-- Electronics had $214,644,492.27
-- Sports & Outdoors had $218,456,280.35
-- Books had $207,598,939.24
-- Home & Kitchen had $210,893,261.67

SELECT OrderStatus, SUM(TotalPrice) AS TotalSales
FROM LargerSalesDataset$
GROUP BY OrderStatus;
-- Of the 4 Order Statuses: Pending had a total sales amount of $327,783,203.87
-- Refunded had $306,081,708.17
-- Cancelled had $327,124,943.58
-- Completed had $307,020,079.41
-- This means that out of the 1,662,575 orders that occurred only $307,020,079.41 has actually exchanged hands from customer to the business and $327,783,203.87 has yet to.

--3. Time Series Analysis:

SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, SUM(TotalPrice) AS MonthlySales
FROM LargerSalesDataset$
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;
-- January had a monthly sale of $113,073,068.04.
-- November had the lowest monthly sale at $91,813,336.70. 
-- December had the highest at $117,812,438.91.

-- 4. Customer Analysis:

SELECT CustomerID, SUM(TotalPrice) AS TotalSpending
FROM LargerSalesDataset
GROUP BY CustomerID;

SELECT CustomerID, SUM(TotalPrice) AS TotalSpending
FROM LargerSalesDataset$
GROUP BY CustomerID
HAVING SUM(TotalPrice) = (
    SELECT MAX(TotalSpending)
    FROM (
        SELECT SUM(TotalPrice) AS TotalSpending
        FROM LargerSalesDataset$
        GROUP BY CustomerID
    ) AS subquery
);
-- The Customer with the highest Total Spending is cd1472e9-2a12-484d-b496-fc6638dc948d at $424,963.42.

-- 5. Product Analysis

SELECT ProductID, ProductCategory, SUM(Quantity) AS TotalQuantity, SUM(TotalPrice) AS TotalSalesAmount
FROM LargerSalesDataset
GROUP BY ProductID, ProductCategory;

SELECT ProductCategory, SUM(Quantity) AS TotalQuantity, SUM(TotalPrice) AS TotalSalesAmount
FROM LargerSalesDataset$
GROUP BY ProductCategory;
-- Among the 6 Product Categories, Books had a Total Quantity of 812,380 and Total Sales Amount of $207,598,939.24.
-- Sports & Outdoors had a total quantity of 863,498 and Total Sales Amount of $218,456,280.35. 
-- Beauty & Health had a total quantity of 792,178 and Total Sales Amount of $199,430,360.05.
-- Electronics had a total quantity of 844,072 and $214,644,492.27.
-- Home & Kitchen had a total quantity of 839,573 and $210,893,261.67.
-- Clothing had a total quantity of 852,366 and $216,986,601.43.

-- 6. Payment Analysis

SELECT PaymentType, SUM(TotalPrice) AS TotalSalesAmount
FROM LargerSalesDataset$
GROUP BY PaymentType;
--Among the 4 payment types PayPal had the highest total sales at $327,378,627.41.
-- Credit Card had the lowest at $308,807,012.38.
-- Gift Card had $310,298,395.79.
-- Debit Card had $321,525,899.44.

-- 7. Filtering

SELECT *
FROM LargerSalesDataset$
WHERE CustomerID = 'specific_customer_id';
