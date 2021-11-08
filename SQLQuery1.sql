-- DATA2201 Group Project
-- Queries for SKS Database
-- Janine Neville, Connor Pittman, Alex Tran

-- 1
-- "User Story" (Display all current managers who have hired other current employees) 
-- SUBQUERY in a WHERE statement

/*USE SKS;

SELECT EmployeeID, FirstName, LastName
FROM Employee
WHERE EmployeeID IN (SELECT ManagerID FROM Employee);


-- 2 
-- Special training is being offered for all employees hired between June 1st 2020 and October 4th 2020. Only display employees that qualify for this special training.
-- LEFT JOIN with WHERE clause

USE SKS;

SELECT E.EmployeeID, E.FirstName, E.LastName
FROM Employee E LEFT JOIN EmployeeLocation EL
	ON E.EmployeeID = EL.EmployeeID
WHERE (E.HireDate BETWEEN '2020-06-01' AND '2020-10-04');

-- 4



-- 5

USE SKS;

SELECT DATEDIFF(hh,HireDate, SYSDATETIME()) AS HoursWorked 
FROM Employee

-- 6

USE SKS;

SELECT C.FirstName + ' ' + C.LastName AS AccountHolders
FROM Customer C JOIN CustomerAccount CA
	ON C.CustomerID = CA.CustomerID
WHERE CA.AccountID = '';

-- 7

USE SKS;

SELECT * FROM LoanRecord;
SELECT LR.LoanAmount
FROM LoanRecord LR 
LEFT JOIN AccountLoan AL
	ON LR.LoanID = AL.LoanID
RIGHT JOIN Account A
	ON AL.AccountID = A.AccountID
WHERE A.AccountID = '110' AND LR.PaymentNumber = '1';

-- 11
-- "User Story" (Display all loans with balances less than $2000 between October 2nd 2021 and December 1st 2021, only showing loans made by a specific account) 
-- 

USE SKS;

-- Needs editing, currently outputs nothing
SELECT AL.AccountID, LR.LoanID, LR.LoanAmount, LR.PaymentDate
FROM LoanRecord LR JOIN AccountLoan AL
	ON LR.LoanID = AL.LoanID
WHERE (LR.PaymentDate BETWEEN '2021-10-01 23:59:59:59' AND '2021-12-01 00:00:00:01') AND LR.LoanAmount <= 2000
GROUP BY AL.AccountID, LR.LoanID, LR.LoanAmount, LR.PaymentDate;


-- 12
-- "User Story"

USE SKS;



*/
