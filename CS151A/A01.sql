set echo on
set feedback 1
set pagesize 999
set trimspool on
set linesize 200
set tab off
clear columns


--Lishan Chan

/*  TASK 00 */
select user, sysdate 
from dual;

/*  TASK 01 */
select banner
from v$version;

/*  TASK 02  */
Delete
From zoo_2015
Where z_id > 100;

Select *
From zoo_2015;
/*  TASK 03 */
Insert Into zoo_2015  (z_id, z_name, z_type, z_cost, z_dob, z_acquired) Values
  (128, 'Giant', 'Tiger', 5000.00, to_date('2014-01-10', 'YYYY-MM-DD'), date '2014-06-15');

Insert Into zoo_2015 (z_id, z_name, z_type, z_cost, z_dob, z_acquired) Values
  (138, 'Elza', 'Panda', 9900.00, to_date('2013-05-12', 'YYYY-MM-DD'), date '2014-01-15');

Insert Into zoo_2015  (z_id, z_name, z_type, z_cost, z_dob, z_acquired) Values
  (148, 'Aron', 'Lion', 4800.00, to_date('2008-10-02', 'YYYY-MM-DD'), date '2010-11-27');

/*  TASK 04 */
insert Into zoo_2015 (z_id, z_name, z_type, z_cost, z_dob, z_acquired) values
  (101, 'Crystal', 'Dog', 880.00, to_date('2014-01-09', 'YYYY-MM-DD'), date '2014-01-16');

insert Into zoo_2015 (z_id, z_name, z_type, z_cost, z_dob, z_acquired) values
  (102, 'Kam', 'Hippo', 510.00, to_date('2013-05-11', 'YYYY-MM-DD'), date '2014-01-16');

insert into zoo_2015 (z_id, z_name, z_type, z_cost, z_dob, z_acquired) values
  (103, 'Lily', 'Cat', 100.00, to_date('2012-12-01', 'YYYY-MM-DD'), date '2012-12-25');

Insert Into zoo_2015(z_id, z_name, z_type, z_cost, z_dob, z_acquired) VALUES
  (652, 'Jerry', 'Tiger', 2200.00, to_date('2015-06-15', 'YYYY-MM_DD'), date '2015-06-15');

Insert Into zoo_2015(z_id, z_name, z_type, z_cost, z_dob, z_acquired) VALUES
  (737, 'Kenny', 'Chimpanzee', 4300.00, to_date('2015-07-11', 'YYYY-MM_DD'), date '2015-07-11');

Insert Into zoo_2015(z_id, z_name, z_type, z_cost, z_dob, z_acquired) VALUES
  (234, 'Newton', 'Ostrich', 3400.00, to_date('2015-03-12', 'YYYY-MM_DD'), date '2015-03-12');

/*  TASK 05 */
Select z_name
, z_type, z_id
, z_cost
, z_dob
, z_acquired
From zoo_2015;

/*  TASK 06 */
select z_type
, z_name
, z_cost
from zoo_2015
order by z_type, z_name;

/*  TASK 07 */
select z_id
, z_name
, z_dob
from zoo_2015
where z_type='Zebra';

/*  TASK 08 */
Select tname
From tab;

/*  TASK 09 */
desc zoo_2015
