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
column "Book_Title" format A25 Truncated

select row_number() over (order by list_price) as "ListPrice Order"
, book_id "Book ID"
, title as "book_title"
, publ_id as publ
, list_price as price
from bk_books
order by list_price;

/*  TASK 02  */
select dense_rank() over(order by publ_id, list_price desc) as "Publ-ListPrice order"
, publ_id as publ
, list_price as Price
, book_id as "book ID"
, title as "book_title"
from bk_books
where year_publd>2005;

/*  TASK 03 */
with saledata as (
   select round(sum(quantity),-1) as totalquantsale
   , book_id
   , title
   , rank() over(order by round(sum(quantity),-1) desc) as  ranking
   from bk_books
   join bk_order_details using (book_id)
   group by book_id, title)
select ranking as "sales ranking"
, book_id
, title as book_title
, totalquantsale
from saledata
where ranking <=15;

/*  TASK 04 */
with saletotal as (
   select cust_id
   , order_date
   , sum(order_price * quantity) as salesbyday
   from bk_order_headers
   join bk_order_details using (order_id)
   where extract(year from order_date)=extract(year from sysdate)-1
   group by cust_id, order_date)
select cust_id
, to_char(order_date, 'yyyy-mm-dd') as order_date
, salesbyday
, sum(salesbyday) over (partition by cust_id
       order by cust_id, order_date
       range between unbounded preceding and current row) as RunningSalesByCustomer
from saletotal
where cust_id <220000;

/*  TASK 05 */
with authorsale as (
   select author_id
   , book_id
   , sum(quantity) as quantity
   , sum(order_price * quantity) as sale
   from bk_book_authors
   join bk_books using (book_id)
   left join bk_order_details using (book_id)
   where author_sequence=1
   and substr(author_id,0,1)<'J'
   group by rollup(author_id,book_id))
select
case when author_id is null then 'Grand total'
     else to_char(author_id)
     end as "Author ID"
, case when book_id is null then 'total'
     else to_char(book_id)  
     end as "Book ID"
, quantity as "Total Quantity"
, coalesce(to_char(sale), 'no sales') as "Total Sales"
from authorsale;

/*  TASK 06 */
with march as (
   select dtm
   from (
      select to_date('2014-02-28', 'yyyy-mm-dd')+row_number()over(order by num)
   as dtm
      from
         (select 1 as num
          from (select 1 as n from dual) tbl
          group by cube(n,n,n,n,n)
         )tbl1
        )tbl2
where dtm<=to_date('2014-03-31','yyyy-mm-dd'))
, cte as (
  select dtm
  , sum(quantity * order_price) as amount
  from march
  left join bk_order_headers BOH on march.dtm=BOH.order_date
  left join bk_order_details using (order_id)
  group by dtm)
select dtm as "Date"
, round(coalesce(amount,0),2) as TotalSales
, coalesce(round(sum(amount) over(order by dtm
                   rows between 2 preceding and 2 following),2),0) as "5 DaySum"
, coalesce(round(avg(amount) over(order by dtm
                   rows between 2 preceding and 2 following),2),0)as "5 DayAvg"
from cte;