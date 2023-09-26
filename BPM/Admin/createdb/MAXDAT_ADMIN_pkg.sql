alter session set plsql_code_type = native;

create or replace package MAXDAT_ADMIN as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
     
  procedure COMPILE_PROGRAM_UNIT
    (p_program_unit_type in varchar2,
     p_program_unit_name in varchar2);
     
  procedure CONFIG_CALC_JOB
    (p_package_name in varchar2,
     p_procedure_name in varchar2,
     p_process_enabled in varchar2);

  procedure CONFIG_ETL
    (p_name in varchar2,
     p_value in varchar2);
     
  procedure CONFIG_JOB_CONTROL
    (p_parameter_name in varchar2,
     p_parameter_value in varchar2);
     
  procedure CONFIG_QUEUE_JOB
    (p_bsl_id in number,
     p_bdm_id in number,
     p_parameter_name in varchar2,
     p_parameter_value in varchar2);

  procedure DISPLAY_DBMS_SCHEDULER_JOBS;
  
  procedure DROP_DBMS_SCHEDULER_JOB (p_job_name in varchar2);
  
  procedure FIX_JOBS;
  
  procedure FIX_QUEUE_ROWS;
  
  procedure GATHER_TABLE_STATS
    (p_owner in varchar2,
     p_table_name in varchar2,
     p_degree in number);
     
  procedure LOCK_TABLE_STATS
    (p_owner in varchar2,
     p_table_name in varchar2);

  procedure RESET_BPM_QUEUE_ROWS;

  procedure RESET_BPM_QUEUE_ROWS_BY_BSL_ID (p_bsl_id in number);
  
  procedure RESET_BPM_QUEUE_ROWS_BY_BUEQ (p_bueq_id in number);
  
  procedure RESET_BPM_QUEUE_ROWS_BY_PBUEQ (p_process_bueq_id in number);
  
  procedure RUN_CALC_PROCEDURE
    (p_package_name in varchar2,
     p_procedure_name in varchar2);
     
  procedure SET_SCHED_DEFAULT_TIMEZONE
    (p_timezone_region in varchar2);
  
  procedure SHUTDOWN_JOBS;
  
  procedure STARTUP_JOBS;
  
  procedure STOP_DBMS_SCHEDULER_JOB (p_job_name in varchar2);
  
  procedure UNLOCK_TABLE_STATS
    (p_owner in varchar2,
     p_table_name in varchar2);
    
end;
/


create or replace package body MAXDAT_ADMIN as

  -- Output log message to MAXDAT_ADMIN_AUDIT_LOGGING table and dbms_output.
  procedure AUDIT_LOGGER
    (p_run_data_object in varchar2,
     p_bsl_id in number,
     p_log_message in clob)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'AUDIT_LOGGER';
    v_sql_code number := null;
    v_log_message clob := null;
  begin

    insert into MAXDAT_ADMIN_AUDIT_LOGGING
      (MAAL_ID,LOG_DATE,USER_NAME,RUN_DATA_OBJECT,BSL_ID,MESSAGE)
    values 
      (SEQ_MAAL_ID.nextval,sysdate,user,p_run_data_object,p_bsl_id,p_log_message);

    commit;

    dbms_output.put_line(user || ': ' || p_log_message);
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to log audit message.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      raise;
    
  end;


  -- Compile FUNCTION, PACKAGE or PROCEDURE program unit natively.
  procedure COMPILE_PROGRAM_UNIT
    (p_program_unit_type in varchar2,
     p_program_unit_name in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'COMPILE_OBJECT';
    v_sql_code number := null;
    v_log_message clob := null;
    v_program_unit_compile varchar2(200) := null;
  begin
  
    if p_program_unit_type not in ('FUNCTION','PACKAGE','PROCEDURE') then
      v_log_message := 'Unsupported Program Unit Type "' || p_program_unit_type || '".  Must be FUNCTION, PACKAGE or PROCEDURE.  Unable to recompile.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
  
    if p_program_unit_name is null then
      v_log_message := 'Null Program Unit Name.  Unable to recompile.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    v_log_message := 'Natively compile ' || lower(p_program_unit_type) || ' "' || p_program_unit_name || '".';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    execute immediate 'alter session set plsql_code_type = native';
    v_program_unit_compile := 'alter ' || BPM_COMMON.CLEAN_PARAMETER(p_program_unit_type) || ' ' || BPM_COMMON.CLEAN_PARAMETER(p_program_unit_name) || ' compile';
    execute immediate v_program_unit_compile;
    commit;
    execute immediate 'alter session set plsql_code_type = interpreted';
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to natively compile ' || lower(p_program_unit_type) || ' "' || p_program_unit_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  --  Configure a BPM calculation job.  Enable or disable a job.
  procedure CONFIG_CALC_JOB
    (p_package_name in varchar2,
     p_procedure_name in varchar2,
     p_process_enabled in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CONFIG_CALC_JOB';
    v_sql_code number := null;
    v_log_message clob := null;
    
  begin
  
    if p_package_name is null then
      v_log_message := 'Null Package Name.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_procedure_name is null then
      v_log_message := 'Null Procedure Name.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_process_enabled is null or p_process_enabled not in ('N','Y') then
      v_log_message := 'Invalid Process Enabled value "' || p_process_enabled || '".  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;

    v_log_message := 'Configure BPM calc job ' || p_package_name || '.' || p_procedure_name || ' enabled = ' || p_process_enabled || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    update PROCESS_BPM_CALC_JOB_CONFIG
    set PROCESS_ENABLED = p_process_enabled
    where
      PACKAGE_NAME = p_package_name
      and PROCEDURE_NAME = p_procedure_name;
      
    if sql%rowcount = 0 then
      v_log_message := 'No PACKAGE_NAME = ' || p_package_name || ' and PROCEDURE_NAME = ' || p_procedure_name || ' to update in PROCESS_BPM_CALC_JOB_CONFIG.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
    end if;
      
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to configure BPM calc job ' || p_package_name || '.' || p_procedure_name || ' enabled = ' || p_process_enabled || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);  
  end;
  
  
  -- Configure ETL processing.
  procedure CONFIG_ETL
    (p_name in varchar2,
     p_value in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CONFIG_ETL';
    v_sql_code number := null;
    v_log_message clob := null;
    v_num_rows_updated number := null;
  begin
  
    if p_name is null then
      v_log_message := 'Null Name.  Unable to update configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_value is null then
      v_log_message := 'Null Value.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    v_log_message := 'Update CORP_ETL_CONTROL set VALUE = ' || p_value || ' where NAME = ' || p_name || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    update CORP_ETL_CONTROL
    set VALUE = p_value
    where NAME = p_name;
    
    if sql%rowcount = 0 then
      v_log_message := 'No NAME = ' || p_name || ' to update in CORP_ETL_CONTROL.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
    end if;
      
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to update CORP_ETL_CONTROL set VALUE = ' || p_value || ' where NAME = ' || p_name || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  -- Configure the BPM job controller.
  procedure CONFIG_JOB_CONTROL
    (p_parameter_name in varchar2,
     p_parameter_value in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CONFIG_JOB_CONTROL';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    if p_parameter_name is null then
      v_log_message := 'Null Paramater Name.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_parameter_value is null then
      v_log_message := 'Null Parameter Value.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    v_log_message := 'Update PROCESS_BPM_QUEUE_JOB_CTRL_CFG set Value = ' || p_parameter_value || ' for Name = ' || p_parameter_name || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    if p_parameter_name = 'MAX_TOTAL_NUM_JOBS' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set MAX_TOTAL_NUM_JOBS = to_number(p_parameter_value)
      where MAX_TOTAL_NUM_JOBS != to_number(p_parameter_value);
      
    elsif p_parameter_name = 'NUM_JOBS_TO_DEL_DURING_ADJUST' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set NUM_JOBS_TO_DEL_DURING_ADJUST = to_number(p_parameter_value)
      where NUM_JOBS_TO_DEL_DURING_ADJUST != to_number(p_parameter_value);
      
    elsif p_parameter_name = 'NUM_JOBS_TO_ADD_DURING_ADJUST' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set NUM_JOBS_TO_ADD_DURING_ADJUST = to_number(p_parameter_value)
      where NUM_JOBS_TO_ADD_DURING_ADJUST != to_number(p_parameter_value);
      
    elsif p_parameter_name = 'NUM_GROUP_CYCLES_BEFORE_ADD' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set NUM_GROUP_CYCLES_BEFORE_ADD = to_number(p_parameter_value)
      where NUM_GROUP_CYCLES_BEFORE_ADD != to_number(p_parameter_value);
      
    elsif p_parameter_name = 'CONTROL_JOB_SLEEP_SECONDS' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set CONTROL_JOB_SLEEP_SECONDS = to_number(p_parameter_value)
      where CONTROL_JOB_SLEEP_SECONDS != to_number(p_parameter_value);
      
    elsif p_parameter_name = 'START_DELAY_SECONDS' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set START_DELAY_SECONDS = to_number(p_parameter_value)
      where START_DELAY_SECONDS != to_number(p_parameter_value);
      
    elsif p_parameter_name = 'STOP_DELAY_SECONDS' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set STOP_DELAY_SECONDS = to_number(p_parameter_value)
      where STOP_DELAY_SECONDS != to_number(p_parameter_value);
      
    elsif p_parameter_name = 'PROCESSING_ENABLED' then
      update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
      set PROCESSING_ENABLED = p_parameter_value
      where PROCESSING_ENABLED != p_parameter_value;
      
    else
      v_log_message := 'Unsupported Parameter Name ' || p_parameter_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
      
    end if;
      
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to update PROCESS_BPM_QUEUE_JOB_CTRL_CFG set Value = ' || p_parameter_value || ' for Name = ' || p_parameter_name || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;
  

  --  Configure BPM queue job processing.
  procedure CONFIG_QUEUE_JOB
    (p_bsl_id in number,
     p_bdm_id in number,
     p_parameter_name in varchar2,
     p_parameter_value in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CONFIG_QUEUE_JOB';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
      if p_bsl_id is null then
      v_log_message := 'Null BSL_ID.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_bdm_id is null then
      v_log_message := 'Null BDM_ID.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);
      return;
    end if;
  
    if p_parameter_name is null then
      v_log_message := 'Null Paramater Name.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_parameter_name = 'ENABLED' and p_parameter_value is null then
      v_log_message := 'Null Enabled parameter Value.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);
      return;
    end if;
    
    v_log_message := 'Update PROCESS_BPM_QUEUE_JOB_CONFIG set Value = ' || p_parameter_value || ' for BSL_ID = ' || p_bsl_id || ' BDM_ID = ' || p_bdm_id || ' Name = ' || p_parameter_name || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    if p_parameter_name = 'MIN_NUM_JOBS' then
      update PROCESS_BPM_QUEUE_JOB_CONFIG
      set MIN_NUM_JOBS = to_number(p_parameter_value)
      where
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id;
      
    elsif p_parameter_name = 'INIT_NUM_JOBS' then
      update PROCESS_BPM_QUEUE_JOB_CONFIG
      set INIT_NUM_JOBS = to_number(p_parameter_value)
      where
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id;

    elsif p_parameter_name = 'MAX_NUM_JOBS' then
      update PROCESS_BPM_QUEUE_JOB_CONFIG
      set MAX_NUM_JOBS = to_number(p_parameter_value)
      where
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id;
        
    elsif p_parameter_name = 'BATCH_SIZE' then
      update PROCESS_BPM_QUEUE_JOB_CONFIG
      set BATCH_SIZE = to_number(p_parameter_value)
      where
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id;
        
    elsif p_parameter_name = 'ENABLED' then
      update PROCESS_BPM_QUEUE_JOB_CONFIG
      set ENABLED = p_parameter_value
      where
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id;
        
    else
      v_log_message := 'Unsupported Parameter Name ' || p_parameter_name || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
      return;
      
    end if;
      
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to update PROCESS_BPM_QUEUE_JOB_CONFIG set Value = ' || p_parameter_value || ' for Name = ' || p_parameter_name || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
  end;
  

  --  Configure BPM queue job. Enable or disable job.
  procedure CONFIG_QUEUE_JOB
    (p_bsl_id in number,
     p_bdm_id in number,
     p_enabled in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CONFIG_CALC_JOB';
    v_sql_code number := null;
    v_log_message clob := null;
    
  begin
  
    if p_bsl_id is null then
      v_log_message := 'Null BSL_ID.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_bdm_id is null then
      v_log_message := 'Null BDM_ID.  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_enabled is null or p_enabled not in ('N','Y') then
      v_log_message := 'Invalid Enabled value "' || p_enabled || '".  Unable to configure.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);
      return;
    end if;

    v_log_message := 'Configure BPM queue job BSL_ID = ' || p_bsl_id || ' BDM_ID = ' || p_bdm_id || ' enabled = ' || p_enabled || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    update PROCESS_BPM_QUEUE_JOB_CONFIG
    set ENABLED = p_enabled
    where
      BSL_ID = p_bsl_id
      and BDM_ID = p_bdm_id;

    if sql%rowcount = 0 then
      v_log_message := 'No BSL_ID = ' || p_bsl_id || ' BDM_ID = ' || p_bdm_id || ' to update in PROCESS_BPM_QUEUE_JOB_CONFIG.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
    end if;
    
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to configure BPM queue job BSL_ID = ' || p_bsl_id || ' BDM_ID = ' || p_bdm_id || ' enabled = ' || p_enabled || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);  
  end;

  
  -- Display DBMS Scheduler job names.  View dbms_output to see list of job names.
  procedure DISPLAY_DBMS_SCHEDULER_JOBS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'DISPLAY_DBMS_SCHEDULER_JOBS';
    v_sql_code number := null;
    v_log_message clob := null;
    
    cursor c_dbms_scheduler_jobs
    is
    select 
      JOB_NAME,
      OWNER
    from ALL_SCHEDULER_JOBS 
    order by 
      OWNER asc,
      JOB_NAME asc;
    
  begin

    v_log_message := 'Display DBMS Scheduler job names.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    for r_dbms_scheduler_job in c_dbms_scheduler_jobs
    loop
      dbms_output.put_line(r_dbms_scheduler_job.JOB_NAME);
    end loop;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to display DBMS scheduler job names.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);  
  end;
  
  
  -- Drop a DBMS Scheduler job.
  procedure DROP_DBMS_SCHEDULER_JOB
    (p_job_name in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'DROP_DBMS_SCHEDULER_JOB';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    v_log_message := 'Drop DBMS Scheduler job "' || p_job_name || '".';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    if p_job_name is null then
      v_log_message := 'Null JOB_NAME.  Unable to drop DBMS Scheduler job.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    dbms_scheduler.drop_job(p_job_name);
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to drop DBMS Scheduler job "' || p_job_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      
  end;
  

  -- Fix metadata of incorrect BPM queue jobs.
  -- Fix metadata of defective jobs with null parameters and stop them.
  -- Fix metadata of jobs that are not running.
  procedure FIX_JOBS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'FIX_JOBS';
    v_sql_code number := null;
    v_log_message clob := null;
    
  begin

    v_log_message := 'Fix metadata of incorrect BPM queue jobs.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    PROCESS_BPM_QUEUE_JOB_CONTROL.FIX_JOBS;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to fix metadata of incorrect BPM queue jobs.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);  
  end;
  
  -- Fix stuck queue rows.
  -- Fix completed but unarchived queue rows.
  -- Note that if any fixes are necessary the queue jobs will be stopped and restarted automatically to fix.
  procedure FIX_QUEUE_ROWS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'FIX_QUEUE_ROWS';
    v_sql_code number := null;
    v_log_message clob := null;
    
  begin

    v_log_message := 'Fix stuck and unarchived BPM queue rows.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    PROCESS_BPM_QUEUE_JOB_CONTROL.FIX_QUEUE_ROWS;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to fix stuck and unarchived BPM queue rows.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);  
  end;
  
  
  -- Gather table statistics.  Helps improve performance.
  -- Updated statistics will not be used by currently running programs.  
  -- Stop and restart program to be able to use the updated statistics.
  -- Degree is the number of parallel processes to run when gathering statistics.
  procedure GATHER_TABLE_STATS
    (p_owner in varchar2,
     p_table_name in varchar2,
     p_degree in number)
   as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GATHER_TABLE_STATS';
    v_sql_code number := null;
    v_log_message clob := null;
    
  begin

    v_log_message := 'Gather table stats for ' || p_owner || '.' || p_table_name || '.   Degree = ' || p_degree;
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => p_owner,TABNAME => p_table_name,CASCADE => TRUE,DEGREE => p_degree,ESTIMATE_PERCENT => 100,METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');

  exception
  
    when others then
      v_sql_code := SQLCODE;
      if v_sql_code = -20005 then
        v_log_message := 'Statistics locked.  Unable to gather stats for table ' || p_owner || '.' || p_table_name || '.  Use MAXDAT_ADMIN_UNLOCK_TABLE_STATS(owner,table) to unlock.';
      else
        v_log_message := 'Unable to gather stats for table ' || p_owner || '.' || p_table_name || '.  ' || SQLERRM;
      end if;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code); 
      
  end;
  
  
  -- Lock table statistics.
  procedure LOCK_TABLE_STATS
    (p_owner in varchar2,
     p_table_name in varchar2)
   as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'LOCK_TABLE_STATS';
    v_sql_code number := null;
    v_log_message clob := null;
    
  begin

    v_log_message := 'Lock table stats for ' || p_owner || '.' || p_table_name || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    DBMS_STATS.LOCK_TABLE_STATS(OWNNAME => p_owner,TABNAME => p_table_name);
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to lock stats for table ' || p_owner || '.' || p_table_name || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);  
  end; 


  -- Reset all BPM processing queue rows that were reserved but failed to process.
  procedure RESET_BPM_QUEUE_ROWS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESET_BPM_QUEUE_ROWS';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    v_log_message := 'Reset all BPM queue rows.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);     
  
    update BPM_UPDATE_EVENT_QUEUE
    set PROCESS_BUEQ_ID = null
    where PROCESS_BUEQ_ID is not null;
    
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset BPM_UPDATE_EVENT_QUEUE rows.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;
  

  -- Reset BPM processing queue rows that were reserved but failed to process by BPM Source Lookup ID.
  procedure RESET_BPM_QUEUE_ROWS_BY_BSL_ID
    (p_bsl_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESET_QUEUE_ROWS_BY_BSL_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    if p_bsl_id is null then
      v_log_message := 'Null BSL_ID.  Unable to reset BPM_UPDATE_EVENT_QUEUE rows.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    v_log_message := 'Reset BPM queue rows for BSL_ID = ' || p_bsl_id || '.';
    AUDIT_LOGGER(v_procedure_name,p_bsl_id,v_log_message);
    
    update BPM_UPDATE_EVENT_QUEUE
    set PROCESS_BUEQ_ID = null
    where 
      BSL_ID = p_bsl_id
      and PROCESS_BUEQ_ID is not null;

    if sql%rowcount = 0 then
      v_log_message := 'No queue rows reset for BSL_ID = ' || p_bsl_id || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
    end if;
    
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset BPM_UPDATE_EVENT_QUEUE rows for BSL_ID = ' || p_bsl_id || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
  end;
  

  -- Reset BPM processing queue row that were reserved but failed to process by BPM Queue BUEQ ID.
  procedure RESET_BPM_QUEUE_ROWS_BY_BUEQ
    (p_bueq_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESET_QUEUE_ROWS_BY_BUEQ_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    if p_bueq_id is null then
      v_log_message := 'Null BUEQ_ID.  Unable to reset BPM_UPDATE_EVENT_QUEUE row.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    v_log_message := 'Reset BPM queue row for BUEQ_ID = ' || p_bueq_id || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    update BPM_UPDATE_EVENT_QUEUE
    set PROCESS_BUEQ_ID = null
    where BUEQ_ID = p_bueq_id;
    
    if sql%rowcount = 0 then
      v_log_message := 'No queue rows reset for BUEQ_ID = ' || p_bueq_id || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
    end if;
      
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset BPM_UPDATE_EVENT_QUEUE row for BUEQ_ID = ' || p_bueq_id || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  -- Reset BPM processing queue rows that were reserved but failed to process by BPM Queue PROCESS_BUEQ ID.
  procedure RESET_BPM_QUEUE_ROWS_BY_PBUEQ
    (p_process_bueq_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESET_QUEUE_ROWS_BY_PBUEQ_ID';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    if p_process_bueq_id is null then
      v_log_message := 'Null PROCESS_BUEQ_ID.  Unable to reset BPM_UPDATE_EVENT_QUEUE rows.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    v_log_message := 'Reset BPM queue rows for PROCESS_BUEQ_ID = ' || p_process_bueq_id || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    update BPM_UPDATE_EVENT_QUEUE
    set PROCESS_BUEQ_ID = null
    where PROCESS_BUEQ_ID = p_process_bueq_id;
    
    if sql%rowcount = 0 then
      v_log_message := 'No queue rows reset for PROCESS_BUEQ_ID = ' || p_process_bueq_id || '.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
    end if;
      
    commit;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset BPM_UPDATE_EVENT_QUEUE rows for PROCESS_BUEQ_ID = ' || p_process_bueq_id || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;
  
  
  --  Run a BPM process package calculation procedure.   Procedure name must start with "CALC_".
  procedure RUN_CALC_PROCEDURE
    (p_package_name in varchar2,
     p_procedure_name in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RUN_CALC_PROCEDURE';
    v_sql_code number := null;
    v_log_message clob := null;
    v_program_unit_name varchar2(63) := null;
    
  begin
  
    if p_package_name is null then
      v_log_message := 'Null calc Package Name.  Unable to run.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_procedure_name is null then
      v_log_message := 'Null calc Procedure Name.  Unable to run.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    if p_procedure_name not like 'CALC_%' then
      v_log_message := p_procedure_name || ' is not a calc Procedure Name.  Unable to run.  Procedure Name must start with "CALC_".';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;

    v_log_message := 'Run BPM calc procedure ' || p_package_name || '.' || p_procedure_name || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    v_program_unit_name := 'begin ' || BPM_COMMON.CLEAN_PARAMETER(p_package_name) || '.' || BPM_COMMON.CLEAN_PARAMETER(p_procedure_name) || '(); end;';
    execute immediate v_program_unit_name;
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := v_program_unit_name || ' Unable to run BPM calc procedure ' || p_package_name || '.' || p_procedure_name || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);  
  end;


  -- Set DBMS Scheduler default timezone.
  -- Requires MANAGE SCHEDULER privilege.
  procedure SET_SCHED_DEFAULT_TIMEZONE
    (p_timezone_region in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SET_SCHED_DEFAULT_TIMEZONE';
    v_log_message clob := null;
  begin
    v_log_message := 'Setting DBMS Scheduler default timezone = ''' || p_timezone_region || '''.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    PROCESS_BPM_QUEUE_JOB_CONTROL.SET_SCHED_DEFAULT_TIMEZONE(p_timezone_region);
  end;
  

  -- Shutdown all BPM control, queue and calculation jobs.
  procedure SHUTDOWN_JOBS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SHUTDOWN_JOBS';
    v_log_message clob := null;
  begin
    v_log_message := 'Shutdown all BPM jobs.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;
  end;
  
  
  -- Startup all BPM control, queue and calculation jobs.
  procedure STARTUP_JOBS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STARTUP_JOBS';
    v_log_message clob := null;
  begin
    v_log_message := 'Startup all BPM jobs.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
  end;


  -- Stop a DBMS Scheduler job.
  procedure STOP_DBMS_SCHEDULER_JOB
    (p_job_name in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_DBMS_SCHEDULER_JOB';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
    v_log_message := 'Stop DBMS Scheduler job "' || p_job_name || '".';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    if p_job_name is null then
      v_log_message := 'Null JOB_NAME.  Unable to stop DBMS Scheduler job.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    dbms_scheduler.stop_job(p_job_name);
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to stop DBMS Scheduler job "' || p_job_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      
  end;
  
  
  -- Unlock table statistics.
  procedure UNLOCK_TABLE_STATS
    (p_owner in varchar2,
     p_table_name in varchar2)
   as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UNLOCK_TABLE_STATS';
    v_sql_code number := null;
    v_log_message clob := null;
    
  begin

    v_log_message := 'Unlock table stats for ' || p_owner || '.' || p_table_name || '.';
    AUDIT_LOGGER(v_procedure_name,null,v_log_message);
    
    DBMS_STATS.UNLOCK_TABLE_STATS(OWNNAME => p_owner,TABNAME => p_table_name);
    
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to unlock stats for table ' || p_owner || '.' || p_table_name || '.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);  
  end; 

  
end;
/

alter session set plsql_code_type = interpreted;
