set echo on
set feedback 1
set pagesize 999
set trimspool on
set linesize 200
set tab off
clear columns

column line format 999
column text format a70
column text wrapped

--Lishan Chan

/*  TASK 00 */
select user, sysdate 
from dual;

/* function source code */
select line, text
from user_source
where type in ('FUNCTION')
and name in ('ADJUSTEDPRICE')
order by name, line;

/*  TASK 01 */
with testdata as
(  select 1 as testrun
, 9.5 as price
, 10 as quantity
, 9.5 as expected
from dual
union all
select 2, 12, 3, 12 from dual
union all
select 3, 20, 6, 19 from dual
union all
select 4, 25, 20, 22.5 from dual
union all
select 5, 18, 35, 15.3 from dual
union all
select 6, 30, 102, 24.6 from dual
union all
select 8, 7.5, 50, 7.5 from dual
)
, calc as (
  select testrun
  , price
  , quantity
  , expected
  , AdjustedPrice(price,quantity) as actual
  from testdata
)
select testrun
, price
, quantity
, expected
, actual
, expected - actual as problem
from calc;
   

/*  TASK 02  */
with testbook as (
  select order_id
  , book_id
  , list_price as list
  , quantity
  , AdjustedPrice(list_price, quantity) as expctdprice
  , order_price as ordprice
  from bk_order_details
  join bk_books using (book_id)
)
select order_id
, book_id
, list
, quantity
, expctdprice
, expctdprice - ordprice as pricingerror
from testbook
where (expctdprice-ordprice) > expctdprice * 0.2;

/* function source code */
select line, text
from user_source
where type in ('FUNCTION')
and name in ('PREVMONTH')
order by name, line;

/*  TASK 03 */
with testdata1 as
(  select 1 as testrun
, sysdate as date_in
, 0 as month_in
, to_char(sysdate, 'YYYY-MM') as expecte
from dual
union all
select 2, date '2012-04-01', 1, '2012-03' from dual
union all
select 3, date '2014-05-30', 2, '2014-03' from dual
union all
select 4, date '2014-06-01', -2, '2014-08' from dual
union all
select 5, null, 3, '2015-01' from dual
union all
select 6, null, 2, '2015-01' from dual
)
,calc1 as (
   select testrun
   , date_in
   , month_in
   , PrevMonth(date_in, month_in) as actual
   , expecte
   from testdata1)
select testrun
, date_in
, month_in
, actual
, expecte
, case 
   when expecte = actual then 'pass'
   else '***FAIL***'
   end status
from calc1;

/*  TASK 04 */
select count(distinct order_id) as NumberOrders
, count(distinct cust_id) as NumberCustWithOrders
from bk_order_headers
where to_char(order_date, 'YYYY-MM') in (PrevMonth(sysdate, 1), PrevMonth(sysdate,2));

