insert into bpm_d_dates(d_date,d_month,d_month_name,d_day,d_day_name,d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,d_week_of_year,d_week_of_month,
                       weekend_flag)
select 
  D_DATE,
  to_char(D_DATE,'Mon') D_MONTH,
  to_char(D_DATE,'FMMonth') D_MONTH_NAME,
  to_char(D_DATE,'Dy') D_DAY,
  to_char(D_DATE,'Day') D_DAY_NAME,
  to_char(D_DATE,'D') D_DAY_OF_WEEK,
  to_char(D_DATE,'DD') D_DAY_OF_MONTH,
  to_char(D_DATE,'DDD') D_DAY_OF_YEAR,
  to_char(D_DATE,'YYYY') D_YEAR,
  to_char(D_DATE,'MM') D_MONTH_NUM,
  to_char(D_DATE,'IW') D_WEEK_OF_YEAR,
  to_char(D_DATE,'W') D_WEEK_OF_MONTH,
  case 
    when to_char(D_DATE,'D') in('1','7') then 'Y' else 'N' 
    end WEEKEND_FLAG
from
  (select add_months(to_date('08/31/2014','mm/dd/yyyy'),-39) + rownum "D_DATE"
   from dual 
   connect by rownum <= (to_date('08/31/2014','mm/dd/yyyy') - (add_months(to_date('08/31/2014','mm/dd/yyyy'),-39))))
order by D_DATE asc;

commit;