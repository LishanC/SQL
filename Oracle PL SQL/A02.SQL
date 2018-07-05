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
PROMPT What is the weather today?
PROMPT 1: Sunny
PROMPT 2: Rainy
PROMPT 3: Snowy
accept opt_num number prompt 'Please enter your selection:  ' ;
declare 
   weather number := &opt_num;
begin
  loop
    if (weather = 1)
      then 
         dbms_output.put_line('Remember your sunglasses!') ;
      exit;
    elsif (weather = 2)
      then 
         dbms_output.put_line('Remember your umbrella' );
      exit;
    elsif (weather = 3)
      then 
         dbms_output.put_line ('Remember your hat' );
      exit;
    else
      dbms_output.put_line ('Invalid weather' );
      exit;
    end if;
  end loop;
end;
/ 

/*  TASK 02  */
accept eid number prompt 'Enter the employ id: ' ;
declare 
   jobid number(38);
   sal emp_employees.salary%TYPE;
begin
   select job_id, salary
   into jobid, sal
   from emp_employees
   where emp_id = &eid;
   loop
      if (jobid =2)
         then
           sal := sal * (1+0.1);
           dbms_output.put_line ('employ id &eid new salary is ' || sal );
         exit;
      elsif (jobid=8)
         then
           sal := sal * (1+0.15);
           dbms_output.put_line ('employ id &eid new salary is ' || sal );
         exit;
      elsif (jobid =16)
         then
           sal := sal * (1+0.2);
           dbms_output.put_line ('employ id &eid new salary is ' || sal );
         exit;
      end if;
   end loop;
end;
/


/*  TASK 03 */
accept user_num number prompt 'Enter the positive number equal or less than 20: ' ;
declare 
   num number := &user_num;
   p number;
   total number(9) :=0 ;
begin
   for k IN 1..num loop
      p := k * k;
      dbms_output.put_line(k ||' squared = ' || p);
      total := total + p;
   end loop;
   dbms_output.put_line('total = '|| total);
end;
/

/*  TASK 04 */
accept user_year number prompt 'Please enter the year you would like to travel to : ';
declare
  future_year number :=&user_year;
  current_year number;
  year number;
begin
  select
     extract(year from current_date) 
     into current_year
     from dual;
  year := future_year - current_year;
  dbms_output.put_line('This will be ' || year || ' years in the future');
  for i in reverse 1..10 loop
     dbms_output.put_line(to_char(i));
  end loop;
  dbms_output.put_line('The year is now ' || future_year);
end;
/
  

