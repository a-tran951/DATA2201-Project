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
-- "User Story" (Display all loans with balances less than $2000 as of October 1st 2021, only showing loans made by a specific account) 

USE SKS;

SELECT LR.LoanID, LR.LoanAmount
FROM LoanRecord LR JOIN AccountLoan AL
	ON LR.LoanID = AL.LoanID
WHERE LR.LoanAmount < 2000 AND PaymentDate <= '2021-10-01'
GROUP BY PaymentDate
HAVING AL.AccountID = 1756788;


-- 12
-- "User Story"

USE SKS;

*/
