alter session set plsql_code_type = native;

/* Procedures to control, create, adjust and stop PROCESS_BPM_QUEUE batch jobs. */

/* 
  Configuration precedence: (highest to lowest)
  
    PROCESS_BPM_QUEUE_JOB_CONFIG(BSL_ID,BDM_ID)
    PROCESS_BPM_QUEUE_JOB_CONFIG(BSL_ID,DEFAULT_BSL_ID hardcoded below)
    PROCESS_BPM_QUEUE_JOB_CONFIG(DEFAULT_BDM_ID hardcoded below,BDM_ID)
    PROCESS_BPM_QUEUE_JOB_CONFIG(DEFAULT_BSL_ID hardcoded below,DEFAULT_BDM_ID hardcoded below)
*/

/* 
   Note that the following database config settings are currently hard-coded 
   in the PROCESS_BPM_QUEUE_pkg.sql code and are not yet controlled by the database.
*/

/*
   PROCESS_BPM_QUEUE_JOB_CTRL_CFG table:
   
     MAX_TOTAL_NUM_JOBS currently prevents an add adjust from exceeeding this limit.   It does not attempt to stop jobs when it already exceeds.
     LOCK_TIMEOUT_SECONDS hardcoded
     PROCESS_SLEEP_SECONDS hardcoded
     PROCESS_BATCH_SECONDS hardcoded
     
   PROCESS_BPM_QUEUE_JOB_CONFIG table:
   
      BATCH_SIZE only set initially when job created.  It does not attempt to adjust batch size for currently running jobs.
*/


create or replace package PROCESS_BPM_QUEUE_JOB_CONTROL as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_JOB_CONTROL_pkg.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 15002 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2015-08-12 14:50:37 -0700 (Wed, 12 Aug 2015) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';

  -- IDs specifying default values.
  DEFAULT_BSL_ID number := 0;
  DEFAULT_BDM_ID number := 0;
  
  CONTROL_JOB_NAME varchar2(30) := 'PROCESS_BPM_QUEUE_CONTROL';
  
  MAX_LOCKING_JOBS number := 2;
  NUM_TRYS_TO_STOP_JOB number := 5;

  FIRST_FIX_QUEUE_ROWS_MINUTES number :=  90;
  UNARCHIVED_QUEUE_ROW_MINUTES number :=  30;
  STUCK_QUEUE_ROW_LOOK_BACK_DAYS number := 1;
  STUCK_QUEUE_ROW_MINUTES      number := 120;
  STUCK_QUEUE_ROW_GAP_MINUTES  number := 120;

  procedure ADJUST_ALL_JOBS;
  
  procedure ADJUST_NUM_OF_JOBS
    (p_bsl_id in number,
     p_bdm_id in number);
     
  procedure CONTROL_JOB;
     
  procedure CREATE_ALL_JOBS;
  
  procedure CREATE_CALC_JOB
    (p_package_name in varchar2,
     p_procedure_name in varchar2);
  
  procedure CREATE_CONTROL_JOB;
     
  procedure CREATE_JOB
    (p_process_action in varchar2,
     p_process_param in varchar2);
     
  procedure CREATE_JOB
    (p_process_action in varchar2,
     p_process_param in varchar2,
     p_start_reason_id in varchar2);
     
  procedure CREATE_PROCESS_ALL_ROWS_BY_BSL
    (p_bsl_id in number,
     p_bdm_id in number,
     p_batch_size in number,
     p_start_reason_id in number);
     
  procedure FIX_JOBS;
  
  procedure FIX_QUEUE_ROWS;
  
  procedure SET_SCHED_DEFAULT_TIMEZONE
    (p_timezone_region in varchar2);
  
  procedure STARTUP_JOBS;
  
  procedure SHUTDOWN_JOBS;

  procedure STOP_ALL_CALC_JOBS;
  
  procedure STOP_ALL_JOBS;
  
  procedure STOP_CONTROL_JOB;
  
  procedure STOP_JOB 
    (p_job_name in varchar2);
    
  procedure STOP_JOB_BY_ID
    (p_job_id in number);
    
  procedure STOP_JOB_BY_ID
    (p_job_id in number,
     p_stop_reason_id number);
    
  procedure STOP_JOB_BY_NAME
    (p_job_name in varchar2,
     p_stop_reason_id number);

end;
/


create or replace package body PROCESS_BPM_QUEUE_JOB_CONTROL as


  -- Create scheduler job for calculation job.
  procedure CREATE_CALC_JOB
    (p_package_name in varchar2,
     p_procedure_name in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_CALC_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
    v_default_timezone varchar2(30) := null;
    v_job_action varchar2(200) := null;
    v_job_name varchar2(30) := null;
    v_start_date varchar2(100) := null;
  begin
    
    select VALUE into v_default_timezone 
    from ALL_SCHEDULER_GLOBAL_ATTRIBUTE 
    where ATTRIBUTE_NAME = 'DEFAULT_TIMEZONE';
    
    if v_default_timezone is null then
      v_sql_code := -20080;
      v_log_message := 'Unable to start calc job "' || p_procedure_name || '".  No DBMS Scheduler default timezone set.  This can be set via MAXDAT_ADMIN.SET_SCHED_DEFAULT_TIMEZONE(timezone_region) which requires MANAGE SCHEDULER privilege.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);    
      return;
    end if;
    
    -- Create job to run daily.
    v_job_action := 'begin ' || p_package_name || '.' || p_procedure_name || ' ; end;';
    v_job_name := p_procedure_name;
    v_start_date := to_char(trunc(sysdate + 1),'DD-MON-YY HH.MI.SS AM') || ' ' || v_default_timezone;
    dbms_scheduler.create_job (
      job_name   => v_job_name,
      job_type   => 'PLSQL_BLOCK',
      job_action => v_job_action,
      start_date => v_start_date,
      repeat_interval=> 'FREQ=DAILY; BYHOUR=0;',
      enabled    =>  TRUE,
      comments   => 'Calculate column values in BPM Semantic current table.');
      
    dbms_scheduler.set_attribute(
      name => v_job_name,
      attribute => 'RESTARTABLE',
      value => TRUE);

    v_log_message := 'Created dbms_scheduler job "' || v_job_name || '".';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);

  exception

    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to start job "' || p_procedure_name || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end;


  -- Create and start scheduler job for PROCESS_BPM_QUEUE process.
  procedure CREATE_JOB
    (p_process_action in varchar2,
     p_process_param in varchar2,
     p_start_reason_id in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
    v_start_delay_seconds number := null;
    v_job_id number := null;
    v_job_name varchar2(40) := null;
    v_job_action varchar2(200) := null;
  begin
  
    select START_DELAY_SECONDS
    into v_start_delay_seconds
    from PROCESS_BPM_QUEUE_JOB_CTRL_CFG;
    
    -- Delay so that job starts are spread out more evenly so they don't align.
    user_lock.sleep(v_start_delay_seconds * 100);
    
    v_job_id := SEQ_PBQJ_ID.nextval;
    v_job_name := p_process_action || '_' || to_char(v_job_id);
    
    insert into PROCESS_BPM_QUEUE_JOB
      (PBQJ_ID,JOB_NAME,START_DATE,STATUS,STATUS_DATE,ENABLED,START_REASON_ID)
    values (v_job_id,v_job_name,sysdate,PROCESS_BPM_QUEUE.JOB_STATUS_STARTED,sysdate,'Y',p_start_reason_id);
    
    commit;

    v_job_action := 'begin PROCESS_BPM_QUEUE.' || p_process_action || '(' || p_process_param || ',' || v_job_id || '); end;';

    dbms_scheduler.create_job (
      job_name   => v_job_name,
      job_type   => 'PLSQL_BLOCK',
      job_action => v_job_action,
      enabled    =>  TRUE,
      comments   => 'Process BPM_UPDATE_EVENT_QUEUE and write data to data models.');
    
  exception
  
    when OTHERS then

      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      raise;

  end;

  
  -- Create and start scheduler job for PROCESS_BPM_QUEUE process (no reason ID).
  procedure CREATE_JOB
    (p_process_action in varchar2,
     p_process_param in varchar2)
  as
  begin
    CREATE_JOB(p_process_action,p_process_param,PBQJ_ADJUST_REASON.START_MANUAL);
  end;
  

  -- Create and start scheduler job for a ROCESS_ALL_ROWS_BY_BSL process.
  procedure CREATE_PROCESS_ALL_ROWS_BY_BSL
    (p_bsl_id in number,
     p_bdm_id in number,
     p_batch_size in number,
     p_start_reason_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_PROCESS_ALL_ROWS_BY_BSL';
    v_log_message clob := null;
    v_error_number number := null;
    v_sql_code number := null;
    v_process_param varchar2(200) := null;
    v_data_model_name varchar2(12) := null;
    v_start_delay_seconds number := null;
    v_job_id number := null;
    v_job_name varchar2(40) := null;
    v_job_action varchar2(200) := null;
  begin
    if p_bdm_id = 2 then
      v_data_model_name := 'BPM_SEMANTIC';
    else
      v_log_message := 'Unsupported data model number "' || p_bdm_id || '".';
      v_error_number := -20023;
      BPM_COMMON.LOGGER
       (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(-20023,v_log_message);
    end if;
    
    select START_DELAY_SECONDS
    into v_start_delay_seconds
    from PROCESS_BPM_QUEUE_JOB_CTRL_CFG;
    
    -- Delay so that job starts are spread out more evenly so they don't align.
    user_lock.sleep(v_start_delay_seconds * 100);
    
    v_job_id := SEQ_PBQJ_ID.nextval;
    v_job_name := 'PROCESS_Q_BY_BSL_' || to_char(v_job_id);
    
    insert into PROCESS_BPM_QUEUE_JOB
      (PBQJ_ID,JOB_NAME,BSL_ID,BDM_ID,BATCH_SIZE,START_DATE,STATUS,STATUS_DATE,ENABLED,START_REASON_ID)
    values (v_job_id,v_job_name,p_bsl_id,p_bdm_id,p_batch_size,sysdate,PROCESS_BPM_QUEUE.JOB_STATUS_STARTED,sysdate,'Y',p_start_reason_id);
    
    commit;
    
    v_process_param := to_char(p_bsl_id) || ',' || to_char(p_bdm_id) || ',' || to_char(p_batch_size  || ',' || to_char(v_job_id));
    v_job_action := 'begin PROCESS_BPM_QUEUE.PROCESS_ALL_ROWS_BY_BSL' || '(' || v_process_param || '); end;';

    dbms_scheduler.create_job (
      job_name   => v_job_name,
      job_type   => 'PLSQL_BLOCK',
      job_action => v_job_action,
      enabled    =>  TRUE,
      comments   => 'Process BPM_UPDATE_EVENT_QUEUE and write data to data models.');

  exception
  
    when OTHERS then

      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,v_job_id,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
      raise;

  end;
  
  
  -- Gracefully stop job.
  procedure STOP_JOB
    (p_job_name in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_jobs number := null;
  begin

    select count(*)
    into v_num_jobs
    from USER_SCHEDULER_JOBS 
    where JOB_NAME = p_job_name;

    if v_num_jobs = 0 then 
      v_log_message := 'dbms_scheduler job "' || p_job_name || '" was already stopped.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,null);  
    else
      dbms_scheduler.drop_job(p_job_name,TRUE);
    end if;

  exception

    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to stop job "' || p_job_name || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end;


  -- Gracefully stop job and log stopping job.
  procedure STOP_JOB_AND_LOG
    (p_job_name in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_jobs number := null;
  begin

    select count(*)
    into v_num_jobs
    from USER_SCHEDULER_JOBS 
    where JOB_NAME = p_job_name;

    if v_num_jobs = 0 then 
      v_log_message := 'dbms_scheduler job "' || p_job_name || '" was already stopped.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,null);  
    else
      dbms_scheduler.drop_job(p_job_name,TRUE);
      v_log_message := 'Stopped dbms_scheduler job "' || p_job_name || '".';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);
    end if;

  exception

    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to stop job "' || p_job_name || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end;
  

  -- Gracefully stop and drop scheduler job by job ID.
  procedure STOP_JOB_BY_ID
    (p_job_id in number,
     p_stop_reason_id number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_JOB_BY_ID';
    v_log_message clob := null;
    v_stop_delay_seconds number := null;
    v_job_name varchar2(30) := null;
    v_job_status varchar2(10) := null;
    v_num_jobs number := null;
  begin

    update PROCESS_BPM_QUEUE_JOB
    set
      ENABLED = 'N',
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    commit;
    
    select STOP_DELAY_SECONDS
    into v_stop_delay_seconds
    from PROCESS_BPM_QUEUE_JOB_CTRL_CFG;
    
    for v_stop_trys in 1..NUM_TRYS_TO_STOP_JOB
    loop
    
      begin
      
        select 
          JOB_NAME,
          STATUS
        into 
          v_job_name,
          v_job_status
        from PROCESS_BPM_QUEUE_JOB
        where PBQJ_ID = p_job_id;
        
        exception
        
          when NO_DATA_FOUND then
          
            v_log_message := 'Job ID ' || p_job_id || ' not found.   Cannot stop job.';
            BPM_COMMON.LOGGER
              (BPM_COMMON.LOG_LEVEL_WARNING,p_job_id,v_procedure_name,null,null,null,null,v_log_message,null);
            return;
            
          when others then
          
            v_log_message := 'Exception when stopping job ID ' || p_job_id || '.';
            BPM_COMMON.LOGGER
              (BPM_COMMON.LOG_LEVEL_WARNING,p_job_id,v_procedure_name,null,null,null,null,v_log_message,null);
            return;
        
      end;
      
      if v_job_status = PROCESS_BPM_QUEUE.JOB_STATUS_SLEEPING then
  
        begin
 
          update PROCESS_BPM_QUEUE_JOB
          set
            END_DATE = sysdate,
            STATUS = PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,
            STOP_REASON_ID = p_stop_reason_id,
            STATUS_DATE = sysdate
          where PBQJ_ID = p_job_id;
          
          commit;
          
          STOP_JOB(v_job_name);
          
          -- Job stopped.
          return;

        exception
         
          when others then
            v_log_message := 'Exception when stopping job ID ' || p_job_id || '.';
            BPM_COMMON.LOGGER
              (BPM_COMMON.LOG_LEVEL_WARNING,p_job_id,v_procedure_name,null,null,null,null,v_log_message,null);
            return;
            
        end;
    
      end if;
      
      -- Delay so that job has time to stop current work cleanly.
      user_lock.sleep(v_stop_delay_seconds * 100);
    
    end loop;
    
    -- Stop job anyway.
    if v_job_status != PROCESS_BPM_QUEUE.JOB_STATUS_SLEEPING then
      v_log_message := 'Stopped job ID ' || p_job_id || ' when status was ' || v_job_status || '.';
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_WARNING,p_job_id,v_procedure_name,null,null,null,null,v_log_message,null);
    end if;
    
    begin
 
      update PROCESS_BPM_QUEUE_JOB
      set
        END_DATE = sysdate,
        STATUS = PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,
        STOP_REASON_ID = p_stop_reason_id,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;
          
      commit;
          
      STOP_JOB(v_job_name);

    exception
         
      when others then
      
        v_log_message := 'Exception when stopping job ID ' || p_job_id || '.';
        BPM_COMMON.LOGGER
          (BPM_COMMON.LOG_LEVEL_WARNING,p_job_id,v_procedure_name,null,null,null,null,v_log_message,null);
        return;
        
    end;
    
  end;
  
  
  -- Gracefully stop and drop scheduler job by job ID.
  procedure STOP_JOB_BY_ID
    (p_job_id in number)
  as
  begin
    STOP_JOB_BY_ID(p_job_id,PBQJ_ADJUST_REASON.STOP_MANUAL);
  end;


  -- Gracefully stop and drop scheduler job by job name.
  procedure STOP_JOB_BY_NAME
    (p_job_name in varchar2,
     p_stop_reason_id number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_JOB_BY_NAME';
    v_log_message clob := null;
    v_stop_delay_seconds number := null;
    v_job_id number;
  begin
    
    select PBQJ_ID
    into v_job_id
    from PROCESS_BPM_QUEUE_JOB
    where JOB_NAME = p_job_name;
    
    if v_job_id is null then 
      v_log_message := 'Job ' || p_job_name || ' not found.   Cannot stop job.';
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_WARNING,v_job_id,v_procedure_name,null,null,null,null,v_log_message,null);
      return;
    end if;
    
    STOP_JOB_BY_ID(v_job_id,p_stop_reason_id);
    
  end;


  -- Gracefully stop all jobs.
  procedure STOP_ALL_JOBS
  as
    cursor c_job_id is
      select PBQJ_ID
      from PROCESS_BPM_QUEUE_JOB
      where STATUS not in (PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,PROCESS_BPM_QUEUE.JOB_STATUS_FAILED)
      order by PBQJ_ID asc;
  begin
  
    update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
    set PROCESSING_ENABLED = 'N';
    
    commit;
    
    for i in c_job_id
    loop
      STOP_JOB_BY_ID(i.PBQJ_ID,PBQJ_ADJUST_REASON.STOP_ALL_PROC_DISABLED);
    end loop;
    
  end;

 
  -- Adjust number of active jobs by source and data model ID.
  procedure ADJUST_NUM_OF_JOBS
    (p_bsl_id in number,
     p_bdm_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'ADJUST_NUM_JOBS';
    v_sql_code number := null;
    v_log_message clob := null;
    
    v_max_total_num_jobs number := null;
    v_num_jobs_to_del_during_adj number := null;
    v_num_jobs_to_add_during_adj number := null;
    v_num_group_cycles_before_add number := null;
    v_processing_enabled varchar2(1) := null;
    
    cursor c_running_jobs is
      select PBQJ_ID
      from PROCESS_BPM_QUEUE_JOB
      where
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id
        and STATUS not in (PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,PROCESS_BPM_QUEUE.JOB_STATUS_FAILED);
        
    cursor c_running_jobs_by_status is
      select PBQJ_ID
      from
        (select 
          PBQJ_ID,
          case
            when STATUS in ('SLEEPING','SUSPENDED') then 1
            when STATUS in ('LOCKING','RESERVING','STARTED') then 2
            when STATUS = 'PROCESSING' then 3
            else 0
            end status_rank
         from PROCESS_BPM_QUEUE_JOB
         where
          BSL_ID = p_bsl_id
          and BDM_ID = p_bdm_id
          and STATUS not in (PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,PROCESS_BPM_QUEUE.JOB_STATUS_FAILED))
      order by status_rank asc;
      
    cursor c_sleeping_jobs (p_num_sleeping_jobs_to_cull number) is
      select PBQJ_ID
      from PROCESS_BPM_QUEUE_JOB
      where
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id
        and STATUS = 'SLEEPING'
        and rownum <= p_num_sleeping_jobs_to_cull;
    
    v_min_num_jobs number := null;
    v_init_num_jobs number := null;
    v_max_num_jobs number := null;
    v_batch_size number := null;
    v_config_enabled varchar2(1) := null;
    
    v_default_bsl_min_num_jobs number := null;
    v_default_bsl_init_num_jobs number := null;
    v_default_bsl_max_num_jobs number := null;
    v_default_bsl_batch_size number := null;
    
    v_default_bdm_min_num_jobs number := null;
    v_default_bdm_init_num_jobs number := null;
    v_default_bdm_max_num_jobs number := null;
    v_default_bdm_batch_size number := null;
    
    v_default_min_num_jobs number := null;
    v_default_init_num_jobs number := null;
    v_default_max_num_jobs number := null;
    v_default_batch_size number := null;
    
    v_num_jobs number := null;
    v_num_jobs_to_stop number := null;
    v_num_jobs_sleeping number := null;
    v_num_sleeping_jobs_to_cull number := null;
    
    v_num_jobs_locking number := null;
    
    v_num_jobs_to_start number := null;
    v_num_unreserved_identifiers number := null;
    v_num_batches_to_finish number := null;
    v_num_group_cycles_to_finish number := null;
    v_num_jobs_needed_to_add number := null;
    v_num_all_jobs number := null;
    v_total_num_jobs_available number := null;
    v_num_jobs_available number := null;
    v_num_jobs_available_to_add number := null;
    v_num_jobs_to_add number := null;
        
  begin
  
    -- Get control job config.
    select 
      MAX_TOTAL_NUM_JOBS,
      NUM_JOBS_TO_DEL_DURING_ADJUST,
      NUM_JOBS_TO_ADD_DURING_ADJUST,
      NUM_GROUP_CYCLES_BEFORE_ADD,
      PROCESSING_ENABLED
    into
      v_max_total_num_jobs,
      v_num_jobs_to_del_during_adj,
      v_num_jobs_to_add_during_adj,
      v_num_group_cycles_before_add,
      v_processing_enabled
    from PROCESS_BPM_QUEUE_JOB_CTRL_CFG;

    -- Stop all running jobs for this source and data model ID 
    -- because all BPM processing jobs are disabled.
    if v_processing_enabled = 'N' then
      for r_running_job in c_running_jobs
      loop
        STOP_JOB_BY_ID(r_running_job.PBQJ_ID,PBQJ_ADJUST_REASON.STOP_ALL_PROC_DISABLED);
      end loop;
      return;
    end if;

    -- Get config for this source and data model ID.
    select
      MIN_NUM_JOBS,
      MAX_NUM_JOBS,
      BATCH_SIZE,
      ENABLED
    into
      v_min_num_jobs,
      v_max_num_jobs,
      v_batch_size,
      v_config_enabled
    from PROCESS_BPM_QUEUE_JOB_CONFIG
    where
      BSL_ID = p_bsl_id
      and BDM_ID = p_bdm_id;

    -- Stop all running jobs for this source and data model ID 
    -- because all BPM processing jobs for this source and data model ID are disabled.
    if v_config_enabled = 'N' then
      for r_running_job in c_running_jobs
      loop
        STOP_JOB_BY_ID(r_running_job.PBQJ_ID,PBQJ_ADJUST_REASON.STOP_BSL_BDM_PROC_DISABLED);
      end loop;
      return;
    end if;
    
    -- Get default BPM processing job config for BSL_ID.  
    if (v_min_num_jobs is null or v_init_num_jobs is null or v_max_num_jobs is null or v_batch_size is null) then
      begin
      
        select
          MIN_NUM_JOBS,
          INIT_NUM_JOBS,
          MAX_NUM_JOBS,
          BATCH_SIZE
        into
          v_default_bsl_min_num_jobs,
          v_default_bsl_init_num_jobs,
          v_default_bsl_max_num_jobs,
          v_default_bsl_batch_size
        from PROCESS_BPM_QUEUE_JOB_CONFIG
        where
          BSL_ID = p_bsl_id
          and BDM_ID = DEFAULT_BDM_ID;
          
      exception
      
        when NO_DATA_FOUND then
          null;
          
        when OTHERS then
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
          raise;
        
      end;
    
      -- Get default BPM processing job config for BDM_ID.  
      if (v_default_bsl_min_num_jobs is null or v_default_bsl_init_num_jobs is null or v_default_bsl_max_num_jobs is null or v_default_bsl_batch_size is null) then
        begin
          select
            MIN_NUM_JOBS,
            INIT_NUM_JOBS,
            MAX_NUM_JOBS,
            BATCH_SIZE
          into
            v_default_bdm_min_num_jobs,
            v_default_bdm_init_num_jobs,
            v_default_bdm_max_num_jobs,
            v_default_bdm_batch_size
          from PROCESS_BPM_QUEUE_JOB_CONFIG
          where
            BSL_ID = DEFAULT_BSL_ID
            and BDM_ID = p_bdm_id;
          
        exception
        
          when NO_DATA_FOUND then
            null;
          
          when OTHERS then
            v_sql_code := SQLCODE;
            v_log_message := SQLERRM;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
            raise;
        
        end;

        -- Get default BPM processing job config.  
        if (v_default_bdm_min_num_jobs is null or v_default_bdm_init_num_jobs is null or v_default_bdm_max_num_jobs is null or v_default_bdm_batch_size is null) then
        
          begin
          
            select
              MIN_NUM_JOBS,
              INIT_NUM_JOBS,
              MAX_NUM_JOBS,
              BATCH_SIZE
            into
              v_default_min_num_jobs,
              v_default_init_num_jobs,
              v_default_max_num_jobs,
              v_default_batch_size
            from PROCESS_BPM_QUEUE_JOB_CONFIG
            where
              BSL_ID = DEFAULT_BSL_ID
              and BDM_ID = DEFAULT_BDM_ID;
          
          exception
        
            when NO_DATA_FOUND then
              null;
          
            when OTHERS then
              v_sql_code := SQLCODE;
              v_log_message := SQLERRM;
              BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
              raise;
        
          end;
          
        end if;
        
      end if;
      
    end if;
    
    -- Get minimum number of jobs for this source and data model ID.
    v_min_num_jobs := coalesce(v_min_num_jobs,v_default_bsl_min_num_jobs,v_default_bdm_min_num_jobs,v_default_min_num_jobs);
    if v_min_num_jobs is null then
      v_log_message := 'Null MIN_NUM_JOBS config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null); 
      return;
    end if;
    
    -- Get initial number of jobs for this source and data model ID.
    v_init_num_jobs := coalesce(v_init_num_jobs,v_default_bsl_init_num_jobs,v_default_bdm_init_num_jobs,v_default_init_num_jobs);
    if v_init_num_jobs is null then
      v_log_message := 'Null INIT_NUM_JOBS config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);    
      return;
    end if;

    -- Get maximum number of jobs for this source and data model ID.
    v_max_num_jobs := coalesce(v_max_num_jobs,v_default_bsl_max_num_jobs,v_default_bdm_max_num_jobs,v_default_max_num_jobs);
    if v_max_num_jobs is null then
      v_log_message := 'Null MAX_NUM_JOBS config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);    
      return;
    end if;
 
    -- Get batch size for this source and data model ID.
    v_batch_size := coalesce(v_batch_size,v_default_bsl_batch_size,v_default_bdm_batch_size,v_default_batch_size);
    if v_batch_size is null then
      v_log_message := 'Null BATCH_SIZE config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);        
      return;
    end if;

    -- Get number of jobs running for this source and data model ID.
    select count(*)
    into v_num_jobs
    from PROCESS_BPM_QUEUE_JOB
    where 
      BSL_ID = p_bsl_id
      and BDM_ID = p_bdm_id
      and STATUS not in (PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,PROCESS_BPM_QUEUE.JOB_STATUS_FAILED);
    
    -- Initialize number of jobs running when no jobs are running and some jobs are allowd.
    -- Should be the case after restart.
    if v_num_jobs = 0 and v_config_enabled = 'Y' and v_min_num_jobs > 0 and v_init_num_jobs > 0 and v_max_num_jobs > 0 then
      for i in 1..v_init_num_jobs
      loop
        CREATE_PROCESS_ALL_ROWS_BY_BSL(p_bsl_id,p_bdm_id,v_batch_size,PBQJ_ADJUST_REASON.START_BSL_BDM_PROC_ENABLED);        
      end loop;
      return;
    end if;
    
    -- Stop extra jobs if too many jobs running for this source and data model ID.
    if v_num_jobs > v_max_num_jobs then
      v_num_jobs_to_stop := v_num_jobs - v_max_num_jobs;
      for r_running_job in c_running_jobs_by_status
      loop
        STOP_JOB_BY_ID(r_running_job.PBQJ_ID,PBQJ_ADJUST_REASON.STOP_TOO_MANY_JOBS);
        v_num_jobs_to_stop := v_num_jobs_to_stop - 1;
        v_num_jobs := v_num_jobs - 1;
        exit when v_num_jobs_to_stop = 0;
      end loop;
    end if;
   
    -- Stop some sleeping for this source and data model ID.
    if v_num_jobs_to_del_during_adj > 0 and v_num_jobs > v_min_num_jobs then
    
      select count(*)
      into v_num_jobs_sleeping
      from PROCESS_BPM_QUEUE_JOB
      where 
        BSL_ID = p_bsl_id
        and BDM_ID = p_bdm_id
        and STATUS = 'SLEEPING';
      
      if v_num_jobs_sleeping > 0 then
      
        v_num_sleeping_jobs_to_cull := least (v_num_jobs_sleeping,v_num_jobs_to_del_during_adj);
        for r_sleeping_job in c_sleeping_jobs(v_num_sleeping_jobs_to_cull)
        loop
          STOP_JOB_BY_ID(r_sleeping_job.PBQJ_ID,PBQJ_ADJUST_REASON.STOP_SLEEPING);
          v_num_jobs := v_num_jobs - 1;
        end loop;
        
        -- Don't add jobs later during adjust if some were sleeping.
        return;
        
      end if;
      
    end if;
    
    -- Start jobs if less then minimum number of jobs.
    if v_num_jobs < v_min_num_jobs then
      v_num_jobs_to_start := v_min_num_jobs - v_num_jobs; 
      if v_num_jobs_to_start > 0 then
        for i in 1..v_num_jobs_to_start
        loop
          CREATE_PROCESS_ALL_ROWS_BY_BSL(p_bsl_id,p_bdm_id,v_batch_size,PBQJ_ADJUST_REASON.START_TOO_FEW_JOBS);
          v_num_jobs := v_num_jobs + 1;
        end loop;
      end if;
    end if;
    
    -- Don't start new jobs if too many locking.
    select count(*)
    into v_num_jobs_locking
    from PROCESS_BPM_QUEUE_JOB
    where 
      STATUS = 'LOCKING'
      and BSL_ID = p_bsl_id
      and BDM_ID = p_bdm_id;
      
    if v_num_jobs_locking >MAX_LOCKING_JOBS then
      return;
    end if;
 
    -- Get number of identifiers that remain to be reserved and processed for this source and data model ID.
    if v_num_jobs_to_add_during_adj <= 0 then
      return;
    end if;
    
    if p_bdm_id = 2 then
      select count(distinct IDENTIFIER)
      into v_num_unreserved_identifiers
      from BPM_UPDATE_EVENT_QUEUE
      where
        BSL_ID = p_bsl_id
        and PROCESS_BUEQ_ID is null;   
    else
      v_log_message := 'Unsupported BDM_ID ' || p_bdm_id || '   Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);          
      return;  
    end if;
    
    -- Add processor jobs, if allowed and needed.
    v_num_batches_to_finish := ceil(v_num_unreserved_identifiers / v_batch_size);
    v_num_group_cycles_to_finish := floor(v_num_batches_to_finish / v_num_jobs);
    v_num_jobs_needed_to_add := floor(v_num_group_cycles_to_finish / v_num_group_cycles_before_add);
    if v_num_jobs_needed_to_add > 0 and v_num_group_cycles_to_finish > v_num_group_cycles_before_add then

      select count(*)
      into v_num_all_jobs
      from PROCESS_BPM_QUEUE_JOB
      where STATUS not in (PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,PROCESS_BPM_QUEUE.JOB_STATUS_FAILED);
    
      if v_num_all_jobs < v_max_total_num_jobs then
        v_total_num_jobs_available := v_max_total_num_jobs - v_num_all_jobs;
        if v_total_num_jobs_available > 0 then
          if v_num_jobs < v_max_num_jobs then
            v_num_jobs_available := v_max_num_jobs - v_num_jobs;
            if v_num_jobs_available > 0 then
              v_num_jobs_available_to_add := least(v_total_num_jobs_available,v_num_jobs_available);
              v_num_jobs_to_add := least(v_num_jobs_available_to_add,v_num_jobs_to_add_during_adj,v_num_jobs_needed_to_add);
              if v_num_jobs_to_add > 0 then
                for i in 1..v_num_jobs_to_add
                loop
                  CREATE_PROCESS_ALL_ROWS_BY_BSL(p_bsl_id,p_bdm_id,v_batch_size,PBQJ_ADJUST_REASON.START_WORK_BACKLOG);
                end loop;
              end if;
            end if;
          end if;
        end if;
      end if;
      
    end if;

  end;
  

  -- Fix incorrect jobs.
  procedure FIX_JOBS
  as
  
  cursor c_null_param_jobs is
  with jp as
    (select
       pbqj.PBQJ_ID,
       substr(asj.JOB_ACTION,instr(asj.JOB_ACTION,'(',1,1) + 1,(instr(asj.JOB_ACTION,')',1,1) - instr(asj.JOB_ACTION,'(',1,1) - 1)) params
     from PROCESS_BPM_QUEUE_JOB pbqj
     inner join USER_SCHEDULER_JOBS asj on (pbqj.JOB_NAME = asj.JOB_NAME) 
     where
       pbqj.STATUS not in (PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,PROCESS_BPM_QUEUE.JOB_STATUS_FAILED)
       and (pbqj.BSL_ID is null or pbqj.BDM_ID is null or pbqj.BATCH_SIZE is null))
  select
    PBQJ_ID,
    to_number(substr(jp.params,0,(instr(jp.params,',',1,1) - instr(jp.params,'(',1,1) - 1))) bsl_id,
    to_number(substr(jp.params,instr(jp.params,',',1,1) + 1,(instr(jp.params,',',1,2) - instr(jp.params,',',1,1) - 1))) bdm_id,
    to_number(substr(jp.params,instr(jp.params,',',1,2) + 1,(instr(jp.params,',',1,3) - instr(jp.params,',',1,2) - 1))) batch_size
  from jp;
  
  cursor c_non_running_jobs is
  select pbqj.PBQJ_ID
  from PROCESS_BPM_QUEUE_JOB pbqj
  left outer join USER_SCHEDULER_JOBS asj on (pbqj.JOB_NAME = asj.JOB_NAME) 
  where
    pbqj.STATUS not in (PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,PROCESS_BPM_QUEUE.JOB_STATUS_FAILED)
    and asj.JOB_NAME is null;
  
  begin
  
    -- Fix metadata of defective jobs with null paramaters and stop them.
    for r_null_param_job in c_null_param_jobs
    loop
    
      update PROCESS_BPM_QUEUE_JOB
      set 
        BSL_ID = r_null_param_job.bsl_id,
        BDM_ID = r_null_param_job.bdm_id,
        BATCH_SIZE = r_null_param_job.batch_size
      where PBQJ_ID = r_null_param_job.PBQJ_ID;
      
      commit;
      
      STOP_JOB_BY_ID(r_null_param_job.PBQJ_ID,PBQJ_ADJUST_REASON.STOP_BAD_METADATA);
      
    end loop;
    
    -- Fix metadata of jobs that are not running.
    for r_non_running_job in c_non_running_jobs
    loop
    
      update PROCESS_BPM_QUEUE_JOB
      set
        END_DATE = sysdate,
        STATUS = PROCESS_BPM_QUEUE.JOB_STATUS_STOPPED,
        STATUS_DATE = sysdate,
        ENABLED = 'N',
        STOP_REASON_ID = PBQJ_ADJUST_REASON.STOP_BAD_METADATA
      where PBQJ_ID = r_non_running_job.PBQJ_ID;
      
      commit;
      
    end loop;
   
  end;
  
  
  -- Fix queue rows.
  procedure FIX_QUEUE_ROWS
  as
  
  v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'FIX_QUEUE_ROWS';
  v_log_message clob := null;
    
  v_unarchived_queue_row_exists number := null;
  v_stuck_queue_row_exists number := null;
  
  cursor c_unarchived_queue_rows is
  select
    BUEQ_ID,
    BSL_ID,
    BIL_ID,
    IDENTIFIER,
    WROTE_BPM_SEMANTIC_DATE
  from BPM_UPDATE_EVENT_QUEUE
  where WROTE_BPM_SEMANTIC_DATE < sysdate - (UNARCHIVED_QUEUE_ROW_MINUTES / (24 * 60));
  
  -- Get all enabled BSL_IDs with stale reserved queue rows (STUCK_QUEUE_ROW_MINUTES)
  -- that failed due to "object no longer exists" error
  -- and have a gap of at least STUCK_QUEUE_ROW_GAP_MINUTES from the unreserved queue rows.
  cursor c_bsl_with_stuck_queue_rows is
  with 
    reserved as
      (select 
         bueq.BSL_ID,
         min(bueq.EVENT_DATE) min_event_date
       from BPM_LOGGING bl
       inner join BPM_UPDATE_EVENT_QUEUE bueq on 
         bl.LOG_DATE > sysdate - STUCK_QUEUE_ROW_LOOK_BACK_DAYS
         and bl.ERROR_NUMBER = -8103 -- object no longer exists error
         and bueq.BSL_ID = bl.BSL_ID
         and bueq.BIL_ID = bl.BIL_ID
         and bueq.IDENTIFIER = bl.IDENTIFIER
       where 
         bueq.PROCESS_BUEQ_ID is not null
         and bueq.WROTE_BPM_SEMANTIC_DATE is null
       group by bueq.BSL_ID),
    unreserved as
      (select 
         BSL_ID,
         min(EVENT_DATE) min_event_date
       from BPM_UPDATE_EVENT_QUEUE
       where 
         PROCESS_BUEQ_ID is null
         and WROTE_BPM_SEMANTIC_DATE is null
       group by BSL_ID),
    pbqjc as
      (select 
         BSL_ID,
         min(ENABLED) min_enabled
       from PROCESS_BPM_QUEUE_JOB_CONFIG
       group by BSL_ID)
  select reserved.BSL_ID
  from reserved
  left outer join unreserved on reserved.BSL_ID = unreserved.BSL_ID
  inner join pbqjc on reserved.BSL_ID = pbqjc.BSL_ID
  where 
    reserved.min_event_date < sysdate - (STUCK_QUEUE_ROW_MINUTES / (24 * 60))
    and nvl(unreserved.min_event_date,sysdate) - reserved.min_event_date > STUCK_QUEUE_ROW_GAP_MINUTES / (24 * 60)
    and pbqjc.min_enabled = 'Y';
  
  begin
  
    select count(*)
    into v_unarchived_queue_row_exists
    from dual
    where exists
      (select 1
       from BPM_UPDATE_EVENT_QUEUE
       where WROTE_BPM_SEMANTIC_DATE < sysdate - (UNARCHIVED_QUEUE_ROW_MINUTES / (24 * 60)));
  
    for r_bsl_with_stuck_queue_row in c_bsl_with_stuck_queue_rows
    loop
      v_stuck_queue_row_exists := 1;
      exit;  -- At least one BSL_ID has a stuck queue row.
    end loop;
    
    if v_unarchived_queue_row_exists = 1 or v_stuck_queue_row_exists = 1 then

      v_log_message := 'Stopping all queue jobs.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);
      
      STOP_ALL_JOBS;
      
      -- Archive queue rows that processed but failed to archive.
      if v_unarchived_queue_row_exists = 1 then
      
        for r_unarchived_queue_row in c_unarchived_queue_rows
        loop
        
          PROCESS_BPM_QUEUE.ARCHIVE_PROCESSED_ROW(r_unarchived_queue_row.BUEQ_ID);
          
          v_log_message := 'Archiving unarchived queue row that completed on ' || to_char(r_unarchived_queue_row.WROTE_BPM_SEMANTIC_DATE,BPM_COMMON.DATE_FMT) || '.';
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,r_unarchived_queue_row.BSL_ID,r_unarchived_queue_row.BIL_ID,r_unarchived_queue_row.IDENTIFIER,null,v_log_message,null);  
          
        end loop;
          
      end if;

      -- Reset stuck queue rows.
      if v_stuck_queue_row_exists = 1 then
      
        for r_bsl_with_stuck_queue_row in c_bsl_with_stuck_queue_rows
        loop
        
          MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(r_bsl_with_stuck_queue_row.BSL_ID);
          
          v_log_message := 'Attempting to fix stuck queue rows by resetting queue rows for BSL_ID = ' ||  to_char(r_bsl_with_stuck_queue_row.BSL_ID) || '.';
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,r_bsl_with_stuck_queue_row.BSL_ID,null,null,null,v_log_message,null);  
  
        end loop;
        
      end if;
 
      v_log_message := 'Starting all queue jobs.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);
      
      CREATE_ALL_JOBS;
        
    end if;
   
  end;
  

  -- Adjust number of active jobs.
  procedure ADJUST_ALL_JOBS
  as
    cursor c_bsl_id is
      select distinct BSL_ID
      from PROCESS_BPM_QUEUE_JOB_CONFIG
      where BSL_ID != DEFAULT_BSL_ID
      order by BSL_ID asc;
      
    cursor c_bdm_id is
      select distinct BDM_ID
      from PROCESS_BPM_QUEUE_JOB_CONFIG
      where BDM_ID != DEFAULT_BDM_ID
      order by BDM_ID asc;
      
    cursor c_calc_job_configs is
      select 
        pbcjc.PACKAGE_NAME,
        pbcjc.PROCEDURE_NAME,
        pbcjc.PROCESS_ENABLED,
        asj.JOB_NAME
      from PROCESS_BPM_CALC_JOB_CONFIG pbcjc
      left outer join USER_SCHEDULER_JOBS asj on (pbcjc.PROCEDURE_NAME = asj.JOB_NAME) 
      order by PBCJC_ID asc;
      
  begin
  
    -- BPM Queue jobs.
    FIX_JOBS;
    for v_bsl_id in c_bsl_id
    loop
      for v_bdm_id in c_bdm_id
      loop
        ADJUST_NUM_OF_JOBS(v_bsl_id.BSL_ID,v_bdm_id.BDM_ID);
      end loop;
    end loop;
    
    -- BPM Calc jobs.
    for r_calc_job_config in c_calc_job_configs
    loop
      if r_calc_job_config.PROCESS_ENABLED = 'Y' and r_calc_job_config.JOB_NAME is null then
        CREATE_CALC_JOB(r_calc_job_config.PACKAGE_NAME,r_calc_job_config.PROCEDURE_NAME);
      elsif r_calc_job_config.PROCESS_ENABLED = 'N' and r_calc_job_config.JOB_NAME is not null then
        STOP_JOB(r_calc_job_config.PROCEDURE_NAME);
      end if;
    end loop;
    
  end; 


  -- Create all jobs.
  procedure CREATE_ALL_JOBS
  as
  begin

    update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
    set PROCESSING_ENABLED = 'Y';
    
    commit;
    
    ADJUST_ALL_JOBS;

  end;
  
  
  -- Control job.
  procedure CONTROL_JOB
  as
    v_control_job_sleep_seconds number := null;
    v_prev_date_hour date := to_date(to_char(sysdate + (FIRST_FIX_QUEUE_ROWS_MINUTES / (60 * 24)),'YYYY-MM-DD HH24'),'YYYY-MM-DD HH24');
    v_current_date_hour date := null;
  begin

    CREATE_ALL_JOBS;
    
    while (true)
    loop
      
      select CONTROL_JOB_SLEEP_SECONDS
      into v_control_job_sleep_seconds
      from PROCESS_BPM_QUEUE_JOB_CTRL_CFG;
      
      user_lock.sleep(v_control_job_sleep_seconds * 100);
      
      ADJUST_ALL_JOBS;
      
      -- Check for stuck or unarchived queue rows about every hour.
      v_current_date_hour := to_date(to_char(sysdate,'YYYY-MM-DD HH24'),'YYYY-MM-DD HH24');
      if v_current_date_hour > v_prev_date_hour then
        FIX_QUEUE_ROWS;
      end if;
      v_prev_date_hour := v_current_date_hour;
              
    end loop;
  end;
  
  
  -- Control job.
  procedure CREATE_CONTROL_JOB
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_CONTROL_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
  begin

    dbms_scheduler.create_job (
      job_name   => CONTROL_JOB_NAME,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'begin PROCESS_BPM_QUEUE_JOB_CONTROL.CONTROL_JOB; end;',
      enabled    =>  TRUE,
      comments   => 'Control job to adjust BPM queue processor jobs.');
      
    dbms_scheduler.set_attribute(
      name => CONTROL_JOB_NAME,
      attribute => 'RESTARTABLE',
      value => TRUE);

    v_log_message := 'Created dbms_scheduler job "' || CONTROL_JOB_NAME || '".';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);
    
  exception
  
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to create dbms_scheduler job "' || CONTROL_JOB_NAME || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      raise;
  
  end;
  
  
  -- Create all calculation jobs.
  procedure CREATE_ALL_CALC_JOBS
  as
    cursor c_calc_job_configs is
      select 
        PACKAGE_NAME,
        PROCEDURE_NAME
      from PROCESS_BPM_CALC_JOB_CONFIG
      where PROCESS_ENABLED = 'Y'
      order by PBCJC_ID asc;
  begin
    
    for r_calc_job_config in c_calc_job_configs
    loop
      CREATE_CALC_JOB(r_calc_job_config.PACKAGE_NAME,r_calc_job_config.PROCEDURE_NAME);
    end loop;
    
  end;
  

  -- Set DBMS Scheduler default timezone.
  -- Requires MANAGE SCHEDULER privilege.
  -- Example: US/Eastern
  -- List of Oracle TIMEZONE_REGION: http://psoug.org/definition/TIMEZONE_REGION.htm
  procedure SET_SCHED_DEFAULT_TIMEZONE
    (p_timezone_region in varchar2)
  as
  begin
    DBMS_SCHEDULER.SET_SCHEDULER_ATTRIBUTE
      (ATTRIBUTE => 'DEFAULT_TIMEZONE',
       VALUE => p_timezone_region);
  end;


  -- Startup all jobs.
  procedure STARTUP_JOBS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'START_JOBS';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
    CREATE_CONTROL_JOB;
    CREATE_ALL_CALC_JOBS;
  end;
  
  
  -- Gracefully stop all calculation jobs.
  procedure STOP_ALL_CALC_JOBS
  as
    cursor c_calc_job_configs is
      select PACKAGE_NAME,PROCEDURE_NAME
      from PROCESS_BPM_CALC_JOB_CONFIG
      order by PBCJC_ID asc;
      
    v_job_name varchar2(61) := null;
  begin
    
    for r_calc_job_config in c_calc_job_configs
    loop
      STOP_JOB_AND_LOG(r_calc_job_config.PROCEDURE_NAME);
    end loop;
    
  end;
  
  
  -- Stop control job.
  procedure STOP_CONTROL_JOB
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_CONTROL_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
  begin  
    STOP_JOB_AND_LOG(CONTROL_JOB_NAME);     
  end;


  -- Shutdown all jobs.
  procedure SHUTDOWN_JOBS
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'SHUTDOWN_JOBS';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
    STOP_CONTROL_JOB;
    STOP_ALL_JOBS;
    FIX_JOBS;
    STOP_ALL_CALC_JOBS;
  end;


end;
/

commit;

alter session set plsql_code_type = interpreted;