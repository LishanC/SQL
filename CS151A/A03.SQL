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
select distinct cl_id
from vt_animals;

/*  TASK 02  */
select
cl_postal_code || ':' || ' ' || cl_city|| ' '||cl_state as Location
from vt_clients
where cl_state not in ('OH', 'IL');

/*  TASK 03 */
select 
cl_id
, an_id
from vt_animals
where an_name is null;

/*  TASK 04 */
select srv_id as "Service ID"
, srv_type as "Service Type"
, srv_list_price as Price
, srv_list_price * 0.125 as "Tax Amnt"
from vt_services
where srv_type not in ('office visit')
order by srv_id;

/*  TASK 05 */
select ex_id
, ex_fee
from vt_exam_details
where ex_fee between 35 and 50
order by srv_id;

/*  TASK 06 */
select cl_id
, an_id
, an_name
from vt_animals
where an_type in ('snake','chelonian', 'crocodilian', 'lizard')
order by cl_id, an_id;

/*  TASK 07 */
select cl_id
, an_type
, from vt_animals
where an_type in ('hamster', 'capybara', 'porcupine', 'dormouse')
order by cl_id;

/*  TASK 08 */
select cl_id
, an_id
, an_name
, an_dob
from vt_animals
where an_type not in ('hamster', 'capybara', 'porcupine', 'dormouse', 'snake','chelonian', 'crocodilian', 'lizard')
order by an_dob desc







