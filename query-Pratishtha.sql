/*1. Find the elevation and average temperature of a location.*/

SELECT location_id, elevation, average_temperature
 FROM location
  WHERE location_id = '9452';
  /*
+-------------+-----------+---------------------+
| location_id | elevation | average_temperature |
+-------------+-----------+---------------------+
|        9452 |     15.00 |               21.23 |
+-------------+-----------+---------------------+
*/

/*2. List the characteristics of materials matching a partial description.*/

SELECT
*FROM material
WHERE description = 'CO2';

/*
+-------------+-------------+---------------+---------------+--------------+---------------+--------------+
| material_id | description | material_type | ir_reflection | v_reflection | ir_absorption | v_absorption |
+-------------+-------------+---------------+---------------+--------------+---------------+--------------+
|        4506 | CO2         | GAS           |          2.10 |         1.50 |          6.21 |         2.69 |
+-------------+-------------+---------------+---------------+--------------+---------------+--------------+
*/

/*3.Find places in a latitude/longitude box (within a range of latitudes/longitudes)*/

SELECT location_id, latitude, longitude
 FROM LOCATION
  WHERE (latitude BETWEEN 11.25 AND 23.5) AND (latitude BETWEEN 11.25 AND 23.5);

/*  
  +-------------+----------+-----------+
| location_id | latitude | longitude |
+-------------+----------+-----------+
|        5840 |     23.5 |     22.25 |
|        6148 |     22.5 |     11.25 |
|        7112 |     13.5 |     14.25 |
|        9452 |     23.5 |     34.25 |
+-------------+----------+-----------+
*/

/*4. List all the contents of a specific location.*/

SELECT
*FROM location
WHERE elevation = 15.00;

/*
+-------------+----------+-----------+-----------+---------------------+---------------+---------------------+------------+---------+-----------+
| location_id | latitude | longitude | elevation | average_temperature | location_type | applicable_standard | population | country | ASCIIname |
+-------------+----------+-----------+-----------+---------------------+---------------+---------------------+------------+---------+-----------+
|        5840 |     23.5 |     22.25 |     15.00 |               21.23 | SILTY         | OIJF                |  528963147 | GERMANY | 0         |
|        9452 |     23.5 |     34.25 |     15.00 |               21.23 | CLAY          | SHTF                |  358562147 | INDIA   | 0         |
+-------------+----------+-----------+-----------+---------------------+---------------+---------------------+------------+---------+-----------+
*/

/*5. Given a particular material, list the latitude, longitude, and elevation of locations with that
material.*/

SELECT location.latitude, location.longitude, location.elevation, material.description
 FROM location, data, material
  WHERE location.location_id = data.location_id and data.material_id = material.material_id and description = 'CO2';
  /*
  +----------+-----------+-----------+-------------+
| latitude | longitude | elevation | description |
+----------+-----------+-----------+-------------+
|     23.5 |     34.25 |     15.00 | CO2         |
+----------+-----------+-----------+-------------+
*/

/*6. Find the supplier who supplied a particular piece of data, and show all information about that
supplier.*/

SELECT *From supplier
 RIGHT JOIN data ON data.supplier_id = supplier.supplier_id
   WHERE data.concentration = 8505.12
   AND data.material_id = '7148'
   AND data.data_time = '2015-05-22 23:15:06';
   
/*
+-------------+---------------+---------+--------------------+--------------+--------------------+-------------+-------------+-------------+---------------------+---------------+
|        2486 | ANIKA         | INDIA   | HUFB               |   7412563148 |                5.6 |        8320 |        2486 |        7148 | 2015-05-22 23:15:06 |       8505.12 |
+-------------+---------------+---------+--------------------+--------------+--------------------+-------------+-------------+-------------+---------------------+---------------+
*/

/*7. Find how many pieces of data we got from each supplier this month*/
SELECT COUNT(*), supplier_id FROM data
 WHERE data_time BETWEEN '2017-08-01' AND '2017-08-30';
 /*
 +----------+-------------+
| COUNT(*) | supplier_id |
+----------+-------------+
|        1 |        8120 |
+----------+-------------+
*/

/*8. Find how much was paid out to suppliers this month, total*/
SELECT SUM(amount) AS Total
 FROM payment
  WHERE payment_date BETWEEN '2017-08-01' AND '2017-08-30';

/*
+---------+
| Total   |
+---------+
| 1500.00 |
+---------+
*/

/*9. Find how much was paid out to suppliers this month, by supplier.*/
SELECT supplier_id,SUM(amount) as Total
 FROM payment 
  WHERE payment_date BETWEEN '2017-08-01' AND '2017-08-30'
   GROUP BY supplier_id;

/*
+-------------+---------+
| supplier_id | Total   |
+-------------+---------+
|        3741 |    0.00 |
|        8120 | 1500.00 |
+-------------+---------+
*/

/*10. Show all employee information in a particular department.*/
SELECT *FROM employee     
 WHERE dept_id IN ('78569');
/*
+-------------+---------------+--------+---------+------------+------------+----------+---------+---------+
| employee_id | employee_name | tax_id | country | hire_date  | birth_date | salary   | bonus   | dept_id |
+-------------+---------------+--------+---------+------------+------------+----------+---------+---------+
|       18431 | ALICE         |    135 | CANNADA | 2005-10-01 | 1980-02-15 | 40000.00 | 1000.00 |   78569 |
+-------------+---------------+--------+---------+------------+------------+----------+---------+---------+
*/

/*11. Increase salary by 10% and set bonus to 0 for all employees in a particular department.*/
UPDATE employee
 SET salary = salary + salary*0.1, bonus =0
  WHERE dept_id = '78569';  
  /*TO see updated table of employee*/
SELECT employee_name, salary, bonus, dept_id FROM employee     
 WHERE dept_id IN ('78569');
/*
+---------------+----------+-------+---------+
| employee_name | salary   | bonus | dept_id |
+---------------+----------+-------+---------+
| ALICE         | 44000.00 |  0.00 |   78569 |
+---------------+----------+-------+---------+
*/ 
 
/*12. Show all current employee information sorted by manager name and employee name.*/
SELECT employee.*, manager.manager_name
  FROM employee
   JOIN
   (SELECT employee_id AS manager_id, employee_name AS manager_name, department.dept_id AS dept_id
    FROM employee JOIN department
	 ON employee.employee_id = department.dept_head_id) AS manager
      ON employee.employee_id = manager.manager_id
      ORDER BY manager.manager_name, employee.employee_name;
   
    
 

/*13. Show all supplier information sorted by country. For each supplier include the number of data
items supplied in current month .*/
SELECT supplier.*, data_sorted.data_count      
FROM supplier        
	LEFT JOIN (    
				SELECT COUNT(*) AS data_count,supplier_id
                FROM data    
				WHERE (data.data_time BETWEEN '2017-08-01 00:00:00' AND '2017-09-01 00:00:00' )  
          ) AS data_sorted    
	ON supplier.supplier_id =data_sorted.supplier_id   
ORDER BY supplier.country;  
/*
+-------------+---------------+-----------+--------------------+--------------+--------------------+------------+
| supplier_id | supplier_name | country   | reliability_source | contact_info | productivity_score | data_count |
+-------------+---------------+-----------+--------------------+--------------+--------------------+------------+
|        3741 | JONAS         | AUSTRALIA | POKL               |   6541239874 |                9.2 |       NULL |
|        8120 | ALICE         | CANNADA   | ADAR               |   9784563210 |                2.3 |          1 |
|        6290 | ANDREW        | FRANCE    | DCVF               |   3256987410 |                8.8 |       NULL |
|        4102 | ALEX          | GERMANY   | NBML               |   4102501414 |                4.4 |       NULL |
|        2486 | ANIKA         | INDIA     | HUFB               |   7412563148 |                5.6 |       NULL |
|        5789 | PATRICK       | SPAIN     | SXCN               |   2589631401 |                6.5 |       NULL |
+-------------+---------------+-----------+--------------------+--------------+--------------------+------------+
*/

/*14. Describe how you implemented the access restrictions on the previous page.*/

/*All employees can see location, material, and location data information*/
CREATE USER employee
IDENTIFIED BY 'verysecret';
GRANT SELECT ON location.* TO employee;
GRANT SELECT ON material.* TO employee;
GRANT SELECT ON data.* TO employee;

/*Only HR employees can access all HR info.*/
CREATE USER 'PETER' IDENTIFIED BY '<<secret0>>';
CREATE TEMPORARY TABLE hr_employee  AS
	SELECT * FROM employee 
	WHERE Dept_ID = 32662;
CREATE TEMPORARY TABLE hr_department AS
	SELECT * FROM department
	WHERE dept_ID = 32662;
GRANT SELECT ON hr_employee TO 'PETER';

/* Only some HR employees can change the information in the HR portion of the DB*/
CREATE USER 'LISA' IDENTIFIED BY '<<secret1>>';
CREATE TEMPORARY TABLE hr_employee  AS
	SELECT * FROM employee 
	WHERE dept_ID = 32662;
CREATE TEMPORARY TABLE hr_department AS
	SELECT * FROM department
	WHERE dept_ID = 32662;
GRANT SELECT, DELETE ON hr_employee TO 'LISA';
GRANT INSERT,UPDATE ON hr_department  TO 'LISA';
GRANT INSERT,UPDATE ON hr_employee.bonus  TO 'LISA';

/*Managers can see their employee information*/ /*Managers can update their employee compensation.*/
CREATE USER 'KAREN' IDENTIFIED BY '<<secret2>>';
CREATE TEMPORARY TABLE IT_employee  AS
	SELECT * FROM employee
	WHERE dept_id = 091136;
CREATE TEMPORARY TABLE IT_department AS
	SELECT * FROM department 
	WHERE dept_id = 091136;
GRANT SELECT,INSERT, UPDATE, DELETE ON IT_employee TO 'KAREN';
GRANT INSERT,UPDATE ON IT_department  TO 'KAREN';
GRANT INSERT,UPDATE ON hr_employee.bonus  TO 'KAREN';
/**************************************************/
CREATE USER 'ALICE' IDENTIFIED BY '<<secret3>>';
CREATE TEMPORARY TABLE company_officers_employee  AS
	SELECT * FROM employee
	WHERE dept_id = 78569;
CREATE TEMPORARY TABLE company_officers_department AS
	SELECT * FROM department 
	WHERE dept_id = 78569;
GRANT SELECT,INSERT, UPDATE, DELETE ON company_officers_employee TO 'ALICE';
GRANT INSERT,UPDATE ON company_officers_department  TO 'ALICE';
GRANT INSERT,UPDATE ON company_officers_employee.bonus  TO 'ALICE';
/********************************************************/

CREATE USER 'STEPHEN' IDENTIFIED BY '<<secret3>>';
CREATE TEMPORARY TABLE marketing_employee  AS
	SELECT * FROM employee
	WHERE dept_id = 55852;
CREATE TEMPORARY TABLE marketing_department AS
	SELECT * FROM department 
	WHERE dept_id = 55852;
GRANT SELECT,INSERT, UPDATE, DELETE ON marketing_employee TO 'STEPHEN';
GRANT INSERT,UPDATE ON marketing_department  TO 'STEPHEN';
GRANT INSERT,UPDATE ON marketing_employee.bonus  TO 'STEPHEN';

/************************************************************/

CREATE USER 'JOSH' IDENTIFIED BY '<<secret3>>';
CREATE TEMPORARY TABLE research_employee  AS
	SELECT * FROM employee
	WHERE dept_id = 89978;
CREATE TEMPORARY TABLE research_department AS
	SELECT * FROM department 
	WHERE dept_id = 89978;
GRANT SELECT,INSERT, UPDATE, DELETE ON research_employee TO 'JOSH';
GRANT INSERT,UPDATE ON research_department  TO 'JOSH';
GRANT INSERT,UPDATE ON research_employee.bonus  TO 'JOSH';

/***********************************************************/

CREATE USER 'MARTIN' IDENTIFIED BY '<<secret3>>';
CREATE TEMPORARY TABLE sales_employee  AS
	SELECT * FROM employee
	WHERE dept_id = 651486;
CREATE TEMPORARY TABLE sales_department AS
	SELECT * FROM department 
	WHERE dept_id = 651486;
GRANT SELECT,INSERT, UPDATE, DELETE ON sales_employee TO 'MARTIN';
GRANT INSERT,UPDATE ON sales_department  TO 'MARTIN';
GRANT INSERT,UPDATE ON sales_employee.bonus  TO 'MARTIN';


/*15. Describe how you implement the constraints shown in the ERD and on the employee info.*/
ALTER TABLE data 
  ADD INDEX(location_id ASC),
  ADD INDEX(supplier_id ASC),
  ADD INDEX(material_id ASC),
  ADD CONSTRAINT FK_data_location FOREIGN KEY(location_id) REFERENCES location(location_id),
  ADD CONSTRAINT FK_data_supplier FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id),
  ADD CONSTRAINT FK_data_material FOREIGN KEY(material_id) REFERENCES material(material_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
;

ALTER TABLE employee
 ADD CONSTRAINT CHECK (salary > 0),
 ADD CONSTRAINT CHECK (bonus <= salary), 
 ADD INDEX(dept_id ASC),
 ADD CONSTRAINT FK_EMP FOREIGN KEY (dept_id) REFERENCES department (dept_id)
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 ;
 
 ALTER TABLE department
 ADD INDEX FK_department_index (parent_dept_id ASC),
 ADD CONSTRAINT department_key_constraint FOREIGN KEY (parent_dept_id) REFERENCES department(dept_id)
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 ;
 
 ALTER TABLE payment
 ADD INDEX FK_payment_index (supplier_id ASC),
 ADD CONSTRAINT payment_key_constraint FOREIGN KEY(supplier_id) REFERENCES supplier (supplier_id)
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 ;
