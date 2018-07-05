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
cl_id
, cl_name_last
from vt_clients
where cl_id not in (
    select cl_id
    from vt_animals);
    
/*  TASK 02  */
select 
cl_id
, cl_name_last
from vt_clients
where cl_id in (
   select cl_id
   from vt_animals);

/*  TASK 03 */
select 
cl_id
, cl_name_last
from vt_clients
where cl_id in (
    select cl_id
    from vt_animals
    where an_type in ('hamster', 'capybara', 'porcupine', 'dormouse'));

/*  TASK 04 */
select 
cl_id
, cl_name_last
from vt_clients
where cl_id in (
    select cl_id
    from vt_animals
    where an_type not in ('snake', 'chelonian', 'crocodilian', 'lizard'));

/*  TASK 05 */
select distinct
an_id
, an_name
from vt_animals
join vt_exam_headers using (an_id)
join vt_staff using (stf_id)
where stf_job_title ='vet assnt';

/*  TASK 06 */
select 
VC.cl_id
, cl_name_last
, VH.an_id
, an_type
from vt_clients VC
join vt_animals VA on VA.cl_id=VC.cl_id 
left join vt_exam_headers VH on VH.an_id=VA.an_id
where VH.an_id is null
order by VC.cl_id, VH.an_id;

/*  TASK 07 */
select 
VC.cl_id
, cl_name_last
, VH.an_id
, an_type
from vt_clients VC
left join vt_animals VA on VA.cl_id=VC.cl_id 
left join vt_exam_headers VH on VH.an_id=VA.an_id
where VH.an_id is null
order by VC.cl_id, VH.an_id;

/*  TASK 08 */
select distinct cl_id, cl_name_last
from (
      select cl_id
      from vt_animals
      join vt_clients using (cl_id)
      where an_type in ('snake', ' chelonian', 'crocodilian', 'lizard'))tbl1
join (
      select cl_id, cl_name_last
      from vt_animals
      join vt_clients using (cl_id)
      where an_type in ('hamster', 'capybara', 'porcupine', 'dormouse')
)tb2 using (cl_id);

    
  



































