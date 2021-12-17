/** DATA2201: Bow Valley College
	Group 2: Alex Tran, Connor Pittman & Janine Neville
	Group project: SKS Bank database
	Phase 2 Queries
	Instructor: Nisha Radhamoni  
	Due date: December 17, 2021  **/
	
/**  Project Phase 2 implementation for the SKS Bank database  **/

-- USE SKS;

/**  Step 1. Implementing different functionalities using stored procedure and user defined function.  **/

/**  (Connor) One of the stored procedures should be implemented with argument passing.  **/

CREATE PROCEDURE sp_FindAccountHoldersByAccountID (@selectedAccount AS int)
AS
BEGIN
	SELECT @selectedAccount AS 'AccountID', C.FirstName + ' ' + C.LastName AS 'Account Holders'
	FROM Account A JOIN CustomerAccount CA 
		ON A.AccountID = CA.AccountID
		JOIN Customer C ON CA.CustomerID = C.CustomerID
	WHERE A.AccountID = @selectedAccount
	ORDER BY C.FirstName;
END;

-- Test Statement
EXEC sp_FindAccountHoldersByAccountID 120;

/**  (Janine) The other stored procedure must be handling an exception.  **/
/**  A stored procedure to make sure an Employee is not deleted from the Employee table, 
when that Employee is listed as a Foreign Key in the Customer Table (under column: BankerEmpID)  **/

CREATE PROCEDURE sp_ExceptionDeleteEmployeeID (@EmployeeID AS int)
AS
BEGIN TRY
DELETE FROM SKS.dbo.Employee WHERE EmployeeID = @EmployeeID
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() AS [Error Message]
END CATCH

/**  Test statement  **/
EXEC sp_ExceptionDeleteEmployeeID 113;


/**  (Alex) At least 1 user defined function - this should not be a stored procedure, create your own function, 
     don’t use a pre-defined function that is a stored procedure for this we make our own.   
     EXTRA Functions if allowed by time  **/

	 DROP FUNCTION bankBalance
CREATE FUNCTION bankBalance(@BranchID as int)
RETURNS money
BEGIN
RETURN (SELECT SUM(DISTINCT Amount) - SUM(DISTINCT PrincipalAmount) AS BankTotal
FROM AccountTransactions AcTr
JOIN Loans Lo
	ON Lo.BranchID = AcTr.BranchID
JOIN LoanPayments LP
	ON LP.LoanID = Lo.LoanID
WHERE Lo.BranchID = @BranchID
)
END;

SELECT dbo.bankBalance(1)

/**  (Janine) Step 2. Create different set of triggers to monitor DML and DDL activates in the database **/
/**  (Janine) 1st trigger (DML) A trigger that report a message/audit entry during a new customer registration  **/
CREATE TRIGGER tg_forinsertcustomer ON Customer
AFTER INSERT
AS 
BEGIN 
  SELECT * FROM inserted
END

/**  Test statement  **/
INSERT INTO Customer 
VALUES ('Adrian', 'Bowles', '3804 6 Avenue SW Calgary', '587-232-7717', 110, NULL)


/**  (Janine) 2nd trigger (DDL) A trigger that disables the trigger that was made above tg_forinsertcustomer  **/ 
DISABLE TRIGGER tg_forinsertcustomer
ON Customer

/** Test statement  **/
INSERT INTO Customer 
VALUES ('Patrice', 'Kane', '810 Erlton Avenue SW Calgary', '403-229-1195', 101, NULL)


/**  (Connor) Step 3 Create index based on frequently used attribute for three of any table 
Replace the default cluster index with non-key attribute for one table. If you used GUI please provide details on which table you implemented it 
Create Composite clustered index for one of the table by removing the default clustered index. . If you used GUI please provide details on which table you implemented it 
Create non clustered composite index for one of the table you have. If you used GUI please provide details on which table you implemented it  **/ 

---- Non-key Attribute
-- Change PK constraint from clustered to nonclustered
ALTER TABLE Branch
DROP CONSTRAINT PK__Branch__A1682FA557F82782 WITH (ONLINE = OFF)
GO

ALTER TABLE Branch
ADD CONSTRAINT PK__Branch__A1682FA557F82782 PRIMARY KEY NONCLUSTERED (BranchID ASC)
GO

-- Create index
CREATE CLUSTERED INDEX Ix_BranchName
ON Branch(BranchName ASC)
GO


---- Composite Clustered Index
-- Disable PK constraint 
ALTER TABLE LoanPayments
DROP CONSTRAINT PK__LoanPaym__5BA74D5C015CC961 WITH (ONLINE = OFF)
GO

-- Create index
CREATE CLUSTERED INDEX Ix_LoanPayment_LoanPaymentID_Amount
ON LoanPayments(LoanPaymentID ASC, Amount ASC)
GO


---- Composite Nonclustered Index
-- Create index
CREATE NONCLUSTERED INDEX Ix_Employee_FirstName_LastName
ON Employee(FirstName, LastName)
GO

/**  (Alex) Step 4. Create different level of users and assign appropriate privilege. 
A minimum of 2 user should be there.   
For instance, customer can read transactions, but they can’t update or delete.  Accountant can read, edit or delete records etc. Create a user as customer_yourID and password customer. When you login with this account you should be able to read and write only on selected tables that are related to customer such as customer, account, loan and payment tables.  Provide testing query script after you enforced the privileges.  
Create a user as accountant_yourID and password accountant. When you login with this account you should be able read all tables but cannot update account, payment and loan tables. Provide testing query script after you enforced the privileges.  **/  



/** Group as a whole - Step 5: Recovery Model and Backup    
First part: Set the recovery model for your database as full recovery model. Second part: Take a full backup of your database.  **/

/**  First part: Set the recovery model of the SKS database from simple to full  **/
USE master
GO
ALTER DATABASE SKS SET RECOVERY FULL WITH NO_WAIT
GO

/**  Second part: Perform a full backup  **/
USE master
BACKUP DATABASE SKS TO DISK = 'C:\backup\FullBackupSKS.bak'
GO
 
