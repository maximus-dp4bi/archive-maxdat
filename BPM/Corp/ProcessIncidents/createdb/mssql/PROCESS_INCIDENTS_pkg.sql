-- Calculation functions and procedures for Process Incidents.

-- Calculates the age in business days.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_BUSINESS_DAYS','FN') is not null
begin
  drop function MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_BUSINESS_DAYS;
end;
go

create function MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_BUSINESS_DAYS
  (@p_receipt_date datetime,
   @p_instance_end_date datetime)
  returns int
as
begin
  return MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN(@p_receipt_date,isnull(@p_instance_end_date,getdate()));
end;
go

grant execute on MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_BUSINESS_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the age in calendar days.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_CALENDAR_DAYS','FN') is not null
begin
  drop function MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_CALENDAR_DAYS;
end;
go

create function MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_CALENDAR_DAYS
  (@p_receipt_date datetime,
   @p_instance_end_date datetime)
  returns int
as
begin
  return MAXDAT.BPM_COMMON_GET_AGE_IN_CALENDAR_DAYS(@p_receipt_date,isnull(@p_instance_end_date,getdate()));
end;
go

grant execute on MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_CALENDAR_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the jeopardy status.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS','FN') is not null
begin
  drop function MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS;
end;
go

create function MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS
  (@p_receipt_date    datetime,
   @p_instance_status varchar,
   @p_priority        varchar)
  returns varchar
as
begin

  declare @v_driver varchar(20) = null;
  declare @v_timeliness_calc varchar(20) = null;
  declare @v_jeopardy_days int;
  declare @v_trunc_jeopardy_days int;
  declare @v_jeopardy_threshold int;
  declare @v_jeopardy_status varchar(20) = null;

  select  @v_driver = OUT_VAR
  from MAXDAT.CORP_ETL_LIST_LKUP
  where NAME = 'pi_incident_sla_basis';

  select @v_timeliness_calc = OUT_VAR 
  from MAXDAT.CORP_ETL_LIST_LKUP
  where NAME = 'pi_timeliness_calc';

  select @v_jeopardy_threshold = OUT_VAR 
  from MAXDAT.CORP_ETL_LIST_LKUP
  where NAME = 'pi_jeopardy_days';

  if @v_timeliness_calc = 'b'
    begin
      set @v_jeopardy_days = MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN(@p_receipt_date,getdate());
      set @v_trunc_jeopardy_days = MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN(convert(datetime,convert(date,(@p_receipt_date))),convert(datetime,convert(date,(getdate()))));
	end;
  else
    begin
      set @v_jeopardy_days = datediff(day,@p_receipt_date,getdate());
      set @v_trunc_jeopardy_days = datediff(day,convert(datetime,convert(date,(@p_receipt_date))),convert(datetime,convert(date,(getdate()))));
    end;

  if @v_driver ='priority'
    begin

      if @p_instance_status = 'active' 
        begin

          select @v_jeopardy_status = case when count(*) >= 1 then 'y' else 'n' end
          from CORP_ETL_LIST_LKUP
          where 
		    LIST_TYPE = 'jeopardy_priority_calc'
            and @v_jeopardy_days >= convert(int,VALUE)
            and OUT_VAR = @p_priority;

          return @v_jeopardy_status;
	    end;

      else

	    begin
          return 'na';
        end;

	end;

  else if @v_driver = 'incident type' 

    begin;

      if @p_instance_status = 'active'

        if @v_trunc_jeopardy_days >= @v_jeopardy_threshold
	      begin
            return 'y';
		  end;
        else
	      begin
            return 'n';
          end;

      else

	    begin
          return 'na';
	    end;

    end;

	return @v_jeopardy_status;

end;
go

grant execute on MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS to MAXDAT_READ_ONLY;
go


-- Calculates the jeopardy status date.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS_DATE','FN') is not null
begin
  drop function MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS_DATE;
end;
go

create function MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS_DATE
  (@p_receipt_date datetime,  
   @p_instance_status varchar,
   @p_priority varchar)
  returns datetime
as
begin
  declare @v_jeopardy_status_date datetime = null;

  if MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS(@p_receipt_date,@p_instance_status,@p_priority) is not null
	begin
      return getdate();
     end;

  return @v_jeopardy_status_date;

end;
go

grant execute on MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS_DATE to MAXDAT_READ_ONLY;
go


-- Calculates the status age in business days.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_BUS_DAYS','FN') is not null
begin
  drop function MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_BUS_DAYS;
end;
go

create function MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_BUS_DAYS
  (@p_incident_status_dt datetime,
   @p_instance_status varchar)
  returns int
as
begin
  declare @v_status_age_in_bus_days int = 0;

  if @p_instance_status = 'Active'
    begin
      return MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN(@p_incident_status_dt,getdate());
	end;

  return @v_status_age_in_bus_days;
end;
go

grant execute on MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_BUS_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the status age in calendar days.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_CAL_DAYS','FN') is not null
begin
  drop function MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_CAL_DAYS;
end;
go

create function MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_CAL_DAYS
  (@p_incident_status_dt datetime,
   @p_instance_status varchar)
  returns int
as
begin
  declare @v_status_age_in_cal_days int = 0;

  if @p_instance_status = 'Active'
    begin
      return datediff(day,convert(date,@p_incident_status_dt),convert(date,getdate()));
	end;
  
  return @v_status_age_in_cal_days;
end;
go

grant execute on MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_CAL_DAYS to MAXDAT_READ_ONLY;
go


-- Calculates the timeliness status.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_GET_TIMELINESS_STATUS','FN') is not null
begin
  drop function MAXDAT.PROCESS_INCIDENTS_GET_TIMELINESS_STATUS;
end;
go

create function MAXDAT.PROCESS_INCIDENTS_GET_TIMELINESS_STATUS
  (@p_receipt_date datetime, 
   @p_instance_status_dt datetime,
   @p_instance_status varchar,
   @p_cancel_date datetime,
   @p_priority varchar)
  returns varchar
as
begin

  declare @v_driver varchar(20) = null;
  declare @v_timeliness_threshold int;
  declare @v_timeliness_calc varchar(20) = null;
  declare @v_timeliness_days int;
  declare @v_timeliness_status varchar(30) = null;

  select  @v_driver = OUT_VAR
  from MAXDAT.CORP_ETL_LIST_LKUP
  where NAME = 'PI_INCIDENT_SLA_BASIS';

  select @v_timeliness_calc = OUT_VAR 
  from MAXDAT.CORP_ETL_LIST_LKUP
  where NAME = 'PI_TIMELINESS_CALC';

  select @v_timeliness_status = OUT_VAR 
  from MAXDAT.CORP_ETL_LIST_LKUP
  where NAME = 'PI_TIMELINESS_DAYS';
  
  if @v_timeliness_calc = 'B'
    begin
      set @v_timeliness_days = MAXDAT.BPM_COMMON_BUS_DAYS_BETWEEN(convert(datetime,convert(date,@p_receipt_date)),convert(datetime,convert(date,@p_instance_status_dt)));
    end;
  else
    begin
      set @v_timeliness_days = datediff(day,convert(datetime,convert(date,@p_receipt_date)),convert(datetime,convert(date,@p_instance_status_dt)));
    end;
  
  if @v_driver='Priority'
    begin
  
      if @p_instance_status = 'Complete'
	    begin

	      select @v_timeliness_status = case when count(*) >= 1 then 'Processed Timely' else 'Processed Untimely' end
          from CORP_ETL_LIST_LKUP
          where 
		    LIST_TYPE = 'TIMELINESS_PRIORITY_CALC'
            and @v_timeliness_days >= convert(int,VALUE)
            and OUT_VAR = @p_priority;

          return @v_timeliness_status;

        end;
    
      else if @p_instance_status = 'Active' or @p_cancel_date is not null
        begin
	      return 'Not Processed';
	    end;
   
  else if @v_driver = 'Incident Type'
    begin
      if @p_instance_status = 'Complete'
        begin
		  if @v_timeliness_days <= @v_timeliness_threshold
		    begin
              return 'Processed Timely';
			end;
          else
            begin
			  return 'Processed Untimely';
			end;
         end;
      else if @p_instance_status = 'Active' or @p_cancel_date is not null
        begin
          return 'Not Processed';
		end;

    end;

  end;
 
  return @v_timeliness_status;

end;
go

grant execute on MAXDAT.PROCESS_INCIDENTS_GET_TIMELINESS_STATUS to MAXDAT_READ_ONLY;
go

  
-- Calculate column values in BPM Semantic table D_PI_CURRENT.
if OBJECT_ID ('MAXDAT.PROCESS_INCIDENTS_CALC_DPICUR','P') is not null
begin
  drop procedure MAXDAT.PROCESS_INCIDENTS_CALC_DPICUR;
end;
go

create procedure MAXDAT.PROCESS_INCIDENTS_CALC_DPICUR
as
begin

  declare @v_procedure_name varchar(61) = 'PROCESS_INCIDENTS_CALC_DPICUR';
  declare @v_log_message varchar(MAX) = null;
  declare @v_sql_code int = null;
  declare @v_num_rows_updated int = null;
  declare @v_calc_dpicur_job_name varchar(30) = 'CALC_DPICUR';

  declare @v_bil_id int = 10; -- 'Incident ID'
  declare @v_bsl_id int = 10; -- 'CORP_ETL_PROCESS_INCIDENTS'
  
  begin try
    update MAXDAT.D_PI_CURRENT
    set
      "Age in Business Days" = MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_BUSINESS_DAYS("Receipt Date",INSTANCE_END_DATE),
      "Age in Calendar Days" = MAXDAT.PROCESS_INCIDENTS_GET_AGE_IN_CALENDAR_DAYS("Receipt Date",INSTANCE_END_DATE),
      "Status Age in Business Days" = MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_BUS_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Status Age in Calendar Days" = MAXDAT.PROCESS_INCIDENTS_GET_STATUS_AGE_IN_CAL_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Cur Jeopardy Status" = MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS("Receipt Date","Cur Instance Status",PRIORITY),
      "Jeopardy Status Date" = MAXDAT.PROCESS_INCIDENTS_GET_JEOPARDY_STATUS_DATE("Receipt Date","Cur Instance Status",PRIORITY),
      "Timeliness Status" = MAXDAT.PROCESS_INCIDENTS_GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY)
    where 
      "Complete Date" is null 
      and "Cancel Date" is null;
    
    set @v_num_rows_updated = @@rowcount;
 
    set @v_log_message = convert(varchar,@v_num_rows_updated) + ' D_PI_CURRENT rows updated with calculated attributes by CALC_DPICUR.';
    execute MAXDAT.BPM_COMMON_LOGGER 'INFO',null,@v_procedure_name,@v_bsl_id,@v_bil_id,null,null,@v_log_message,null;

  end try
     
  begin catch
    set @v_sql_code = error_number();
    set @v_log_message = error_message();
    execute MAXDAT.BPM_COMMON_LOGGER 'SEVERE',null,@v_procedure_name,@v_bsl_id,@v_bil_id,null,null,@v_log_message,@v_sql_code;
  end catch
 
end;
go


-- Create and schedule job to run CALC_DPICUR procedure daily at midnight that
-- updates calculated columns of active instances in the MAXDAT.D_PI_CURRENT table.
-- Code generated by SQL Server Agent.
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 12/4/2014 4:25:08 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CALC_DPICUR', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Daily job that updates calculated columns of active instances in the MAXDAT.D_PI_CURRENT table.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MAXDAT', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run CALC_DPICUR procedure.]    Script Date: 12/4/2014 4:25:09 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run CALC_DPICUR procedure.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'execute MAXDAT.PROCESS_INCIDENTS_CALC_DPICUR', 
		@database_name=N'UK_HWS', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Run daily CALC_DPICUR job.', 
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
		@schedule_uid=N'ee246475-273a-4e81-b9a3-65b3d4996249'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO
