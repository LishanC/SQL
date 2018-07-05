create or replace Function AdjustedPrice (
   price in number,
   quantity in number)
   return number
is
   v_discount_rate number;
   v_return_price number;

begin
    if (price is null or price <0) then
    v_return_price := null;
    elsif(price >=10) then
       if(quantity is null or quantity <0) then
          v_return_price:=null;
       elsif (quantity between 1 and 3) then
          v_discount_rate:=0;
       elsif (quantity between 4 and 10) then
          v_discount_rate:=0.05;
       elsif (quantity between 11 and 25) then
          v_discount_rate:=0.1;
       elsif (quantity between 26 and 100) then
         v_discount_rate:=0.15;
       else
         v_discount_rate:=0.18;
       end if;
     else
      v_discount_rate:=0;
  end if;
  
   v_return_price := round(price *(1-v_discount_rate),2);
   return v_return_price;

end;
/


create or replace function PrevMonth (
   in_date in date,
   in_mn_adjust in int )
   return varchar2
is
   v_return_date varchar2(35);

begin
    if (in_mn_adjust is null or in_mn_adjust <0) then
       v_return_date := null;
    else 
       v_return_date:=coalesce(to_char(add_months(in_date, -(in_mn_adjust)), 'YYYY-MM'), to_char(add_months(sysdate, -(in_mn_adjust)), 'YYYY-MM'));
    
   end if;

    return v_return_date;

end;
/































  
