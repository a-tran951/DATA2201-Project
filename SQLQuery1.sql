-- DATA2201 Group Project
-- Queries for SKS Database
-- Janine Neville, Connor Pittman, Alex Tran








-- 1
-- "User Story" (Display all current managers who have hired other current employees) [subquery in a WHERE statement]

/*USE SKS;

SELECT EmployeeID, FirstName, LastName
FROM Employee
WHERE EmployeeID IN (SELECT ManagerID FROM Employee);


-- 2 
-- Special training is being offered for all employees hired after April 1st 2020 that work at the Country Hills location. Only display employees that qualify for this special training.

USE SKS;

SELECT E.EmployeeID, E.FirstName, E.LastName
FROM Employee E JOIN EmployeeLocation EL
	ON E.EmployeeID = EL.EmployeeID
WHERE E.HireDate >= '2020-04-01' AND EL.LocationID = 5;

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
-- "User Story" (Display account ID, loan ID, loan amount, and payment date for all loans with balances less than $2000 between April 2nd 2021 and December 1st 2021. Group columns by PaymentDate, LoanAmount, AccountID, LoandID )

USE SKS;

-- Needs editing, currently outputs nothing
SELECT AL.AccountID, LR.LoanID, LR.LoanAmount, LR.PaymentDate
FROM LoanRecord LR JOIN AccountLoan AL
	ON LR.LoanID = AL.LoanID
WHERE (LR.PaymentDate BETWEEN '2021-04-01 23:59:59:59' AND '2021-12-01 00:00:00:01') AND LR.LoanAmount <= 2000
GROUP BY LR.PaymentDate, LR.LoanAmount, AL.AccountID, LR.LoanID;


-- 12
-- "User Story"

USE SKS;

*/
