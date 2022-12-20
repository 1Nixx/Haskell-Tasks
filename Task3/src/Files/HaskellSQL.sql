CREATE DATABASE HaskellDB;

GO

USE HaskellDB;

CREATE TABLE Customers (
	Id INT PRIMARY KEY IDENTITY,
	CustomerName NVARCHAR(50) NOT NULL,
	CustomerAddress NVARCHAR(50) NOT NULL
);

CREATE TABLE Shops (
	Id INT PRIMARY KEY IDENTITY,
	ShopName NVARCHAR(50) NOT NULL,
	ShopAddress NVARCHAR(50) NOT NULL
);

CREATE TABLE Products
(
	Id INT PRIMARY KEY IDENTITY,
	ProductShopId INT NOT NULL,
	ProductName NVARCHAR(50) NOT NULL,
	ProductPrice FLOAT NOT NULL,
	ProductColor NVARCHAR(50) NOT NULL,
	FOREIGN KEY (ProductShopId) REFERENCES Shops (Id)
); 

CREATE TABLE Orders (
	Id INT PRIMARY KEY IDENTITY,
	OrderCustomerId INT NOT NULL,
	OrderNumber NVARCHAR(50) NOT NULL,
	FOREIGN KEY (OrderCustomerId) REFERENCES Customers (Id)
)

CREATE TABLE ProductOrders (
	Id INT PRIMARY KEY IDENTITY,
	OrderFKId INT NOT NULL,
	ProdFKId INT NOT NULL,
	FOREIGN KEY (OrderFKId) REFERENCES Orders (Id),
	FOREIGN KEY (ProdFKId) REFERENCES Products (Id)
)

INSERT INTO Customers
VALUES 
	('Nikita', 'Minsk'),
	('Misha', 'Gomel'),
	('Andrey', 'USA')

INSERT INTO Shops
VALUES 
	('H&M', 'Minsk'),
	('Rybanok', 'Vitebsk'),
	('Malorita', 'Poland')

INSERT INTO Orders
VALUES 
	(2, '45AB'),
	(2, '555IK'),
	(1, '741hjk')

INSERT INTO Products
VALUES 
	(2, 'Molotok', 45.55, 'Black'),
	(2, 'Shayba', 789, 'White'),
	(1, 'T-Shirt', 666.66, 'Other')

INSERT INTO ProductOrders
VALUES 
	(1, 1),
	(1, 3),
	(3, 1),
	(2, 1)