-- DATA2201 Group Project
-- Queries for SKS Database
-- Janine Neville, Connor Pittman, Alex Tran

-- 1
-- "User Story" (Display all current managers who have hired other current employees) 
-- SUBQUERY in a WHERE statement

USE SKS;

SELECT EmployeeID, FirstName, LastName
FROM Employee
WHERE EmployeeID IN (SELECT ManagerID FROM Employee);


-- 2 
-- Special training is being offered for all employees that work at the 'Downtown' bank location and have worked for the bank for at least 3 years. 
-- List all employees, sorted by EmployeeID, with employees that qualify for the training being listed first.
-- CASE statement

USE SKS;

SELECT EmployeeID, FirstName + ' ' + LastName AS 'Employee Name', 
	CASE 
		WHEN WorkLocation = 'Downtown' AND HireDate < '2018-11-19' THEN 'Yes'
		ELSE 'No'
	END AS 'Training Eligible'
FROM Employee
ORDER BY 'Training Eligible' DESC, EmployeeID ASC;

-- 3
-- "User Story" (Display all chequing accounts with balances greater than $500 that have never made any loans, order result by account balance)
-- LEFT JOIN clause

USE SKS;

SELECT A.AccountID, A.Balance, A.BranchID, A.LastAccessed, A.DateOpened
FROM Account A LEFT JOIN LoanPayments LP
	ON A.AccountID = LP.AccountID
WHERE A.InterestRate IS NULL AND LP.LoanPaymentID IS NULL
ORDER BY A.Balance;


-- 4

/*
	The bank owner wants to know how much is lost from Loans 
*/
USE SKS;

SELECT SUM(DISTINCT Amount) - SUM(DISTINCT PrincipalAmount) AS BankTotal
FROM AccountTransactions AcTr
JOIN Loans Lo
	ON Lo.BranchID = AcTr.BranchID
JOIN LoanPayments LP
	ON LP.LoanID = Lo.LoanID
WHERE Lo.BranchID = '2';

-- 5

/*
	The Bank manager wants to know how long an employee has been with the Bank
*/

USE SKS;

SELECT FirstName + ' ' + LastName AS Employee, DATEDIFF(DD,HireDate, SYSDATETIME()) AS DaysWith
FROM Employee

-- 6

/*
	Customer/Employee wants to know who the account is held by
*/

USE SKS;

SELECT C.FirstName + ' ' + C.LastName AS AccountHolders
FROM Customer C 
JOIN CustomerAccount CA
	ON C.CustomerID = CA.CustomerID
WHERE CA.AccountID = '120';

-- 7

/*
	The Bank wants to know who to contact for a specific Loan
*/

USE SKS;

SELECT C.FirstName + ' ' + C.LastName AS AccountHolders
FROM Customer C 
JOIN CustomerAccount CA
	ON C.CustomerID = CA.CustomerID
RIGHT JOIN LoanPayments LP
	ON LP.AccountID = CA.AccountID
WHERE LP.LoanID = '108' AND LP.PaymentNumber = '2'


-- 8
/** "User Story" (Update cheque record id, update account to match what their account is because a
customer has called and explained they visited Branch ID 5 and made a deposit of $1030.75 to their account (AccountID 4933919) 
on October 15, 2021, however they have now examined their account statement for October and their payment is not listed.  
To correct this, the employee can search payments on that date in that amount, to determine which account the payment was 
deposited into, and correct the transaction. The employee will then need to ensure the AccountTransaction table is 
updated to show the payment is reflected in the correct account) **/

USE SKS


/*
UPDATE AccountTransactions
SET 
    AccountID = 4933919
WHERE
    TransactionDate='2021-05-18'
	AND Amount = 1030.75

-- Test statement 
USE SKS
SELECT * FROM AccountTransactions WHERE TransactionDate='2021-10-15';
*/


-- 9
/**  "User Story" (You are an assistant to a bank manager.  The manager has asked you to create 
a list of all employees including their address, who have worked for the bank in the province of Alberta for 
over 5 years as of January 1, 2022, so that the bank can mail to them a 5 years of service award cheque.)  **/

USE SKS;

SELECT FirstName, LastName, HomeAddress
FROM Employee
WHERE HireDate>'2017-01-01';


-- 10
/** "User Story (The bank has noticed they are having trouble retaining entry level employees.
In an attempt to encourage employees to stay, the bank wants to increase their lowest paid employees'
hourly pay rates.)  **/

USE SKS;

UPDATE Employee
SET PayRate = Payrate + 2
WHERE Payrate < 25;


-- 11
-- SKS National Bank management wants a list of all employees that are listed as personal bankers for customers of the bank.
-- Make sure to sort the resulting table by CustomerID and include the following columns: CustomerID, Customer Name, BranchID, Branch Name, Preferred Employee, and EmployeeID. Sort the results by CustomerID.
-- Muliple INNER JOIN clauses

USE SKS;

SELECT C.FirstName + ' ' + C.LastName AS 'Customer Name' , C.CustomerID, B.BranchName AS 'Branch Name', B.BranchID, E.FirstName + ' ' + E.LastName AS 'Personal Banker', E.EmployeeID
FROM Customer C JOIN CustomerAccount CA
	ON C.CustomerID = CA.CustomerID
	JOIN Account A ON CA.AccountID = A.AccountID
	JOIN Branch B ON A.BranchID = B.BranchID
	JOIN Employee E ON B.BranchID = E.BranchID
WHERE E.EmployeeID = C.BankerEmpID and A.BranchID = E.BranchID
ORDER BY C.CustomerID ASC;


