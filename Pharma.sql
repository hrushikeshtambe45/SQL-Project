create database pharma
use pharma

select * from Pharma_data ;


select DISTINCT Country from Pharma_data;


SELECT CustomerName FROM Pharma_data WHERE [Sub-channel]='Retail'; 



SELECT COUNT(Quantity) as TotalQuantity FROM Pharma_data Where ProductClass = 'Antibiotics'; 



SELECT DISTINCT Month FROM Pharma_data;  


SELECT Year,COUNT(Sales) AS TotalSales from Pharma_data Group by year;


SELECT TOP 1 CustomerName, MAX(Sales) AS HigestSales FROM Pharma_data GROUP by CustomerName ORDER BY HigestSales DESC;



SELECT [Name of Sales Rep], Manager from Pharma_data Where Manager= 'James Goodwill';



SELECT TOP 5 City, MAX(Sales) AS HighestSales From Pharma_data GROUP BY  City Order by City DESC;



SELECT [Product Name],[Sub-channel], AVG(Price) AS AveragePrice FROM Pharma_data GROUP BY  [Sub-channel],[Product Name];


SELECT CustomerName, Sales from Pharma_data WHERE City='Rendsburg' AND Year = '2018'



SELECT year, month, ProductClass, SUM(Sales) AS Total_Sales FROM Pharma_data GROUP BY year, month, ProductClass ORDER BY year, month, ProductClass; 


SELECT TOP 3 [Name of Sales Rep], MAX(Sales) AS Highest_Sale FROM Pharma_data WHERE Year= 2019 GROUP BY [Name of Sales Rep] ORDER BY  MAX(Sales) DESC;



SELECT DISTINCT Month ,Year, [Sub-channel], SUM(Sales) AS Total_Sales, AVG(Sales) AS Average_Sales  FROM Pharma_data GROUP BY Month ,Year, [Sub-channel];  



SELECT ProductClass, SUM(Sales) AS Total_Sales, AVG(Price) AS Average_Price, SUM(Quantity) AS Total_Quantity FROM Pharma_data GROUP BY ProductClass; 


SELECT TOP 5 Year , MAX(Sales) AS TOP_5_Sales FROM Pharma_data GROUP BY Year ORDER BY TOP_5_Sales DESC; 


WITH SalesWithPreviousYear AS (
SELECT
Country,
Year,
SUM(Sales) AS TotalSales,
LAG(SUM(Sales)) OVER (PARTITION BY Country ORDER BY Year) AS PreviousYearSales
FROM
Pharma_data
GROUP BY
Country, Year 
)
SELECT
Country,
Year,
TotalSales,
CASE
WHEN PreviousYearSales IS NOT NULL THEN ((TotalSales - PreviousYearSales) / PreviousYearSales) * 100
ELSE NULL
END AS Year_over_Year_Growth
FROM
SalesWithPreviousYear;



SELECT Month, MIN(Sales) AS LowestSales FROM Pharma_data GROUP BY Month;




WITH SubchannelSales AS (
SELECT
Country,
[Sub-channel],
SUM(Sales) AS TotalSales
FROM
Pharma_data
GROUP BY
Country, [Sub-channel]
),
RankedSubchannelSales AS (
SELECT
Country,
[Sub-channel],
TotalSales,
ROW_NUMBER() OVER (PARTITION BY [Sub-channel] ORDER BY TotalSales DESC) AS SalesRank
FROM
SubchannelSales
)
SELECT
Country,
[Sub-channel],
TotalSales
FROM
RankedSubchannelSales
WHERE
SalesRank = 1;