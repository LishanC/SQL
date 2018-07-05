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
cust_id as "cust ID"
, cust_name_last as "cust Name"
from bk_customers 
where cust_id in (
   select cust_id
   from bk_order_headers 
   where order_id in (
      select order_id
      from bk_order_details 
      where order_price > 75))
group by cust_id, cust_name_last
order by cust_id;

/*  TASK 02  */
select 
cust_id
, cust_name_last
from bk_customers BC
where exists (
      select 1
      from bk_order_headers BH
      where extract(month from order_date)=1
      and extract (year from order_date) = extract(year from sysdate)
      and BH.cust_id=BC.cust_id)
and exists (
      select 1
      from bk_order_headers BH
      where extract(month from order_date) =2
      and extract (year from order_date) = extract(year from sysdate)
      and BH.cust_id=BC.cust_id)
and exists (
      select 1
      from bk_order_headers BH
      where extract(month from order_date) =3
      and extract (year from order_date) = extract(year from sysdate)
      and BH.cust_id=BC.cust_id)
order by cust_id;

/*  TASK 03 */
select 
author_name_first
, author_name_last
, author_id
from bk_authors BA
where exists (
   select author_id
   from bk_book_authors BBA
   where BA.author_id=BBA.author_id
   group by author_id
   having count(author_id)>1)
and not exists (
   select 1
   from bk_order_details BD
   where book_id in (
       select book_id
       from bk_books BBS
       where book_id in (
          select book_id
          from bk_book_authors BBA
          where BBA.author_id = BA.author_id)))
order by author_id;

/*  TASK 04 */
select
book_id
, substr(title,0,15) as Title
from bk_books BB
where book_id in (
    select book_id
    from bk_book_topics BT
    where topic_id in ('DB', 'SQL', 'SSRV', 'MYSQL', 'ORA', 'ADO')
    group by book_id
    having count(topic_id)=2)
order by book_id;
  
/*  TASK 05 */
select
order_date
, BH.order_id
, BH.cust_id
, (
   select cust_name_last 
   from bk_customers BC
   where BC.cust_id=BH.cust_id) as Customer
, (
   select sum(quantity) 
   from bk_order_details BD
   where BD.order_id=BH.order_id)as NumberBooks
, (
   select sum(order_price * quantity)
   from bk_order_details BD
   where BD.order_id=BH.order_id) as OrderCost
from bk_order_headers BH
where extract(month from order_date) in (1,2,3)
and extract(year from order_date)=extract(year from sysdate)-1
group by BH.order_id,BH.cust_id,order_date
order by order_date;

/*  TASK 06 */
with C1 as (
   select cust_id
   , count(order_id) as cnt1
   from bk_order_headers
   where extract(month from order_date) in (1,2,3)
   and extract(year from order_date)=extract(year from sysdate)-1
   group by cust_id)
,C2 as (
   select cust_id
   , count(order_id) as cnt2
   from bk_order_headers
   where extract(month from order_date) in (1,2,3)
   and extract(year from order_date)=extract(year from sysdate)
   group by cust_id)
,C3 as (
   select cust_id
   from C1
   where cust_id in (
     select cust_id
     from C2
     where C1.cnt1>=C2.cnt2))
select 
cust_id
, cust_name_last
from bk_customers BC
where cust_id in (
   select cust_id
   from C3);