CREATE DATABASE airline
USE airline

CREATE TABLE employees(
emp_id INT PRIMARY KEY IDENTITY,
emp_fname NVARCHAR(20),
emp_lname NVARCHAR(20),
desigantion NVARCHAR(10),
salary NUMERIC(10,1)
)

INSERT INTO employees values('Rituraj','singh','manager',18000)
INSERT INTO employees values('Anmol','Saini','manager',19000)
INSERT INTO employees values('Priya','Vashudeva','Hr',200000)
INSERT INTO employees values('Big','Bang','Security',11200)
INSERT INTO employees values('Akhil','Saini','Hr',189000)

select * from employees

CREATE TABLE emp_personal(
emp_id INT FOREIGN KEY REFERENCES employees(emp_id) IDENTITY,
emp_gender NVARCHAR(10),
emp_city NVARCHAR(20),
experience  NVARCHAR(20)
)

INSERT INTO emp_personal VALUES ('Male','mohali','1 year')
INSERT INTO emp_personal VALUES ('Female','chandigarg','4 year')
INSERT INTO emp_personal VALUES ('female','moga','2 year')
INSERT INTO emp_personal VALUES ('Male','panchkula','2 year')
INSERT INTO emp_personal VALUES ('Male','mohali','1 year')

/*  Create procedure for Insert data into table */

CREATE PROCEDURE sp_insertEmp(
@emp_fname NVARCHAR(20),
@emp_lname NVARCHAR(20),
@desigantion NVARCHAR(10),
@salary NUMERIC(10,1),
@emp_gender NVARCHAR(10),
@emp_city NVARCHAR(20),
@experience  NVARCHAR(20)
 )
 AS 
 BEGIN 
 INSERT INTO employees (emp_fname,emp_lname,desigantion,salary) VALUES(@emp_fname,@emp_lname,@desigantion,@salary)
 INSERT INTO emp_personal(emp_gender,emp_city,experience) VALUES (@emp_gender,@emp_city,@experience)
 END

 EXEC sp_insertEmp @emp_fname='Bhargavi',@emp_lname='Goyal',@desigantion='Desk Help',@salary=19883.99,@emp_gender='feamle',@emp_city='jakhal',@experience=3

 SELECT * FROM employees
 
 SELECT * FROM emp_personal
 
 /*  fatching a particular complete data of employees */


 CREATE PROCEDURE sp_displayEmpData(@id int)
  AS
  BEGIN
  SELECT e.emp_id,e.emp_fname,e.emp_lname,e.desigantion,p.emp_gender,p.emp_city,p.experience FROM employees AS e
  JOIN emp_personal AS p
    On e.emp_id=p.emp_id and e.emp_id=@id
END

exec sp_displayEmpData @id=5


/* create table for passenger */

CREATE TABLE passengers(
p_id INT PRIMARY KEY IDENTITY(1,1),
p_fname NVARCHAR(20),
p_lname NVARCHAR(20),
p_source NVARCHAR(20),
destination NVARCHAR(20)
)

INSERT INTO passengers VALUES ('Aswi','Kumari', 'New delhi','kolkata')

INSERT INTO passengers VALUES ('Ajay','Kumar', 'New delhi','Chandigarh')

INSERT INTO passengers VALUES ('Amit','Kumar', 'New delhi','Hyderbad')

INSERT INTO passengers VALUES ('Vicky','Kumar', 'pune','Haridwar')

SELECT * FROM passengers

/* Create table for passenger datails */

CREATE TABLE pass_details (
p_id INT FOREIGN KEY REFERENCES passengers(p_id) IDENTITY,
seat_number NVARCHAR(10),
fare int)


INSERT INTO pass_details VALUES ('1 A', 5000)
INSERT INTO pass_details VALUES ('1 B', 5600)
INSERT INTO pass_details VALUES ('1 C', 5800)
INSERT INTO pass_details VALUES ('1 D', 5900)

SELECT * FROM pass_details

/* create procedure for insert data into table */

CREATE PROCEDURE sp_insertPass(
@p_fname NVARCHAR(20),
@p_lname NVARCHAR(20),
@p_source NVARCHAR(20),
@destination NVARCHAR(20),
@seat_number NVARCHAR(10),
@fare int
)
AS 
BEGIN
INSERT INTO passengers(p_fname,p_lname,p_source,destination) VALUES(@p_fname,@p_lname,@p_source,@destination)
INSERT INTO pass_details(seat_number, fare) values (@seat_number,@fare)

End
drop procedure sp_insertPass

EXEC sp_insertPass
@p_fname = 'Muskan',
@p_lname = 'khatun',
@p_source ='new delhi',
@destination= 'Goa',
@seat_number= '3 B',
@fare= 9870


SELECT * FROM passengers

SELECT * FROM pass_details

/*creating procedure to display passenger data of the concerned id number*/
CREATE PROCEDURE sp_displayPassenger(@id int)
AS
BEGIN
SELECT
     p.p_id,p.p_fname,p.p_lname, p.p_source, p.destination, pd.seat_number, pd.fare
FROM passengers as p
join pass_details as pd
    on p.p_id=pd.p_id and p.p_id=@id
END
drop procedure sp_displayPassenger

/*executing sp_displayPassenger procedure to display details related to passenger id 3*/
exec sp_displayPassenger @id=3
