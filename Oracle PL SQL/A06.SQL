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
declare
   type catecurtype is REF cursor;
   type numlist is table of number;
   prd_cv catecurtype;
   prd_rec prd_products.prod_id%type;
   catgid varchar2(10) := 'PET';
   sql_stmt varchar2(200);
   eid numlist;
begin
   sql_stmt := 'select prod_id from prd_products where catg_id = :j ';
   open prd_cv for sql_stmt using catgid;
   fetch prd_cv bulk collect into eid;
   close prd_cv;   
end;
/


/*  TASK 02  */
accept percent number prompt 'Enter the percentage you wish : ';
accept catgid char prompt 'Enter the catergory id : ';

declare
   type namelist is table of prd_products.prod_name%type;
   names namelist;
begin
   update prd_products set prod_list_price = prod_list_price * (1 + &percent/100) where catg_id = '&catgid'
       returning prod_name bulk collect into names;
   for i in names.first..names.last
   loop 
      dbms_output.put_line('update product name are: ' || names(i));
   end loop;
end;
/

/*  TASK 03 */
accept target_sal number prompt 'Enter the target sale amount you wish: ' ;
declare 
   type numlist is table of number;
   type raiselist is table of number;
   type emp_table_type1 is table of emp_employees.emp_id%type index by pls_integer ;
   type emp_table_type2 is table of emp_employees.salary%type index by pls_integer ;
   empid emp_table_type1;
   newsal emp_table_type2;
   jobs numlist := numlist(1,4,8);
   prices raiselist := raiselist(0.1, 0.15, 0.2);
   sal_amount number(38) ;
begin
   select sum(quantity_ordered * quoted_price) into sal_amount
   from oe_orderDetails OD
   join oe_orderHeaders OH on OD.order_id = OH.order_id
   where extract(year from order_date)=2015;
   
   if sal_amount < &target_sal then
      dbms_output.put_line('no salary raise this year');
   else    
      forall i in jobs.first..jobs.last
          update emp_employees set salary = salary * (1+prices(i)) where job_id = jobs(i);
     
      select emp_id, salary bulk collect into empid, newsal from emp_employees
      where job_id in (1,4,8);

      for i in empid.first..empid.last
      loop
          dbms_output.put_line('emp_id ' || empid(i) ||' new salary is : ' || newsal(i));
      end loop;
   end if;
end;
/

select emp_id, salary from emp_employees where job_id in (1,4,8);

accept answer char prompt 'confirm if the new salary correct with y/n : ';
declare
begin
  if &answer = 'y' then
      commit;
  else
     rollback;
  end if;
end;
/

select emp_id, salary from emp_employees where job_id in (1,4,8);

/*  TASK 04 */
accept empid number prompt 'Enter the employee id : ' ;
accept emp_column char prompt 'Enter the name of column : ' ;
accept val char prompt 'Enter the new value : ';

declare     
   sql_stmt varchar2(200);
begin
   case 
   when &emp_column = 'emp_id' then    
      sql_stmt := 'update emp_employees set emp_id = to_number(&val) where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'name_last' then
      sql_stmt := 'update emp_employees set emp_id = cast (&val as varchar2(25)) where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'name_first' then
      sql_stmt := 'update emp_employees set name_first = cast(&val as varchar2(25)) where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'ssn' then
      sql_stmt := 'update emp_employees set ssn = &val where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'emp_mng' then
      sql_stmt := 'update emp_employees set emp_mng = to_number(&val) where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'dept_id' then
      sql_stmt := 'update emp_employees set dept_id = to_number(&val) where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'hire_date' then
      sql_stmt := 'update emp_employees set hire_date = to_date(&val) where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'salary' then
      sql_stmt := 'update emp_employees set salary = to_number(&val) where emp_id = &empid';
      execute immediate sql_stmt;
   when &emp_column = 'job_id' then
      sql_stmt := 'update emp_employees set job_id = to_number(&val) where emp_id = &empid';
      execute immediate sql_stmt; 
   end case;
end;
/

select emp_id, salary from emp_employees where emp_id = &empid;
