USE Northwind;


-- ==================================================================
--1) We have a table called Shippers. Return all the fields
--   from all the shippers
-- ==================================================================

SELECT * FROM Shippers;


-- ==================================================================
--2)In the Categories table, selecting all the fields using
--	this SQL:
--	Select * from Categories
--	…will return 4 columns. We only want to see two
--	columns, CategoryName and Description
-- ==================================================================

SELECT 
	CategoryName, 
	Description 
FROM Categories;


-- ==================================================================
--3)Sales Representatives
--	We’d like to see just the FirstName, LastName, and
--	HireDate of all the employees with the Title of Sales
--	Representative. Write a SQL statement that returns
--	only those employees.
-- ==================================================================

SELECT 
	FirstName, 
	LastName, 
	HireDate 
FROM Employees
WHERE Title = 'Sales Representative';


-- ==================================================================
--4)Sales Representatives in the United States
--	Now we’d like to see the same columns as above, but
--	only for those employees that both have the title of
--	Sales Representative, and also are in the United
--	States
-- ==================================================================

SELECT 
	FirstName, 
	LastName, 
	HireDate 
FROM Employees
WHERE Title = 'Sales Representative' AND Country = 'USA';


-- ==================================================================
--5)Orders placed by specific EmployeeID
--	Show all the orders placed by a specific employee.
--	The EmployeeID for this Employee (Steven
--	Buchanan) is 5
-- ==================================================================

SELECT 
	OrderID,
	OrderDAte 
FROM Orders
WHERE EmployeeID = 
	(SELECT EmployeeID 
	FROM Employees 
	WHERE LastName = 'Buchanan' AND FirstName = 'Steven'); -- extract ID searching it based on first and last name


-- ==================================================================
--6) Suppliers and ContactTitles
--In the Suppliers table, show the SupplierID,
--ContactName, and ContactTitle for those Suppliers
--whose ContactTitle is not Marketing Manager
-- ==================================================================

SELECT 
	SupplierID, 
	ContactName,
	ContactTitle 
FROM Suppliers
WHERE ContactTitle <> 'Marketing Manager';

-- Not equals: <>, !=, NOT IN (list of invalid arguments)


-- ==================================================================
--7) Products with “queso” in ProductName
--In the products table, we’d like to see the ProductID
--and ProductName for those products where the
--ProductName includes the string “queso”.
-- ==================================================================

SELECT 
	ProductID,
	ProductName 
FROM Products
WHERE ProductName LIKE('%queso%');


-- ==================================================================
--8) Orders shipping to France or Belgium
--Looking at the Orders table, there’s a field called
--ShipCountry. Write a query that shows the OrderID,
--CustomerID, and ShipCountry for the orders where
--the ShipCountry is either France or Belgium.
-- ==================================================================


SELECT * FROM Orders

SELECT 
	OrderID, 
	CustomerID, 
	ShipCountry 
FROM Orders
WHERE ShipCountry IN ('France', 'Belgium');


-- ==================================================================
--9. Orders shipping to any country in Latin
--America
--	Now, instead of just wanting to return all the orders
--	from France of Belgium, we want to show all the
--	orders from any Latin American country. But we
--	don’t have a list of Latin American countries in a
--	table in the Northwind database. So, we’re going to
--	just use this list of Latin American countries that
--	happen to be in the Orders table:
--		Brazil
--		Mexico
--		Argentina
--		Venezuela
--	It doesn’t make sense to use multiple Or statements
--	anymore, it would get too convoluted. Use the In
--	statement.
-- ==================================================================

SELECT 
	OrderID, 
	CustomerID, 
	ShipCountry 
FROM Orders 
WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela');


-- ==================================================================
--10) Employees, in order of age
--	For all the employees in the Employees table, show
--	the FirstName, LastName, Title, and BirthDate.
--	Order the results by BirthDate, so we have the oldest
--	employees first.
-- ==================================================================

SELECT 
	FirstName + ' ' + LastName AS FullName,
	Title,
	BirthDate 
FROM Employees 
ORDER BY BirthDate; -- by default sort in ASC (ascending) order, we can use DESC flag to reverse

-- ==================================================================
--11. Showing only the Date with a DateTime field
--	In the output of the query above, showing the
--	Employees in order of BirthDate, we see the time of
--	the BirthDate field, which we don’t want. Show only
--	the date portion of the BirthDate field.
-- ==================================================================

SELECT 
	FirstName + ' ' + LastName AS FullName,
	Title,
	CONVERT(DATE, BirthDate) 
FROM Employees 
ORDER BY BirthDate; -- by default sort in ASC (ascending) order, we can use DESC flag to reverse

-- ==================================================================
--12. Employees full name
--	Show the FirstName and LastName columns from
--	the Employees table, and then create a new column
--	called FullName, showing FirstName and LastName
--	joined together in one column, with a space inbetween.
-- ==================================================================

SELECT 
	FirstName ,
	LastName ,
	CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

-- Note: use CONCAT() when you know that one of the fields might contain NULL values

-- ==================================================================
--13. OrderDetails amount per line item
--	In the OrderDetails table, we have the fields
--	UnitPrice and Quantity. Create a new field,
--	TotalPrice, that multiplies these two together. We’ll
--	ignore the Discount field for now.
--	In addition, show the OrderID, ProductID, UnitPrice,
--	and Quantity. Order by OrderID and ProductID.
-- ==================================================================

SELECT
	OrderID,
	ProductID,
	UnitPrice,
	Quantity,
	UnitPrice * Quantity AS TotalPrice
FROM [Order Details]
ORDER BY OrderID, ProductID DESC; -- ascendidng by OrderID, descending by ProductID


-- ==================================================================
--14. How many customers?
--	How many customers do we have in the Customers
--	table? Show one value only, and don’t rely on getting
--	the recordcount at the end of a resultset.
-- ==================================================================

SELECT  
	COUNT(CustomerID) AS TotalCustomers 
FROM Customers;


-- ==================================================================
--15. When was the first order?
--	Show the date of the first order ever made in the
--	Orders table.
-- ==================================================================

SELECT
	TOP(1) OrderDate AS FirstOrder
FROM Orders
ORDER BY OrderDate ASC;

-- Alternative
SELECT
	FirstOrder = MIN(OrderDate)
FROM Orders


-- ==================================================================
--16. Countries where there are customers
--	Show a list of countries where the Northwind
--	company has customers
-- ==================================================================

SELECT DISTINCT -- helpfull for easy queries
	Country
FROM Customers;


-- for more complex queries we end up using GROUP BY because it offers
-- more flexibility when we need to agregate multiple columns
SELECT 
	Country
FROM Customers
GROUP BY Country;


-- ==================================================================
--17. Contact titles for customers
--	Show a list of all the different values in the
--	Customers table for ContactTitles. Also include a
--	count for each ContactTitle.
--	This is similar in concept to the previous question
--	“Countries where there are customers”, except we
--	now want a count for each ContactTitle.
-- ==================================================================

SELECT
	ContactTitle,
	COUNT(ContactTitle) AS TotalTitles 
FROM Customers
GROUP BY ContactTitle
ORDER BY TotalTitles DESC; -- ordering is the last operation; we can only execute it after having retrieved all elemets

