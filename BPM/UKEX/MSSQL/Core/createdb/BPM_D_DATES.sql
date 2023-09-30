use maxdat;
set datefirst 7

if exists(select 1 from sysobjects where name='Maintain_BPM_D_Dates')
begin
drop proc Maintain_BPM_D_Dates;
end;


if exists(select 1 from sysobjects where name='BPM_D_Date_Hour_SV')
begin
drop view BPM_D_Date_Hour_SV;
end;


if exists(select 1 from sysobjects where name='BPM_D_Dates_SV')
begin
drop view BPM_D_Dates_SV;
end;

if exists(select 1 from sysobjects where name='D_Dates')
begin
drop view D_Dates;
end;

if exists(select 1 from sysobjects where name='BPM_D_Dates')
begin
drop table BPM_D_Dates;
end;



create table BPM_D_Dates(
D_Date date not null,
D_Month char(3) not null,
D_Month_Name varchar(9) not null,
D_Day char(3) not null,
D_Day_Name varchar(9) not null,
D_Day_Of_Week tinyint not null,
D_Day_Of_Month char(2) not null,
D_Day_Of_Year char(3) not null,
D_Year smallint not null,
D_Month_Num char(2) not null,
D_Week_Of_Year char(2) not null,
D_Week_Of_Month tinyint not null,
Weekend_Flag char(1) not null
);

insert into BPM_D_Dates
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
    when datepart(dw,D_Date) in('1','7') then 'Y' else 'N' 
    end Weekend_Flag
from
(SELECT  TOP (DATEDIFF(DAY, dateadd(month,-12,dateadd(m, datediff(m, 0, getdate()), 0)), getdate()) + 1)
        D_Date = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, dateadd(month,-12,dateadd(m, datediff(m, 0, getdate()), 0)))
FROM    sys.all_objects a
        CROSS JOIN sys.all_objects b
) D_Dates;


alter table BPM_D_Dates add constraint BPM_D_Dates_PK primary key (D_Date);

grant select on BPM_D_Dates  to MAXDat_Read_Only;
go

create view D_Dates
  (D_Date,D_Month,D_Month_Name,D_Day,D_Day_Name,D_Day_Of_Week,D_Day_Of_Month,
   D_Day_Of_Year,D_Year,D_Month_Num,D_Week_Of_Year,D_Week_Of_Month, Weekend_Flag,
   Today,Yesterday,Last_Weekday,This_Week,Last_Week)  as
select D_Date,D_Month,D_Month_Name,D_Day,D_Day_Name,D_Day_Of_Week,D_Day_Of_Month, D_Day_Of_Year,D_Year,D_Month_Num,D_Week_Of_Year,D_Week_Of_Month, Weekend_Flag,
  case when cast(D_DATE As Date) = cast(getDate() As Date) then 'Y'
    else 'N' end Today,
  case when cast(D_DATE As Date) = (dateadd(dd,-1,cast(getDate() As Date) )) then 'Y'
    else 'N' end Yesterday,
  case when D_Day_Of_Week = 1 and cast(D_DATE As Date) = dateadd(dd,-2,cast(getDate() As Date)) then 'Y'
    when D_Day_Of_Week = 2 and cast(D_DATE As Date) = dateadd(dd,-3,cast(getDate() As Date)) then 'Y'
    when D_Day_Of_Week not in (1,2) and cast(D_DATE As Date) = dateadd(dd,-1,cast(getDate() As Date)) then 'Y'
    else 'N' end Last_Weekday,
  case when ((datepart(year,D_Date) = datepart(year,getdate()) and (datepart(ww,D_Date)=datepart(ww,cast(getDate() As Date)) )))  then 'Y'
    else 'N'
    end This_Week,
  case when ((datepart(year,D_Date) = datepart(year,getdate())) and (D_Week_Of_Year=datepart(ww,dateadd(ww,-1,cast(getDate() As Date))))	)  then 'Y'
    else 'N' end Last_Week
from BPM_D_Dates 
;

go
grant select on D_DATES to MAXDAT_READ_ONLY;

go

create view BPM_D_DATE_HOUR_SV as
select dateadd(hh,bdh.d_hour,cast(bdd.d_date as datetime)) D_Date_Hour
from 
  BPM_D_DATES bdd,
  BPM_D_HOURS bdh
where dateadd(hh,bdh.d_hour,cast(bdd.d_date as datetime)) < getdate()
;
go

grant select on BPM_D_DATE_HOUR_SV to MAXDAT_READ_ONLY;
go


create procedure Maintain_BPM_D_Dates as
set nocount on 
insert into BPM_D_Dates
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
    when datepart(dw,D_Date) in('1','7') then 'Y' else 'N' 
    end Weekend_Flag
from
(SELECT  TOP (DATEDIFF(DAY, dateadd(month,-12,dateadd(m, datediff(m, 0, getdate()), 0)), getdate()) + 1)
        D_Date = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, dateadd(month,-12,dateadd(m, datediff(m, 0, getdate()), 0)))
FROM    sys.all_objects a
        CROSS JOIN sys.all_objects b
) dd
where not exists(select 1 from BPM_D_Dates bdd where dd.d_Date=bdd.D_Date)
;

go

use msdb
EXEC msdb.dbo.sp_add_job
    @job_name = 'Daily_Maintain_BPM_D_Dates Job' ,
	@enabled=1,
	@notify_level_eventlog=3,
	@delete_level=0;
GO

EXEC msdb.dbo.sp_add_jobschedule
    @job_name = 'Daily_Maintain_BPM_D_Dates Job' ,
    @name = 'Daily_Maintain_BPM_D_Dates Sched' ,
	@freq_type=4,
	@freq_interval=1,
	@active_start_time = 0001	;
go
