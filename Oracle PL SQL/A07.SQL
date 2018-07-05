set echo on
set feedback 1 
set pagesize 999 
set trimspool on 
set linesize 200 
set tab off 
clear columns 
set serveroutput on
set autocommit off

-- Lishan Chan

/*  TASK 00 */ 

select user, sysdate from dual;

/*  TASK 01 */
create or replace function get_title(id bk_books.book_id%type)
return bk_books.title%type
is 
  v_title bk_books.title%type;
begin
  select title into v_title from bk_books where book_id = id;
  return v_title;
end;
/

/*  TEST 01 */
select get_title(1110) from dual;

/*  TASK 02  */
create or replace function get_bulk_discount(v_price bk_order_details.order_price%type,
                                             v_quantity bk_order_details.quantity%type)
return bk_order_details.order_price%type
is
    total bk_order_details.order_price%type;
    new_price bk_order_details.order_price%type;
begin
    if v_quantity >2 
      then
        new_price := v_price * (1 - 0.05);
        total := new_price * v_quantity;
        return total;
    else
        total := v_price * v_quantity;
        return total;
    end if;
end;
/

/*  TEST 02 */
select get_bulk_discount(order_price, quantity)
from bk_order_details 
where order_id = 1028 ;


/*  TASK 03 */
create sequence book_seq
start with 2624
increment by 1
nocache
nocycle;

create or replace function valid_publ(pubid bk_publishers.publ_id%type)
return boolean
is
begin
   
   if pubid in(9000,9020,9021,9022,9023,9024,9030,9102,9325,9444,9456,9507,9521,9528,9561,9623,
               9664,9725,9745,9776,9822,9825,9902) then
         return true;
   else
         return false;
   end if;
end;
/

create or replace procedure add_book(v_title bk_books.title%type,
                                     v_publid bk_books.publ_id%type,
                                     v_isbn bk_books.isbn%type,
                                     v_page bk_books.page_count%type
                                     )
is
   year number := extract(year from sysdate);
   price number(6,2) :=29.00;
   bookid number :=book_seq.nextval;
begin
   if valid_publ(v_publid) then
      insert into bk_books(book_id,title,publ_id,year_publd,isbn,page_count,list_price )
      values(bookid,v_title,v_publid, year,v_isbn,v_page,price);
   else
      dbms_output.put_line('publish id is not valid');
   end if;
end;
/

/*  TEST 03 */
exec add_book('Big Little Lies', 1133,8934626,298);
      
/*  TEST 04 */
execute book_pkg.add_book('Java' ,9000,9780136100911, 398);

select * from bk_books where publ_id=9000;



