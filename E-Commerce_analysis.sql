use E_COMMERCE;
select * from Customer_Detail;
select * from Product_Detail;
select * from Order_details;
select * from Sales_Detail;
select count(Category) from Product_Detail where Sub_Category= "Bookcases";

desc Customer_Detail;
desc Product_Detail;
desc Order_details;
desc Sales_Detail;

drop table Customer_Detail;
drop table Product_Detail;
drop table Order_details;
drop table Sales_Detail;

/**JOINs Questions**/

-- 1 Show the Sub_Category and their total sales amount for a specific date.
select distinct Sub_Category,sum(Amount),orderd_date 
from Product_Detail 
JOIN Sales_Detail on Product_Detail.Prod_ID=Sales_Detail.Prod_ID
JOIN Order_details on Order_details.order_id=Sales_Detail.order_id
where orderd_date = '05-01-2019'
group by Sub_Category;

-- 2 Display the customer names who have made more than 5 purchases.
select Customer_Detail.Customer_ID,CustomerName, Quantity
from Customer_Detail 
JOIN Product_Detail on Customer_Detail.Customer_ID=Product_Detail.Customer_ID
JOIN Sales_Detail on Product_Detail.Prod_ID=Sales_Detail.Prod_ID
where Quantity>5;


-- 3 Find the total amount and positive profit for each product sold, along with the customer details who made the purchase.
SELECT CD.CustomerName, SD.Prod_ID, Sub_Category, SUM(SD.Amount) AS TotalAmount, SUM(SD.Profit) AS TotalProfit
FROM Customer_Detail CD
JOIN Order_details OD ON CD.Customer_ID = OD.Customer_ID
JOIN Sales_Detail SD ON OD.order_id = SD.order_id
JOIN Product_Detail PD ON PD.Prod_ID=SD.Prod_ID
WHERE SD.Profit>0
GROUP BY 
CD.CustomerName, SD.Prod_ID;

-- 4 Show the top 5 customers who have spent the most amount in total, along with details of their purchases.
SELECT CD.CustomerName, SUM(SD.Amount) AS TotalSpent
FROM Customer_Detail CD
JOIN Order_details OD ON CD.Customer_ID = OD.Customer_ID
JOIN Sales_Detail SD ON OD.order_id = SD.order_id
GROUP BY 
CD.CustomerName
ORDER BY 
TotalSpent DESC LIMIT 5;

-- 5 List the products that have been ordered by more than one customer, along with the customer names who ordered them.
SELECT PD.Sub_Category, COUNT(DISTINCT CD.Customer_ID) AS NumCustomers, GROUP_CONCAT(CD.CustomerName) AS CustomerNames
FROM Product_Detail PD
JOIN Sales_Detail SD ON PD.Prod_ID = SD.Prod_ID
JOIN Order_details OD ON SD.order_id = OD.order_id
JOIN Customer_Detail CD ON OD.Customer_ID = CD.Customer_ID
GROUP BY PD.Sub_Category
HAVING NumCustomers > 1
order by NumCustomers ASC;

/* 6 List the names of customers who have made at least two orders and include the total number of orders they have made. 
Display the results in descending order based on the total number of orders.*/
SELECT CD.CustomerName,
    COUNT(OD.Order_ID) AS TotalOrders
FROM Customer_Detail CD
JOIN Order_details OD ON CD.Customer_ID = OD.Customer_ID
GROUP BY CD.Customer_ID, CD.CustomerName
HAVING COUNT(OD.Order_ID) >= 2
ORDER BY
TotalOrders DESC;

-- 7 List total profit and total sales with customer ID for mumbai city
SELECT CD.Customer_ID,
CD.CustomerName,
CD.City,
SUM(SD.Amount) AS TotalSales,
SUM(SD.Profit) AS TotalProfit
FROM Customer_Detail CD
JOIN Product_Detail PD ON CD.Customer_ID = PD.Customer_ID
JOIN Order_details OD ON PD.Order_ID = OD.order_id
JOIN Sales_Detail SD ON PD.Prod_ID = SD.Prod_ID AND PD.Order_ID = SD.order_id
WHERE CD.City = 'Mumbai'  
GROUP BY CD.Customer_ID, CD.CustomerName, CD.City
ORDER BY CustomerName ASC;


-- 1 Retrieve the order IDs for orders placed by a specific customer.
SELECT *
FROM Order_details
WHERE customer_id = (SELECT customer_id FROM Customer_Detail WHERE CustomerName = 'Pearl');

-- 2 Find orders where the quantity sold is greater than the average quantity sold.
SELECT *
FROM Sales_Detail
WHERE Quantity > (SELECT AVG(Quantity) FROM Sales_Detail);

-- 3 Retrieve the product details for orders placed in a specific cities.
SELECT *
FROM Product_Detail
WHERE Order_ID IN (SELECT Order_ID FROM Order_Details WHERE Customer_ID IN (SELECT Customer_ID FROM Customer_Detail WHERE City = 'Pune' or City='Jaipur'));

-- 4 Get the total quantity sold for a specific category.
SELECT SUM(Quantity)
FROM Sales_Detail
WHERE Prod_ID IN (SELECT Prod_ID FROM Product_Detail WHERE Category = 'Electronics');

-- 5 Retrieve orders with the highest sales amount.
SELECT *
FROM Sales_Detail
WHERE Amount = (SELECT MAX(Amount) FROM Sales_Detail);



-- 1 Calculate the total number of orders placed using each payment method.
SELECT payment_method, COUNT(Order_ID) AS OrderCount
FROM Order_details
GROUP BY payment_method;

-- 2 Retrieve the orders with the highest total sales amount.
SELECT Order_ID, SUM(Amount) AS TotalSales
FROM Sales_Detail
GROUP BY Order_ID
ORDER BY TotalSales DESC
LIMIT 1;

-- 3 List the products with their corresponding categories and sub-categories.
SELECT Prod_ID, Category, Sub_Category
FROM Product_Detail
where Category="Furniture" AND Sub_Category="Chairs";

-- 4 Retrieve the products in the 'Electronics' category.
SELECT *
FROM Product_Detail
WHERE Category = 'Electronics' ;

-- 5 Find the average profit per order.
SELECT 
AVG(Profit) AS AverageProfit_or_loss
FROM
Sales_Detail;

-- 6 List Customers from Maharashtra

select Customer_ID, CustomerName, State 
from Customer_Detail 
where State =  'Maharashtra';

-- 7 change row consrtraints to not null
alter table Product_Detail
modify Category varchar(567) not null;

-- 8 Update state where spcific customer_id
update Customer_Detail
set state= "Raigad" where Customer_ID='B-25606';

-- 9 show amount of product more than 400
select * from Sales_Detail 
where Amount > 400;

-- 10 Show details where profit is not negative and quantity more than 5
select * from Sales_Detail
where Profit >=40 and Quantity < 5;

-- 11 show details where customer name is ending with "n"
select * from Customer_Detail where CustomerName like "%n";

-- 12 How many Customers Buy Phones on UPI
select * from Order_details 
join Product_Detail on Order_details.Order_ID=Product_Detail.Order_ID
where Payment_Method = "UPI" and Sub_Category="Phones";

-- 13 List top 5 max paid amount
SELECT Prod_ID, Max(Amount) as TOP_PAY
FROM Sales_Detail
GROUP BY Prod_ID
ORDER BY TOP_PAY DESC
limit 5;

-- 14 find Minimum profit in Negative with number of Quantities
SELECT Quantity, MIN(Profit) as MIN_P
FROM Sales_Detail
GROUP BY Quantity
HAVING MIN_P < 0
order by MIN_P DESC;




 

