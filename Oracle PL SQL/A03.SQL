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
declare 
   CURSOR c1 IS select * from emp_employees
       where dept_id in (210,215)
       order by name_last;
begin
   for item in c1
   loop
       dbms_output.put_line('Employee ID: ' || item.emp_id||', Name: '|| item.name_last || ' ' || item.name_first || ' work in the IT support department');
   end loop;
end;
/

/*  TASK 02  */
accept target_sal number prompt 'Enter the target sale amount you wish: ' ;
declare 
   sal_amount number(38) ;
begin
   select sum(quantity_ordered * quoted_price) into sal_amount
   from oe_orderDetails OD
   join oe_orderHeaders OH on OD.order_id = OH.order_id
   where extract(year from order_date)=2015;  
   for item in 
     (select emp_id, job_id, salary
      from emp_employees)
   loop
       exit when sal_amount < &target_sal;   
       if (item.job_id =1)
          then
             item.salary := item.salary * (1+0.1);
             dbms_output.put_line ('employee id '||item.emp_id || ' new salary is ' || item.salary );
       elsif (item.job_id =4)
          then
             item.salary := item.salary * (1+0.15);
             dbms_output.put_line ('employee id '||item.emp_id || ' new salary is ' || item.salary );
       elsif (item.job_id=8)
          then
             item.salary := item.salary * (1+0.2);
             dbms_output.put_line ('employee id '||item.emp_id || ' new salary is ' || item.salary );
       end if;
   end loop;
end;
/


/*  TASK 03 */
declare
   CURSOR dept_cursor IS
     select dept_id, dept_name from emp_departments
     where dept_id <100
     order by dept_id;
   CURSOR emp_cursor (deptid varchar2) IS
      select name_last, job_id, hire_date, salary
      from emp_employees
      where emp_id <120
      and dept_id = deptid;  
   v_deptid emp_departments.dept_id%TYPE;
   v_deptname emp_departments.dept_name%TYPE;
   v_lastname emp_employees.name_last%TYPE;
   v_jobid emp_employees.job_id%TYPE;
   v_hiredate emp_employees.hire_date%TYPE;
   v_salary emp_employees.salary%TYPE;
   begin
      OPEN dept_cursor;
      loop
         fetch dept_cursor into v_deptid, v_deptname;
         exit when dept_cursor%NOTFOUND;
         dbms_output.put_line('department: ' || v_deptid ||' - ' ||  v_deptname);
      open emp_cursor(v_deptid);
      loop
         fetch emp_cursor into v_lastname, v_jobid, v_hiredate, v_salary;
         exit when emp_cursor%NOTFOUND;
         dbms_output.put_line('....' ||v_lastname);
         dbms_output.put_line('....' || 'JobID: ' ||v_jobid);
         dbms_output.put_line('....' || 'HireDate: '||v_hiredate);
         dbms_output.put_line('....' || ' Salary: ' ||v_salary);
       end loop;
       close emp_cursor;
       end loop;
       close dept_cursor;
  end;
/
        
      
      








































  

