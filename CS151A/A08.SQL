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
an_id
, an_name
from vt_animals
where an_id in (
   select an_id
   from vt_exam_headers
   where extract (year from ex_date) in ('2005', '2007','2010'));


/*  TASK 02  */
select
an_id
, ex_id
, to_char(ex_date, 'YYYY-MM-DD') as "Exam_date"
, case
     when current_date - ex_date <30 then 'Less then 30'
     when current_date - ex_date <90 then 'Less then 90'
     when current_date - ex_date <180 then 'Less then 180'
     when current_date - ex_date <360 then 'Less then 360'
  else '360 days or more'
  end "Exam_Age"
from vt_exam_headers
order by an_id, ex_date desc;

/*  TASK 03 */
select 
ex_id
, an_id
, ex_date
from vt_exam_headers
where ex_date=last_day(ex_date);

/*  TASK 04 */
select distinct
cl_id
, cl_name_last || ' ' || cl_name_first as "Client"
from vt_clients
join vt_animals using (cl_id)
join vt_exam_headers using (an_id)
where to_char(ex_date, 'MON') in ('SEP', 'OCT');

/*  TASK 05 */sd
variable range number
exec :range :=6

select 
cl_id
, cl_name_last
, an_id
, ex_date
, ex_id
from vt_clients 
join vt_animals using (cl_id)
join vt_exam_headers using (an_id)
where ceil(months_between(current_date, ex_date)) between 1 and :range;

