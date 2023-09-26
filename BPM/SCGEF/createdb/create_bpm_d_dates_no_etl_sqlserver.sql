create table maxdat_support.BPM_D_DATES
  (D_DATE date not null,
   D_MONTH_SHORT_NAME varchar(12) not null,
   D_MONTH_NAME varchar(36) not null,
   D_DAY varchar(12) not null,
   D_DAY_NAME varchar(36) not null,
   D_DAY_OF_WEEK varchar(1) not null,
   D_DAY_OF_MONTH varchar(2) not null,
   D_DAY_OF_YEAR varchar(3) not null,
   D_YEAR varchar(4) not null,
   D_MONTH_NUM varchar(2) not null,
   D_WEEK_NUM varchar(2) not null,
   D_WEEK_OF_MONTH varchar(1) not null,
   WEEKEND_FLAG char(1) not null,
   BUSINESS_DAY_FLAG char(1) not null,
   D_WEEK varchar(6) not null,
   D_MONTH int not null);
GO

begin transaction
insert into maxdat_support.BPM_D_DATES 
 select 
  D_DATE,
  CAST(DATENAME(month,D_DATE) AS CHAR(3)) D_MONTH_SHORT_NAME,
  DATENAME(month,D_DATE) D_MONTH_NAME,
  CAST(DATENAME(dw,D_DATE) AS CHAR(3))  D_DAY,
  DATENAME(dw,D_DATE) D_DAY_NAME,
  DATEPART(dw,D_DATE) D_DAY_OF_WEEK,
  DATEPART(d,D_DATE) D_DAY_OF_MONTH,
  DATEPART(dayofyear,D_DATE) D_DAY_OF_YEAR,
  DATEPART(year,D_DATE) D_YEAR,
  DATEPART(month,D_DATE) D_MONTH_NUM,
  DATEPART(week,D_DATE) D_WEEK_NUM,
  DATEDIFF(WEEK, DATEADD(MONTH, DATEDIFF(MONTH, 0,D_DATE), 0), D_DATE) +1 D_WEEK_OF_MONTH,
  
  case when DATEPART(dw,D_DATE) in('1','7') then 'Y' else 'N' end WEEKEND_FLAG,
  case when DATEPART(dw,D_DATE)  not in ('1','7') and h.HOLIDAY_DATE is null 
    then 'Y' else 'N' end BUSINESS_DAY_FLAG,
  CAST(CAST(DATEPART(year,D_DATE) AS CHAR(4)) 
    + case WHEN LEN(DATEPART(week,D_DATE)) = 1 then '0'+ CAST(DATEPART(week,D_DATE) AS CHAR(1)) else CAST(DATEPART(week,D_DATE) AS CHAR(2)) end AS INT) d_week, 
  CAST(CAST(DATEPART(year,D_DATE) AS CHAR(4)) 
    + CASE WHEN LEN(DATEPART(month,D_DATE)) = 1 THEN '0' + CAST(DATEPART(month,D_DATE)  AS CHAR(1)) 
	  ELSE CAST(DATEPART(month,D_DATE)  AS CHAR(2)) END AS INT) d_month
from (
select CAST(DATEADD(month, -48, GETDATE()) + Number AS DATE) d_date
from (
  SELECT TOP (CAST(getdate() - DATEADD(month, -48, GETDATE()) AS int)) 
                ROW_NUMBER() OVER (ORDER BY t1.ID) AS Number
           FROM Master.sys.SysColumns t1
          CROSS JOIN Master.sys.SysColumns t2 ) tmp
) tmp 
 left outer join maxdat_support.HOLIDAYS h on D_DATE = h.HOLIDAY_DATE;

commit transaction
GO

alter table maxdat_support.BPM_D_DATES add constraint BPM_D_DATES_PK primary key (D_DATE);
go


create view maxdat_support.D_DATES as
select 
  D_DATE,
  D_WEEK,
  D_MONTH,
  D_MONTH_SHORT_NAME,
  D_MONTH_NAME,
  D_DAY,
  D_DAY_NAME,
  D_DAY_OF_WEEK,
  D_DAY_OF_MONTH,
  D_DAY_OF_YEAR,
  D_YEAR,
  D_MONTH_NUM,
  D_WEEK_NUM,
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
  case when ((datepart(year,D_DATE) = datepart(year,getdate())) and (D_WEEK_NUM=datepart(ww,dateadd(ww,-1,cast(getdate() as date)))) ) then 'Y'
    else 'N' end LAST_WEEK,
  case when D_MONTH_NUM between 7 and 12 then D_YEAR +1 else D_YEAR end as D_SFYEAR
from MAXDAT_SUPPORT.BPM_D_DATES;

GO



CREATE VIEW maxdat_support.D_WEEKS AS
SELECT d_week,d_week_num, CASE WHEN d_week_num = 1 THEN MAX(d_year) ELSE MIN(d_year) END d_year     
     ,MIN(d_date) d_week_start, MAX(d_date) d_week_end
from maxdat_support.bpm_d_dates
group by d_week,d_week_num;
GO

CREATE VIEW maxdat_support.D_MONTHS AS
SELECT d_month, d_month_num, d_year,d_month_short_name, d_month_name, d_month_name +' ' + cast(d_year as char(4)) month_name_year,MIN(d_date) d_month_start, MAX(d_date) d_month_end
, case when D_MONTH_NUM between 7 and 12 then D_YEAR +1 else D_YEAR end as D_SFYEAR
FROM maxdat_support.bpm_d_dates
GROUP BY d_month, d_month_num, d_year,d_month_short_name, d_month_name;
GO

CREATE VIEW maxdat_support.D_MONTH_OF_YEAR AS
SELECT DISTINCT d_month_num, d_month_short_name, d_month_name
FROM maxdat_support.bpm_d_dates;
GO

CREATE VIEW maxdat_support.D_YEARS AS
SELECT d_year, MIN(d_date) d_year_start, MAX(d_date) d_year_end
FROM maxdat_support.bpm_d_dates
GROUP BY d_year;
GO

CREATE VIEW maxdat_support.D_SFYEAR AS
SELECT case when D_MONTH_NUM between 7 and 12 then D_YEAR + 1 else D_YEAR end  as D_SFYEAR, MIN(d_date) d_year_start, MAX(d_date) d_year_end
FROM maxdat_support.bpm_d_dates
GROUP BY case when D_MONTH_NUM between 7 and 12 then D_YEAR + 1 else D_YEAR end
GO

create procedure maxdat_support.MAINTAIN_BPM_D_DATES as
begin

  set nocount on;

 insert into maxdat_support.BPM_D_DATES 
 select 
  D_DATE,
  CAST(DATENAME(month,D_DATE) AS CHAR(3)) D_MONTH_SHORT_NAME,
  DATENAME(month,D_DATE) D_MONTH_NAME,
  CAST(DATENAME(dw,D_DATE) AS CHAR(3))  D_DAY,
  DATENAME(dw,D_DATE) D_DAY_NAME,
  DATEPART(dw,D_DATE) D_DAY_OF_WEEK,
  DATEPART(d,D_DATE) D_DAY_OF_MONTH,
  DATEPART(dayofyear,D_DATE) D_DAY_OF_YEAR,
  DATEPART(year,D_DATE) D_YEAR,
  DATEPART(month,D_DATE) D_MONTH_NUM,
  DATEPART(week,D_DATE) D_WEEK_NUM,
  DATEDIFF(WEEK, DATEADD(MONTH, DATEDIFF(MONTH, 0,D_DATE), 0), D_DATE) +1 D_WEEK_OF_MONTH,
  
  case when DATEPART(dw,D_DATE) in('1','7') then 'Y' else 'N' end WEEKEND_FLAG,
  case when DATEPART(dw,D_DATE)  not in ('1','7') and h.HOLIDAY_DATE is null 
    then 'Y' else 'N' end BUSINESS_DAY_FLAG,
  CAST(CAST(DATEPART(year,D_DATE) AS CHAR(4)) 
    + case WHEN LEN(DATEPART(week,D_DATE)) = 1 then '0'+ CAST(DATEPART(week,D_DATE) AS CHAR(1)) else CAST(DATEPART(week,D_DATE) AS CHAR(2)) end AS INT) d_week, 
  CAST(CAST(DATEPART(year,D_DATE) AS CHAR(4)) 
    + CASE WHEN LEN(DATEPART(month,D_DATE)) = 1 THEN '0' + CAST(DATEPART(month,D_DATE)  AS CHAR(1)) 
	  ELSE CAST(DATEPART(month,D_DATE)  AS CHAR(2)) END AS INT) d_month
from (
select CAST(DATEADD(month, -12, GETDATE()) + Number AS DATE) d_date
from (
  SELECT TOP (CAST(getdate() - DATEADD(month, -12, GETDATE()) AS int)) 
                ROW_NUMBER() OVER (ORDER BY t1.ID) AS Number
           FROM Master.sys.SysColumns t1
          CROSS JOIN Master.sys.SysColumns t2 ) tmp
) tmp
 left outer join maxdat_support.HOLIDAYS h on D_DATE = h.HOLIDAY_DATE
where not exists (select 1 from maxdat_support.BPM_D_DATES bdd where tmp.D_DATE = bdd.D_DATE);

end;
go

