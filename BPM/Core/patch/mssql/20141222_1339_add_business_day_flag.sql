alter table MAXDAT.BPM_D_DATES add BUSINESS_DAY_FLAG char(1);
go

update MAXDAT.BPM_D_DATES 
set BUSINESS_DAY_FLAG = 
   case when D_DAY_OF_WEEK not in ('1','7') and h.HOLIDAY_DATE is null then 'Y' else 'N' end
   from MAXDAT.BPM_D_DATES d_dates
   left outer join MAXDAT.HOLIDAYS h on (d_dates.D_DATE = h.HOLIDAY_DATE);

alter table MAXDAT.BPM_D_DATES alter column BUSINESS_DAY_FLAG char(1) not null;
go

drop view MAXDAT.D_DATES;
go

create view MAXDAT.D_DATES as
select 
  D_DATE,
  D_MONTH,
  D_MONTH_NAME,
  D_DAY,
  D_DAY_NAME,
  D_DAY_OF_WEEK,
  D_DAY_OF_MONTH,
  D_DAY_OF_YEAR,
  D_YEAR,
  D_MONTH_NUM,
  D_WEEK_OF_YEAR,
  D_WEEK_OF_MONTH,
  WEEKEND_FLAG,  
  BUSINESS_DAY_FLAG,
  case when cast(D_DATE as date) = cast(getdate() as date) then 'Y'
    else 'N' end TODAY,
  case when cast(D_DATE as date) = (dateadd(dd,-1,cast(getdate() as date) )) then 'Y'
    else 'N' end YESTERDAY,
  case when D_DAY_OF_WEEK = 1 and cast(D_DATE as date) = dateadd(dd,-2,cast(getdate() as date)) then 'Y'
    when D_DAY_OF_WEEK = 2 and cast(D_DATE as date) = dateadd(dd,-3,cast(getdate() as date)) then 'Y'
    when D_DAY_OF_WEEK not in (1,2) and cast(D_DATE As Date) = dateadd(dd,-1,cast(getdate() as date)) then 'Y'
    else 'N' end LAST_WEEKDAY,
  case when ((datepart(year,D_DATE) = datepart(year,getdate()) and (datepart(ww,D_DATE)=datepart(ww,cast(getdate() as date)) ))) then 'Y'
    else 'N'
    end THIS_WEEK,
  case when ((datepart(year,D_DATE) = datepart(year,getdate())) and (D_WEEK_OF_YEAR=datepart(ww,dateadd(ww,-1,cast(getdate() as date)))) ) then 'Y'
    else 'N' end LAST_WEEK
from MAXDAT.BPM_D_DATES;
go


-- Maintain BPM_D_DATES table.
if OBJECT_ID ('MAXDAT.MAINTAIN_BPM_D_DATES','P') is not null
begin
  drop procedure MAXDAT.MAINTAIN_BPM_D_DATES;
end;
go

create procedure MAXDAT.MAINTAIN_BPM_D_DATES as
begin

  set nocount on;

  insert into BPM_D_DATES
  select 
    D_DATE,
    left(datename(month,D_DATE),3) D_MONTH,
    datename(month,D_DATE) D_MONTH_NAME,
    left(datename(dw,D_DATE),3) D_DAY,
    datename(dw,D_DATE) D_DAY_NAME,
    datepart(dw,D_DATE) D_DAY_OF_WEEK,
    right('0' + convert(varchar(2),datepart(d,D_DATE)),2) D_DAY_OF_MONTH,
    datepart(dy,D_DATE) D_DAY_OF_YEAR,
    datepart(year,D_DATE) D_YEAR,
    right('0' + convert(varchar(2),datepart(month,D_DATE)),2) D_MONTH_NUM,
    right('0' + convert(varchar(2),datepart(ww,D_DATE)),2) D_WEEK_OF_YEAR,
    datepart(Week,D_DATE) - datepart(wk,dateadd(MM,datediff(MM,0,D_DATE), 0)) + 1 D_WEEK_OF_MONTH,
    case 
      when datepart(dw,D_DATE) in ('1','7') then 'Y' else 'N' end WEEKEND_FLAG,
    case 
      when datepart(dw,D_DATE) not in ('1','7') and h.HOLIDAY_DATE is null then 'Y' else 'N' end BUSINESS_DAY_FLAG
  from
    (select 
       top (datediff(day,dateadd(month,-12,dateadd(m,datediff(m,0,getdate()),0)),getdate()) + 1)
       D_DATE = dateadd(day,row_number() over(order by a.object_id) - 1,dateadd(month,-12,dateadd(m,datediff(m,0,getdate()),0)))
     from sys.all_objects a
     cross join sys.all_objects b) d_dates
   left outer join MAXDAT.HOLIDAYS h on (d_dates.D_DATE = h.HOLIDAY_DATE)
   where not exists (select 1 from MAXDAT.BPM_D_DATES bdd where d_dates.D_DATE = bdd.D_DATE);

end;
go
