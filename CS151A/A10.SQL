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
create or replace view bk_OrdersPriorYear as (
select 
order_id
, book_id
, order_date
, cust_id as c_id
, cust_name_last || ',' ||' ' || cust_name_first as c_name
from bk_order_details
join bk_order_headers using (order_id)
join bk_customers using (cust_id)
where extract(year from order_date)=extract(year from sysdate)-1
);


/*  TASK 02  */
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 3
intersect
  select
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 6
intersect
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 9;
 

/*  TASK 03 */
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 3
union
  select
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 6
union
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 9;


/*  TASK 04 */
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 4
intersect
  select
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 5
minus
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 6;
 

/*  TASK 05 */
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 3
union
  select
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 6
minus
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 9;

/*  TASK 06 */
  select c_id
  , c_name
  from bk_ordersPriorYear
minus 
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 3
minus
  select
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 6
minus
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 9;


/*  TASK 07 */
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 1
minus
  select
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 2
minus
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 3;

/*  TASK 08 */
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 3
union
  select
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 6
minus (
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 3
intersect
  select 
  c_id
  , c_name
  from bk_OrdersPriorYear
  where extract(month from order_date) = 6
);