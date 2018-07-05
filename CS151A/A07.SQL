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
variable rate number
exec :rate :=0.09

select 
ex_id as "Exam ID"
, srv_id as "Service ID"
, to_char(ex_fee, '9999.00') as "Fee Charged"
, to_char(ex_fee * :rate, '9999.00') as "Tax Amount"
from vt_exam_details
where srv_id in (
   select srv_id
   from vt_services
   where srv_type not in ('office visit'))
order by ex_id, srv_id;
    
/*  TASK 02  */
variable rand number
exec :rand :=Floor(dbms_random.value(10,26))

select :rand
from dual;

select
ex_id
, srv_id
, ex_fee
from vt_exam_details
where rownum <= :rand;

/*  TASK 03 */
select 
an_id
, an_name
, cl_id
from vt_animals
where an_id in (
   select an_id
   from vt_exam_headers
   where to_char(ex_date, 'Mon YYYY') in ('Nov 2014', 'Dec 2014', 'Jan 2015'));

/*  TASK 04 */
select 
an_id
, an_name
, cl_id
from vt_animals
where an_id not in (
   select an_id
   from vt_exam_headers
   where to_char(ex_date, 'Mon YYYY') in ('Nov 2014', 'Dec 2014', 'Jan 2015'))
order by an_id;

/*  TASK 05 */
select 
an_id
, an_name
, cl_id
from vt_animals
where an_id in (
   select an_id
   from vt_exam_headers
   where to_char(ex_date, 'Mon YYYY') not in ('Nov 2014', 'Dec 2014', 'Jan 2015'))
and an_id not in (
   select an_id
   from vt_exam_headers
   where to_char(ex_date, 'Mon YYYY') in ('Nov 2014', 'Dec 2014', 'Jan 2015'));









