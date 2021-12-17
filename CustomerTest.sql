
--Customer
SELECT * FROM Branch

SELECT * FROM Account

UPDATE Account
SET DateOpened = SYSDATETIME()
WHERE AccountID = 1