alter session set plsql_code_type = native;

create or replace package PROCESS_BPM_QUEUE as

  procedure PROCESS_ALL_ROWS_ALL_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_job_id number);

  procedure PROCESS_ALL_ROWS_BY_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_bsl_id in number,
     p_job_id number);

  -- No longer maintained.
  /*
  procedure PROCESS_CONV_ROWS_BY_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_bsl_id in number,
     p_job_id number);
  */
  
  procedure PROCESS_BATCH_ALL_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_job_id number);

  procedure PROCESS_BATCH_BY_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_bsl_id in number,
     p_job_id number);

  procedure RELEASE_QUEUE_ROW
    (p_bueq_id in number);

  -- No longer maintained.
  /*
  procedure RELEASE_QUEUE_ROW_CONV
    (p_bueq_id in number);
  */

end;
/


create or replace package body PROCESS_BPM_QUEUE as

  v_batch_sleep_seconds   number :=   1;
  v_process_sleep_seconds number := 120;

  v_data_model_name_bpm_event    varchar2(9)  := 'BPM_EVENT';
  v_data_model_num_bpm_event     number := 1;

  v_data_model_name_bpm_semantic varchar2(12) := 'BPM_SEMANTIC';
  v_data_model_num_bpm_semantic  number := 2;

  -- Handle Numbers can be anything unique.
  v_lock_handle_prefix number := 120000; -- random #
  v_conv_lock_handle  number  := v_lock_handle_prefix + 0; -- random #

  v_lock_timeout_seconds  number := 300;
  
  v_job_status_failed     varchar2(10) := 'FAILED';
  v_job_status_locking    varchar2(10) := 'LOCKING';
  v_job_status_processing varchar2(10) := 'PROCESSING';
  v_job_status_reserving  varchar2(10) := 'RESERVING';
  v_job_status_sleeping   varchar2(10) := 'SLEEPING';
  v_job_status_started    varchar2(10) := 'STARTED';
  v_job_status_stopped    varchar2(10) := 'STOPPED';


  -- Get data model name.
  function GET_DATA_MODEL_NAME (p_data_model_num number) return varchar2
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_DATA_MODEL_NAME';
    v_error_message clob := null;
    v_data_model_name varchar2(12) := null;
  begin
    case
      when p_data_model_num = v_data_model_num_bpm_event    then v_data_model_name := v_data_model_name_bpm_event;
      when p_data_model_num = v_data_model_num_bpm_semantic then v_data_model_name := v_data_model_name_bpm_semantic;
      else
        v_error_message := 'Unsupported data model number "' || p_data_model_num || '".';
        BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
        RAISE_APPLICATION_ERROR(-20023,v_error_message);
    end case;
    return v_data_model_name;
  end;
 
 
  -- Get data model number.
  function GET_BDM_ID (p_data_model_name varchar2) return number
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_BDM_ID';
    v_error_message clob := null;
    v_data_model_num number := null;
  begin
    case
      when p_data_model_name = v_data_model_name_bpm_event    then v_data_model_num := v_data_model_num_bpm_event;
      when p_data_model_name = v_data_model_name_bpm_semantic then v_data_model_num := v_data_model_num_bpm_semantic;
      else
        v_error_message := 'Unsupported data model name "' || p_data_model_name || '".';
        BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
        RAISE_APPLICATION_ERROR(-20023,v_error_message);
    end case;
    return v_data_model_num;
  end;
  
  
  -- Get lock handle number.
  function GET_LOCK_HANDLE_NUM
    (p_bsl_id number,
     p_data_model_num number) return number
  as
    v_lock_handle_num number := null;
  begin
    v_lock_handle_num := v_lock_handle_prefix + (nvl(p_bsl_id,0) * 10) + p_data_model_num;
    return v_lock_handle_num;
  end;


  --  Get release lock return status name.
  function GET_RELEASE_LOCK_STATUS_NAME (p_status integer) return varchar2
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
  function GET_REQUEST_LOCK_STATUS_NAME (p_status integer)  return varchar2
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
  
  
  -- Release a lock on the conversion queue.
  procedure RELEASE_CONV_LOCK
    (p_status out number)
  as
  begin
    p_status := user_lock.release(v_conv_lock_handle);
  end;


  -- Release a lock.
  procedure RELEASE_LOCK
    (p_bsl_id in number,
     p_data_model_num in number,
     p_status out number)
  as
  begin
    p_status := user_lock.release(GET_LOCK_HANDLE_NUM(p_bsl_id,p_data_model_num));
  end;


  -- Request a lock on the conversion queue.
  procedure REQUEST_CONV_LOCK
    (p_status out integer)
  as
    v_lock_mode number := 6; -- x_mode
  begin
    p_status := user_lock.request(v_conv_lock_handle,v_lock_mode,v_lock_timeout_seconds,user_lock.global);
  end;


  -- Request a lock.
  procedure REQUEST_LOCK
    (p_bsl_id in number,
     p_data_model_num in number,
     p_status out integer)
  as
    v_lock_mode number := 6; -- x_mode
  begin
    p_status := user_lock.request(GET_LOCK_HANDLE_NUM(p_bsl_id,p_data_model_num),v_lock_mode,v_lock_timeout_seconds,user_lock.global);
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
    select *
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID = p_bueq_id
      and WROTE_BPM_EVENT_DATE is not null
      and WROTE_BPM_SEMANTIC_DATE is not null;
    
    delete 
    from BPM_UPDATE_EVENT_QUEUE
    where 
      BUEQ_ID = p_bueq_id
      and WROTE_BPM_EVENT_DATE is not null
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


  -- Release row in conversion queue that was processed.
  -- No longer maintained.
  /*
  procedure RELEASE_QUEUE_ROW_CONV
    (p_bueq_id in number)
  as
  begin
    if p_bueq_id is null then
      return;
    end if;
    update BPM_UPDATE_EVENT_QUEUE_CONV
    set PROCESS_BUEQ_ID = null
    where BUEQ_ID = p_bueq_id;
    commit;
  end;
  */


  -- Mark rows in queue that are being processed to prevent conflicts.
  procedure RESERVE_QUEUE_ALL_BSL
    (p_batch_size in number,
     p_data_model_num in number,
     p_job_id in number,
     p_job_batch_id in number,
     p_process_bueq_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESERVE_QUEUE_ALL_BSL';
    v_error_message clob := null;
    v_num_rows_updated number := null;
    v_bsl_id number := null;
    v_status number := null;
    v_enabled varchar2(1) := null;
    
    cursor c_bpm_event_batch 
    is
    select bueq.BUEQ_ID
    from
      (select IDENTIFIER
       from 
         (select IDENTIFIER
          from BPM_UPDATE_EVENT_QUEUE
          where
            PROCESS_BUEQ_ID is null
            and WROTE_BPM_EVENT_DATE is null
            and WROTE_BPM_SEMANTIC_DATE is null
          order by 
            EVENT_DATE asc,
            BUEQ_ID asc)
      where rownum <= p_batch_size
      minus
      select distinct IDENTIFIER
      from BPM_UPDATE_EVENT_QUEUE
      where
        PROCESS_BUEQ_ID is not null
        and WROTE_BPM_EVENT_DATE is null
        and WROTE_BPM_SEMANTIC_DATE is null) available_identifiers,
      BPM_UPDATE_EVENT_QUEUE bueq
    where
      available_identifiers.IDENTIFIER = bueq.IDENTIFIER
      and bueq.PROCESS_BUEQ_ID is null
      and bueq.WROTE_BPM_EVENT_DATE is null
      and bueq.WROTE_BPM_SEMANTIC_DATE is null;

    cursor c_bpm_semantic_batch 
    is
    select bueq.BUEQ_ID
    from
      (select IDENTIFIER
       from 
         (select IDENTIFIER
          from BPM_UPDATE_EVENT_QUEUE
          where
            PROCESS_BUEQ_ID is null
            and WROTE_BPM_EVENT_DATE is not null
            and WROTE_BPM_SEMANTIC_DATE is null
          order by 
            EVENT_DATE asc,
            BUEQ_ID asc)
      where rownum <= p_batch_size
      minus
      select distinct IDENTIFIER
      from BPM_UPDATE_EVENT_QUEUE
      where
        PROCESS_BUEQ_ID is not null
        and WROTE_BPM_EVENT_DATE is not null
        and WROTE_BPM_SEMANTIC_DATE is null) available_identifiers,
      BPM_UPDATE_EVENT_QUEUE bueq
    where
      available_identifiers.IDENTIFIER = bueq.IDENTIFIER
      and bueq.PROCESS_BUEQ_ID is null
      and bueq.WROTE_BPM_EVENT_DATE is not null
      and bueq.WROTE_BPM_SEMANTIC_DATE is null;
    
  begin
  
    select ENABLED
    into v_enabled
    from PROCESS_BPM_QUEUE_JOB
    where PBQJ_ID = p_job_id;
    
    if v_enabled = 'N' then

      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = v_job_status_sleeping,
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
      STATUS = v_job_status_locking,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set 
      LOCKING_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;
    
    REQUEST_LOCK(v_bsl_id,p_data_model_num,v_status);
    if v_status != 0 then
      p_process_bueq_id := null;
      v_error_message := 'Unable to get lock to reserve queue rows.  '  || GET_REQUEST_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
      
      update PROCESS_BPM_QUEUE_JOB_BATCH
      set 
        LOCKING_END_DATE = sysdate,
        BATCH_END_DATE = sysdate,
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
        STATUS = v_job_status_sleeping,
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
      STATUS = v_job_status_reserving,
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
    if p_data_model_num = v_data_model_num_bpm_event then    
      for r_bpm_event_batch in c_bpm_event_batch
      loop
        update BPM_UPDATE_EVENT_QUEUE
        set PROCESS_BUEQ_ID = p_process_bueq_id
        where BUEQ_ID = r_bpm_event_batch.BUEQ_ID;
        v_num_rows_updated := v_num_rows_updated + 1;
      end loop;
    elsif p_data_model_num = v_data_model_num_bpm_semantic then
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
        STATUS = v_job_status_sleeping,
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

    RELEASE_LOCK(v_bsl_id,p_data_model_num,v_status);
    if v_status != 0 then
      v_error_message := 'Unable to release lock after reserving queue rows.  '  || GET_RELEASE_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
    end if;

    if v_num_rows_updated = 0 then
      p_process_bueq_id := null;
    end if;

  end;


  -- Mark rows for a BSL_ID in queue that are being processed to prevent conflicts.
  procedure RESERVE_QUEUE_BY_BSL
    (p_batch_size in number,
     p_data_model_num in number,
     p_bsl_id in number,
     p_job_id in number,
     p_job_batch_id in number,
     p_process_bueq_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESERVE_QUEUE_BY_BSL';
    v_error_message clob := null;
    v_num_rows_updated number := null;
    v_status number := null;
    v_enabled varchar2(1) := null;
    
    cursor c_bpm_event_batch 
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
            and WROTE_BPM_EVENT_DATE is null
            and WROTE_BPM_SEMANTIC_DATE is null
          order by 
            EVENT_DATE asc,
            BUEQ_ID asc)
       where rownum <= p_batch_size
       minus
       select distinct IDENTIFIER
       from BPM_UPDATE_EVENT_QUEUE
       where
         BSL_ID = p_bsl_id
         and PROCESS_BUEQ_ID is not null
         and WROTE_BPM_EVENT_DATE is null
         and WROTE_BPM_SEMANTIC_DATE is null) available_identifiers,
      BPM_UPDATE_EVENT_QUEUE bueq
    where
      available_identifiers.IDENTIFIER = bueq.IDENTIFIER
      and BSL_ID = p_bsl_id
      and bueq.PROCESS_BUEQ_ID is null
      and bueq.WROTE_BPM_EVENT_DATE is null
      and bueq.WROTE_BPM_SEMANTIC_DATE is null;

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
            and WROTE_BPM_EVENT_DATE is not null
            and WROTE_BPM_SEMANTIC_DATE is null
          order by 
            EVENT_DATE asc,
            BUEQ_ID asc)
      where rownum <= p_batch_size
      minus
      select distinct IDENTIFIER
      from BPM_UPDATE_EVENT_QUEUE
      where
        BSL_ID = p_bsl_id
        and PROCESS_BUEQ_ID is not null
        and WROTE_BPM_EVENT_DATE is not null
        and WROTE_BPM_SEMANTIC_DATE is null) available_identifiers,
      BPM_UPDATE_EVENT_QUEUE bueq
    where
      available_identifiers.IDENTIFIER = bueq.IDENTIFIER
      and BSL_ID = p_bsl_id
      and bueq.PROCESS_BUEQ_ID is null
      and bueq.WROTE_BPM_EVENT_DATE is not null
      and bueq.WROTE_BPM_SEMANTIC_DATE is null;
      
  begin

    select ENABLED
    into v_enabled
    from PROCESS_BPM_QUEUE_JOB
    where PBQJ_ID = p_job_id;
    
    if v_enabled = 'N' then

      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = v_job_status_sleeping,
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
      STATUS = v_job_status_locking,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set 
      LOCKING_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;
    
    REQUEST_LOCK(p_bsl_id,p_data_model_num,v_status);
    if v_status != 0 then
      p_process_bueq_id := null;
      v_error_message := 'Unable to get lock to reserve queue rows.  '  || GET_REQUEST_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);

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
        STATUS = v_job_status_sleeping,
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
      STATUS = v_job_status_reserving,
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
    if p_data_model_num = v_data_model_num_bpm_event then    
      for r_bpm_event_batch in c_bpm_event_batch
      loop
        update BPM_UPDATE_EVENT_QUEUE
        set PROCESS_BUEQ_ID = p_process_bueq_id
        where BUEQ_ID = r_bpm_event_batch.BUEQ_ID;
        v_num_rows_updated := v_num_rows_updated + 1;
      end loop;
    elsif p_data_model_num = v_data_model_num_bpm_semantic then
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
        STATUS = v_job_status_sleeping,
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

    RELEASE_LOCK(p_bsl_id,p_data_model_num,v_status);
    if v_status != 0 then
      v_error_message := 'Unable to release lock after reserving queue rows.  '  || GET_RELEASE_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
    end if;

    if v_num_rows_updated = 0 then
      p_process_bueq_id := null;
    end if;

  end;

  
  -- Mark rows for a BSL_ID in queue that are being processed to prevent conflicts for conversion queue.
  -- No longer maintained.
  /*
  procedure RESERVE_QUEUE_BY_BSL_CONV
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_bsl_id in number,
     p_job_id in number,
     p_job_batch_id in number,
     p_process_bueq_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RESERVE_QUEUE_BY_BSL_CONV';
    v_error_message clob := null;
    v_num_rows_updated number := null;
    v_status number := null;
    v_locking_end_date date := null;
    
    cursor c_bpm_semantic_batch_conv 
    is    
    select bueqc.BUEQ_ID
    from
      (select IDENTIFIER
       from 
         (select IDENTIFIER
          from BPM_UPDATE_EVENT_QUEUE_CONV
          where
            BSL_ID = p_bsl_id
            and PROCESS_BUEQ_ID is null
            and WROTE_BPM_EVENT_DATE is not null
            and WROTE_BPM_SEMANTIC_DATE is null
          order by 
            EVENT_DATE asc,
            BUEQ_ID asc)
       where rownum <= p_batch_size
       minus
       select distinct IDENTIFIER
       from BPM_UPDATE_EVENT_QUEUE_CONV
       where
         BSL_ID = p_bsl_id
         and PROCESS_BUEQ_ID is not null
         and WROTE_BPM_EVENT_DATE is not null
         and WROTE_BPM_SEMANTIC_DATE is null) available_identifiers,
      BPM_UPDATE_EVENT_QUEUE_CONV bueqc
    where
      available_identifiers.IDENTIFIER = bueqc.IDENTIFIER
      and bueqc.BSL_ID = p_bsl_id
      and bueqc.PROCESS_BUEQ_ID is null
      and bueqc.WROTE_BPM_EVENT_DATE is not null
      and bueqc.WROTE_BPM_SEMANTIC_DATE is null;
         
  begin

    if p_data_model_name != v_data_model_name_bpm_semantic then
      v_error_message := 'Unsupported data model "' || p_data_model_name || '".';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20023,v_error_message);
    end if;
    
    update PROCESS_BPM_QUEUE_JOB
    set 
      STATUS = v_job_status_locking,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      LOCKING_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;

    REQUEST_CONV_LOCK(v_status);
    if v_status != 0 then
      p_process_bueq_id := null;
      v_error_message := 'Unable to get lock to reserve queue rows.  '  || GET_REQUEST_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);

      update PROCESS_BPM_QUEUE_JOB_BATCH
      set
        LOCKING_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = p_job_batch_id;
      
      commit;
      
      return;
    end if;

    v_locking_end_date := sysdate;
    
    update PROCESS_BPM_QUEUE_JOB
    set 
      STATUS = v_job_status_reserving,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;

    p_process_bueq_id := SEQ_PROCESS_BUEQ_ID.nextval;

    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      PROCESS_BUEQ_ID = p_process_bueq_id,
      LOCKING_END_DATE = v_locking_end_date,
      RESERVE_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;

    v_num_rows_updated := 0;
    for r_bpm_semantic_batch_conv in c_bpm_semantic_batch_conv
    loop
      update BPM_UPDATE_EVENT_QUEUE
      set PROCESS_BUEQ_ID = p_process_bueq_id
      where BUEQ_ID = r_bpm_semantic_batch_conv.BUEQ_ID;
      v_num_rows_updated := v_num_rows_updated + 1;
    end loop;
    
    commit;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      NUM_QUEUE_ROWS_IN_BATCH = v_num_rows_updated, 
      RESERVE_END_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;

    commit;

    RELEASE_CONV_LOCK(v_status);
    if v_status != 0 then
      v_error_message := 'Unable to release lock after reserving queue rows.  '  || GET_RELEASE_LOCK_STATUS_NAME(v_status);
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
    end if;

    if v_num_rows_updated = 0 then
      p_process_bueq_id := null;
    end if;

  end;
  */

  -- Process reserved rows.
  procedure PROCESS_RESERVED_ROWS
    (p_data_model_num in number,
     p_job_id in number,
     p_job_batch_id in number,
     p_process_bueq_id in number)
  as 
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'PROCESS_RESERVED_ROWS';
    v_sql_code number := null;
    v_error_message clob := null;
    v_enabled varchar2(1) := null;
    v_prev_identifier number := null;
    v_block_identifier number := null;
    
    v_num_bpm_event_insert number := 0;
    v_num_bpm_semantic_insert number := 0;
    v_num_bpm_event_update number := 0;
    v_num_bpm_semantic_update number := 0;
          
  begin
  
    update PROCESS_BPM_QUEUE_JOB
    set 
      STATUS = v_job_status_processing,
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
          STATUS = v_job_status_sleeping,
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
            if p_data_model_num = v_data_model_num_bpm_event then
              BPM_EVENT.INSERT_BPM_EVENT(r_bueq_row);
              v_num_bpm_event_insert := v_num_bpm_event_insert + 1;
            elsif p_data_model_num = v_data_model_num_bpm_semantic then
              BPM_SEMANTIC.INSERT_BPM_SEMANTIC(r_bueq_row);
              v_num_bpm_semantic_insert := v_num_bpm_semantic_insert + 1;
            end if;
          elsif r_bueq_row.OLD_DATA is not null and r_bueq_row.NEW_DATA is not null then
            if p_data_model_num = v_data_model_num_bpm_event then
              BPM_EVENT.UPDATE_BPM_EVENT(r_bueq_row);
              v_num_bpm_event_update := v_num_bpm_event_update + 1;
            elsif p_data_model_num = v_data_model_num_bpm_semantic then
              BPM_SEMANTIC.UPDATE_BPM_SEMANTIC(r_bueq_row);
              v_num_bpm_semantic_update := v_num_bpm_semantic_update + 1;
            end if;
          else
            v_error_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA and NEW_DATA records.';
            BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,r_bueq_row.IDENTIFIER,null,null,null,v_error_message);
            RAISE_APPLICATION_ERROR(-20021,v_error_message);       
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
          
          if p_data_model_num = v_data_model_num_bpm_event then
            RELEASE_QUEUE_ROW(r_bueq_row.BUEQ_ID);  
          elsif p_data_model_num = v_data_model_num_bpm_semantic then
            ARCHIVE_PROCESSED_ROW(r_bueq_row.BUEQ_ID);
          end if;

        end if;
      exception
        when OTHERS then
          v_block_identifier := r_bueq_row.IDENTIFIER;
          v_sql_code := SQLCODE;
          v_error_message := SQLERRM;
          BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);    
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
      v_error_message := SQLERRM;
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);    
  end;

  -- Process reserved rows from conversion queue.
  -- No longer maintained.
  /*
  procedure PROCESS_RESERVED_ROWS_CONV
    (p_data_model_num in varchar2,
     p_job_id in number,
     p_job_batch_id in number,
     p_process_bueq_id in number)
  as 
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'PROCESS_RESERVED_ROWS_CONV';
    v_sql_code number := null;
    v_error_message clob := null;
    v_prev_identifier number := null;
    v_block_identifier number := null;
    
    v_num_bpm_semantic_insert number := 0;
    v_num_bpm_semantic_update number := 0;
    
  begin

    if p_data_model_num != v_data_model_num_bpm_semantic then
      v_error_message := 'Unsupported conv data model in ' || v_procedure_name || ' "' || GET_DATA_MODEL_NAME(p_data_model_num) || '".';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20023,v_error_message);
    end if;
    
    update PROCESS_BPM_QUEUE_JOB
    set 
      STATUS = v_job_status_processing,
      STATUS_DATE = sysdate
    where PBQJ_ID = p_job_id;

    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      PROC_XML_START_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;
    
    commit;

    for r_bueq_row in (
      select *
      from BPM_UPDATE_EVENT_QUEUE_CONV
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
            if p_data_model_num = v_data_model_num_bpm_semantic then
              BPM_SEMANTIC.INSERT_BPM_SEMANTIC_CONV(r_bueq_row);
              v_num_bpm_semantic_insert := v_num_bpm_semantic_insert + 1;
            end if;
          elsif r_bueq_row.OLD_DATA is not null and r_bueq_row.NEW_DATA is not null then
            if p_data_model_num = v_data_model_num_bpm_semantic then
              BPM_SEMANTIC.UPDATE_BPM_SEMANTIC_CONV(r_bueq_row);
              v_num_bpm_semantic_update := v_num_bpm_semantic_update + 1;
            end if;
          else
            v_error_message := 'Cannot process from conversion queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA and NEW_DATA records.';
            BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,r_bueq_row.IDENTIFIER,null,null,null,v_error_message);
            RAISE_APPLICATION_ERROR(-20022,v_error_message);       
          end if;

          update PROCESS_BPM_QUEUE_JOB_BATCH
          set
            NUM_BPM_SEMANTIC_INSERT = v_num_bpm_semantic_insert,
            NUM_BPM_SEMANTIC_UPDATE = v_num_bpm_semantic_update,
            STATUS_DATE = sysdate
          where PBQJB_ID = p_job_batch_id;
          
          v_prev_identifier := r_bueq_row.IDENTIFIER;
          RELEASE_QUEUE_ROW_CONV(r_bueq_row.BUEQ_ID);  

        end if;

      exception
        when OTHERS then
          v_block_identifier := r_bueq_row.IDENTIFIER;
          v_sql_code := SQLCODE;
          v_error_message := SQLERRM;
          BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);    
      end;
    end loop;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      PROC_XML_END_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = p_job_batch_id;

  exception
    when OTHERS then
      v_sql_code := SQLCODE;
      v_error_message := SQLERRM;
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
  end;
  */

  -- Process all unprocessed rows in the queue for all BSL_ID.
  procedure PROCESS_ALL_ROWS_ALL_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_job_id in number)
  as
    v_data_model_num number := null;
    v_pbqj_id number := null;
    v_pbqjb_id number := null;
    v_process_bueq_id number := null;
    v_batch_id number := 0;
    v_num_sleep_seconds number := 0;
  begin
    v_data_model_num := GET_BDM_ID(p_data_model_name);
  
    update PROCESS_BPM_QUEUE_JOB
    set
      BDM_ID = v_data_model_num,
      BATCH_SIZE = p_batch_size
    where PBQJ_ID = p_job_id;
    
    commit;
    
    while (true)
    loop
      v_pbqjb_id := SEQ_PBQJB_ID.nextval;
      v_batch_id := v_batch_id + 1;
      v_num_sleep_seconds := 0;
      
      insert into PROCESS_BPM_QUEUE_JOB_BATCH
        (PBQJB_ID,PBQJ_ID,BATCH_ID,BATCH_START_DATE,STATUS_DATE)
      values (v_pbqjb_id,p_job_id,v_batch_id,sysdate,sysdate);
      
      commit;
    
      RESERVE_QUEUE_ALL_BSL(p_batch_size,v_data_model_num,p_job_id,v_pbqjb_id,v_process_bueq_id);
      if v_process_bueq_id is null then
 
        update PROCESS_BPM_QUEUE_JOB_BATCH
        set
          BATCH_END_DATE = sysdate,
          STATUS_DATE = sysdate
        where PBQJB_ID = v_pbqjb_id;
        
        update PROCESS_BPM_QUEUE_JOB
        set 
          STATUS = v_job_status_sleeping,
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
        PROCESS_RESERVED_ROWS(v_data_model_num,p_job_id,v_pbqjb_id,v_process_bueq_id);
      end if;
      
      update PROCESS_BPM_QUEUE_JOB_BATCH
      set
        BATCH_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = v_pbqjb_id;
      
      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = v_job_status_sleeping,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;
      
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
  end;


  -- Process all unprocessed rows in the queue for a BSL_ID.
  procedure PROCESS_ALL_ROWS_BY_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_bsl_id in number,
     p_job_id in number)
  as
    v_data_model_num number := null;
    v_process_bueq_id number := null;
    v_pbqjb_id number := null;
    v_batch_id number := 0;
    v_num_sleep_seconds number := 0;
  begin
    v_data_model_num := GET_BDM_ID(p_data_model_name);
        
    update PROCESS_BPM_QUEUE_JOB
    set
      BSL_ID = p_bsl_id,
      BDM_ID = v_data_model_num,
      BATCH_SIZE = p_batch_size
    where PBQJ_ID = p_job_id;
    
    commit;
    
    while (true)
    loop
      v_pbqjb_id := SEQ_PBQJB_ID.nextval;
      v_batch_id := v_batch_id + 1;
      v_num_sleep_seconds := 0;
      
      insert into PROCESS_BPM_QUEUE_JOB_BATCH
        (PBQJB_ID,PBQJ_ID,BATCH_ID,BATCH_START_DATE,STATUS_DATE)
      values (v_pbqjb_id,p_job_id,v_batch_id,sysdate,sysdate);
      
      commit;
      
      RESERVE_QUEUE_BY_BSL(p_batch_size,v_data_model_num,p_bsl_id,p_job_id,v_pbqjb_id,v_process_bueq_id);
      if v_process_bueq_id is null then
      
        update PROCESS_BPM_QUEUE_JOB_BATCH
        set
          BATCH_END_DATE = sysdate,
          STATUS_DATE = sysdate
        where PBQJB_ID = v_pbqjb_id;
      
        update PROCESS_BPM_QUEUE_JOB
        set 
          STATUS = v_job_status_sleeping,
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
        PROCESS_RESERVED_ROWS(v_data_model_num,p_job_id,v_pbqjb_id,v_process_bueq_id);
      end if;
      
      update PROCESS_BPM_QUEUE_JOB_BATCH
      set
        BATCH_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = v_pbqjb_id;

/*
      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = v_job_status_sleeping,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;
*/      
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
  end;


  -- Process all unprocessed rows in the queue for a BSL_ID for conversion queue.
  -- No longer maintained.
  /*
  procedure PROCESS_CONV_ROWS_BY_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_bsl_id in number,
     p_job_id in number)
  as
    v_data_model_num number := null;
    v_process_bueq_id number := null;
    v_pbqjb_id number := null;
    v_batch_id number := 0;
    v_num_sleep_seconds number := 0;
  begin
    v_data_model_num := GET_BDM_ID(p_data_model_name);
  
    update PROCESS_BPM_QUEUE_JOB
    set
      BSL_ID = p_bsl_id,
      BDM_ID = v_data_model_num,
      BATCH_SIZE = p_batch_size
    where PBQJ_ID = p_job_id;
    
    commit;
    
    while (true)
    loop
      v_pbqjb_id := SEQ_PBQJB_ID.nextval;
      v_batch_id := v_batch_id + 1;
      v_num_sleep_seconds := 0;
      
      insert into PROCESS_BPM_QUEUE_JOB_BATCH
        (PBQJB_ID,PBQJ_ID,BATCH_ID,BATCH_START_DATE,STATUS_DATE)
      values (v_pbqjb_id,p_job_id,v_batch_id,sysdate,sysdate);
      
      commit;
      
      RESERVE_QUEUE_BY_BSL_CONV(p_batch_size,v_data_model_num,p_bsl_id,p_job_id,v_pbqjb_id,v_process_bueq_id);
      if v_process_bueq_id is null then
 
        update PROCESS_BPM_QUEUE_JOB_BATCH
        set
          BATCH_END_DATE = sysdate,
          STATUS_DATE = sysdate
        where PBQJB_ID = v_pbqjb_id;
        
        update PROCESS_BPM_QUEUE_JOB
        set 
          STATUS = v_job_status_sleeping,
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
        PROCESS_RESERVED_ROWS_CONV(v_data_model_num,p_job_id,v_pbqjb_id,v_process_bueq_id);
      end if;
      
      update PROCESS_BPM_QUEUE_JOB_BATCH
      set
        BATCH_END_DATE = sysdate,
        STATUS_DATE = sysdate
      where PBQJB_ID = v_pbqjb_id;

      update PROCESS_BPM_QUEUE_JOB
      set 
        STATUS = v_job_status_sleeping,
        STATUS_DATE = sysdate
      where PBQJ_ID = p_job_id;
      
      commit;
      
      user_lock.sleep(v_batch_sleep_seconds * 100);
      update PROCESS_BPM_QUEUE_JOB_BATCH
      set
        NUM_SLEEP_SECONDS = v_num_sleep_seconds,
        STATUS_DATE = sysdate
      where PBQJB_ID = v_pbqjb_id;
        
      commit;
      
    end loop;
  end;
  */

  -- Process a batch of unprocessed rows for all BSL_ID.
  procedure PROCESS_BATCH_ALL_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_job_id in number)
  as
    v_data_model_num number := null;
    v_process_bueq_id number := null;
    v_pbqjb_id number := null;
    v_batch_id number := 0;
  begin
    v_data_model_num := GET_BDM_ID(p_data_model_name);
      
    update PROCESS_BPM_QUEUE_JOB
    set BDM_ID = v_data_model_num
    where PBQJ_ID = p_job_id;
    
    v_pbqjb_id := SEQ_PBQJB_ID.nextval;
    v_batch_id := v_batch_id + 1;
      
    insert into PROCESS_BPM_QUEUE_JOB_BATCH
      (PBQJB_ID,PBQJ_ID,BATCH_ID,BATCH_START_DATE,STATUS_DATE)
    values (v_pbqjb_id,p_job_id,v_batch_id,sysdate,sysdate);
    
    commit;
    
    RESERVE_QUEUE_ALL_BSL(p_batch_size,v_data_model_num,p_job_id,v_pbqjb_id,v_process_bueq_id);
    if v_process_bueq_id is not null then
      PROCESS_RESERVED_ROWS(v_data_model_num,p_job_id,v_pbqjb_id,v_process_bueq_id);
    end if;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      BATCH_END_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = v_pbqjb_id;
    
    update PROCESS_BPM_QUEUE_JOB
    set END_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    commit;
      
  end;


  -- Process a batch in the queue for a BSL_ID.
  procedure PROCESS_BATCH_BY_BSL
    (p_batch_size in number,
     p_data_model_name in varchar2,
     p_bsl_id in number,
     p_job_id number)
  as
    v_data_model_num number := null;
    v_process_bueq_id number := null;
    v_pbqjb_id number := null;
    v_batch_id number := 0;
  begin
    v_data_model_num := GET_BDM_ID(p_data_model_name);

    update PROCESS_BPM_QUEUE_JOB
    set
      BSL_ID = p_bsl_id,
      BDM_ID = v_data_model_num
    where PBQJ_ID = p_job_id;

    v_pbqjb_id := SEQ_PBQJB_ID.nextval;
    v_batch_id := v_batch_id + 1;
      
    insert into PROCESS_BPM_QUEUE_JOB_BATCH
      (PBQJB_ID,PBQJ_ID,BATCH_ID,BATCH_START_DATE,STATUS_DATE)
    values (v_pbqjb_id,p_job_id,v_batch_id,sysdate,sysdate);
    
    commit;
    
    RESERVE_QUEUE_BY_BSL(p_batch_size,v_data_model_num,p_bsl_id,p_job_id,v_pbqjb_id,v_process_bueq_id);
    if v_process_bueq_id is not null then
      PROCESS_RESERVED_ROWS(v_data_model_num,p_job_id,v_pbqjb_id,v_process_bueq_id);
    end if;
    
    update PROCESS_BPM_QUEUE_JOB_BATCH
    set
      BATCH_END_DATE = sysdate,
      STATUS_DATE = sysdate
    where PBQJB_ID = v_pbqjb_id;
    
    update PROCESS_BPM_QUEUE_JOB
    set END_DATE = sysdate
    where PBQJ_ID = p_job_id;
    
    commit;
      
  end;

end;
/

commit;

alter session set plsql_code_type = interpreted;