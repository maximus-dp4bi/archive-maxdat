
declare
  D_DATE date := to_date('2013/01/01','YYYY/MM/DD');
  vD_DATE date;
  vd_month varchar(12);
  vd_month_name varchar(36);
  vd_day varchar(12);
  vd_day_name varchar(36);
  vd_day_of_week varchar(1);
  vd_day_of_month varchar(2);
  vd_day_of_year varchar(3);
  vd_year varchar(4);
  vd_month_num varchar(2);
  vd_week_of_year varchar(2);
  vD_WEEK_OF_MONTH varchar(1);
  vWEEKEND_FLAG  varchar(1);
  d_cnt number := 0;
begin
loop
  exit when D_DATE = to_date('2013/07/02','YYYY/MM/DD');
  select 
         D_DATE,to_char(D_DATE,'Mon'),to_char(D_DATE,'FMMonth'),to_char(D_DATE,'Dy'), to_char(D_DATE,'Day'),
         to_char(D_DATE,'D'),to_char(D_DATE,'DD'),to_char(D_DATE,'DDD'),to_char(D_DATE,'YYYY'),to_char(D_DATE,'MM'),
         to_char(D_DATE,'IW'),TO_CHAR(D_DATE,'W'),case when TO_CHAR(D_DATE,'D') in('1','7') then 'Y' else 'N' end
  into   vD_DATE,vd_month,vd_month_name,vd_day,vd_day_name,
         vd_day_of_week,vd_day_of_month,vd_day_of_year,vd_year,vd_month_num,
         vd_week_of_year,vD_WEEK_OF_MONTH,vWEEKEND_FLAG     
  from dual;
  
  select count(*) into d_cnt from d_dates where d_date = vD_DATE;
  if d_cnt = 0 then
     --dbms_output.put_line('Insert for ' ||to_char(vD_DATE));
     insert into BPM_D_DATES 
        (D_DATE,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (vD_DATE,vd_month,vd_month_name,vd_day,vd_day_name,
         vd_day_of_week,vd_day_of_month,vd_day_of_year,vd_year,vd_month_num,
         vd_week_of_year,vD_WEEK_OF_MONTH,vWEEKEND_FLAG);
  end if;
  d_date := D_DATE+1;
  d_cnt := 0;
end loop;
end;
