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
drop table smallanimals;

create table smallanimals as
    select cl_id as clid
    , an_id as ANID
    , substr(an_name,0,10) as ANNAME
    , an_type as ANCATEGORY
    , max(ex_date) as recentexamdate
    , sum(ex_fee) as totalfees
    from vt_animals
    left join vt_exam_headers using (an_id)
    left join vt_exam_details using (ex_id)
    where an_type in ('hamster', 'capybara', 'porcupine', 'dormouse', 'snake', 'chelonian', 'crocodilian', 'lizard') 
    group by cl_id, an_id, an_name, an_type;

select *
from smallanimals
order by clid;

/*  TASK 02  */
alter table smallanimals
add examstatus varchar2(25);

update smallanimals
set examstatus=case
                  when months_between(trunc(to_date(sysdate),'mm'),trunc(to_date(recentexamdate),'mm'))<9 then 'current'
                  when months_between(trunc(to_date(sysdate),'mm'),trunc(to_date(recentexamdate),'mm'))<12 then 'send notice'               
                  when months_between(trunc(to_date(sysdate),'mm'),trunc(to_date(recentexamdate),'mm'))>=12 then 'send 2nd notice'
               else
               'no data-call'
               end;

select *
from smallanimals;

/*  TASK 03 */
create or replace view bk_MnthSales as 
    select book_id
    , title
    , extract(year from order_date) as yr
    , extract(month from order_date) as mnth
    , to_char(sum(order_price * quantity),'999.99') as mnthsales
    from bk_order_headers
    join bk_order_details using (order_id)
    join bk_books using (book_id)
    group by book_id, title,extract(year from order_date), extract(month from order_date)
    order by book_id;
 
select * from bk_MnthSales;

/*  TASK 04 */
select *
from bk_MnthSales
where mnthsales = (
    select max(mnthsales)
    from bk_MnthSales
    where yr=2014 and mnth=8);

/*  TASK 05 */
insert into bk_order_headers
values (10000, '25-AUG-14',208950);

insert into bk_order_headers
values (10001, '2-AUG-14',200368);

insert into bk_order_headers
values (10002, '5-AUG-14',258595);

insert into bk_order_details
values (10000,1,2032,50,400);

insert into bk_order_details
values (10001,1,2031,80,250);

insert into bk_order_details
values (10002,1,1103,10,2000);

select *
from bk_MnthSales
where mnthsales = (
    select max(mnthsales)
    from bk_MnthSales
    where yr=2014 and mnth=8);

/*  TASK 06 */
delete 
from bk_order_details
where order_id=10000;

delete 
from bk_order_details
where order_id=10001;

delete 
from bk_order_details
where order_id=10002;

delete 
from bk_order_headers
where order_id=10000;

delete 
from bk_order_headers
where order_id=10001;

delete 
from bk_order_headers
where order_id=10002;


