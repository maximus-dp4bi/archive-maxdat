create table MAXDAT.BPM_D_DATES
  (D_DATE datetime not null,
   D_MONTH varchar(12) not null,
   D_MONTH_NAME varchar(36) not null,
   D_DAY varchar(12) not null,
   D_DAY_NAME varchar(36) not null,
   D_DAY_OF_WEEK varchar(1) not null,
   D_DAY_OF_MONTH varchar(2) not null,
   D_DAY_OF_YEAR varchar(3) not null,
   D_YEAR varchar(4) not null,
   D_MONTH_NUM varchar(2) not null,
   D_WEEK_OF_YEAR varchar(2) not null,
   D_WEEK_OF_MONTH varchar(1) not null,
   WEEKEND_FLAG char(1) not null,
   BUSINESS_DAY_FLAG char(1) not null);

insert into MAXDAT.BPM_D_DATES
select 
  D_DATE,
  left(datename(month,D_DATE),3) D_MONTH,
  datename(month,D_DATE) D_MONTH_NAME,
  left(datename(dw,D_DATE),3) D_Day,
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
order by D_DATE asc;

alter table MAXDAT.BPM_D_DATES add constraint BPM_D_DATES_PK primary key (D_DATE);
go

grant select on MAXDAT.BPM_D_DATES to MAXDAT_READ_ONLY;
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

grant select on MAXDAT.D_DATES to MAXDAT_READ_ONLY;
go


create view MAXDAT.BPM_D_DATE_HOUR_SV as
select dateadd(hh,bdh.D_HOUR,cast(bdd.D_DATE as datetime)) D_DATE_HOUR
from 
  MAXDAT.BPM_D_DATES bdd,
  MAXDAT.BPM_D_HOURS bdh
where dateadd(hh,bdh.D_HOUR,cast(bdd.D_DATE as datetime)) < getdate();
go

grant select on MAXDAT.BPM_D_DATE_HOUR_SV to MAXDAT_READ_ONLY;
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


-- Create and schedule job to run MAINTAIN_BPM_D_DATES procedure daily at midnight to update MAXDAT.BPM_D_DATES table with the current date.
-- Code generated by SQL Server Agent.
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 12/4/2014 1:42:10 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MAINTAIN_BPM_D_DATES', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Daily job that adds the new (current) day row to the MAXDAT.BPM_D_DATES table.  This job also adds any missing days between the latest and the current day to handle the case where the job has not been run for several days.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MAXDAT', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run MAINTAIN_BPM_D_DATES procedure.]    Script Date: 12/4/2014 1:42:11 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run MAINTAIN_BPM_D_DATES procedure.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'execute MAXDAT.MAINTAIN_BPM_D_DATES', 
		@database_name=N'UK_HWS', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Run daily MAINTAIN_BPM_D_DATES job.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20141205, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'64137584-f3cd-49a2-86e7-f4b558a478c4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO
