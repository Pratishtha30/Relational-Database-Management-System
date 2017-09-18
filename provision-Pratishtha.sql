CREATE TABLE department
(
 dept_id                       INTEGER(2)             NOT NULL     PRIMARY KEY    AUTO_INCREMENT,
 dept_name                     VARCHAR(100)           NOT NULL,
 dept_head_id                  INTEGER(2)             NOT NULL,
 dept_aa                       CHAR(15)               NOT NULL,
 parent_dept_id                INTEGER(2)             NULL,
 dept_head_user_id             VARCHAR(15)            NOT NULL,
 location                      VARCHAR(30)            NULL,
 dept_type                     VARCHAR(15)            NULL,
 INDEX(parent_dept_id ASC),
 CONSTRAINT department_key_constraint FOREIGN KEY (parent_dept_id) REFERENCES department(dept_id)
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 );
 
/*
INSERT INTO department
(dept_id, dept_name, dept_head_id, dept_aa, parent_dept_id, dept_head_user_id, location, dept_type)
VALUES
(091136, 'IT', 1109431, 'AA147', 091136, 'DH088', 0, 0),
(78569, 'COMPANY_OFFICERS', 18431, 'AA753', 091136, 'DH123', 0 , 0),
(32662, 'HR', 98341, 'AA4861', 32662, 'DH256', 32662, 0),
(55852, 'MARKETING', 65201, 'AA753', 55852, 'DH904', 0 , 0),
(89978, 'RESEARCH', 320150, 'AA701', 78569, 'DH311', 0 , 0),
(651486, 'SALES', 159168, 'AA397', 32662, 'DH937', 0 , 0)
;
*/


CREATE TABLE employee
(
 employee_id         INTEGER(2)         NOT NULL      PRIMARY KEY          AUTO_INCREMENT,
 employee_name       VARCHAR(100)       NOT NULL,
 tax_id              INT(2)             NOT NULL,
 country             VARCHAR(50)        NOT NULL,
 hire_date           DATE               NOT NULL,
 birth_date          DATE               NOT NULL,
 salary              DECIMAL(10,2)      NOT NULL,
 bonus               DECIMAL(10,2)      NULL,
 dept_id             INTEGER(2)         NOT NULL,
 CHECK (salary > 0),
 CHECK (bonus <= salary), 
 INDEX(dept_id ASC),
 CONSTRAINT FK_EMP FOREIGN KEY (dept_id) REFERENCES department (dept_id)
 ON UPDATE NO ACTION
 ON DELETE NO ACTION
 );

/*
INSERT INTO employee
(employee_id, employee_name, tax_id, country, hire_date, birth_date, salary, bonus, dept_id)
VALUES
(18431, 'ALICE', 135, 'CANNADA', '2005-10-01', '1980-02-15', 40000, 1000, 78569),
(98341, 'LISA', 505, 'KOREA', '2005-02-01', '1990-12-15', 44000, 0, 32662),
(70231, 'PETER', 369, 'DENMARK', '2009-01-11', '1980-02-15', 20000, 1000, 32662),
(43431, 'JOHN', 852, 'FIJI', '2015-11-21', '1980-08-12', 20000, 1000, 091136),
(09431, 'MARY', 655, 'GREECE', '2010-1-01', '2000-02-06', 20000, 1000, 091136),
(65201, 'STEPHEN', 123, 'CHINA', '2012-10-01', '1986-02-06', 40000, 1000, 55852),
(320150, 'JOSH', 405, 'JAPAN', '2011-12-11', '2005-12-16', 40000, 1000, 89978),
(1109431, 'KAREN', 789, 'INDONESIA', '2013-05-11', '2000-02-06', 40000, 1000, 091136),
(159168, 'MARTIN', 605, 'ROMANIA', '2011-05-03', '2000-12-06', 40000, 1000, 651486)
;
*/

CREATE TABLE location
(
 location_id                 INTEGER(2)            NOT NULL    PRIMARY KEY     UNIQUE,
 latitude                   DOUBLE               NOT NULL,
 longitude                   DOUBLE               NOT NULL,
 elevation                   DECIMAL(10,2)        NOT NULL,
 average_temperature         DECIMAL(10,2)        NOT NULL,
 location_type               VARCHAR(100)          NOT NULL,
 applicable_standard         VARCHAR(100)          NOT NULL,
 population                  BIGINT(10)           NULL,
 country                     CHAR(10)             NOT NULL,
 ASCIIname                   VARCHAR(15)          NULL,
 INDEX(latitude),
 INDEX(longitude)
);

/*
INSERT INTO location
(location_id, latitude, longitude, elevation, average_temperature, location_type, applicable_standard, population, country, ASCIIname)
VALUES
(9452, 23.5, 34.25, 15, 21.23, 'CLAY', 'SHTF', 358562147, 'INDIA', 0),
(8320, 33.5, 24.25, 25, 28.23, 'SANDY SALINE', 'XXUV', 0, 'SPAIN', 0),
(7112, 13.5, 14.25, 25, 18.23, 'PEATY', 'MNBH', 456123789, 'AUSTRALIA', 0),
(6148, 22.5, 11.25, 18, 20.23, 'CLAY', 'SHTF', 852147963, 'CANNADA', 0),
(5840, 23.5, 22.25, 15, 21.23, 'SILTY', 'OIJF', 528963147, 'GERMANY', 0),
(4337, 33.5, 34.25, 25, 31.23, 'CLAY', 'SHTF', 145632879, 'FRANCE', 0)
;
*/

CREATE TABLE supplier
(
 supplier_id                     INTEGER(2)      NOT NULL    PRIMARY KEY     UNIQUE     AUTO_INCREMENT,
 supplier_name                   VARCHAR(100)    NOT NULL,
 country                         VARCHAR(15)     NOT NULL,
 reliability_source              VARCHAR(100)    NOT NULL,
 contact_info                    BIGINT          NOT NULL    UNIQUE,
 productivity_score              DOUBLE          NULL
);

/*
INSERT INTO supplier
(supplier_id, supplier_name, country, reliability_source, contact_info, productivity_score)
VALUES
(8120, 'ALICE', 'CANNADA', 'ADAR', 9784563210, 2.3),
(2486, 'ANIKA', 'INDIA', 'HUFB', 7412563148, 5.6),
(3741, 'JONAS', 'AUSTRALIA', 'POKL', 6541239874, 9.2),
(4102, 'ALEX', 'GERMANY', 'NBML', 4102501414, 4.4),
(5789, 'PATRICK', 'SPAIN', 'SXCN', 2589631401, 6.5),
(6290, 'ANDREW', 'FRANCE', 'DCVF', 3256987410, 8.8)
;
*/

CREATE TABLE payment
(
 supplier_id                   INTEGER(2)     NOT NULL      UNIQUE,
 payment_date                  DATE            NOT NULL     PRIMARY KEY,
 amount                        DECIMAL(10,2)   NULL,
 payment_id                    VARCHAR(10)     NOT NULL      UNIQUE,
 CONSTRAINT payment_key_constraint FOREIGN KEY(supplier_id) REFERENCES supplier (supplier_id)
);

/*
INSERT INTO payment
(supplier_id, payment_date, amount, payment_id)
VALUES
(8120, '2017-08-22', 1500, 'P452'),
(2486, '2014-01-11', 2000, 'P159'),
(3741, '2017-08-18', 0, 'P123'),
(4102, '2016-02-26', 4000, 'P302'),
(5789, '2014-11-05', 6000, 'P925'),
(6290, '2015-09-13', 7450, 'P078')
;
*/


CREATE TABLE material
(
 material_id           INTEGER(2)       NOT NULL   PRIMARY KEY    UNIQUE,
 description           CHAR(10)          NOT NULL,
 material_type         CHAR(10)          NOT NULL,
 ir_reflection         FLOAT(4,2)        NOT NULL,
 v_reflection          FLOAT(4,2)        NOT NULL,
 ir_absorption         FLOAT(4,2)        NOT NULL,
 v_absorption          FLOAT(4,2)        NOT NULL
);


/*
INSERT INTO material
(material_id, description, material_type, ir_reflection, v_reflection, ir_absorption, v_absorption)
VALUES
(4506, 'CO2', 'GAS', 02.10, 01.50, 06.21, 02.69),
(7148, 'VAPOR', 'LIQUID', 04.20, 06.78, 01.80, 08.35), 
(5125, 'WATER', 'LIQUID', 04.89, 01.50, 06.21, 02.69),
(4354, 'ICE', 'SOLID', 03.88, 04.57, 09.36, 02.58),
(8624, 'SOOT', 'GAS', 07.46, 06.78, 02.55, 02.69),
(3031, 'OZONE', 'GAS', 05.22, 00.23, 01.12, 03.14)
;
*/

CREATE TABLE data
(
 location_id          INTEGER(2)        NOT NULL,
 supplier_id          INTEGER(2)        NOT NULL,
 material_id          INTEGER(2)        NOT NULL,
 data_time            DATETIME           NOT NULL,
 concentration        DOUBLE(10,2)       NULL,
 INDEX(location_id),
 INDEX(supplier_id),
 INDEX(material_id),
 CONSTRAINT FK_data_location FOREIGN KEY(location_id) REFERENCES location(location_id),
  CONSTRAINT FK_data_supplier FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id),
   CONSTRAINT FK_data_material FOREIGN KEY(material_id) REFERENCES material(material_id)
);

/*
INSERT INTO data
(location_id, supplier_id, material_id, data_time, concentration)
VALUES
(9452, '8120','4506', '2017-08-22 03:14:25', 1112.32 ),
(8320, '2486', '7148', '2015-05-22 23:15:06', 8505.12),
(7112, '3741', '5125', '2015-05-18 11:02:15', 1598.11),
(6148, '4102', '4354', '2016-02-26 14:19:14', 25806.7),
(5840, '5789', '8624', '2014-11-05 21:05:32', 11110.2),
(4337, '6290', '3031', '2015-09-12 19:12:55', 45218.2)
;
*/

