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
select distinct
, VA.cl_id
, an_type
, cl_name_last
from vt_clients VC
join vt_animals VA on VC.cl_id=VA.id
where an_dob < '31-Dec-08';

/*  TASK 02  */
select vh.ex_id
, ex_date
, srv_id
, ex_fee
, an_type
from vt_exam_headers vh
join vt_exam_details vd on vh.ex_id=vd.ex_id
join vt_animals va on va.an_id=vh.an_id
where an_type in ('hamster', 'capybara', 'porcupine', 'dormouse');

/*  TASK 03 */
 select 
, vs.stf_id
, stf_name_first || ' ' || stf_name_last as Name
, ex_date
from vt_staff vs
join vt_exam_headers vh on vs.stf_id=vh.stf_id
join vt_animals va on va.an_id=vh.an_id
where an_type not in ('snake', 'chelonian', 'crocodilian', 'lizard')
order by ex_date;

/*  TASK 04 */
select 
, cl_id
, vh.ex_id
, stf_id
, vd.srv_id
, srv_desc
, srv_list_price
, ex_fee
from vt_exam_headers vh
join vt_exam_details vd on vh.ex_id=vd.ex_id
join vt_services vs on vs.srv_id=vd.srv_id
join vt_animals va on va.an_id=vh.an_id
where ex_fee <0.5 * srv_list_price
order by stf_id, vh.ex_id, vd.srv_id;

/*  TASK 05 */
select
vh.ex_id
, ex_fee
, ex_desc
, srv_desc
, an_id
from vt_exam_headers vh
join vt_exam_details vd on vh.ex_id=vd.ex_id
join vt_services vs on vs.srv_id=vd.srv_id
where ex_fee between 50 and 100
order by vd.srv_id, vh.ex_id;

/*  TASK 06 */
select distinct
vc.cl_id
, cl_name_last
from vt_clients vc
join vt_animals va on va.cl_id=vc.cl_id
where an_type in ('cat')
order by vc.cl_id;

/*  TASK 07 */
select distinct
vc.cl_id
, cl_name_last
from vt_clients vc
join vt_animals va on va.cl_id=vc.cl_id
where an_type not in ('cat')
order by vc.cl_id;

/*  TASK 08 */
select distinct
vc.cl_id
, cl_name_last
from vt_clients vc
join vt_animals va on va.cl_id=vc.cl_id
where an_type in ('hamster', 'capybara', 'porcupine', 'dormouse')
order by vc.cl_id;

/*  TASK 09 */
select distinct
vc.cl_id
, cl_name_last
from vt_clients vc
join vt_animals va on va.cl_id=vc.cl_id
where an_type not in ('hamster', 'capybara', 'porcupine', 'dormouse')
order by vc.cl_id;



