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
   type dept_table_type IS table of emp_departments.dept_name%TYPE index by PLS_INTEGER;
   my_dept_table dept_table_type;
   loop_count number := 10;
   deptno number := 0;
   max_count number(3);
   t integer;
   j integer :=0;
begin
   select max(dept_id)
   into max_count
   from emp_departments
   where mod(dept_id,10)=0;
   for i in 10..max_count
   loop
       deptno := deptno + loop_count;
       select count(*) into t from emp_departments
       where dept_id = deptno;
       if t>0
         then 
           j :=j+1;
           select dept_name into my_dept_table(j)
           from emp_departments
           where dept_id = deptno;
       end if;
   end loop;

   for i in my_dept_table.FIRST..my_dept_table.LAST
   loop
       dbms_output.put_line(my_dept_table(i));
   end loop;
end;
/


/*  TASK 02  */
accept id number prompt 'Enter the department id : ';
declare
   type emp_table_type is table of varchar(255) index by pls_integer;
   my_emp_table emp_table_type;
   cursor c1 is 
      select salary, name_first, name_last
      from emp_employees
      where dept_id = &id
      for update of salary nowait;
      i integer :=0 ;
      num_total number;
      emp c1%rowtype;
begin
   if (&id not in (20,80,90,95,215))
     then
        dbms_output.put_line('SORRY, NO SALARY REVISIONS FOR EMPLOYEES IN THIS DEPARTMENT');
   else
     open c1;
     loop 
       fetch c1 into emp;
       exit when c1%rowcount <1 or c1%NOTFOUND;
       update emp_employees set salary = 
         (case 
             when salary<6500 then
               salary * 1.2         
             when salary>6500 and salary <9500 then 
               salary * 1.15 
             when salary>9500 and salary <12000 then
               salary * 1.08 
              when salary >12000 then 
               salary * 1.03 
          end )
       where current of c1;
       my_emp_table(i) := emp.name_first || ' ' || emp.name_last ;
       i :=i+1;
     end loop;
    num_total := c1%rowcount;
    close c1;
    if my_emp_table.count = 0 then
       dbms_output.put_line('no data');
    else
        for i in my_emp_table.first..my_emp_table.last
        loop 
           dbms_output.put_line(my_emp_table(i));
        end loop;
    end if;
    dbms_output.put_line('total number is : ' || num_total);
   end if;
end;
/
      

/*  TASK 03 */
accept flight_no number prompt 'Enter the flight number you wish to book : ';

accept seat_no number prompt 'Enter the seat number you wish to book: ';

declare 
   cursor c1 is
   select flightno, seats
   from flight
   where flightno = &flight_no 
   for update of seats;
begin
   for c1_rec in c1 
   loop
       if (c1_rec.seats + &seat_no <=555)
         then 
            update flight
            set seats = seats + &seat_no
            where current of c1;
         else
            dbms_output.put_line('exceed maxium seat number');
         exit;
      end if;
   end loop;
end;
/

accept flight_no number prompt 'Enter the flight number you wish to book : ';

accept seat_no number prompt 'Enter the seat number you wish to book: ';

accept cli_id number prompt 'Enter the Diamond Premier customer id : ';

declare
   pragma autonomous_transaction;
   clientid number := &cli_id;
   cursor c1 is
      select flightno, seats
      from flight
      where flightno = &flight_no
      for update of seats;
   seat1 number;
begin
   for c1_rec in c1
   loop 
      if (clientid <=0)
        then
           dbms_output.put_line('This is not a Diamond premier customer id');
        exit;
      elsif (c1_rec.seats + &seat_no >560)
        then
           dbms_output.put_line('exceed maxium seat number');
        exit;
      else
            update flight
            set seats = seats + &seat_no
            where current of c1;
      end if;
    end loop;
   commit;
end;
/
       











