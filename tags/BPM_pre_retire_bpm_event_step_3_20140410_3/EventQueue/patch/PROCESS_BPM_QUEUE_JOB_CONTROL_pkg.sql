alter session set plsql_code_type = native;

/* Procedures to control, create, adjust and stop PROCESS_BPM_QUEUE batch jobs. */

/* 
  Configuration precedence: (highest to lowest)
  
    PROCESS_BPM_QUEUE_JOB_CONFIG(BSL_ID,BDM_ID)
    PROCESS_BPM_QUEUE_JOB_CONFIG(BSL_ID,v_default_bsl_id hardcoded below)
    PROCESS_BPM_QUEUE_JOB_CONFIG(v_default_bdm_id hardcoded below,BDM_ID)
    PROCESS_BPM_QUEUE_JOB_CONFIG(v_default_bsl_id hardcoded below,v_default_bdm_id hardcoded below)
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

  procedure ADJUST_ALL_JOBS;
  
  procedure ADJUST_NUM_OF_JOBS
    (p_bsl_id in number,
     p_bdm_id in number);
     
  procedure CONTROL_JOB;
     
  procedure CREATE_ALL_JOBS;
  
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

  -- PROCESS_BPM_QUEUE_JOB.STATUS codes
  v_job_status_failed     varchar2(10) := 'FAILED';
  v_job_status_locking    varchar2(10) := 'LOCKING';
  v_job_status_processing varchar2(10) := 'PROCESSING';
  v_job_status_reserving  varchar2(10) := 'RESERVING';
  v_job_status_sleeping   varchar2(10) := 'SLEEPING';
  v_job_status_started    varchar2(10) := 'STARTED';
  v_job_status_stopped    varchar2(10) := 'STOPPED';
  
  -- IDs specifying default values.
  v_default_bsl_id number := 0;
  v_default_bdm_id number := 0;
  
  -- PBQJ_ADJUST_REASON_LKUP.PBQJ_ADJUST_REASON_ID IDs
  v_start_all_proc_enabled     number := 101;
  v_start_bsl_bdm_proc_enabled number := 102;
  v_start_manual               number := 103;
  v_start_too_few_jobs         number := 111;
  v_start_work_backlog         number := 130;
  v_stop_all_proc_disabled     number := 201;
  v_stop_bsl_bdm_proc_disabled number := 202;
  v_stop_manual                number := 203;
  v_stop_too_many_total_jobs   number := 210;
  v_stop_too_many_jobs         number := 211;
  v_stop_sleeping              number := 220;
  
  v_control_job_name varchar2(30) := 'PROCESS_BPM_QUEUE_CONTROL';

 
  -- Create and start scheduler job for PROCESS_BPM_QUEUE process.
  procedure CREATE_JOB
    (p_process_action in varchar2,
     p_process_param in varchar2,
     p_start_reason_id in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_JOB';
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
    v_job_action := 'begin PROCESS_BPM_QUEUE.' || p_process_action || '(' || p_process_param || ',' || v_job_id || '); end;';
    dbms_scheduler.create_job (
      job_name   => v_job_name,
      job_type   => 'PLSQL_BLOCK',
      job_action => v_job_action,
      enabled    =>  TRUE,
      comments   => 'Process BPM_UPDATE_EVENT_QUEUE and write data to data models.');

    dbms_output.put_line('Created dbms_scheduler job "' || v_job_name || '" with job action "' || v_job_action || '".');

    insert into PROCESS_BPM_QUEUE_JOB
      (PBQJ_ID,JOB_NAME,START_DATE,STATUS,STATUS_DATE,ENABLED,START_REASON_ID)
    values (v_job_id,v_job_name,sysdate,v_job_status_started,sysdate,'Y',p_start_reason_id);
    
    commit;

  end;
  
  
   -- Create and start scheduler job for PROCESS_BPM_QUEUE process (no reason ID).
  procedure CREATE_JOB
    (p_process_action in varchar2,
     p_process_param in varchar2)
  as
  begin
    CREATE_JOB(p_process_action,p_process_param,v_start_manual);
  end;
  

  -- Create and start scheduler job for a ROCESS_ALL_ROWS_BY_BSL process.
  procedure CREATE_PROCESS_ALL_ROWS_BY_BSL
    (p_bsl_id in number,
     p_bdm_id in number,
     p_batch_size in number,
     p_start_reason_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_PROCESS_ALL_ROWS_BY_BSL';
    v_error_message  clob := null;
    v_process_param varchar2(200) := null;
    v_data_model_name varchar2(12) := null;
  begin
    if p_bdm_id = 1 then
      v_data_model_name := 'BPM_EVENT';
    elsif p_bdm_id = 2 then
      v_data_model_name := 'BPM_SEMANTIC';
    else
      v_error_message := 'Unsupported data model number "' || p_bdm_id || '".';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20023,v_error_message);
    end if;
    v_process_param := to_char(p_batch_size) || ',''' || v_data_model_name || ''',' || to_char(p_bsl_id);
    CREATE_JOB('PROCESS_ALL_ROWS_BY_BSL',v_process_param,p_start_reason_id);
  end;
  

  -- Gracefully stop and drop scheduler job by job ID.
  procedure STOP_JOB_BY_ID
    (p_job_id in number,
     p_stop_reason_id number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_JOB_BY_ID';
    v_error_message clob := null;
    v_stop_delay_seconds number := null;
    v_job_name varchar2(30) := null;
    v_job_status varchar2(10) := null;
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
    
    -- Delay so that job has time to stop current work cleanly.
    user_lock.sleep(v_stop_delay_seconds * 100);
    
    select 
      JOB_NAME,
      STATUS
    into 
      v_job_name,
      v_job_status
    from PROCESS_BPM_QUEUE_JOB
    where PBQJ_ID = p_job_id;
    
    if v_job_name is null then 
      v_error_message := 'Job ID ' || p_job_id || ' not found.   Cannot stop job.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
      return;
    end if;
    
    if v_job_status != v_job_status_sleeping then
      v_error_message := 'Stopped job ID ' || p_job_id || ' when status was ' || v_job_status || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);    
    end if;
  
    begin
      dbms_scheduler.drop_job(v_job_name,TRUE);
    
      update PROCESS_BPM_QUEUE_JOB
      set
        END_DATE = sysdate,
        STATUS = v_job_status_stopped,
        STOP_REASON_ID = p_stop_reason_id,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;
    
      commit;
      
    exception
      when others then
        v_error_message := 'Exception when stopping job ID ' || p_job_id || '.';
        dbms_output.put_line(v_error_message);
        BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
    end;
    
  end;
  
  
  -- Gracefully stop and drop scheduler job by job ID.
  procedure STOP_JOB_BY_ID
    (p_job_id in number)
  as
  begin
    STOP_JOB_BY_ID(p_job_id,v_stop_manual);
  end;


  -- Gracefully stop and drop scheduler job by job name.
  procedure STOP_JOB_BY_NAME
    (p_job_name in varchar2,
     p_stop_reason_id number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_JOB_BY_NAME';
    v_error_message clob := null;
    v_stop_delay_seconds number := null;
    v_job_id number;
  begin
    
    select PBQJ_ID
    into v_job_id
    from PROCESS_BPM_QUEUE_JOB
    where JOB_NAME = p_job_name;
    
    if v_job_id is null then 
      v_error_message := 'Job ' || p_job_name || ' not found.   Cannot stop job.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
      return;
    end if;
    
    STOP_JOB_BY_ID(v_job_id,p_stop_reason_id);
    
  end;
  
  
  -- Gracefully stop and drop scheduler job by job name (no reason ID).
  procedure STOP_JOB
    (p_job_name in varchar2)
  as
  begin
    STOP_JOB_BY_NAME(p_job_name,v_stop_manual);
  end;


  -- Gracefully stop all jobs.
  procedure STOP_ALL_JOBS
  as
    cursor c_job_id is
      select PBQJ_ID
      from PROCESS_BPM_QUEUE_JOB
      where STATUS not in ('FAILED','STOPPED')
      order by PBQJ_ID asc;
  begin
    update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
    set PROCESSING_ENABLED = 'N';
    
    commit;
    
    for i in c_job_id
    loop
      STOP_JOB_BY_ID(i.PBQJ_ID,v_stop_all_proc_disabled);
    end loop;
  end;

 
  -- Adjust number of active jobs by source and data model ID.
  procedure ADJUST_NUM_OF_JOBS
    (p_bsl_id in number,
     p_bdm_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'ADJUST_NUM_JOBS';
    v_sql_code number := null;
    v_error_message clob := null;
    
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
        and STATUS not in ('FAILED','STOPPED');
        
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
          and STATUS not in ('FAILED','STOPPED'))
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
        STOP_JOB_BY_ID(r_running_job.PBQJ_ID,v_stop_all_proc_disabled);
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
        STOP_JOB_BY_ID(r_running_job.PBQJ_ID,v_stop_bsl_bdm_proc_disabled);
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
          and BDM_ID = v_default_bdm_id;
          
      exception
        when NO_DATA_FOUND then
          null;
          
        when OTHERS then
          v_sql_code := SQLCODE;
          v_error_message := SQLERRM;
          BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,v_sql_code,v_error_message);
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
            BSL_ID = v_default_bsl_id
            and BDM_ID = p_bdm_id;
          
        exception
        
          when NO_DATA_FOUND then
            null;
          
          when OTHERS then
            v_sql_code := SQLCODE;
            v_error_message := SQLERRM;
            BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,v_sql_code,v_error_message);
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
              BSL_ID = v_default_bsl_id
              and BDM_ID = v_default_bdm_id;
          
          exception
        
            when NO_DATA_FOUND then
              null;
          
            when OTHERS then
              v_sql_code := SQLCODE;
              v_error_message := SQLERRM;
              BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,v_sql_code,v_error_message);
              raise;
        
          end;
          
        end if;
        
      end if;
      
    end if;
    
    -- Get minimum number of jobs for this source and data model ID.
    v_min_num_jobs := coalesce(v_min_num_jobs,v_default_bsl_min_num_jobs,v_default_bdm_min_num_jobs,v_default_min_num_jobs);
    if v_min_num_jobs is null then
      v_error_message := 'Null MIN_NUM_JOBS config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);      
      return;
    end if;
    
    -- Get initial number of jobs for this source and data model ID.
    v_init_num_jobs := coalesce(v_init_num_jobs,v_default_bsl_init_num_jobs,v_default_bdm_init_num_jobs,v_default_init_num_jobs);
    if v_init_num_jobs is null then
      v_error_message := 'Null INIT_NUM_JOBS config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);      
      return;
    end if;

    -- Get maximum number of jobs for this source and data model ID.
    v_max_num_jobs := coalesce(v_max_num_jobs,v_default_bsl_max_num_jobs,v_default_bdm_max_num_jobs,v_default_max_num_jobs);
    if v_max_num_jobs is null then
      v_error_message := 'Null MAX_NUM_JOBS config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);      
      return;
    end if;
 
    -- Get batch size for this source and data model ID.
    v_batch_size := coalesce(v_batch_size,v_default_bsl_batch_size,v_default_bdm_batch_size,v_default_batch_size);
    if v_batch_size is null then
      v_error_message := 'Null BATCH_SIZE config value.  Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);      
      return;
    end if;

    -- Get number of jobs running for this source and data model ID.
    select count(*)
    into v_num_jobs
    from PROCESS_BPM_QUEUE_JOB
    where 
      BSL_ID = p_bsl_id
      and BDM_ID = p_bdm_id
      and STATUS not in ('FAILED','STOPPED');
    
    -- Initialize number of jobs running when no jobs are running and some jobs are allowd.
    -- Should be the case after restart.
    if v_num_jobs = 0 and v_config_enabled = 'Y' and v_min_num_jobs > 0 and v_init_num_jobs > 0 and v_max_num_jobs > 0 then
      for i in 1..v_init_num_jobs
      loop
        CREATE_PROCESS_ALL_ROWS_BY_BSL(p_bsl_id,p_bdm_id,v_batch_size,v_start_bsl_bdm_proc_enabled);        
      end loop;
      return;
    end if;
    
    -- Stop extra jobs if too many jobs running for this source and data model ID.
    if v_num_jobs > v_max_num_jobs then
      v_num_jobs_to_stop := v_num_jobs - v_max_num_jobs;
      for r_running_job in c_running_jobs_by_status
      loop
        STOP_JOB_BY_ID(r_running_job.PBQJ_ID,v_stop_too_many_jobs);
        v_num_jobs_to_stop := v_num_jobs_to_stop - 1;
        v_num_jobs := v_num_jobs - 1;
        exit when v_num_jobs_to_stop = 0;
      end loop;
    end if;
   
    -- Stop some sleeping for this source and data model ID.
    if v_num_jobs_to_add_during_adj > 0 and v_num_jobs > v_min_num_jobs then
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
          STOP_JOB_BY_ID(r_sleeping_job.PBQJ_ID,v_stop_sleeping);
          v_num_jobs := v_num_jobs - 1;
        end loop;
        
        -- Don't add jobs later during adjust if some were sleeping.
        return;
        
      end if;
      
    end if;
    
    -- Start jobs. --
    
    if v_num_jobs < v_min_num_jobs then
      v_num_jobs_to_start := v_min_num_jobs - v_num_jobs; 
      if v_num_jobs_to_start > 0 then
        for i in 1..v_num_jobs_to_start
        loop
          CREATE_PROCESS_ALL_ROWS_BY_BSL(p_bsl_id,p_bdm_id,v_batch_size,v_start_too_few_jobs);
          v_num_jobs := v_num_jobs + 1;
        end loop;
      end if;
    end if;
 
    -- Get number of identifiers that remain to be reserved and processed for this source and data model ID.
    
    if v_num_jobs_to_add_during_adj <= 0 then
      return;
    end if;
    
    if p_bdm_id = 1 then
      select count(distinct IDENTIFIER)
      into v_num_unreserved_identifiers
      from BPM_UPDATE_EVENT_QUEUE
      where
        BSL_ID = p_bsl_id
        and PROCESS_BUEQ_ID is null
        and WROTE_BPM_EVENT_DATE is null
        and WROTE_BPM_SEMANTIC_DATE is null;
    elsif p_bdm_id = 2 then
      select count(distinct IDENTIFIER)
      into v_num_unreserved_identifiers
      from BPM_UPDATE_EVENT_QUEUE
      where
        BSL_ID = p_bsl_id
        and PROCESS_BUEQ_ID is null
        and WROTE_BPM_EVENT_DATE is not null
        and WROTE_BPM_SEMANTIC_DATE is null;   
    else
      v_error_message := 'Unsupported BDM_ID ' || p_bdm_id || '   Cannot adjust number of BPM processor jobs.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);      
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
      where STATUS not in ('FAILED','STOPPED');
    
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
                  CREATE_PROCESS_ALL_ROWS_BY_BSL(p_bsl_id,p_bdm_id,v_batch_size,v_start_work_backlog);
                end loop;
              end if;
            end if;
          end if;
        end if;
      end if;
      
    end if;

  end;
  

  -- Adjust number of active jobs.
  procedure ADJUST_ALL_JOBS
  as
    cursor c_bsl_id is
      select distinct BSL_ID
      from PROCESS_BPM_QUEUE_JOB_CONFIG
      where BSL_ID != v_default_bsl_id
      order by BSL_ID asc;
      
    cursor c_bdm_id is
      select distinct BDM_ID
      from PROCESS_BPM_QUEUE_JOB_CONFIG
      where BDM_ID != v_default_bdm_id
      order by BDM_ID asc;
  begin
    for v_bsl_id in c_bsl_id
    loop
      for v_bdm_id in c_bdm_id
      loop
        ADJUST_NUM_OF_JOBS(v_bsl_id.BSL_ID,v_bdm_id.BDM_ID);
      end loop;
    end loop;
  end; 


  -- Create all jobs.
  procedure CREATE_ALL_JOBS
  as
  begin

    update PROCESS_BPM_QUEUE_JOB_CTRL_CFG
    set PROCESSING_ENABLED = 'Y';
    
    commit;
    
    ADJUST_ALL_JOBS ();

  end;
  
  
  -- Control job.
  procedure CONTROL_JOB
  as
    v_control_job_sleep_seconds number := null;
  begin

    CREATE_ALL_JOBS;
    
    while (true)
    loop
      
      select CONTROL_JOB_SLEEP_SECONDS
      into v_control_job_sleep_seconds
      from PROCESS_BPM_QUEUE_JOB_CTRL_CFG;
      
      user_lock.sleep(v_control_job_sleep_seconds * 100);
      
      ADJUST_ALL_JOBS ();
              
    end loop;
  end;
  
  -- Control job.
  procedure CREATE_CONTROL_JOB
  as
  begin

    dbms_scheduler.create_job (
      job_name   => v_control_job_name,
      job_type   => 'PLSQL_BLOCK',
      job_action => 'begin PROCESS_BPM_QUEUE_JOB_CONTROL.CONTROL_JOB; end;',
      enabled    =>  TRUE,
      comments   => 'Control job to adjust BPM queue processor jobs.');
      
    dbms_scheduler.set_attribute(
      name => v_control_job_name,
      attribute => 'RESTARTABLE',
      value => TRUE);

    dbms_output.put_line('Created dbms_scheduler job "' || v_control_job_name || '".');
  
  end;

  -- Stop control job.
  procedure STOP_CONTROL_JOB
  as
  begin
    dbms_scheduler.drop_job(v_control_job_name,TRUE);
  end;
  
end;
/

commit;

alter session set plsql_code_type = interpreted;