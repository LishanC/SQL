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
select stf_job_title
, stf_name_last
from vt_staff vs
join vt_staff_pay vp on vs.stf_id=vp.stf_id
where stf_salary >3000;

select stf_job_title
, stf_name_last
from vt_staff
where stf_id in (
   select stf_id
   from vt_staff_pay
   where stf_salary >3000);

/*  TASK 02  */
select cl_id
, an_id
, an_name
, an_dob
from vt_animals
where cl_id in (
   select cl_id
   from vt_clients
   where cl_city in ('New York', 'Massachusetts'))
and an_type not in ('dogs','birds');

/*  TASK 03 */
variable amount number
exec :amount :=50

select srv_id
, ex_fee
, ex_id
, ex_date
from vt_exam_headers
join vt_exam_details using (ex_id)
where ex_fee > :amount;

exec :amount :=100
/ 

/*  TASK 04 */
variable ID number
exec :ID :=15001

select cl_id
, cl_name_last
, an_type
, srv_id
, srv_desc
, ex_fee
from vt_clients
join vt_animals using (cl_id)
join vt_exam_headers using (an_id)
join vt_exam_details using (ex_id)
join vt_services using (srv_id)
where an_id = :ID;

exec :ID=16004
/

exec :ID=15401
/

/*  TASK 05 */
select * from vt_services
where  srv_desc like '%Feline%'
   and srv_desc not like '%Dental%';

/*  TASK 06 */
select cl_id
, cl_name_last
from vt_clients
where cl_id in (
   select cl_id
   from vt_animals
   where an_type in ('snake', 'chelonian', 'crocodilian', 'lizard'));

/*  TASK 07 */
select cl_id
 , cl_name_last
 from vt_clients
 where cl_id in (
    select cl_id
    from vt_animals
    where an_type in ('snake', 'chelonian', 'crocodilian', 'lizard'))
 and cl_id in (
    select cl_id
    from vt_animals
    where an_type in ('bird'));

/*  TASK 08 */
 select cl_id
, cl_name_last
from vt_clients
where cl_id in
 ( select cl_id
   from vt_animals
   where an_type ='bird')
and cl_id not in
( select cl_id
   from vt_animals
   where an_type = 'snake')
and cl_id not in
( select cl_id
   from vt_animals
   where an_type ='chelonian')
and cl_id not in
( select cl_id
   from vt_animals
   where an_type ='crocodilian')
and cl_id not in
( select cl_id
   from vt_animals
   where an_type ='lizard');

/*  TASK 09 */
select cl_id
 , cl_name_last
 from vt_clients
 where cl_id in (
    select cl_id
    from vt_animals
    where an_type in ('hamster', 'capybara', 'porcupine', 'dormouse'))
 and cl_id in (
    select cl_id
    from vt_animals
    where an_type in ('dog'));

