-- DATA2201 Group Project
-- Queries for SKS Database
-- Janine Neville, Connor Pittman, Alex Tran

-- 1
-- "User Story" (The bank's national head office has asked for a report with information regarding the current bank managers.  
-- This will report will need to include a list of all the management staff who have hired employees in the province of Alberta.  
-- The bank manager wants to display all current managers who have hired other current employees) 
-- SUBQUERY in a WHERE statement

USE SKS;

SELECT EmployeeID, FirstName, LastName
FROM Employee
WHERE EmployeeID IN (SELECT ManagerID FROM Employee);


-- 2 
-- "User Story" (Special training is being offered for all employees that work at the 'Downtown' bank location and have worked for the bank 
-- for at least three years. The manager will query the database to prepare a list of all employees, sorted by EmployeeID, with employees 
-- that qualify for the training being listed first.)
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
-- "User Story" (A loan officer is looking to contact prospective loan customers who are already existing account holders at the SKS Bank.
-- The loan officer wants to display all chequing accounts with balances greater than $500 that have never made any loans, order result by account balance)
-- LEFT JOIN clause

USE SKS;

SELECT A.AccountID, A.Balance, A.BranchID, A.LastAccessed, A.DateOpened
FROM Account A LEFT JOIN LoanPayments LP
	ON A.AccountID = LP.AccountID
WHERE A.InterestRate IS NULL AND LP.LoanPaymentID IS NULL
ORDER BY A.Balance;


-- 4
/*  "User Story" (The banks's owner wants to know how much money has been lent out in the form of loans to date.)
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
"User Story" (The Bank manager wants to know how long its employees have been with the Bank, since their date of hire through to the current date.)
*/

USE SKS;

SELECT FirstName + ' ' + LastName AS Employee, DATEDIFF(DD,HireDate, SYSDATETIME()) AS DaysWith
FROM Employee

-- 6

/*
"User Story" (An irrate customer calls to complain about a bank employee, the customer is very upset and is yelling and refuses to give their name
or phone number during the call, but does give their Account ID number to the bank manager during the call.  The manager was unsuccessful in calming the customer down and 
resolving their complaint and the customer hung up the phone.  The manager would like an opportunity to remedy the situation so they will need to 
query the SKS bank database and find out who that account (Account ID 120) is held by, and get a contact phone number to call the customer back and get
further information and try to help the customer.
*/

USE SKS;

SELECT C.FirstName + ' ' + C.LastName AS AccountHolders
FROM Customer C 
JOIN CustomerAccount CA
	ON C.CustomerID = CA.CustomerID
WHERE CA.AccountID = '120';

-- 7

/*
"User Story" (The bank manager asks a loan officer to contact the customer for LoanID 108 to offer them a special incentive to switch their loan balance
to a more flexible personal line of credit.  The loan officer wants to know who to contact for that specific Loan.)
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


