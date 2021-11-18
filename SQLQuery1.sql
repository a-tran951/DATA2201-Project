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
-- Special training is being offered for all employees that work at the 'Downtown' bank location and were hired between June 1st 2020 and October 4th 2020. Only display employees that qualify for this special training.
-- WHERE clause

USE SKS;

SELECT EmployeeID, FirstName, LastName
FROM Employee
WHERE WorkLocation = 'Downtown' AND EmployeePos <> 'Manager';

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

SELECT DATEDIFF(DD,HireDate, SYSDATETIME()) AS DaysWith
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
/* "User Story" (Display all loans with balances less than $2000 between October 2nd 2021 and December 1st 2021, only showing loans made by a specific account) 
*/

USE SKS;

--SELECT 
--FROM Loans JOIN LoanPayments


/*
-- Needs editing, currently outputs nothing
SELECT AL.AccountID, LR.LoanID, LR.LoanAmount, LR.PaymentDate
FROM LoanRecord LR JOIN AccountLoan AL
	ON LR.LoanID = AL.LoanID
WHERE (LR.PaymentDate BETWEEN '2021-10-01 23:59:59:59' AND '2021-12-01 00:00:00:01') AND LR.LoanAmount <= 2000
GROUP BY AL.AccountID, LR.LoanID, LR.LoanAmount, LR.PaymentDate;
*/

-- 12
-- "User Story" (Find all bankers that are preferred by customers)
-- Display the CustomerID and Full Name of customers with preffered bankers, the BranchID and Branch Name of the branch that their preferred banker works at, 
-- and the EmployeeID and Employee Name of their preferred banker. Sort the results by CustomerID.

USE SKS;

SELECT C.CustomerID, C.LastName + ', ' + C.FirstName AS 'Customer Name' , B.BranchID, B.BranchName AS 'Branch Name',  E.EmployeeID, E.LastName + ', ' + E.FirstName AS 'Preferred Employee'  
FROM Customer C JOIN CustomerAccount CA
	ON C.CustomerID = CA.CustomerID
	JOIN Account A ON CA.AccountID = A.AccountID
	JOIN Branch B ON A.BranchID = B.BranchID
	JOIN Employee E ON B.BranchID = E.BranchID
WHERE E.EmployeeID = C.BankerEmpID and A.BranchID = E.BranchID
ORDER BY C.CustomerID ASC;


