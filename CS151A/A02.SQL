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
select
an_type
, an_name
, an_id
from vt_animals
order by an_id;

/*  TASK 02  */
select 
ex_date "Exam Date"
, an_id "Animal ID"
from vt_exam_headers
order by ex_date desc;

/*  TASK 03 */
select distinct an_type 
from vt_animals ;

/*  TASK 04 */
select 
ex_id "EXAM_ID"
, ex_fee "FEE_CHARGED"
from vt_exam_details
order by ex_id, ex_fee;

/*  TASK 05 */
select 
srv_type
, srv_desc
from vt_services
order by srv_type, srv_list_price;

/*  TASK 06 */
select distinct
cl_state "State"
, cl_city "City"
from vt_clients
order by cl_state, cl_city;

/*  TASK 07 */
select
stf_job_title "Job Desc"
, stf_name_first "First Name"
, stf_name_last "Last Name"
from vt_staff
order by stf_name_last, stf_name_first;

/*  TASK 08 */
select 
an_id
, ex_date
, stf_id
from vt_exam_headers
order by stf_id, ex_date;



