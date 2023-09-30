-- Calculation functions and procedures for Mange Work V2.

-- Calculates the age in business days.
if OBJECT_ID ('MAXDAT.MW_V2_GET_AGE_IN_BUSINESS_DAYS','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_AGE_IN_BUSINESS_DAYS;
end;
go

create function MAXDAT.MW_V2_GET_AGE_IN_BUSINESS_DAYS
  (@p_work_receipt_date datetime,
   @p_instance_end_date datetime)
  returns int
as
begin
  return MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN(@p_work_receipt_date,isnull(@p_instance_end_date,getdate()));
end;
go

grant execute on MAXDAT.MW_V2_GET_AGE_IN_BUSINESS_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the age in calendar days.
if OBJECT_ID ('MAXDAT.MW_V2_GET_AGE_IN_CALENDAR_DAYS','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_AGE_IN_CALENDAR_DAYS;
end;
go

create function MAXDAT.MW_V2_GET_AGE_IN_CALENDAR_DAYS
  (@p_work_receipt_date datetime,
   @p_instance_end_date datetime)
  returns int
as
begin
  return MAXDAT.BPM_COMMON_GET_AGE_IN_CALENDAR_DAYS(@p_work_receipt_date,isnull(@p_instance_end_date,getdate()));
end;
go

grant execute on MAXDAT.MW_V2_GET_AGE_IN_CALENDAR_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the jeopardy flag.
if OBJECT_ID ('MAXDAT.MW_V2_GET_JEOPARDY_FLAG','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_JEOPARDY_FLAG;
end;
go

create function MAXDAT.MW_V2_GET_JEOPARDY_FLAG
  (@p_task_type_id int,
   @p_curr_work_receipt_date datetime,
   @p_instance_end_date datetime)
  returns varchar
as
begin

  declare @v_jeopardy_flag varchar = null;

  declare @v_sla_days_type varchar(1) = null;
  declare @v_age_in_business_days int = null;
  declare @v_age_in_calendar_days int = null;
  declare @v_sla_jeopardy_days int = null;

  set @v_sla_days_type = MAXDAT.MW_V2_GET_SLA_DAYS_TYPE(@p_task_type_id);

  if @v_sla_days_type is null
    begin
      return 'N';
    end;

  set @v_age_in_business_days = MAXDAT.MW_V2_GET_AGE_IN_BUSINESS_DAYS(@p_curr_work_receipt_date,@p_instance_end_date);
  set @v_age_in_calendar_days = MAXDAT.MW_V2_GET_AGE_IN_CALENDAR_DAYS(@p_curr_work_receipt_date,@p_instance_end_date);
  set @v_sla_jeopardy_days = MAXDAT.MW_V2_GET_JEOPARDY_DAYS(@p_task_type_id);

  if (@v_sla_days_type = 'B'
      and @v_age_in_business_days is not null
      and @v_sla_jeopardy_days is not null
      and @v_age_in_business_days >= @v_sla_jeopardy_days)
    or
      (@v_sla_days_type = 'C'
       and @v_age_in_calendar_days is not null
       and @v_sla_jeopardy_days is not null
       and @v_age_in_calendar_days >= @v_sla_jeopardy_days)
    begin
      return 'Y';
    end;
  else
    begin
      return 'N';
    end;

  return @v_jeopardy_flag;

end;
go

grant execute on MAXDAT.MW_V2_GET_JEOPARDY_FLAG to MAXDAT_READ_ONLY;
go


-- Calculates the status age in business days.
if OBJECT_ID ('MAXDAT.MW_V2_GET_STATUS_AGE_IN_BUS_DAYS','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_STATUS_AGE_IN_BUS_DAYS;
end;
go

create function MAXDAT.MW_V2_GET_STATUS_AGE_IN_BUS_DAYS
  (@p_status_date datetime,
   @p_instance_end_date datetime)
  returns int
as
begin
     return MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN(@p_status_date,isnull(@p_instance_end_date,getdate()));
end;
go

grant execute on MAXDAT.MW_V2_GET_STATUS_AGE_IN_BUS_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the status age in calendar days.
if OBJECT_ID ('MAXDAT.MW_V2_GET_STATUS_AGE_IN_CAL_DAYS','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_STATUS_AGE_IN_CAL_DAYS;
end;
go

create function MAXDAT.MW_V2_GET_STATUS_AGE_IN_CAL_DAYS
  (@p_status_date datetime,
   @p_instance_end_date datetime)
  returns int
as
begin
   return datediff(day,convert(date,@p_status_date),convert(date,isnull(@p_instance_end_date,getdate())));
end;
go

grant execute on MAXDAT.MW_V2_GET_STATUS_AGE_IN_CAL_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the timeliness status.
if OBJECT_ID ('MAXDAT.MW_V2_GET_TIMELINESS_STATUS','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_TIMELINESS_STATUS;
end;
go

create function MAXDAT.MW_V2_GET_TIMELINESS_STATUS
  (@p_INSTANCE_END_DATE datetime,
   @p_TASK_TYPE_ID int,
   @p_CURR_WORK_RECEIPT_DATE datetime)
  returns varchar
as
begin
  declare @v_timeliness_status    varchar = null;

  declare @v_sla_days_type        varchar(1) = null;
  declare @v_sla_days             int = null;
  declare @v_age_in_business_days int = null;
  declare @v_age_in_calendar_days int = null;
  declare @v_sla_jeopardy_days    int = null;

  set @v_sla_days_type =  MAXDAT.MW_V2_GET_SLA_DAYS_TYPE(@p_task_type_id);
  set @v_sla_days = MAXDAT.MW_V2_GET_SLA_DAYS(@p_task_type_id);
  set @v_age_in_business_days = MAXDAT.MW_V2_GET_AGE_IN_BUSINESS_DAYS(@p_curr_work_receipt_date,@p_instance_end_date);
  set @v_age_in_calendar_days = MAXDAT.MW_V2_GET_AGE_IN_CALENDAR_DAYS(@p_curr_work_receipt_date,@p_instance_end_date);
  set @v_sla_jeopardy_days = MAXDAT.MW_V2_GET_JEOPARDY_DAYS(@p_task_type_id);

  if @p_instance_end_date is null
    begin
      return 'Not Complete';
	end;
  else if @v_sla_days is null
	begin
      return 'Not Required';
	end;
  else if (@v_sla_days_type = 'B' and @v_age_in_business_days > @v_sla_days)
          or
          (@v_sla_days_type = 'C' and @v_age_in_calendar_days > @v_sla_days)
    begin
      return 'Untimely';
	end;
  else
    begin
      return 'Timely';
    end;

  return @v_timeliness_status;

end;
go

grant execute on MAXDAT.MW_V2_GET_TIMELINESS_STATUS to MAXDAT_READ_ONLY;
go


-- Calculates the number of jeopardy days.
if OBJECT_ID ('MAXDAT.MW_V2_GET_JEOPARDY_DAYS','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_JEOPARDY_DAYS;
end;
go
  
create function MAXDAT.MW_V2_GET_JEOPARDY_DAYS
  (@p_task_type_id int)
  returns int 
as
begin

  declare @v_jeopardy_days int = null;

  select @v_jeopardy_days = case when count(*) >= 1 then max(SLA_JEOPARDY_DAYS) else null end
  from MAXDAT.D_TASK_TYPES
  where TASK_TYPE_ID = @p_task_type_id;

  return @v_jeopardy_days;

end;
go

grant execute on MAXDAT.MW_V2_GET_JEOPARDY_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the number of SLA days.
if OBJECT_ID ('MAXDAT.MW_V2_GET_SLA_DAYS','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_SLA_DAYS;
end;
go

create function MAXDAT.MW_V2_GET_SLA_DAYS
  (@p_task_type_id int)
  returns int
as
begin

  declare @v_sla_days int = null;

  select @v_sla_days = case when count(*) >= 1 then max(SLA_DAYS) else null end
  from MAXDAT.D_TASK_TYPES
  where TASK_TYPE_ID = @p_task_type_id;

  return @v_sla_days;

end;
go

grant execute on MAXDAT.MW_V2_GET_SLA_DAYS to MAXDAT_READ_ONLY;
go

-- Calculates the SLA days type.
if OBJECT_ID ('MAXDAT.MW_V2_GET_SLA_DAYS_TYPE','FN') is not null
begin
  drop function MAXDAT.MW_V2_GET_SLA_DAYS_TYPE;
end;
go

create function MAXDAT.MW_V2_GET_SLA_DAYS_TYPE
  (@p_task_type_id int)
  returns varchar
as
begin

  declare @v_sla_days_type varchar(1) = null;

  select @v_sla_days_type = case when count(*) >= 1 then max(SLA_DAYS_TYPE) else null end
  from MAXDAT.D_TASK_TYPES
  where TASK_TYPE_ID = @p_task_type_id;

  return @v_sla_days_type;

end;
go

grant execute on MAXDAT.MW_V2_GET_SLA_DAYS_TYPE to MAXDAT_READ_ONLY;
go


-- Calculate column values in BPM Semantic table D_MW_V2_CURRENT.
if OBJECT_ID ('MAXDAT.MW_V2_CALC_DMWCUR_V2','P') is not null
begin
  drop procedure MAXDAT.MW_V2_CALC_DMWCUR_V2;
end;
go

create procedure MAXDAT.MW_V2_CALC_DMWCUR_V2
as
begin

  declare @v_procedure_name varchar(61) = 'MW_V2_CALC_DMWCUR_V2';
  declare @v_log_message varchar(MAX) = null;
  declare @v_sql_code int = null;
  declare @v_num_rows_updated int = null;
  declare @v_calc_dmwcur_v2_job_name varchar(30) = 'CALC_DMWCUR_V2';

  declare @v_bil_id int = 3; -- 'Task ID'
  declare @v_bsl_id int = 2001; -- 'CORP_ETL_MW_V2'

  begin try
    update MAXDAT.D_MW_V2_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = MAXDAT.MW_V2_GET_AGE_IN_BUSINESS_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      AGE_IN_CALENDAR_DAYS = MAXDAT.MW_V2_GET_AGE_IN_CALENDAR_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      JEOPARDY_FLAG = MAXDAT.MW_V2_GET_JEOPARDY_FLAG(TASK_TYPE_ID,CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
      STATUS_AGE_IN_BUS_DAYS = MAXDAT.MW_V2_GET_STATUS_AGE_IN_BUS_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      STATUS_AGE_IN_CAL_DAYS = MAXDAT.MW_V2_GET_STATUS_AGE_IN_CAL_DAYS(CURR_STATUS_DATE,INSTANCE_END_DATE),
      TIMELINESS_STATUS = MAXDAT.MW_V2_GET_TIMELINESS_STATUS(INSTANCE_END_DATE,TASK_TYPE_ID,CURR_WORK_RECEIPT_DATE)
    where
      INSTANCE_END_DATE is null
      and CANCEL_WORK_DATE is null;

    set @v_num_rows_updated = @@rowcount;
 
    set @v_log_message = convert(varchar,@v_num_rows_updated) + ' D_MW_V2_CURRENT rows updated with calculated attributes by CALC_DMWCUR_V2.';
    execute MAXDAT.BPM_COMMON_LOGGER 'INFO',null,@v_procedure_name,@v_bsl_id,@v_bil_id,null,null,@v_log_message,null;

  end try
     
  begin catch
    set @v_sql_code = error_number();
    set @v_log_message = error_message();
    execute MAXDAT.BPM_COMMON_LOGGER 'SEVERE',null,v_procedure_name,@v_bsl_id,@v_bil_id,null,null,@v_log_message,@v_sql_code;
  end catch

end;
go  


-- Create and schedule job to run CALC_DMWCUR_V2 procedure daily at midnight that
-- updates calculated columns of active instances in the MAXDAT.D_MW_V2_CURRENT table.
-- Code generated by SQL Server Agent.
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 12/4/2014 3:06:07 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CALC_DMWCUR_V2', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Daily job that updates calculated columns of active instances in the MAXDAT.D_MW_V2_CURRENT table.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MAXDAT', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run MW_V2_CALC_DMWCUR_V2 procedure.]    Script Date: 12/4/2014 3:06:08 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run MW_V2_CALC_DMWCUR_V2 procedure.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'execute MAXDAT.MW_V2_CALC_DMWCUR_V2', 
		@database_name=N'UK_HWS', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Run daily CALC_DMWCUR_V2 job.', 
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
		@schedule_uid=N'48f50835-5d3e-489f-8735-351f2f3a275c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO
