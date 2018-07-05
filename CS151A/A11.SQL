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
book_id
, title
from bk_books 
where (book_id in (
   select book_id
   from bk_book_topics
   where topic_id = 'DB')
and book_id in (
   select book_id
   from bk_book_topics
   where topic_id= 'SQL')
or book_id in (
   select book_id
   from bk_book_topics
   where topic_id in ('DB', 'SQL')) )
and book_id in (
   select book_id
   from bk_order_details)
order by book_id;
   

/*  TASK 02  */
select 
book_id
, title
from bk_books 
where book_id in (
   select book_id
   from bk_book_topics
   where topic_id = 'DB')
and book_id in (
   select book_id
   from bk_book_topics
   where topic_id= 'SQL')
and book_id in (
   select book_id
   from bk_order_details)
order by book_id;

/*  TASK 03 */
select 
book_id
, title
from bk_books 
where book_id in (
   select book_id
   from bk_book_topics
   where topic_id = 'SQL')
and book_id not in (
   select book_id
   from bk_book_topics
   where topic_id in ('DB'))
and book_id in (
   select book_id
   from bk_order_details)
order by book_id;

/*  TASK 04 */
with cte1 as (
   select cust_id
   , order_id
   , order_price
   , quantity
   from bk_order_headers OH
   join bk_order_details using (order_id)
   where extract(year from order_date)=extract(year from sysdate)-1)
select cust_id, cust_name_last
from bk_customers
where cust_id in (
   select cust_id
   from cte1
   group by cust_id
   having sum(order_price*quantity)>5000)
order by cust_id;


/*  TASK 05 */
select
extract (year from order_date) as year
, extract (month from order_date) as month
from bk_order_headers
group by extract (year from order_date), extract (month from order_date)
having count(order_id) <=all (
   select count(order_id)
   from bk_order_headers
   group by extract (year from order_date), extract (month from order_date));

/*  TASK 06 */
select
book_id
, title
from bk_books
where book_id in (
   select book_id
   from bk_order_details
   group by book_id
   having sum(quantity)>=20)
and book_id in (
   select book_id
   from bk_order_details
   group by book_id
   having sum(quantity)<50)
order by book_id;


/*  TASK 07 */
select
cust_id
, cust_name_last
from bk_customers
where cust_id in (
   select cust_id
   from bk_order_headers
   where extract(year from order_date)=extract(year from sysdate)
   and order_id in (
      select order_id
      from bk_order_details
      where book_id in (
         select book_id
         from bk_books
         where book_id in (
            select book_id
            from bk_book_topics
            where topic_id in ('ART'))
) ) )
order by cust_id;


/*  TASK 08 */
select
cust_id
, cust_name_last
from bk_customers
where cust_id in (
   select cust_id
   from bk_order_headers
   where order_id in (
      select order_id
      from bk_order_details
      group by order_id
      having sum(quantity*order_price) >=all (
        select sum(quantity*order_price)
        from bk_order_details
        group by order_id)
));




















