CREATE OR REPLACE PACKAGE "PROCESS_BPM_QUEUE" as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/EventQueue/createdb/PROCESS_BPM_QUEUE_pkg.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 9742 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2014-04-25 16:22:08 -0600 (Fri, 25 Apr 2014) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';

  JOB_STATUS_FAILED     varchar2(10) := 'FAILED';
  JOB_STATUS_LOCKING    varchar2(10) := 'LOCKING';
  JOB_STATUS_PROCESSING varchar2(10) := 'PROCESSING';
  JOB_STATUS_RESERVING  varchar2(10) := 'RESERVING';
  JOB_STATUS_SLEEPING   varchar2(10) := 'SLEEPING';
  JOB_STATUS_STARTED    varchar2(10) := 'STARTED';
  JOB_STATUS_STOPPED    varchar2(10) := 'STOPPED';

  procedure PROCESS_ALL_ROWS_BY_BSL
    (p_bsl_id in number,
     p_bdm_id in number,
     p_batch_size in number,
     p_job_id in number);

  procedure RELEASE_QUEUE_ROW
    (p_bueq_id in number);

end;
/


CREATE OR REPLACE PACKAGE BODY "PROCESS_BPM_QUEUE" as

  v_batch_sleep_seconds   number :=   1;
  v_process_sleep_seconds number := 120;

  v_bdm_name_bpm_semantic varchar2(12) := 'BPM_SEMANTIC';
  v_bdm_num_bpm_semantic  number := 2;

  -- Handle Numbers can be anything unique.
  v_lock_handle_prefix number := 120000; -- random #

  v_lock_timeout_seconds  number := 300;
  

  -- Get data model name.
  function GET_DATA_MODEL_NAME (p_bdm_id number) 
  return varchar2 result_cache
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DATA_MODEL_NAME';
    v_log_message clob := null;
    v_error_number number := null;
    v_bdm_name varchar2(12) := null;
  begin
    if p_bdm_id = v_bdm_num_bpm_semantic then 
      v_bdm_name := v_bdm_name_bpm_semantic;
    else
      v_log_message := 'Unsupported data model number "' || p_bdm_id || '".';
      v_error_number := -20023;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,null);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
    end if;
    return v_bdm_name;
  end;
 
 
  -- Get data model number.
  function GET_BDM_ID (p_data_model_name varchar2) 
  return number result_cache
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_BDM_ID';
    v_log_message clob := null;
    v_bdm_num number := null;
    v_error_number number := null;
  begin
    if p_data_model_name = v_bdm_name_bpm_semantic then 
      v_bdm_num := v_bdm_num_bpm_semantic;
    else
      v_log_message := 'Unsupported data model name "' || p_data_model_name || '".';
      v_error_number := -20023;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
    end if;
    return v_bdm_num;
  end;
  
  
  -- Get lock handle number.
  function GET_LOCK_HANDLE_NUM
    (p_bsl_id number,
     p_bdm_id number) 
  return number result_cache
  as
    v_lock_handle_num number := null;
  begin
    v_lock_handle_num := v_lock_handle_prefix + (nvl(p_bsl_id,0) * 10) + p_bdm_id;
    return v_lock_handle_num;
  end;


  --  Get release lock return status name.
  function GET_RELEASE_LOCK_STATUS_NAME (p_status integer) 
  return varchar2 result_cache
  as
    v_status_name varchar2(40) := null;
  begin
    case
      when p_status = 0 then v_status_name := 'Success';
      when p_status = 3 then v_status_name := 'Parameter error.';
      when p_status = 4 then v_status_name := 'Does not own lock specified in lock handle.';
      when p_status = 5 then v_status_name := 'Illegal lock handle.';
      else v_status_name := 'Unexpected release lock return status "' || p_status || '".';
    end case;
    return v_status_name;
  end;


  --  Get request lock return status name.
  function GET_REQUEST_LOCK_STATUS_NAME (p_status integer)  
  return varchar2 result_cache
  as
    v_status_name varchar2(40) := null;
  begin
    case 
      when p_status = 0 then v_status_name := 'Success';
      when p_status = 1 then v_status_name := 'Timeout';
      when p_status = 2 then v_status_name := 'Deadlock';
      when p_status = 3 then v_status_name := 'Parameter error.';
      when p_status = 4 then v_status_name := 'Does not own lock specified in lock handle.';
      when p_status = 5 then v_status_name := 'Illegal lock handle.';
      else v_status_name := 'Unexpected request lock return status "' || p_status || '".';
    end case;
    return v_status_name;
  end;


  -- Release a lock.
  procedure RELEASE_LOCK
    (p_bsl_id in number,
     p_bdm_id in number,
     p_status out number)
  as
  begin
    p_status := user_lock.release(GET_LOCK_HANDLE_NUM(p_bsl_id,p_bdm_id));
  end;


  -- Request a lock.
  procedure REQUEST_LOCK
    (p_bsl_id in number,
     p_bdm_id in number,
     p_status out integer)
  as
    v_lock_mode number := 6; -- x_mode
  begin
    p_status := user_lock.request(GET_LOCK_HANDLE_NUM(p_bsl_id,p_bdm_id),v_lock_mode,v_lock_timeout_seconds,user_lock.global);
  end;


  -- Release row in archive queue that was processed.
  procedure RELEASE_QUEUE_ROW_ARCHIVE
    (p_bueq_id in number)
  as
  begin
    if p_bueq_id is null then
      return;
    end if;
    update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
    set PROCESS_BUEQ_ID = null
    where BUEQ_ID = p_bueq_id;
    commit;
  end;
  
  

  -- Archive row that has been processed successfully.
  procedure ARCHIVE_PROCESSED_ROW
    (p_bueq_id in number)
  as
  begin

    insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
      (BUEQ_ID,
       BSL_ID,
       BIL_ID,
       IDENTIFIER,
       EVENT_DATE,
       QUEUE_DATE,
       PROCESS_BUEQ_ID,
       WROTE_BPM_SEMANTIC_DATE,
       DATA_VERSION,
       OLD_DATA,
       NEW_DATA)
    select 
      BUEQ_ID,
      BSL_ID,
      BIL_ID,
      IDENTIFIER,
      EVENT_DATE,
      QUEUE_DATE,
      PROCESS_BUEQ_ID,
      WROTE_BPM_SEMANTIC_DATE,
      DATA_VERSION,
      OLD_DATA,
      NEW_DATA 
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID = p_bueq_id
      and WROTE_BPM_SEMANTIC_DATE is not null;
    
    delete 
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID = p_bueq_id
      and WROTE_BPM_SEMANTIC_DATE is not null;

    commit;

    RELEASE_QUEUE_ROW_ARCHIVE(p_bueq_id);

  end;


  -- Release row in queue that was processed.
  procedure RELEASE_QUEUE_ROW
    (p_bueq_id in number)
  as
  begin
    if p_bueq_id is null then
      return;
    end if;
    update BPM_UPDATE_EVENT_QUEUE
    set PROCESS_BUEQ_ID = null
    where BUEQ_ID = p_bueq_id;
    commit;
  end;


  -- Mark rows for a BSL_ID in queue that are being processed to prevent conflicts.
  procedure RESERVE_QUEUE_BY_BSL
    (p_batch_size in number,
     p_bdm_id in number,
     p_bsl_id in number,
     p_job_id in number,
     p_job_batch_id in number,
     p_process_bueq_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESERVE_QUEUE_BY_BSL';
    v_log_message clob := null;
    v_num_rows_updated number := null;
    v_status number := null;
    v_enabled varchar2(1) := null;
    
    cursor c_bpm_semantic_batch 
    is
    select bueq.BUEQ_ID
    from
      (select IDENTIFIER
       from 
         (select IDENTIFIER
          from BPM_UPDATE_EVENT_QUEUE
          where
            BSL_ID = p_bsl_id
            and PROCESS_BUEQ_ID is null
          order by EVENT_DATE asc)
      where rownum <= p_batch_size
      minus
      select distinct IDENTIFIER
      from BPM_UPDATE_EVENT_QUEUE
      where 
        BSL_ID = p_bsl_id
        and PROCESS_BUEQ_ID is not null) available_identifiers,
      BPM_UPDATE_EVENT_QUEUE bueq
    where
      available_identifiers.IDENTIFIER = bueq.IDENTIFIER
      and BSL_ID = p_bsl_id
      and bueq.PROCESS_BUEQ_ID is null;
      
  begin

    select ENABLED
    into v_enabled
    from PROCESS_BPM_QUEUE_JOB
    where PBQJ_ID = p_job_id;
    
    if v_enabled = 'N' then

      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = JOB_STATUS_SLEEPING,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;

      update PROCESS_BPM_QUEUE_JOB_BATCH
      set 
        BATCH_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = p_job_batch_id; 
    
      commit;
      
      return;
      
    end if;
    
    update PROCESS_BPM_QUEUE_JOB
    set 
      STATUS = JOB_STATUS_LOCKING,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set 
      LOCKING_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;
    
    REQUEST_LOCK(p_bsl_id,p_bdm_id,v_status);
    if v_status != 0 then
      p_process_bueq_id := null;
      v_log_message := 'Unable to get lock to reserve queue rows.  '  || GET_REQUEST_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,p_job_id,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);

      update PROCESS_BPM_QUEUE_JOB_BATCH
      set 
        LOCKING_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = p_job_batch_id;
      
      commit;
      
      return;
    end if;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      LOCKING_END_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;
    
    select ENABLED
    into v_enabled
    from PROCESS_BPM_QUEUE_JOB
    where PBQJ_ID = p_job_id;
    
    if v_enabled = 'N' then

      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = JOB_STATUS_SLEEPING,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;

      update PROCESS_BPM_QUEUE_JOB_BATCH
      set 
        BATCH_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = p_job_batch_id; 
    
      commit;
      
      return;
      
    end if;
    
    update PROCESS_BPM_QUEUE_JOB
    set 
      STATUS = JOB_STATUS_RESERVING,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    p_process_bueq_id := SEQ_PROCESS_BUEQ_ID.nextval;

    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      PROCESS_BUEQ_ID = p_process_bueq_id,
      RESERVE_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;
    
    v_num_rows_updated := 0;
    if p_bdm_id = v_bdm_num_bpm_semantic then
      for r_bpm_semantic_batch in c_bpm_semantic_batch
      loop
        update BPM_UPDATE_EVENT_QUEUE
        set PROCESS_BUEQ_ID = p_process_bueq_id
        where BUEQ_ID = r_bpm_semantic_batch.BUEQ_ID;
        v_num_rows_updated := v_num_rows_updated + 1;
      end loop;
    end if;
    
    commit;

    select ENABLED
    into v_enabled
    from PROCESS_BPM_QUEUE_JOB
    where PBQJ_ID = p_job_id;
    
    if v_enabled = 'N' then
 
      update BPM_UPDATE_EVENT_QUEUE
      set PROCESS_BUEQ_ID = null
      where PROCESS_BUEQ_ID = p_process_bueq_id;

      commit;

      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = JOB_STATUS_SLEEPING,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;

      update PROCESS_BPM_QUEUE_JOB_BATCH
      set 
        BATCH_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = p_job_batch_id;
    
      commit;
      
      return;
      
    end if;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      NUM_QUEUE_ROWS_IN_BATCH = v_num_rows_updated, 
      RESERVE_END_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;

    commit;

    RELEASE_LOCK(p_bsl_id,p_bdm_id,v_status);
    if v_status != 0 then
      v_log_message := 'Unable to release lock after reserving queue rows.  '  || GET_RELEASE_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,p_job_id,v_procedure_name,p_bsl_id,null,null,null,v_log_message,null);
    end if;

    if v_num_rows_updated = 0 then
      p_process_bueq_id := null;
    end if;

  end;
  

  -- Process reserved rows.
  procedure PROCESS_RESERVED_ROWS
    (p_bdm_id in number,
     p_job_id in number,
     p_job_batch_id in number,
     p_process_bueq_id in number)
  as 
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'PROCESS_RESERVED_ROWS';
    v_sql_code number := null;
    v_log_message clob := null;
    v_enabled varchar2(1) := null;
    v_prev_identifier varchar2(100) := null;
    v_block_identifier varchar2(100) := null;
    
    v_num_bpm_event_insert number := 0;
    v_num_bpm_semantic_insert number := 0;
    v_num_bpm_event_update number := 0;
    v_num_bpm_semantic_update number := 0;
    
    v_error_number number := null;
          
  begin
  
    update PROCESS_BPM_QUEUE_JOB
    set 
      STATUS = JOB_STATUS_PROCESSING,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;

    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      PROC_XML_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;
    
    v_prev_identifier := null;
    v_block_identifier := null;
    for r_bueq_row in (
      select *
      from BPM_UPDATE_EVENT_QUEUE
      where PROCESS_BUEQ_ID = p_process_bueq_id
      order by
        IDENTIFIER asc,
        case
          when OLD_DATA is null then 0
          else 1
          end asc,
        EVENT_DATE asc,
        BUEQ_ID asc)
    loop
    
      select ENABLED
      into v_enabled
      from PROCESS_BPM_QUEUE_JOB
      where PBQJ_ID = p_job_id;
    
      if v_enabled = 'N' then
      
        update BPM_UPDATE_EVENT_QUEUE
        set PROCESS_BUEQ_ID = null
        where PROCESS_BUEQ_ID = p_process_bueq_id;
        
        commit;

        update PROCESS_BPM_QUEUE_JOB
        set 
          STATUS = JOB_STATUS_SLEEPING,
          STATUS_DATE = sysdate
        where PBQJ_ID = p_job_id;

        update PROCESS_BPM_QUEUE_JOB_BATCH
        set 
          BATCH_END_DATE = sysdate,
          STATUS_DATE = sysdate
        where PBQJB_ID = p_job_batch_id; 
    
        commit;
      
        return;
      
      end if;
    
      begin
        -- Process rows, unless identifier has been blocked due to error.
        if v_prev_identifier is null 
          or r_bueq_row.IDENTIFIER != v_prev_identifier 
          or v_block_identifier is null 
          or r_bueq_row.IDENTIFIER != v_block_identifier then

          if r_bueq_row.IDENTIFIER != v_prev_identifier then
            v_block_identifier := null;
          end if;

          if r_bueq_row.OLD_DATA is null and r_bueq_row.NEW_DATA is not null then
            if p_bdm_id = v_bdm_num_bpm_semantic then
              BPM_SEMANTIC.INSERT_BPM_SEMANTIC(r_bueq_row);
              v_num_bpm_semantic_insert := v_num_bpm_semantic_insert + 1;
            end if;
          elsif r_bueq_row.OLD_DATA is not null and r_bueq_row.NEW_DATA is not null then
            if p_bdm_id = v_bdm_num_bpm_semantic then
              BPM_SEMANTIC.UPDATE_BPM_SEMANTIC(r_bueq_row);
              v_num_bpm_semantic_update := v_num_bpm_semantic_update + 1;
            end if;
          else
            v_log_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA and NEW_DATA records.';
            v_error_number := -20021;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,p_job_id,v_procedure_name,r_bueq_row.BSL_ID,r_bueq_row.BIL_ID,r_bueq_row.IDENTIFIER,null,v_log_message,null);
            RAISE_APPLICATION_ERROR(v_error_number,v_log_message);       
          end if;
          
          update PROCESS_BPM_QUEUE_JOB_BATCH
          set
            NUM_BPM_EVENT_INSERT = v_num_bpm_event_insert,
            NUM_BPM_EVENT_UPDATE = v_num_bpm_event_update,
            NUM_BPM_SEMANTIC_INSERT = v_num_bpm_semantic_insert,
            NUM_BPM_SEMANTIC_UPDATE = v_num_bpm_semantic_update,
            STATUS_DATE = sysdate
          where PBQJB_ID = p_job_batch_id;

          v_prev_identifier := r_bueq_row.IDENTIFIER;
          
          if p_bdm_id = v_bdm_num_bpm_semantic then
            ARCHIVE_PROCESSED_ROW(r_bueq_row.BUEQ_ID);
          end if;

        end if;
        
      exception
      
        when OTHERS then
          v_block_identifier := r_bueq_row.IDENTIFIER;
          v_sql_code := SQLCODE;
          v_log_message := SQLERRM;
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,p_job_id,v_procedure_name,r_bueq_row.BSL_ID,r_bueq_row.BIL_ID,r_bueq_row.IDENTIFIER,null,v_log_message,v_sql_code);   
      end;
      
    end loop;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      PROC_XML_END_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;
    
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,p_job_id,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);   

  end;


  -- Process all unprocessed rows in the queue for a BSL_ID.
  procedure PROCESS_ALL_ROWS_BY_BSL
    (p_bsl_id in number,
     p_bdm_id in number,
     p_batch_size in number,
     p_job_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'PROCESS_ALL_ROWS_BY_BSL';
    v_log_message clob := null;
    v_sql_code number := null;
    v_bdm_num number := null;
    v_process_bueq_id number := null;
    v_pbqjb_id number := null;
    v_batch_id number := 0;
    v_num_sleep_seconds number := 0;
  begin
    
    while (true)
    loop
      v_pbqjb_id := SEQ_PBQJB_ID.nextval;
      v_batch_id := v_batch_id + 1;
      v_num_sleep_seconds := 0;
      
      insert into PROCESS_BPM_QUEUE_JOB_BATCH
        (PBQJB_ID,PBQJ_ID,BATCH_ID,BATCH_START_DATE,STATUS_DATE)
      values (v_pbqjb_id,p_job_id,v_batch_id,sysdate,sysdate);
      
      commit;
      
      RESERVE_QUEUE_BY_BSL(p_batch_size,p_bdm_id,p_bsl_id,p_job_id,v_pbqjb_id,v_process_bueq_id);
      if v_process_bueq_id is null then
      
        update PROCESS_BPM_QUEUE_JOB_BATCH
        set
          BATCH_END_DATE = sysdate,
          STATUS_DATE = sysdate
        where PBQJB_ID = v_pbqjb_id;
      
        update PROCESS_BPM_QUEUE_JOB
        set 
          STATUS = JOB_STATUS_SLEEPING,
          STATUS_DATE = sysdate
        where PBQJ_ID = p_job_id;
        
        commit;
        
        user_lock.sleep(v_process_sleep_seconds * 100);
        v_num_sleep_seconds := v_num_sleep_seconds + v_process_sleep_seconds;
        
        update PROCESS_BPM_QUEUE_JOB_BATCH
        set
          NUM_SLEEP_SECONDS = v_num_sleep_seconds,
          STATUS_DATE = sysdate
        where PBQJB_ID = v_pbqjb_id;
        
        commit;
        
      else
        PROCESS_RESERVED_ROWS(p_bdm_id,p_job_id,v_pbqjb_id,v_process_bueq_id);
      end if;
      
      update PROCESS_BPM_QUEUE_JOB_BATCH
      set
        BATCH_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = v_pbqjb_id;
      commit;
      
      user_lock.sleep(v_batch_sleep_seconds * 100);
      v_num_sleep_seconds := v_num_sleep_seconds + v_batch_sleep_seconds;
      
      update PROCESS_BPM_QUEUE_JOB_BATCH
      set
        NUM_SLEEP_SECONDS = v_num_sleep_seconds,
        STATUS_DATE = sysdate
      where PBQJB_ID = v_pbqjb_id;

      commit;
        
    end loop;
    
  exception
  
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,p_job_id,v_procedure_name,p_bsl_id,null,null,null,v_log_message,v_sql_code);
      raise;
       
  end;

end;
/
