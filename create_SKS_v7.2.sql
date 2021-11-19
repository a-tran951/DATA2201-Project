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
	BranchID INT, 
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
	AccountID INT PRIMARY KEY IDENTITY(101,1),
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
	LoanID INT PRIMARY KEY IDENTITY(101,1),
	BranchID INT NOT NULL,
	CustomerID INT NOT NULL,
	PrincipalAmount MONEY,
	LoanDate DATE NOT NULL
	)
GO


/**  Object:  Table Loan Payments  **/   
CREATE TABLE LoanPayments(
	LoanPaymentID INT PRIMARY KEY IDENTITY(20,1),
	PaymentNumber INT NOT NULL,
	BranchID INT NOT NULL,
	LoanID INT NOT NULL,
	AccountID INT NOT NULL,
	Amount MONEY NOT NULL,
	PaymentDate DATE NOT NULL
	)
GO

/**  Object:  Table CustomerAccount  **/ 
CREATE TABLE CustomerAccount(
	CustomerID INT NOT NULL,
	AccountID INT NOT NULL
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
	('Banker', 'Robert', 'Parr', '212 Mount Royal Drive SW Calgary', '2010-03-05', 111, $21.00, 1, 'Downtown', 'Branch'),
	('Loan Officer', 'Sara', 'Levin', '2101 16 Avenue NW Calgary', '2009-10-03', 111, $24.00, 2, 'East Village', 'Branch'),
	('Banker', 'Jacob', 'Tremblay', '2017 Abbottsfield Road NW Edmonton', '2019-12-21', 114, $21.00, 3, 'Shaganappi', 'Branch'),
	('Banker', 'Yun', 'Chow', '812 Riverbend Circle SE Calgary', '2018-08-30', 111, $21.00, 4, 'Bowness', 'Branch'),
	('Loan Officer', 'Alex', 'Armstrong', '432 Martindale Avenue NE Calgary', '2020-12-07', 118, $24.00, 5, 'Coventry Hills', 'Branch'),
	('Banker', 'Helen', 'Parr', '212 Mount Royal Drive SW Calgary',  '2017-10-10', 114, $21.00, 6, 'Cranston', 'Branch'), 
	('Banker', 'Edward', 'Elric', '123 45 Street SW Calgary', '2018-09-22', 111, $21.00, 7, 'Valley Ridge', 'Branch'),
	('Banker', 'Mary', 'Turner', '1200 Cranston Blvd SW Calgary', '2001-05-26', 114, $21.00, 8, 'Shawnessy', 'Branch'),
	('Banker', 'Sofia', 'Torres', '645 Dover Street SW Calgary', '2015-02-11', 118, $21.00, 9, 'Panorama Hills', 'Branch'),
	('Banker', 'Ahmed', 'Chavan', '601 Coach Hill Street SW Calgary', '2005-05-05', 118, $21.00, 10, 'Downtown', 'Branch'),
	('Manager', 'Bradley', 'King', '1402 Bowness Street NW Calgary', '2003-04-01', 118, $32.00, 11, 'Beltline', 'Office'),
	('Banker', 'Francine', 'Smith', '291 Windemere Crescent SW Calgary', '2015-01-28', 111, $21.00, 12, 'Valley Ridge', 'Branch'),
	('Banker', 'Alphonse', 'Elric', '123 45 Street SW Calgary', '2019-07-16', 118, $21.00, 13, 'Sunridge', 'Branch'),
	('Manager', 'Walter', 'White', '3828 Piermont Drive NE Calgary', '2016-11-20', 118, $32.00, 14, 'Silverado', 'Office'),	
	('Loan Officer', 'Olivia', 'Harper', '6078 Cloverdale Avenue NW Edmonton','2004-09-18', 114, $24.00, 15, 'Pleasantview', 'Branch'),
	('Banker', 'Fatima', 'Montes', '5456 Heritage Valley Street SW Edmonton', '2008-07-31', 114, $21.00, 16, 'Westmount', 'Branch'),
	('Banker', 'Nora', 'Cooper', '400 Abbeydale Lane NE Calgary', '2017-12-30', 111, $21.00, 12, 'Inglewood', 'Branch'),
	('Manager', 'Edna', 'Mode', '1920 Centre Street NW Calgary', '2001-11-07', 118, $32.00, 11, 'Coventry Hills', 'Branch')
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
INSERT Account ( AccountType, Balance, BranchID, InterestRate, LastAccessed, DateOpened) VALUES
	( 'Chequing', $6780.00, 1, NULL, '2021-11-04', '2018-02-16'),
	( 'Saving', $18.00, 4, 0.01, '2020-12-30', '2001-01-02'),
	( 'Chequing', $10999.81, 6, NULL, '2021-11-10', '1998-11-13'),
	( 'Chequing', $343.88, 8, NULL, '2021-11-09', '2007-10-03'),
	( 'Saving', $1239.02, 1, 0.01, '2021-02-11', '2021-02-10'),
	( 'Saving', $8900.74, 3, 0.01, '2021-09-03', '2020-09-08'),
	( 'Saving', $9900.18, 2, 0.01, '2021-05-17', '2021-04-01'),
	( 'Chequing', $608.58, 4, NULL, '2021-11-01', '2009-03-18'),
	( 'Saving', $2988.11, 5, 0.01, '2021-10-14', '2015-12-01'),
	( 'Saving', $701.21, 7, 0.01, '2021-06-02', '2019-05-14'),
	( 'Chequing', $844.38, 3, NULL, '2021-11-09', '2017-11-22'),
	( 'Chequing', $12.78, 2, NULL, '2021-09-20', '2020-06-28'),
	( 'Chequing', $294.84, 9, NULL, '2021-11-10', '2008-07-02'),
	( 'Saving', $3859.47, 7, 0.01, '2021-09-30', '2020-09-24'),
	( 'Chequing', $20300.16, 5, NULL, '2021-10-15', '2003-11-13'),
	( 'Chequing', $3401.05, 2, NULL, '2021-09-08', '2018-05-19'),
	( 'Saving', $5195.55, 8, 0.01, '2021-11-05', '2019-07-25'),
	( 'Saving', $481.30, 9, 0.01, '2021-04-03', '2001-01-29'),
	( 'Chequing', $99.50, 3, NULL, '2021-10-31', '2015-07-26'),
	( 'Chequing', $5010.33, 4, NULL, '2021-11-15', '2020-03-04'),
	( 'Chequing', $69.40, 5, NULL, '2021-11-01', '2021-08-16')
GO


/**  Adding records to the AccountTransactions table  **/ 
INSERT AccountTransactions (AccountID, CustomerID, Deposit, Withdrawal, BranchID, TransactionDate, OverdraftDate, OverdraftAmount, OverdraftChequeNo) VALUES
	(101, 204, $9.00, NULL, 1, '2021-02-02', NULL, NULL, NULL),
	(102, 202, $1000.00, NULL, 6, '2021-10-05',  NULL, NULL, NULL),
	(103, 203, $80.00, NULL, 8, '2021-11-07', NULL, NULL, NULL),
	(104, 205, $900.50, NULL, 3, '2021-09-03', NULL, NULL, NULL),
	(105, 208, $88.10, NULL, 5, '2021-09-20', NULL, NULL, NULL),
	(106, 207, $608.58, NULL, 4, '2021-11-01',  NULL, NULL, NULL),
	(107, 201, NULL, $1235.00, 1, '2020-12-15',  NULL, NULL, NULL),
	(108, 209, $50.00, NULL, 7, '2021-05-31', NULL, NULL, NULL),
	(109, 211, NULL, NULL, 2, '2021-09-15', '2020-09-15', $800.00, 07),
	(110, 210, $400.00, NULL, 3, '2021-11-01', NULL, NULL, NULL),
	(111, 212, $135.00, NULL, 9, '2021-11-05', NULL, NULL, NULL),
	(112, 216,  $5010.33, NULL, 1, '2021-11-15', NULL, NULL, NULL), 
	(113, 214, $1030.75, NULL, 5, '2021-10-15', NULL, NULL, NULL),
	(114, 206, $1000.00, NULL, 2, '2021-05-01', NULL, NULL, NULL),	
	(115, 216,  NULL, $4910.39, 1, '2021-11-05',  NULL, NULL, NULL),
	(116, 216,  $25.00, NULL, 2, '2021-03-26',  NULL, NULL, NULL),
	(117, 213,  $349.73, NULL, 7, '2021-09-02', NULL, NULL, NULL),
	(118, 216,  $18.00, NULL, 4, '2021-10-20',  NULL, NULL, NULL),
	(119, 215,  NULL, $10800.00, 8, '2021-09-08',  NULL, NULL, NULL),
	(120, 218,  NULL, NULL, 3, '2021-07-31', '2021-07-31', $84.71, 230),
	(120, 200, NULL, NULL, 7, '2021-09-30', '2021-09-30', $200.00, 52)
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
INSERT LoanPayments (LoanID, PaymentNumber, BranchID, AccountID, Amount, PaymentDate) VALUES
	(108, 1, 9, 101, $409.57, '2021-09-01'),
	(104, 1, 8, 107, $200000.00, '2021-09-30'),
	(108, 2, 9, 101, $409.57, '2021-10-01'),
	(106, 1, 2, 102, $84.19, '2021-10-01'),
	(102, 1, 1, 114, $500.00, '2021-10-01'),
	(101, 1, 1, 114, $8030.00, '2021-10-15'),
	(103, 1, 4, 108, $714.35, '2021-10-15'),
	(104, 2, 8, 107, $200000.00, '2021-10-30'),
	(105, 1, 3, 111, $3199.87, '2021-10-30'),
	(106, 2, 2, 102, $84.19, '2021-11-01'),
	(102, 2, 1, 114, $500.00, '2021-11-01'),
	(108, 3, 9, 101, $409.57, '2021-11-01'),
	(101, 2, 1, 114, $8030.00, '2021-11-15'),
	(103, 3, 4, 108, $714.35, '2021-11-15')
GO

/**  Adding records to the CustomerAccount table  **/ 
INSERT CustomerAccount (CustomerID, AccountID) VALUES
	(200, 101),
	(201, 102),
	(202, 103),
	(203, 104),
	(204, 105),
	(205, 106),
	(206, 107),
	(207, 108),
	(208, 109),
	(209, 110),
	(210, 111),
	(211, 112),
	(212, 113),
	(213, 114),
	(214, 115),
	(215, 116),
	(216, 117),
	(216, 118),
	(216, 119),
	(217, 120),
	(218, 120)
GO


/** Adding constraints to CustomerAccount Table **/
ALTER TABLE CustomerAccount
ADD CONSTRAINT FK_CustomerAcount_A
FOREIGN KEY (AccountID) REFERENCES Account(AccountID);

ALTER TABLE CustomerAccount
ADD CONSTRAINT FK_CustomerAccount_C
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE CustomerAccount
ADD CONSTRAINT PK_CustomerAccount
PRIMARY KEY (CustomerID, AccountID);

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
ADD CONSTRAINT FK_Account_LoanPayments
FOREIGN KEY (AccountID) REFERENCES Account(AccountID);

ALTER TABLE LoanPayments
ADD CONSTRAINT FK_Loans_LoanPayments
FOREIGN KEY (LoanID) REFERENCES Loans(LoanID);


/** Adding Foreign Key constraints to Account Table **/
ALTER TABLE Account
ADD CONSTRAINT FK_Branch_Account
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID);


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


