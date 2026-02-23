use office;
create table Dept(
DEPTNO  int primary key,
DNAME VARCHAR(255),
LOC VARCHAR(255)
);
alter table  Dept rename as department;
alter table department add column PINCODE varchar(255) not null default 0;
alter table department change DNAME DEPT_NAME varchar(20);
alter table department modify LOC char(20);
select * from department;
drop table department;
