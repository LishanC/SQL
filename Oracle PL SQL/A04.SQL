set echo on
set feedback 1 
set pagesize 999 
set trimspool on 
set linesize 200 
set tab off 
clear columns 
set serveroutput on

-- Lishan Chan

/*  TASK 00 */ 

select user, sysdate from dual;

/*  TASK 01 */
accept num number prompt 'Enter the publ id you wish: ' ;
declare 
   publisher_record bk_publishers%rowtype;
   CURSOR c1 IS 
          select * from bk_publishers
          where publ_id =&num;
begin
   select * into publisher_record
   from bk_publishers
   where publ_id =&num;
   for record in c1
   loop
      dbms_output.put_line(record.publ_id ||' ' || record.publ_name);
   end loop;
end;
/


/*  TASK 02  */
accept n number prompt 'Enter the top of best sellers you wish: ' ;
declare  
   cursor book_sales_cur is
      select bk_books.book_id
      , quantity
      , title
      , year_publd
      , isbn
      , list_price
      from bk_books
      join (
         select book_id
         , sum(quantity) as quantity
         from bk_order_details
         group by book_id
         order by quantity desc)sale
         on bk_books.book_id = sale.book_id
         where rownum<=&n;
   book_sales_rec book_sales_cur%rowtype;
begin
  open book_sales_cur;
     fetch book_sales_cur into book_sales_rec;
     while book_sales_cur%ROWCOUNT <= &n and book_sales_cur%FOUND
     loop
        insert into best_sellers values book_sales_rec;
        fetch book_sales_cur into book_sales_rec;
     end loop;
  close book_sales_cur;
end;
/

select * from best_sellers;


delete from best_sellers;
   

/*  TASK 03 */
accept n1 number prompt 'Enter the low limit number : ' ;
accept n2 number prompt 'Enter the high limit number : ' ;
accept n3 number prompt 'Enter the handling fee : ' ;
declare
   handling_rec bk_handling_fees%rowtype;
   high number;
   low number :=&n1;
begin
   select max(high_limit)
   into high
   from bk_handling_fees;
   handling_rec.low_limit :=&n1;
   handling_rec.high_limit := &n2;
   handling_rec.handling_fee :=&n3;
   loop
     if (low > high)
       then 
          insert into bk_handling_fees values handling_rec;
       exit;
     else
       dbms_output.put_line ('overlap ' );
      exit;
     end if;
   end loop;
end;
/
    
select * from bk_handling_fees;    


/*  TASK 04 */     
accept id1 number prompt 'Enter the first customer id : ' ;
accept id2 number prompt 'Enter the second customer id : ' ;
declare
   cursor bk_order_cur1 is
       select order_id, order_date, cust_id
       from bk_order_headers
       where cust_id =&id1;
   cursor bk_order_cur2 is
       select order_id, order_date, cust_id
       from bk_order_headers
       where cust_id =&id2;
begin
   for bk_info1 in bk_order_cur1
   loop
      for bk_info2 in bk_order_cur2
      loop
         if (bk_info1.order_date = bk_info2.order_date)
         then
            dbms_output.put_line('the same order date is" ' || bk_info1.order_date);
         end if;
      end loop;
   end loop;
end;
/
