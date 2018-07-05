set echo on
set feedback 1
set pagesize 999
set trimspool on
set linesize 200
set tab off
clear columns

set Long 999999
column BookID format A10
column Title format A35
column Price format 9,990.00
column AuthorList format A50
column Subject format A15
column AvgPrice format 9,990.00

--Lishan Chan

/*  TASK 00 */
select user, sysdate 
from dual;

/*  TASK 01 */
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extractvalue(book_xml, '//book/bk_price[1]') as Price
, extractvalue(book_xml, '//book/bk_subject[1]') as subject
from asgXML_books;

/*  TASK 02  */
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extractvalue(book_xml, '//book/bk_price[1]') as booktitle
, extract(book_xml, '//bk_authors[author]') as authorlist
from asgXML_books
where extractvalue(book_xml, '//bk_subject') ='Fiction'
and extractvalue(book_xml,'//bk_price') >30;

/*  TASK 03 */
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extractvalue(book_xml, '//book/bk_price[1]') as booktitle
, extract(book_xml, '//bk_authors[author]') as authorlist
from asgXML_books
where existsNode(book_xml, '//bk_subject[1]="Fiction"')=1
and existsNode(book_xml, '//bk_price[1]>30')=1;

/*  TASK 04 */
with cet as (
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extract(book_xml, '//author') as authorlist
from asgXML_books)
select bookid
, title
, authorlist
from cet
where authorlist like '%Martin%';

/*  TASK 05 */
with cet as (
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extractvalue(book_xml, '//author[1]') as authorlist
from asgXML_books)
select bookid
, title
, authorlist
from cet
where authorlist = 'Martin';

/*  TASK 06 */
with cet as (
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extract(book_xml, '//author') as authorlist
from asgXML_books)
select bookid
, title
, authorlist
from cet
where authorlist not like '%Martin%';

/*  TASK 07 */
with cet as (
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extractvalue(book_xml, '//author[4]') as authorlist4
, extractvalue(book_xml, '//author[10]') as authorlist10
from asgXML_books)
select bookid
, title
from cet
where authorlist4 is not null and authorlist10 is null;

/*  TASK 08 */
with cet as (
select 
extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
, extractvalue(book_xml, '//book/bk_title[1]') as title
, extractvalue(book_xml, '//book/bk_price[1]') as Price
from asgXML_books)
select BOOKID
, title
, Price
, dense_rank() over (order by Price desc nulls last) as pricerank
from cet;


/*  TASK 09 */
with cet as (
select 
extractvalue(book_xml, '//book/bk_price[1]') as Price
, extractvalue(book_xml, '//book/bk_subject[1]') as subject
from asgXML_books)
, GroupedData as (
select subject
, avg(price) as avgprice
, count(*) as numbooks
from cet
group by rollup (subject))
select 
coalesce (subject, 'summary')
, avgprice as "Avg Price"
, numbooks as "Number Books"
from GroupedData;

/*  TASK 10 */
with C1 as (
   select 
   extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
   , extractvalue(book_xml, '//book/bk_subject[1]') as subject
   , extractvalue(book_xml, '//book/bk_title[1]') as title
   , extractvalue(book_xml, '//book/bk_price[1]') as Price
   from asgXML_books
   where extractvalue(book_xml, '//book/bk_subject[1]')='SQL')
, C2 as (
   select 
   extractvalue(book_xml, '//book/bk_id[1]') as BOOKID
   , extractvalue(book_xml, '//book/bk_subject[1]') as subject
   , extractvalue(book_xml, '//book/bk_title[1]') as title
   , extractvalue(book_xml, '//book/bk_price[1]') as Price
   from asgXML_books
   where extractvalue(book_xml, '//book/bk_subject[1]')!='SQL')
, C3 as (
select C1.subject 
, C1.price as price1
, C2.subject
, C2.price as price2
from C1
cross join C2)
select
round(avg(price1),2) as AvgPrice_SQL
, round(avg(price2),2) as AvgPrice_other
from C3;

