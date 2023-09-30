alter session set plsql_code_type = native;

create or replace package PKG_HCO_V2_CALL_UPDATE as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/ContactCenter/trunk/kettle/MAXDAT/product/main/scripts/versions/Enhancements-Defects/MAXDAT-8474/004_Update_HCO_V2_Call.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 14422 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-12-10 15:15:32 -0700 (Mon, 10 Dec 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: lg74078 $';

  procedure PROC_REFRESH_MATERIALIZED_VIEW ;
  procedure PROC_CREATE_SCHEDULER_JOB;
   
  end;
  /
  
  create or replace package body PKG_HCO_V2_CALL_UPDATE as
  
  -- Initialize global variables
  
  g_err_date date := sysdate;	
  g_err_level varchar2(10) := 'CRITICAL';	
  g_create_ts date := sysdate;		
  g_update_ts date := sysdate;
  g_process_name varchar2(30) := 'PROC_REFRESH_MATERIALIZED_VIEW';
  g_driver_table1_name varchar2(50):= 'CC_F_V2_CALL_SV';
  g_driver_table2_name varchar2(50):= 'DB_SCHEDULER';
  
  procedure PROC_REFRESH_MATERIALIZED_VIEW
  as
  
 begin
  
  DBMS_MVIEW.REFRESH( 'CC_F_V2_CALL_SV'); 

exception
		when others then         
          insert into corp_etl_error_log (ERR_DATE, ERR_LEVEL, PROCESS_NAME, JOB_NAME, ERROR_DESC, CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME)
           values (g_err_date, g_err_level, g_process_name, g_process_name, g_driver_table1_name, sysdate, sysdate, g_driver_table1_name);

  end;
  
  procedure PROC_CREATE_SCHEDULER_JOB
  as 
  v_schedule_name varchar2(50) := 'cc_v2_call_schedule';
  v_package_name varchar2(50) := 'PKG_HCO_V2_CALL_UPDATE';
  v_procedure_name varchar2(61) := 'PROC_REFRESH_MATERIALIZED_VIEW';
  v_job_type varchar2(50) := 'STORED_PROCEDURE';
  v_job_name varchar2(50) := 'REFRESH_MATERIALIZED_VIEW';
  v_default_timezone varchar2(30) := null;
  v_sql_code number := null;
  v_log_message clob := null;
  v_start_date varchar2(100) := null;

  
  begin
  
      select VALUE into v_default_timezone 
      from ALL_SCHEDULER_GLOBAL_ATTRIBUTE 
      where ATTRIBUTE_NAME = 'DEFAULT_TIMEZONE';
      
      if v_default_timezone is null then
        v_sql_code := -20080;
        v_log_message := 'Unable to start scheduler job "' || v_procedure_name || '".  No DBMS Scheduler default timezone set.  This can be set via MAXDAT_ADMIN.SET_SCHED_DEFAULT_TIMEZONE(timezone_region) which requires MANAGE SCHEDULER privilege.';
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);    
        return;
    end if;
    
    
  v_start_date := to_char(trunc(sysdate + 1),'DD-MON-YY HH.MI.SS AM') || ' ' || v_default_timezone;
  
  v_log_message := 'Created dbms_scheduler job "' || v_job_name || '".';
  
  BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);

  DBMS_SCHEDULER.CREATE_SCHEDULE (
    schedule_name     => v_schedule_name,
    start_date        => v_start_date,
    repeat_interval   => 'FREQ=DAILY; BYHOUR=6;',
    comments          => 'Every day');
    
    DBMS_SCHEDULER.CREATE_JOB (
            job_name   => v_job_name,
            job_type   => v_job_type,
            job_action => v_package_name ||'.' || v_procedure_name,
            schedule_name => v_schedule_name,
            enabled    =>  TRUE);

    
     DBMS_SCHEDULER.SET_ATTRIBUTE(
            name => v_job_name,
            attribute => 'RESTARTABLE',
        value => TRUE);
      
 
  exception
		when others then         
          insert into corp_etl_error_log (ERR_DATE, ERR_LEVEL, PROCESS_NAME, JOB_NAME, ERROR_DESC, CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME)
           values (g_err_date, g_err_level, g_process_name, g_process_name, g_driver_table2_name, sysdate, sysdate, g_driver_table2_name);
		      
  end;
  


end;
/

  grant execute on PKG_HCO_V2_CALL_UPDATE to MAXDAT_READ_ONLY;
  
  alter session set plsql_code_type = interpreted;




