--Question 1
--Retrieve information about the products with colour values except null, red, silver/black, white 
--and list price between£75 and £750. 
--Rename the column StandardCost to Price. Also, sort the results in descending order by list price.
select Color, Name, StandardCost as Price, ListPrice from Production.Product
where Color is not null and Color not in ('Red', 'Siver/Black', 'White') and ListPrice between 75 and 750
order by ListPrice desc;

--Question 2
--Find all the male employees born between 1962 to 1970 and with hire date greater than 2001 
--and female employees born between 1972 and 1975 and hire date between 2001 and 2002.
select BusinessEntityID, Gender, Year(BirthDate), year(HireDate) from HumanResources.Employee
where ((Gender = 'F') and (Year(BirthDate) between 1972 and 1975) and (Year(HireDate) in (2001,2002)) 
or ((Gender = 'M') and (Year(BirthDate) between 1962 and 1970) and (Year(HireDate) > 2001)));

--Question 3
--Create a list of 10 most expensive products that have a product number beginning with ‘BK’. 
--Include only the productID, Name and colour
select top 10 productID, Name, color from Production.Product
where ProductNumber like 'BK%'
order by ListPrice desc; 

--Question 4 : Create a list of all contact persons
--where the first 4 characters of the last name are the same as the first four characters of the email address. 
--Also, for all contacts whose first name and the last name begin with the same characters, 
--create a new column called full name combining first name and the last name only. 
--Also provide the length of the new column full name.
select PP.BusinessEntityID, PP.FirstName,PP.LastName,PE.EmailAddress,concat(PP.FirstName,' ', PP.LastName) 
as Full_Name, len(concat(PP.FirstName,' ', PP.LastName)) as len_full_name from [Person].[Person] AS PP
inner join [Person].[EmailAddress] as PE
on PP.BusinessEntityID = PE.BusinessEntityID
where (substring(PP.LastName,1,4) = substring(PE.EmailAddress,1,4)) 
and (substring(PP.FirstName,1,1) = substring(PP.LastName,1,1));

--Question 5
--Return all product subcategories that take an average of 3 days or longer to manufacture.
select PPS.ProductSubcategoryID, PPS.Name, PP.DaysToManufacture from Production.ProductSubcategory as PPS
left join Production.Product as PP
on PPS.ProductSubcategoryID = PP.ProductSubcategoryID
where DaysToManufacture >=3;


--Question 6
--Create a list of product segmentation by defining criteria that places each item in a predefined segment as follows. 
--If price gets less than £200 then low value. If price is between £201 and £750 then mid value. If between £750 and £1250
--then mid to high value else higher value. Filter the results only for black, silver and red color products.
select * from Production.Product;

select ProductID,Name,ListPrice,Color, 
case 
when ListPrice < 200
then 'Low Value'
when ListPrice between 201 and 750
then 'Mid Value'
when ListPrice between 750 and 1250
then 'Mid to High Value'
else 'Higher Value' 
end as product_segmentation
from Production.Product
where Color in ('Red','Black','Silver')

--Question 7
--How many Distinct Job title is present in the Employee table?
select count (distinct JobTitle) as distinctcount_jobtitle from HumanResources.Employee;

--Question 8
--Use employee table and calculate the ages of each employee at the time of hiring.
select BusinessEntityID, datediff(year, BirthDate, HireDate) as Age_at_time_of_hire from HumanResources.Employee;

--Question 9
--How many employees will be due a long service award in the next 5 years, if long service is 20 years?
SELECT COUNT(*) AS EmployeesWithLongServiceAward
FROM HumanResources.Employee
WHERE DATEDIFF(year, HireDate, GETDATE()) >= 20
AND DATEDIFF(year, HireDate, DATEADD(year, 5, GETDATE())) >= 20
AND DATEDIFF(year, HireDate, DATEADD(year, 5, GETDATE())) < 25;

--Question 10
--How many more years does each employee have to work before reaching sentiment, if sentiment age is 65?
select BusinessEntityID, DATEDIFF (year, BirthDate, ModifiedDate) AS Age, 
CASE 
    when DATEDIFF (year, BirthDate, ModifiedDate) >= 65 then 0 
    else 65 - DATEDIFF (year, BirthDate, ModifiedDate) END AS 'Years to Sentient' 
from HumanResources.Employee;

SELECT BusinessEntityID, 65 - (CAST(DATEDIFF (year, BirthDate, ModifiedDate)AS INT)) AS YTR FROM HumanResources.Employee;

--Question 11
--Implement new price policy on the product table base on the colour of the item
--If white increase price by 8%, If yellow reduce price by 7.5%, If black increase price by 17.2%. If multi, silver,
--silver/black or blue take the square root of the price and double the value. Column should be called Newprice. For
--each item, also calculate commission as 37.5% of newly computed list price.
SELECT ProductID, Name, Color, ListPrice,
    CASE 
        WHEN Color = 'White' THEN ListPrice * 1.08
        WHEN Color = 'Yellow' THEN ListPrice * 0.925
        WHEN Color = 'Black' THEN ListPrice * 1.172
        WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN SQRT(ListPrice) * 2
        ELSE ListPrice
    END AS NewPrice,
    (CASE 
        WHEN Color = 'White' THEN ListPrice * 1.08
        WHEN Color = 'Yellow' THEN ListPrice * 0.925
        WHEN Color = 'Black' THEN ListPrice * 1.172
        WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN SQRT(ListPrice) * 2
        ELSE ListPrice
    END) * 0.375 AS Commission
FROM  Production.Product;


--Question 12
--Print the information about all the Sales.Person and their sales quota. For every Sales person you should provide their
--FirstName, LastName, HireDate, SickLeaveHours and Region where they work.
select FirstName, LastName, CountryRegionName AS Region, SPQ.SalesQuota, HRE.HireDate, HRE.SickLeaveHours 
	from Sales.vSalesPerson SP
	inner join HumanResources.Employee HRE
	on SP.BusinessEntityID = HRE.BusinessEntityID
	inner join Sales.SalesPersonQuotaHistory SPQ
	on SP.BusinessEntityID = SPQ.BusinessEntityID;
	


--Question 13
--Using adventure works, write a query to extract the following information • Product name, • Product category name
--• Product subcategory name, • Sales person, • Revenue, • Month of transaction, • Quarter of transaction, • Region
SELECT pp.Name AS ProductName, pc.Name AS ProductCategory, psc.Name AS ProductSubcategory,
    CONCAT(pe.FirstName, ' ', pe.LastName) AS SalesPerson, soh.TotalDue AS Revenue,
    MONTH(soh.OrderDate) AS MonthOfTransaction, DATENAME(QUARTER, soh.OrderDate) AS QuarterOfTransaction, st.Name AS Region
FROM Sales.SalesOrderHeader soh
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN 
    Production.Product pp ON sod.ProductID = pp.ProductID
JOIN 
    Production.ProductSubcategory psc ON pp.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN 
    Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN 
    Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN 
    Person.Person pe ON sp.BusinessEntityID = pe.BusinessEntityID
JOIN 
    Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID;
	

--Question 14
--Display the information about the details of an order i.e. order number, order date, amount of order, which customer
--gives the order and which salesman works for that customer and how much commission he gets for an order.


--Question 15: For all the products calculate
 -- Commission as 14.790% of standard cost,
-- Margin, if standard cost is increased or decreased as follows: Black: +22%, Red: -12%, Silver: +15%, Multi: +5%
--White: Two times original cost divided by the square root of cost. For other colours, standard cost remains the same
SELECT ProductID, Name AS ProductName, Color, StandardCost,
    CASE
        WHEN Color = 'Black' THEN StandardCost * 1.22
        WHEN Color = 'Red' THEN StandardCost * 0.88
        WHEN Color = 'Silver' THEN StandardCost * 1.15
        WHEN Color = 'Multi' THEN StandardCost * 1.05
        WHEN Color = 'White' THEN (StandardCost * 2) / SQRT(StandardCost)
        ELSE StandardCost
    END AS AdjustedStandardCost, StandardCost * 0.1479 AS Commission,
    CASE
        WHEN Color = 'Black' THEN StandardCost * 0.22
        WHEN Color = 'Red' THEN StandardCost * -0.12
        WHEN Color = 'Silver' THEN StandardCost * 0.15
        WHEN Color = 'Multi' THEN StandardCost * 0.05
        WHEN Color = 'White' THEN (StandardCost * 2) / SQRT(StandardCost) - StandardCost
        ELSE 0
    END AS Margin
FROM 
    Production.Product;

--Question 16: Create a view to find out the top 5 most expensive products for each colour.
CREATE VIEW Top5MostExpensiveProductsByColor AS
SELECT * FROM ( SELECT  ProductID, Name AS ProductName, Color, StandardCost,
        ROW_NUMBER() OVER (PARTITION BY Color ORDER BY ListPrice DESC) AS RowNum
    FROM  Production.Product) AS RankedProducts
WHERE  RowNum <= 5;

select * from Top5MostExpensiveProductsByColor;