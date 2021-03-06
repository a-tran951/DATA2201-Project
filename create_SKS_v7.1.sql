/** DATA2201: Bow Valley College
	Group 2: Alex Tran, Connor Pittman & Janine Neville
	Group project: SKS Bank database
	Version: 7.1
	Instructor: Nisha Radhamoni  **/


USE master
GO

/**  Object:  Database SKS  **/
IF DB_ID('SKSv1') IS NOT NULL
	DROP DATABASE SKSv1
GO

CREATE DATABASE SKSv1
GO 

USE SKSv1
GO


/**  Object:  Table Customer  **/    
CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY IDENTITY(200,1),
	FirstName VARCHAR (50) NOT NULL,
	LastName VARCHAR (50) NOT NULL,
	Address VARCHAR (100)
	)
GO

/**  Object:  Table Employee  **/   
CREATE TABLE Employee(
	EmployeeID INT PRIMARY KEY IDENTITY(100,1) NOT NULL,
	EmployeePos VARCHAR (50) NULL,
	Address VARCHAR(100) NULL,
	HireDate DATE NULL,
	LastName VARCHAR (50) NULL,
	FirstName VARCHAR (50) NULL,
	ManagerID INT NULL,
	PayRate MONEY NULL
	)
GO

/**  Object:  Table Branch  **/   
CREATE TABLE Branch(
	BranchID INT PRIMARY KEY IDENTITY(30,1),
	BranchName VARCHAR (50) NULL,
	City VARCHAR (50) NULL
	)
GO

/**  Object:  Table Account  **/   
CREATE TABLE Account(
	AccountID INT PRIMARY KEY IDENTITY(110,1),
	AccountDeposit DECIMAL NULL,
	EmployeeID INT REFERENCES Employee (EmployeeID),
	LastAccessed DATE NULL,
	Balance DECIMAL NULL,
	InterestRate DECIMAL(5,3) NULL,
	AccountType VARCHAR (50) NULL
	)
GO

/**  Object:  Table EmployeeLocation  **/   
CREATE TABLE EmployeeLocation(
	LocationID INT PRIMARY KEY IDENTITY(300,1),
	EmployeeID INT REFERENCES Employee (EmployeeID),
	Location VARCHAR (100) NOT NULL
	)
GO

/**  Object:  Table Loans  **/   
CREATE TABLE Loans(
	LoanID INT PRIMARY KEY IDENTITY(210,1),
	BranchID INT REFERENCES Branch (BranchID),	
	)
GO

/**  Object:  Table AccountLoan  **/   
CREATE TABLE AccountLoan(
	LoanID INT REFERENCES Loans (LoanID),
	AccountID INT REFERENCES Account (AccountID),
	PRIMARY KEY (LoanID, AccountID)
	)
GO

/**  Object:  Table CustomerAccount  **/   
CREATE TABLE CustomerAccount(
	CustomerID INT REFERENCES Customer (CustomerID),
	AccountID INT REFERENCES Account (AccountID),
	PRIMARY KEY (CustomerID, AccountID)
	)
GO

/**  Object:  Table ChequeRecord  **/   
CREATE TABLE ChequeRecord(
	ChequeRecordID INT PRIMARY KEY IDENTITY(600,1),
	AccountID INT REFERENCES Account (AccountID),
	Amount DECIMAL NULL,
	ChequeDate DATE NULL
	)
GO

/**  Object:  Table LoanRecord  **/   
CREATE TABLE LoanRecord(
	LoanRecordID INT PRIMARY KEY IDENTITY(500,1),
	LoanID INT REFERENCES Loans (LoanID),
	PaymentNumber INT NOT NULL,
	PaymentDate DATETIME NOT NULL,
	LoanAmount DECIMAL NOT NULL
	)
GO

/**  Adding records to the Customer table  **/   
INSERT Customer (FirstName, LastName, Address) VALUES 
	('Jason', 'Atkinson', '237 Windemere Crescent SW Calgary'),
	('Vanessa', 'Deslauriers', '2439 48 Street SE Calgary'), 
	('Susan', 'Coronel', '104 Riverdale Avenue SW Calgary'),
	('Marcel', 'Plourde', '3632 28 Avenue NE Calgary'),
	('Edgar', 'Uson', '7828 48 Street NW Calgary'), 
	('Travis', 'Phinney', '10410 114 Street SW Edmonton'), 
	('Sujay', 'Ravichandran', '1838 33 Street SW Calgary'), 
	('Patricia', 'Lawton', '118 Pasadena Drive NE Calgary'), 
	('Danica', 'Sparks', '3538 2 Street SW Calgary'), 
	('Odessa', 'Montague', '1207 52 Street SW Calgary'), 
	('Anik', 'Merrill', '34 Pasena Crescent SW Calgary'), 
	('Maninder', 'Toor', '342 Mount Royal Drive SW Calgary'), 
	('Thomas', 'Marriott', '1004 8 Avenue SW Calgary'), 
	('Ralph', 'Keizer', '2370 45 Street SW Calgary'), 
	('Nadr', 'Abourachad', '237 Windemere Crescent SW Calgary'), 
	('Francis', 'Belliveau', '1948 16 Avenue NW Calgary'), 
	('Frank', 'Wong', '28 Bridgeview Drive Cochrane'), 
	('Pearl', 'Dunham', '1901 Centre Street NW Calgary'), 
	('Joellen', 'Beasley', '34 Abbeydale Drive SE Calgary'), 
	('Grace', 'Madison', '34 Pumphill Crescent SW Calgary') 
GO 

/**  Adding records to the Account table  **/ 
INSERT Account (AccountDeposit, EmployeeID, LastAccessed, Balance, InterestRate, AccountType) VALUES
	('2503681',NULL,'2020-01-17','954179',NULL,'Chequing'),
	('596046',NULL,'2020-02-09','332381',0.01,'Saving'),
	('213281',NULL,'2020-07-25','18739',NULL,'Chequing'),
	('1571618',NULL,'2018-10-10','22270',0.01,'Saving'),
	('1756788',NULL,'2000-11-12','713336',0.01,'Saving'),
	('1947453',NULL,'2003-11-20','81268',0.01,'Saving'),
	('1521355',NULL,'2016-12-14','954179',0.01,'Saving'),
	('1177887',NULL,'2021-01-26','12337',NULL,'Chequing'),
	('1108061',NULL,'2021-05-16','610756',0.01,'Saving'),
	('1947492',NULL,'2018-05-26','1657357',0.1,'Saving'),
	('87580',NULL,'2021-06-07','-1784',NULL,'Chequing'),
	('117701',NULL,'2010-06-12','-4005',NULL,'Chequing'),
	('1262055',NULL,'2021-07-12','-29095',NULL,'Chequing'),
	('86949',NULL,'2021-09-08','46565',0.01,'Saving')
	
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
SET IDENTITY_INSERT Loans ON


INSERT Loans(LoanID,BranchID) VALUES 
	(210, 30),
	(211, 31),
	(212, 33),
	(214, 37),
	(215, 38)
SET IDENTITY_INSERT Loans OFF

/**  Adding records to the ChequeRecord table  **/ 
INSERT ChequeRecord (AccountID, Amount, ChequeDate) VALUES 
	(110, 131420, '2020-01-17'),
	(112, 11023, '2020-07-25'),
	(117, 10082, '2021-01-26'),
	(120, -2813, '2021-06-07'),
	(121, -5000, '2010-06-12'),
	(122, -30000, '2020-06-12'),
	(110, 123100, '2019-12-03'),
	(112, 13142, '2020-06-06'),
	(117, 13142, '2020-12-02'),
	(120, 13142, '2021-05-03'),
	(121, 13142, '2010-05-12'),
	(122, 13142, '2021-05-18'),
	(110, 13142, '2019-11-03'),
	(112, 13142, '2020-06-10'),
	(117, 13142, '2020-12-16'),
	(120, 13142, '2021-05-20'),
	(121, 13142, '2010-05-01'),
	(122, 13142, '2020-05-23')
GO

/**  Adding records to the LoanRecord table  **/ 
INSERT LoanRecord(LoanID, PaymentNumber, PaymentDate, LoanAmount) VALUES
	(210, 1, '2021-08-15 10:01:44', 25000),
	(210, 2, '2021-09-15 15:36:07', 10000),
	(210, 3, '2021-10-15 13:22:58', 25000),
	(211, 1, '2021-06-02 10:18:33', 1312),
	(211, 2, '2021-07-02 11:25:41', 1251),
	(211, 3, '2021-08-02 09:48:37', 2500),
	(211, 4, '2021-09-02 14:11:22', 1842),
	(211, 5, '2021-10-02 10:39:45', 1131),
	(211, 6, '2021-11-02 13:34:31', 2190),
	(212, 1, '2021-08-30 09:40:28', 1312),
	(212, 2, '2021-09-30 16:51:49', 1251),
	(212, 3, '2021-10-30 11:38:25', 2500),
	(213, 1, '2020-12-01 12:00:00', 231.77),
	(213, 2, '2021-01-01 12:00:00', 148.39),
	(214, 1, '2019-12-12 12:57:23', 1048.42),
	(214, 2, '2020-01-12 12:17:10', 1823.81),
	(214, 3, '2020-02-12 10:11:10', 132.10),
	(215, 1, '2020-03-12 15:30:40', 500.82)
GO


/**  Adding records to the Employee table  **/ 
INSERT Employee (EmployeePos, Address, HireDate, FirstName, LastName, ManagerID, PayRate) VALUES
	('Banker', '400 Abbeydale Lane NE Calgary', '2020-09-12', 'Nora', 'Cooper', 101, 21.00),
	('Manager', '1920 Centre Street NW Calgary', '2019-02-07', 'Edna', 'Mode', NULL, 32.00),
	('Banker', '212 Mount Royal Drive SW Calgary', '2020-08-14', 'Robert', 'Parr', 101, 21.00),
	('Loan Officer', '2101 16 Avenue NW Calgary', '2020-09-12', 'Sara', 'Levin', 101, 24.00),
	('Banker', '2017 Abbottsfield Road NW Edmonton', '2020-10-13', 'Jacob', 'Tremblay', 115, 21.00),
	('Banker', '812 Riverbend Circle SE Calgary', '2020-08-24', 'Yun', 'Chow', 115, 21.00),
	('Loan Officer', '432 Martindale Avenue NE Calgary', '2019-09-07', 'Alex', 'Armstrong', 112, 24.00),
	('Banker', '212 Mount Royal Drive SW Calgary', '2020-01-13', 'Helen', 'Parr', 101, 21.00),
	('Banker', '123 45 Street SW Calgary', '2020-10-03', 'Edward', 'Elric', 112, 21.00),
	('Banker', '1200 Cranston Blvd SW Calgary', '2020-12-06', 'Mary', 'Turner', 115, 21.00),
	('Banker', '645 Dover Street SW Calgary', '2020-03-21', 'Sofia', 'Torres', 101, 21.00),
	('Banker', '601 Coach Hill Street SW Calgary', '2020-02-16', 'Ahmed', 'Chavan', 112, 21.00),
	('Manager', '1402 Bowness Street NW Calgary', '2019-04-11', 'King', 'Bradley', 104, 32.00),
	('Banker', '291 Windemere Crescent SW Calgary', '2020-02-10', 'Francine', 'Smith', 112, 21.00),
	('Banker', '123 45 Street SW Calgary', '2020-10-03', 'Alphonse', 'Elric', 112, 21.00),
	('Manager', '3828 Piermont Drive NE Calgary', '2020-04-20', 'Walter', 'White', 104, 32.00),
	('Loan Officer', '6078 Cloverdale Avenue NW Edmonton', '2020-05-10', 'Olivia', 'Harper', 115, 24.00),
	('Banker', '5456 Heritage Valley Street SW Edmonton', '2020-05-09', 'Fatima', 'Montes', 115, 21.00)
GO


/**  Adding records to the EmployeeLocation table  **/ 
INSERT EmployeeLocation (Location) VALUES
	('Cranston (Calgary, AB)'),
	('Crescent Heights (Calgary, AB)'),
	('Westmount (Edmonton, AB)'),
	('Sunridge (Calgary, AB)'),
	('Country Hills (Calgary, AB)'),
	('Pleasantview (Edmonton, AB)'),
	('Downtown (Calgary, AB)'),
	('Bowness (Calgary, AB)'),
	('Inglewood (Calgary, AB)'),
	('Shawnessy (Calgary, AB)'),
	('Valley Ridge (Calgary, AB)'),
	('Coventry Hills (Calgary, AB)'),
	('Shaganappi (Calgary, AB)'),
	('Sage Hill (Calgary, AB)'),
	('Panorama Hills (Calgary, AB)'),
	('East Village (Calgary, AB)'),
	('Southcentre Tower (Calgary, AB)'),
	('Calgary Business Centre (Calgary, AB)'),
	('Bantrel Tower (Calgary, AB)'),
	('Scotia Place (Edmonton, AB)')
GO