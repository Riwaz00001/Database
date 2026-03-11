CREATE DATABASE TechSolutionsDB;
USE TechSolutionsDB;
CREATE TABLE DEPARTMENT(
DeptID INT PRIMARY KEY,
DeptName VARCHAR(255) NOT NULL,
Location VARCHAR(255) NOT NULL
);
CREATE TABLE EMPLOYEE(
EmpID INT PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
gender VARCHAR(255) NOT NULL,
salary DECIMAL(10,2) NOT NULL,
hire_date DATE NOT NULL,
DeptID INT NOT NULL,
FOREIGN KEY(DeptID) REFERENCES DEPARTMENT(DeptID)
);
CREATE TABLE PROJECT(
ProjectID INT PRIMARY KEY,
project_name VARCHAR(255) NOT NULL ,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
budget DECIMAL(10,2) NOT NULL
);
CREATE TABLE WORKS_ON(
EmpID INT NOT NULL,
ProjectID INT NOT NULL,
PRIMARY KEY(EmpID,ProjectID),
hours_worked DECIMAL NOT NULL,
FOREIGN KEY(EmpID) REFERENCES EMPLOYEE(EmpID),
FOREIGN KEY(ProjectID) REFERENCES PROJECT(ProjectID)
);
#DML
INSERT INTO DEPARTMENT VALUES (1, 'Engineering', 'New York');
INSERT INTO DEPARTMENT VALUES (2, 'Marketing', 'Los Angeles');
INSERT INTO DEPARTMENT VALUES (3, 'Finance', 'Chicago');
INSERT INTO DEPARTMENT VALUES (4, 'Human Resources', 'Houston');
INSERT INTO DEPARTMENT VALUES (5, 'Operations', 'Seattle');

INSERT INTO EMPLOYEE VALUES (101, 'James', 'Anderson', 'Male', 75000.00, '2019-03-15', 1);
INSERT INTO EMPLOYEE VALUES (102, 'Sarah', 'Mitchell', 'Female', 68000.00, '2020-07-22', 2);
INSERT INTO EMPLOYEE VALUES (103, 'Robert', 'Carter', 'Male', 82000.00, '2018-01-10', 3);
INSERT INTO EMPLOYEE VALUES (104, 'Emily', 'Johnson', 'Female', 71000.00, '2021-05-30', 4);
INSERT INTO EMPLOYEE VALUES (105, 'Michael', 'Davis', 'Male', 90000.00, '2017-11-08', 5);
INSERT INTO EMPLOYEE VALUES (106, 'Riwaj', 'Johnson', 'Male', 400000.00, '2021-05-30', 5);
INSERT INTO EMPLOYEE VALUES (107, 'Pratik', 'Davis', 'Male', 800000.00, '2017-11-08', 5);

INSERT INTO PROJECT VALUES (1, 'Website Redesign', '2024-01-01', '2024-06-30', 50000.00);
INSERT INTO PROJECT VALUES (2, 'Mobile App Launch', '2024-02-15', '2024-09-15', 120000.00);
INSERT INTO PROJECT VALUES (3, 'Data Migration', '2024-03-01', '2024-05-31', 35000.00);
INSERT INTO PROJECT VALUES (4, 'ERP Implementation', '2024-04-01', '2025-03-31', 200000.00);
INSERT INTO PROJECT VALUES (5, 'Cloud Infrastructure', '2024-05-01', '2024-12-31', 95000.00);

INSERT INTO WORKS_ON VALUES (101, 1, 120.00);
INSERT INTO WORKS_ON VALUES (102, 2, 95.50);
INSERT INTO WORKS_ON VALUES (103, 3, 80.00);
INSERT INTO WORKS_ON VALUES (104, 4, 150.00);
INSERT INTO WORKS_ON VALUES (105, 5, 200.00);

#update salary by 10% whose employee id is 102
UPDATE EMPLOYEE SET salary=salary*1.1 WHERE EmpID=102;
SELECT * FROM EMPLOYEE;

#delete project whose project id is 5
DELETE FROM WORKS_ON WHERE ProjectID=5;
DELETE FROM PROJECT WHERE ProjectID=5;
SELECT * FROM PROJECT;

#Display all employees who earn more than 50,000
SELECT * FROM EMPLOYEE WHERE salary>50000;

#display first,last name and salary of employees sorted by salary in descending order
SELECT first_name,last_name,salary
FROM EMPLOYEE
 ORDER BY salary DESC;
 
 #display employee who belong to Marketing department
 SELECT E.*,Deptname FROM EMPLOYEE E
 JOIN DEPARTMENT D
 ON E.DeptID=D.DeptID WHERE D.Deptname='Marketing';
 
 #show total number of employees in each department
 SELECT Deptname,COUNT(*) AS total_Employees FROM EMPLOYEE E
 JOIN DEPARTMENT D
 ON E.DeptID=D.DeptID 
 GROUP BY Deptname;
 
 #display employees who were hired after january 3,2019;
 SELECT * FROM EMPLOYEE WHERE hire_date>'2019-01-3';
 
 #display employee names along with their department names
 SELECT E.*,Deptname FROM EMPLOYEE E
 JOIN DEPARTMENT D
 ON E.DeptID=D.DeptID;
 
 #show employees and projects they are working on 
 SELECT E.*,project_name FROM EMPLOYEE E
 JOIN WORKS_ON W
 ON E.EmpID=W.EmpID
 JOIN PROJECT P
 ON W.ProjectID=P.ProjectID;
 
 #display project names with total hours worked by employees
 SELECT SUM(hours_worked) AS Total_hours,first_name,project_name
 FROM EMPLOYEE E
 JOIN WORKS_ON W
 ON E.EmpID=W.EmpID
 JOIN PROJECT P
 ON W.ProjectID=P.ProjectID;
 
 #PART E
 #AVERAGE SALARY OF EMPLOYEES IN EACH DEPARTMENT
 SELECT Deptname,AVG(salary) AS average_salary
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DeptID=D.DeptID
GROUP BY Deptname;

#Display department having highest salary
SELECT Deptname,salary AS Highest_salary
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DeptID=D.DeptID
ORDER BY salary DESC LIMIT 1;

#find employees whose salary is greater than average salary of all employees
SELECT AVG(salary) AS avg_salary,salary 
FROM EMPLOYEE E
WHERE salary> (SELECT AVG(salary) FROM EMPLOYEE);

#Create view Named highSalaryemployees that shows employees with salary greater than 90000
CREATE VIEW HighSalaryEmployees AS
SELECT EmpID,first_name,last_name,salary
FROM EMPLOYEE
WHERE salary>90000;
SELECT * FROM HighSalaryEmployees;

#Create index on the lastname column of EMPLOYEE TABLE
CREATE INDEX LastName ON EMPLOYEE(last_name);
SHOW INDEXES FROM EMPLOYEE;
