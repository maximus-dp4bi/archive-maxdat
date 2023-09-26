insert into MAXDAT.CC_D_DATES
(D_DATE
        , d_month
        , d_month_name
        ,  d_day
        ,  d_day_name
        , d_day_of_week
        , d_day_of_month
        , d_day_of_year
        , d_year
        , d_month_num
        , d_week_of_year
        , D_WEEK_OF_MONTH 
        , WEEKEND_FLAG)
select 
  D_Date,
  left(datename(month,D_Date),3) D_Month,
  datename(month,D_Date) D_Month_Name,
  left(datename(dw,D_Date),3) D_Day,
  datename(dw,D_Date) D_Day_Name,
  datepart(dw,D_Date) D_Day_Of_Week,
  right('0' + convert(varchar(2),datepart(d,D_Date)),2) D_Day_Of_Month,
  datepart(dy,D_Date) D_Day_Of_Year,
  datepart(year,D_Date) D_Year,
  right('0' + convert(varchar(2),datepart(month,D_Date)),2) D_Month_Num,
  right('0' + convert(varchar(2),datepart(ww,D_Date)),2) D_Week_Of_Year,
  --datepart(w,D_Date)
  datepart(Week, D_Date) -datepart(wk, dateadd(MM, datediff(MM,0,D_Date), 0))+ 1 D_Week_Of_Month,
  case 
    when datepart(dw,D_Date) in('1','7') then 1 else 0 
    end Weekend_Flag
from
(SELECT  TOP (DATEDIFF(DAY, dateadd(month,-72,dateadd(m, datediff(m, 0, getdate()), 0)), getdate()) + 1)
        D_Date = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, dateadd(month,-24,dateadd(m, datediff(m, 0, getdate()), 0)))
FROM    sys.all_objects a
        CROSS JOIN sys.all_objects b
) D_Dates;

