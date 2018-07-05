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
SUM (quantity * order_price) as Amtdue
from bk_order_details
where book_id in (1894);


/*  TASK 02  */
select 
sum (quantity) as "NumberOfOrders"
from bk_order_details
join bk_order_headers using (order_id)
where book_id in (1894)
and to_char(order_date, 'YYYY')=extract(year from sysdate) -1;

/*  TASK 03 */
select 
cust_id
, cust_name_last as "CustName"
, sum(quantity) as "BookTotal"
, sum(case when to_char(order_date, 'YYYY')=to_char(sysdate, 'YYYY') 
      then quantity end) as "CurrentYearBookTotal"
from bk_customers
left join bk_order_headers using (cust_id)
left join bk_order_details using (order_id)
group by cust_id, cust_name_last
order by cust_id;

/*  TASK 04 */
variable Q number;
exec :Q :=to_char(add_months(sysdate,-3),'Q');

select :Q from dual;

select count(order_id) as NumOfOrder
, count(distinct cust_id) as NumOfCust
from bk_order_headers
where to_char(order_date, 'Q')= :Q;

/*  TASK 05 */
select book_id
, title
from bk_order_details
join bk_books using (book_id)
join bk_book_topics using (book_id)
where topic_id in ('FCT', 'POE')
group by book_id, title
having count(order_id) = (
   select max(count(order_id))
   from bk_order_details
   join bk_books using (book_id)
   join bk_book_topics using (book_id)
   where topic_id in ('FCT', 'POE')
   group by book_id);


/*  TASK 06 */
select 
  count(distinct (case when topic_id in ('CMP') then book_id else null end)) as "Computer Science"
, count(distinct (case when topic_id in ('DB','SQL','SSRV','MySQL','ORA','ADO') then book_id else null end)) as "Database Systems"
, count(distinct (case when topic_id in ('NOSQL','XML', 'DB') then book_id else null end)) as "Data Storage Techniques" 
, count(distinct book_id) as "All Books"
from bk_book_topics;

/*  TASK 07 */
select 
bk_customers.cust_id
, cust_name_last
, coalesce(to_char(max(order_date),'DD-MM-YYYY'), 'No Orders') as "MostRecentOrder"
from bk_customers
left join (
  select cust_id
  , order_date
  , order_id
  from bk_order_headers
  join bk_order_details using (order_id)
) table1 on table1.cust_id=bk_customers.cust_id
group by bk_customers.cust_id, cust_name_last
order by bk_customers.cust_id, cust_name_last;

/*  TASK 08 */
select distinct
cust_id
, cust_name_last
from bk_customers
join bk_order_headers using (cust_id)
join bk_order_details using (order_id)
join bk_books using (book_id)
join bk_book_topics using (book_id)
where topic_id in ('SQL')
and cust_id not in (
   select distinct cust_id
   from bk_order_headers
   join bk_order_details using (order_id)
   where book_id in (1142))
group by cust_id, cust_name_last
having sum(quantity * order_price) > 500;


