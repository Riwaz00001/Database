#Create a database named BankDB and create accounts with the fields:account_id,account_holder,balance.
CREATE DATABASE BankDB;
USE BankDB;
CREATE TABLE accounts(
account_id INT PRIMARY KEY,
account_holder VARCHAR(100),
balance DECIMAL(10,2)
);
INSERT INTO accounts VALUES
(1,'Ram',50000),
(2,'Shyam',30000),
(3,'Sita',20000);
#write a transaction that transfers Rs 5000 from Rams account to Shyams account
start transaction;
UPDATE accounts 
set balance=balance-5000 
WHERE account_id=1;
UPDATE accounts
SET balance=balance+5000
WHERE account_id=2;
COMMIT;
SELECT * FROM accounts;

##write a transaction that transfers Rs 10000 from Shyams account to Sitas account
#use rollback
START TRANSACTION;
UPDATE accounts
SET balance=balance-10000
WHERE account_id=2;
UPDATE accounts 
SET balance=balance+10000
WHERE account_id=3;
ROLLBACK;

##Write a transaction that demonstartes the use of SAVEPOINT while updating account balances.
START TRANSACTION;
UPDATE accounts
SET balance=balance-2000
WHERE account_id=1;
SAVEPOINT sp1;
UPDATE accounts
SET balance =balance+2000
WHERE account_id=2;
ROLLBACK TO sp1;
COMMIT;
SELECT * FROM accounts;

#TRIGGERS
#Create a table EMPLOYEES
#with the fields :emp_id,name,salary
CREATE TABLE EMPLOYEES(
emp_id INT PRIMARY KEY,
name VARCHAR(255),
salary DECIMAL(10,2)
);
#Create another table salary_log to record employee salary changes with fields :log_id ,emp_id,
#old_salary,new_salary,update_at.
CREATE TABLE salary_log(
log_id INT AUTO_INCREMENT PRIMARY KEY,
emp_id INT,
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO EMPLOYEES VALUES (1, 'Ram', 15000);
INSERT INTO EMPLOYEES VALUES (2, 'Sita', 18000);
INSERT INTO EMPLOYEES VALUES (3, 'Hari', 22000);
INSERT INTO EMPLOYEES VALUES (4, 'Gita', 25000);
INSERT INTO EMPLOYEES VALUES (5, 'Shyam', 30000);
#create a Before INSERT trigger on employees that prevents inserting employees whose salary is less than 10000.
DELIMITER $$
CREATE TRIGGER check_salary
BEFORE INSERT ON employees
FOR EACH ROW 
BEGIN
IF NEW.salary<10000 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT="salary must be atleast 10000";
END IF;
END $$
DELIMITER ;

#create procedure that retrieves all records from the employees table
DELIMITER $$
CREATE PROCEDURE getEmployees()
BEGIN 
SELECT * FROM EMPLOYEES;
END $$
DELIMITER ;
CALL getEmployees;

#
DELIMITER $$
CREATE PROCEDURE addEmployee(
IN p_id INT,
IN p_name VARCHAR(100),
IN p_salary DECIMAL(10,2)
)
BEGIN 
INSERT INTO EMPLOYEES VALUES();
END $$
DELIMITER ;
CALL addEmployee(6,'Hari',20000);

##Create a stored procedure that updates the salary of an employee based on employee ID.
DELIMITER $$
CREATE PROCEDURE updateSalary(
IN p_id INT,
IN new_salary DECIMAL(10,2)
)
BEGIN
UPDATE EMPLOYEES
SET salary=new_salary
WHERE emp_id=p_id;
END $$
DELIMITER ;
CALL updateSalary(1,30000);
SELECT * FROM EMPLOYEES;

#Create a stored procedure that transfers money between two accounts using a transaction
DELIMITER $$
CREATE PROCEDURE Transfer(
IN from_account INT,
IN to_account INT,
IN amount DECIMAL(10,2)
)
BEGIN 
START TRANSACTION;
UPDATE accounts 
SET balance=balance-amount
WHERE account_id=from_account;

UPDATE accounts
SET balance=balance+amount
WHERE account_id=to_account;

COMMIT;
END $$
DELIMITER ;
CALL Transfer(1,2,18000);
SELECT * FROM accounts;

