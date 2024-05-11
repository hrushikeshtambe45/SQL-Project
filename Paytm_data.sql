CREATE DATABASE Paytm 
use Paytm

SELECT * FROM Purchase_data

SELECT DISTINCT Category_Grouped, COUNT(DISTINCT Category) AS UniqueCategories
FROM Purchase_data GROUP BY Category_Grouped;


SELECT TOP 5 Shipping_city, COUNT(*) AS OrderCount
FROM Purchase_data
GROUP BY Shipping_city
ORDER BY OrderCount DESC;



SELECT *
FROM Purchase_data
WHERE Sale_Flag = 'On Sale';


SELECT TOP 1 *
FROM Purchase_data
ORDER BY Item_Price DESC;



SELECT Category, SUM(Value_CM1) AS TotalSales
FROM Purchase_data
GROUP BY Category;



SELECT Product_Gender, AVG(Quantity) AS AvgQuantity
FROM Purchase_data
WHERE Category = 'Women Apparel' or Category ='Men Apparel'
GROUP BY Product_Gender;


SELECT TOP 5 *, (Value_CM1 / Value_CM2) AS Ratio
FROM Purchase_data
ORDER BY Ratio DESC;



SELECT TOP 3 Class, SUM(Value_CM1) AS TotalSales
FROM Purchase_data
GROUP BY Class
ORDER BY TotalSales DESC;



SELECT TOP 3 Brand, SUM(Value_CM1) AS TotalSales
FROM Purchase_data
GROUP BY Brand
ORDER BY TotalSales DESC;



SELECT COALESCE(SUM(Value_CM1),0) AS TotalRevenue
FROM Purchase_data
WHERE  Sale_Flag = 'On Sale';


SELECT TOP 5 Shipping_city, AVG(Value_CM1 / Quantity) AS AvgOrderValue
FROM Purchase_data
GROUP BY Shipping_city
ORDER BY AvgOrderValue DESC;



SELECT Product_Gender, COUNT(*) AS TotalOrders, SUM(Value_CM1) AS TotalSales
FROM Purchase_data
WHERE Category = 'Women Apparel' or Category ='Men Apparel'
GROUP BY Product_Gender;



SELECT Category, (SUM(Value_CM1) / (SELECT SUM(Value_CM1) FROM Purchase_data)) * 100 AS SalesPercentage
FROM Purchase_data
GROUP BY Category;



SELECT TOP 1 Category, AVG(Item_Price) AS AvgItemPrice
FROM Purchase_data
GROUP BY Category
ORDER BY AvgItemPrice DESC;





SELECT Segment, SUM(Value_CM1) AS TotalSales, AVG(Quantity) AS AvgQuantityPerOrder
FROM Purchase_data
GROUP BY Segment;




