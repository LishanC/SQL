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

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
/
/*  TASK 02  */
declare 
   v_name1 number :=1;
   v_name2 date  :=current_date;
   v_name3 char  :='A';
begin
   -- begin processing
   dbms_output.put_line('Variable 1 is ' || v_name1 );
   dbms_output.put_line('Variable 2 is ' || v_name2 );
   dbms_output.put_line('Variable 3 is ' || v_name3 );
   v_name1 := v_name1 +1;
   v_name2 := v_name2 +1;
   v_name3 := chr(ascii(v_name3) +1);
   dbms_output.put_line('new variable 1 is ' || v_name1);
   dbms_output.put_line('new variable 2 is ' || v_name2);
   dbms_output.put_line('new variable 3 is ' || v_name3);
end;
/

/*  TASK 03 */
accept agent_num number prompt 'Enter the number of season ticket holders: ' ;

declare
   max_num number:=41159;
   ava_ticket number;
begin
   ava_ticket :=max_num - &agent_num;
   dbms_output.put_line('available ticket number is ' || ava_ticket );
end;
/

/*  TASK 04 */
declare
   v_salary emp_employees.salary%TYPE;
begin
   select salary into v_salary
   from emp_employees
   where emp_id=145;

   dbms_output.put_line('The employee 145 salary is : ' || v_salary);
end;
/

/*  TASK 05 */
accept c_id number prompt 'Enter the customer id: ' ;
declare
   c_credit cust_customers.customer_credit_limit%TYPE; 
begin
   select customer_credit_limit into c_credit
   from cust_customers
   where customer_id = &c_id;

   dbms_output.put_line('Customer credit limit is : ' || c_credit);
end;
/
