create database COMPANYDB;
use COMPANYDB;
create table DEPARTMENT(
DNAME varchar(20),
DNUMBER int primary key,
MGRSSN varchar(15),
MGRSTARTDATE date
);
create table EMPLOYEE(
FNAME VARCHAR(20),
MINIT CHAR(1),
LNAME varchar(15),
SSN varchar(15) primary key,
BDATE date,
ADDRESS varchar(100),
SEX CHAR(1),
SALARY INT,
SUPERSN VARCHAR(15),
DNO INT,
FOREIGN KEY(DNO) references DEPARTMENT (DNUMBER)
);
INSERT INTO DEPARTMENT (DNAME, DNUMBER, MGRSSN, MGRSTARTDATE)
VALUES 
('Research', 1, '111-11-1111', '2022-01-01'),
('Sales', 2, '222-22-2222', '2019-03-15'),
('HR', 3, '333-33-3333', '2021-06-10');
INSERT INTO EMPLOYEE 
(FNAME, MINIT, LNAME, SSN, BDATE, ADDRESS, SEX, SALARY, SUPERSN, DNO)
VALUES
('Ramesh', 'K', 'Sharma', '1001', '1985-05-12', 'Kathmandu', 'M', 80000, NULL, 1),
('Sita', 'L', 'Adhikari', '1002', '1990-08-22', 'Pokhara', 'F', 90000, NULL, 2),
('Amit', 'R', 'Thapa', '1003', '1988-11-30', 'Lalitpur', 'M', 95000, NULL, 3),
('Bikash', 'P', 'Gurung', '1005', '1995-09-10', 'Chitwan', 'M', 60000, '1003', 3),
('Anjali', 'T', 'Rai', '1006', '1993-06-25', 'Biratnagar', 'F', 65000, '1001', 1);
select * from EMPLOYEE;
select * from DEPARTMENT;
#q1. 10% Salary Raise for Research Department
select E.FNAME,E.LNAME,E.SALARY*1.1 AS increased_salary from EMPLOYEE E JOIN DEPARTMENT D ON E.DNO=D.DNUMBER WHERE D.DNAME='Research';
#salary Statistics of Accounts Department
#Q2sum,max, min,avg for department Sales
select sum(SALARY) AS TOTAL from EMPLOYEE;
SELECT MAX(E.SALARY) AS HIGHEST_SALARY,
MIN(E.SALARY) AS LOWEST_SALARY,
AVG(E.SALARY) AS AVERAGE_SALARY FROM EMPLOYEE E JOIN DEPARTMENT D ON E.DNO=D.DNUMBER WHERE D.DNAME="Sales";
#Q3 Employees controlled by department no 3
SELECT FNAME,LNAME,ADDRESS,SALARY FROM EMPLOYEE E JOIN DEPARTMENT D ON E.DNO=D.DNUMBER WHERE D.DNUMBER="3";
#Q4  Departments having atleast 2 Employees
SELECT D.DNAME, COUNT(*) AS Emp_count from EMPLOYEE E JOIN DEPARTMENT D ON E.DNO=D.DNUMBER GROUP BY D.DNUMBER,D.DNAME HAVING COUNT(*)>=2;
#q5 Employees Born in 1990's
SELECT * FROM EMPLOYEE WHERE year(BDATE) between 1990 and 1999;



