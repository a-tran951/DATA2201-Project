/** DATA2201: Bow Valley College
	Group 2: Alex Tran, Connor Pittman & Janine Neville
	Group project: SKS Bank database
	Version: 7.2
	Instructor: Nisha Radhamoni  **/


USE master
GO

/**  Object:  Database SKS  **/
IF DB_ID('SKS') IS NOT NULL
	DROP DATABASE SKS
GO

CREATE DATABASE SKS
GO 

USE SKS
GO



/**  Object:  Table Branch  **/   
CREATE TABLE Branch(
	BranchID INT PRIMARY KEY IDENTITY(1,1),
	BranchName VARCHAR (50) NOT NULL,
	City VARCHAR (50) NOT NULL
	)
GO


/**  Object:  Table Employee  **/   
CREATE TABLE Employee(
	EmployeeID INT PRIMARY KEY IDENTITY(101,1) NOT NULL,
	EmployeePos VARCHAR (50) NOT NULL,
	FirstName VARCHAR (50) NOT NULL,
	LastName VARCHAR (50) NOT NULL,
	HomeAddress VARCHAR (100) NOT NULL,
	HireDate VARCHAR (50),
	ManagerID VARCHAR (5),
	PayRate MONEY,
	BranchID VARCHAR (10), 
	WorkLocation VARCHAR (50),
	LocationType VARCHAR (10) 
	)
GO


/**  Object:  Table Customer  **/    
CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY IDENTITY(200,1) NOT NULL,
	FirstName VARCHAR (50) NOT NULL,
	LastName VARCHAR (50) NOT NULL,
	HomeAddress VARCHAR (100) NOT NULL,
	Phone VARCHAR (25) NOT NULL,
	BankerEmpID INT NULL,
	LoanOfficerEmpID INT NULL
	)
GO


/**  Object:  Table Account  **/   
CREATE TABLE Account(
	AccountID INT PRIMARY KEY,
	CustomerID INT NOT NULL,
	AccountType VARCHAR (50) NOT NULL,
	Balance MONEY,
	BranchID INT NOT NULL,
	InterestRate DECIMAL(3,3) NULL,
	LastAccessed DATE NULL,
	DateOpened DATE NULL
	)
GO


/**  Object:  Table AccountTransactions  **/   
CREATE TABLE AccountTransactions(
	TransactionID INT PRIMARY KEY IDENTITY(151,1),
	AccountID INT NOT NULL,
	CustomerID INT NOT NULL,
	Deposit MONEY NULL,
	Withdrawal MONEY NULL,
	BranchID INT NOT NULL,
	TransactionDate DATE NULL,
	OverdraftDate DATE NULL,
	OverdraftAmount MONEY NULL,
	OverdraftChequeNo INT NULL
	)
GO

/**  Object:  Table Loans  **/   
CREATE TABLE Loans(
	LoanID INT PRIMARY KEY IDENTITY(10,1),
	BranchID INT NOT NULL,
	CustomerID INT NOT NULL,
	PrincipalAmount MONEY,
	LoanDate DATE NOT NULL
	)
GO


/**  Object:  Table Loan Payments  **/   
CREATE TABLE LoanPayments(
	LoanPaymentID INT PRIMARY KEY IDENTITY(20,1),
	BranchID INT NOT NULL,
	LoanID INT NOT NULL,
	CustomerID INT NOT NULL,
	Amount MONEY NOT NULL,
	PaymentDate DATE NOT NULL
	)
GO


/**  Adding records to the Branch table  **/ 
INSERT Branch (BranchName, City) VALUES
	('Cranston', 'Calgary'),
	('Crescent Heights', 'Calgary'),
	('Westmount', 'Edmonton'),
	('Sunridge', 'Calgary'),
	('Country Hills', 'Calgary'),
	('Pleasantview', 'Edmonton'),
	('Downtown', 'Calgary'),
	('Bowness', 'Calgary'),
	('Inglewood', 'Calgary'),
	('Shawnessy', 'Calgary'),
	('Valley Ridge', 'Calgary'),
	('Coventry Hills', 'Calgary'),
	('Shaganappi', 'Calgary'),
	('Sage Hill', 'Calgary'),
	('Panorama Hills', 'Calgary'),
	('East Village', 'Calgary')
GO


/**  Adding records to the Employee table  **/ 
INSERT Employee (EmployeePos, FirstName, LastName, HomeAddress, HireDate, ManagerID, PayRate, BranchID, WorkLocation, LocationType) VALUES
	('Banker', 'Robert', 'Parr', '212 Mount Royal Drive SW Calgary', '2010-03-05', 111, $21.00, 107, 'Downtown', 'Branch'),
	('Loan Officer', 'Sara', 'Levin', '2101 16 Avenue NW Calgary', '2009-10-03', 111, $24.00, 116, 'East Village', 'Branch'),
	('Banker', 'Jacob', 'Tremblay', '2017 Abbottsfield Road NW Edmonton', '2019-12-21', 114, $21.00, 113, 'Shaganappi', 'Branch'),
	('Banker', 'Yun', 'Chow', '812 Riverbend Circle SE Calgary', '2018-08-30', 111, $21.00, 108, 'Bowness', 'Branch'),
	('Loan Officer', 'Alex', 'Armstrong', '432 Martindale Avenue NE Calgary', '2020-12-07', 118, $24.00, 112, 'Coventry Hills', 'Branch'),
	('Banker', 'Helen', 'Parr', '212 Mount Royal Drive SW Calgary',  '2017-10-10', 114, $21.00, 101, 'Cranston', 'Branch'), 
	('Banker', 'Edward', 'Elric', '123 45 Street SW Calgary', '2018-09-22', 111, $21.00, 111, 'Valley Ridge', 'Branch'),
	('Banker', 'Mary', 'Turner', '1200 Cranston Blvd SW Calgary', '2001-05-26', 114, $21.00, 110, 'Shawnessy', 'Branch'),
	('Banker', 'Sofia', 'Torres', '645 Dover Street SW Calgary', '2015-02-11', 118, $21.00, 115, 'Panorama Hills', 'Branch'),
	('Banker', 'Ahmed', 'Chavan', '601 Coach Hill Street SW Calgary', '2005-05-05', 118, $21.00, 107, 'Downtown', 'Branch'),
	('Manager', 'Bradley', 'King', '1402 Bowness Street NW Calgary', '2003-04-01', NULL, $32.00, NULL, 'Beltline', 'Office'),
	('Banker', 'Francine', 'Smith', '291 Windemere Crescent SW Calgary', '2015-01-28', 111, $21.00, 111, 'Valley Ridge', 'Branch'),
	('Banker', 'Alphonse', 'Elric', '123 45 Street SW Calgary', '2019-07-16', 118, $21.00, 104, 'Sunridge', 'Branch'),
	('Manager', 'Walter', 'White', '3828 Piermont Drive NE Calgary', '2016-11-20', NULL, $32.00, NULL, 'Silverado', 'Office'),	
	('Loan Officer', 'Olivia', 'Harper', '6078 Cloverdale Avenue NW Edmonton','2004-09-18', 114, $24.00, '106', 'Pleasantview', 'Branch'),
	('Banker', 'Fatima', 'Montes', '5456 Heritage Valley Street SW Edmonton', '2008-07-31', 114, $21.00, 103, 'Westmount', 'Branch'),
	('Banker', 'Nora', 'Cooper', '400 Abbeydale Lane NE Calgary', '2017-12-30', 111, $21.00, 109, 'Inglewood', 'Branch'),
	('Manager', 'Edna', 'Mode', '1920 Centre Street NW Calgary', '2001-11-07', NULL, $32.00, 112, 'Coventry Hills', 'Branch')
GO


/**  Adding records to the Customer table  **/   
INSERT Customer (FirstName, LastName, HomeAddress, Phone, BankerEmpID, LoanOfficerEmpID) VALUES 
	('Joellen', 'Beasley', '34 Abbeydale Drive SE Calgary', '403-444-2394', 113, 102),
	('Vanessa', 'Deslauriers', '2439 48 Street SE Calgary', '587-882-7203', 117, 105),
	('Nadr', 'Abourachad', '237 Windemere Crescent SW Calgary', '587-494-0000', 101, NULL),
	('Thomas', 'Marriott', '1004 8 Avenue SW Calgary', '403-255-1499', 110, NULL),
	('James', 'McPhee', '7828 48 Street NW Calgary', '403-292-1049', 109, NULL),
	('Susan', 'Coronel', '104 Riverdale Avenue SW Calgary', '587-717-9898', 103, NULL),
	('Armando', 'Coronel', '104 Riverdale Avenue SW Calgary', '587-717-9898', 106, 105),
	('Sujay', 'Ravichandran', '1838 33 Street SW Calgary', '403-856-9122', 104, 102),
	('Danica', 'Sparks', '3538 2 Street SW Calgary', '587-404-1311', 117, NULL),
	('Maninder', 'Toor', '8 Mount Royal Drive SW Calgary', '403-495-1092', 107, NULL),
	('Anik', 'Merrill', '82A Pasena Crescent SW Calgary', '403-999-5555', 108, 115),
	('Odessa', 'Montague', '1207 52 Street SW Calgary', '587-283-4030', 116, NULL),
	('Ralph', 'Keizer', '2370 45 Street SW Calgary', '587-994-3093', 113, NULL),
	('Travis', 'Phinney', '10410 114 Street SW Edmonton', '587-584-7007', 104, 115),
	('Pearl', 'Dunham', '1901 Centre Street NW Calgary', '403-229-3119', 106, NULL),
	('Francis', 'Belliveau', '1948 16 Avenue NW Calgary', '403-595-6172', 112, NULL),
	('Marcel', 'Plourde', '3632 28 Avenue NE Calgary', '403-223-8418', 101, 115),
	('Madison', 'Atkinson', '237 Windemere Crescent SW Calgary', '403-208-4391', 107, NULL),
	('Jason', 'Atkinson', '237 Windemere Crescent SW Calgary', '403-208-4391', 117, NULL),
	('Frank', 'Wong', '28 Bridgeview Drive Cochrane', '587-301-2280', 104, NULL)
GO


/**  Adding records to the Account table  **/ 
INSERT Account (AccountID, CustomerID, AccountType, Balance, BranchID, InterestRate, LastAccessed, DateOpened) VALUES
	(2503681, 200, 'Chequing', $6780.00, 1, NULL, '2021-11-04', '2018-02-16'),
	(596046, 201, 'Saving', $18.00, 4, 0.01, '2020-12-30', '2001-01-02'),
	(213281, 202, 'Chequing', $10999.81, 6, NULL, '2021-11-10', '1998-11-13'),
	(1571618, 203, 'Chequing', $343.88, 8, NULL, '2021-11-09', '2007-10-03'),
	(1756788, 204, 'Saving', $1239.02, 1, 0.01, '2021-02-11', '2021-02-10'),
	(1947453, 205, 'Saving', $8900.74, 3, 0.01, '2021-09-03', '2020-09-08'),
	(1521355, 206, 'Saving', $9900.18, 2, 0.01, '2021-05-17', '2021-04-01'),
	(1177887, 207, 'Chequing', $608.58, 4, NULL, '2021-11-01', '2009-03-18'),
	(1108061, 208, 'Saving', $2988.11, 5, 0.01, '2021-10-14', '2015-12-01'),
	(1947492, 209, 'Saving', $701.21, 7, 0.01, '2021-06-02', '2019-05-14'),
	(87580, 210, 'Chequing', $844.38, 3, NULL, '2021-11-09', '2017-11-22'),
	(117701, 211, 'Chequing', $12.78, 2, NULL, '2021-09-20', '2020-06-28'),
	(1262055, 212, 'Chequing', $294.84, 9, NULL, '2021-11-10', '2008-07-02'),
	(86949, 213, 'Saving', $3859.47, 7, 0.01, '2021-09-30', '2020-09-24'),
	(4933919, 214, 'Chequing', $20300.16, 5, NULL, '2021-10-15', '2003-11-13'),
	(294920, 215, 'Chequing', $3401.05, 2, NULL, '2021-09-08', '2018-05-19'),
	(304020, 216, 'Saving', $5195.55, 8, 0.01, '2021-11-05', '2019-07-25'),
	(2040501, 217, 'Saving', $481.30, 9, 0.01, '2021-04-03', '2001-01-29'),
	(4995999, 218, 'Chequing', $99.50, 3, NULL, '2021-10-31', '2015-07-26'),
	(1412494, 219, 'Chequing', $5010.33, 4, NULL, '2021-11-15', '2020-03-04'),
	(5929592, 220, 'Chequing', $69.40, 5, NULL, '2021-11-01', '2021-08-16')
GO


/**  Adding records to the AccountTransactions table  **/ 
INSERT AccountTransactions (AccountID, CustomerID, Deposit, Withdrawal, BranchID, TransactionDate, OverdraftDate, OverdraftAmount, OverdraftChequeNo) VALUES
	(1756788, 204, $9.00, NULL, 1, '2021-02-02', NULL, NULL, NULL),
	(213281, 202, $1000.00, NULL, 6, '2021-10-05',  NULL, NULL, NULL),
	(1571618, 203, $80.00, NULL, 8, '2021-11-07', NULL, NULL, NULL),
	(1947453, 205, $900.50, NULL, 3, '2021-09-03', NULL, NULL, NULL),
	(1108061, 208, $88.10, NULL, 5, '2021-09-20', NULL, NULL, NULL),
	(1177887, 207, $608.58, NULL, 4, '2021-11-01',  NULL, NULL, NULL),
	(596046, 201, NULL, $1235.00, 1, '2020-12-15',  NULL, NULL, NULL),
	(1947492, 209, $50.00, NULL, 7, '2021-05-31', NULL, NULL, NULL),
	(117701, 211, NULL, NULL, 2, '2021-09-15', '2020-09-15', $800.00, 07),
	(87580, 210, $400.00, NULL, 3, '2021-11-01', NULL, NULL, NULL),
	(1262055, 212, $135.00, NULL, 9, '2021-11-05', NULL, NULL, NULL),
	(1412494, 219,  $5010.33, NULL, 1, '2021-11-15', NULL, NULL, NULL), 
	(4933919, 214, $1030.75, NULL, 5, '2021-10-15', NULL, NULL, NULL),
	(1521355, 206, $1000.00, NULL, 2, '2021-05-01', NULL, NULL, NULL),	
	(304020, 216,  NULL, $4910.39, 1, '2021-11-05',  NULL, NULL, NULL),
	(2040501, 217,  $25.00, NULL, 2, '2021-03-26',  NULL, NULL, NULL),
	(86949, 213,  $349.73, NULL, 7, '2021-09-02', NULL, NULL, NULL),
	(4995999, 218,  $18.00, NULL, 4, '2021-10-20',  NULL, NULL, NULL),
	(294920, 215,  NULL, $10800.00, 8, '2021-09-08',  NULL, NULL, NULL),
	(5929592, 220,  NULL, NULL, 3, '2021-07-31', '2021-07-31', $84.71, 230),
	(2503681, 200, NULL, NULL, 7, '2021-09-30', '2021-09-30', $200.00, 52)
GO


/**  Adding records to the Loans table  **/ 
INSERT Loans (BranchID, CustomerID, PrincipalAmount, LoanDate) VALUES
	(1, 214, $571000.00, '2021-08-15'),
	(1, 214, $25000.00, '2018-07-20'),
	(4, 208, $43078.38, '2020-06-07'),
	(8, 207, $2120000.00, '2021-05-30'),
	(3, 211, $749100.59, '2019-09-30'),
	(2, 202, $129405.70, '2020-12-02'),
	(7, 216, $17200.14, '2021-11-01'),
	(9, 201, $28309.99, '2018-08-01')
GO


/**  Adding records to the Loan Payments table  **/ 
INSERT LoanPayments (LoanID, BranchID, CustomerID, Amount, PaymentDate) VALUES
	(108, 9, 201, $409.57, '2021-09-01'),
	(104, 8, 207, $200000.00, '2021-09-30'),
	(108, 9, 201, $409.57, '2021-10-01'),
	(106, 2, 202, $84.19, '2021-10-01'),
	(102, 1, 214, $500.00, '2021-10-01'),
	(101, 1, 214, $8030.00, '2021-10-15'),
	(103, 4, 208, $714.35, '2021-10-15'),
	(104, 8, 207, $200000.00, '2021-10-30'),
	(105, 3, 211, $3199.87, '2021-10-30'),
	(106, 2, 202, $84.19, '2021-11-01'),
	(102, 1, 214, $500.00, '2021-11-01'),
	(108, 9, 201, $409.57, '2021-11-01'),
	(101, 1, 214, $8030.00, '2021-11-15'),
	(103, 4, 208, $714.35, '2021-11-15')
GO


/** Adding Foreign Key constraints to Employee Table **/
ALTER TABLE Employee
ADD CONSTRAINT FK_Branch_Employee
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID);


/** Adding Foreign Key constraints to Loans Table **/
ALTER TABLE Loans
ADD CONSTRAINT FK_Branch_Loans
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID);

ALTER TABLE Loans
ADD CONSTRAINT FK_Customer_Loans
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);


/** Adding Foreign Key constraints to LoanPayments Table **/
ALTER TABLE LoanPayments
ADD CONSTRAINT FK_Branch_LoanPayments
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID);

ALTER TABLE LoanPayments
ADD CONSTRAINT FK_Customer_LoanPayments
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);


/** Adding Foreign Key constraints to Account Table **/
ALTER TABLE Account
ADD CONSTRAINT FK_Branch_Account
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID);

ALTER TABLE Account
ADD CONSTRAINT FK_Customer_Account
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);


/** Adding Foreign Key constraints to AccountTransactions Table **/
ALTER TABLE AccountTransactions
ADD CONSTRAINT FK_Branch_AccountTransactions
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID);

ALTER TABLE AccountTransactions
ADD CONSTRAINT FK_Customer_AccountTransactions
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE AccountTransactions
ADD CONSTRAINT FK_Account_AccountTransactions
FOREIGN KEY (AccountID) REFERENCES Account(AccountID);