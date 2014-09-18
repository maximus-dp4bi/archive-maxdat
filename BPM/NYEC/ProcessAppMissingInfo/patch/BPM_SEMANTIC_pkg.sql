alter session set plsql_code_type = native;

create or replace package BPM_SEMANTIC as

  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);
    
  procedure INSERT_BPM_SEMANTIC_CONV
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);
    
  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);
    
  procedure UPDATE_BPM_SEMANTIC_CONV
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);
    
  procedure UPDATE_BPM_QUEUE
    (p_bueq_id number);
    
  procedure UPDATE_BPM_QUEUE_CONV
    (p_bueq_id number);

end;
/

create or replace package body BPM_SEMANTIC as
  
  -- Insert BPM Semantic records.
  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_error_message clob := null;  
  begin
  
    if p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.NEW_DATA is null then
      v_error_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE.NEW_DATA record for IDENTIFIER value "' || p_bueq_row.IDENTIFIER || '".';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20015,v_error_message);   
    end if;
 
    if p_bueq_row.BSL_ID = 1 then 
      MANAGE_WORK.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 2 then 
      NYEC_PROCESS_APP.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 4 then 
      NYEC_PROCESS_APP_MI.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    /*
    elsif p_bueq_row.BSL_ID = 5 then 
      NYEC_PROCESS_MI.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 6 then 
      NYEC_INITIATE_RENEWAL.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 7 then 
      MYEC_PROCESS_STATE_REVIEW.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 8 then 
      NYEC_SEND_INFO_TP.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    */
    else
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20012,v_error_message);  
    end if;

    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID);
    
    commit;

  end;
  
  
  -- Insert BPM Semantic records from conversion queue.
  procedure INSERT_BPM_SEMANTIC_CONV
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC_CONV';
    v_error_message clob := null;  
  begin
  
    if p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.NEW_DATA is null then
      v_error_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE.NEW_DATA record for IDENTIFIER value "' || p_bueq_row.IDENTIFIER || '".';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20015,v_error_message);   
    end if;
 
    if p_bueq_row.BSL_ID = 1 then 
      MANAGE_WORK.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 2 then 
      NYEC_PROCESS_APP.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 4 then 
      NYEC_PROCESS_APP_MI.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    /*
    elsif p_bueq_row.BSL_ID = 5 then 
      NYEC_PROCESS_MI.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 6 then 
      NYEC_INITIATE_RENEWAL.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 7 then 
      MYEC_PROCESS_STATE_REVIEW.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 8 then 
      NYEC_SEND_INFO_TP.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    */
    else
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20012,v_error_message);  
    end if;

    UPDATE_BPM_QUEUE_CONV(p_bueq_row.BUEQ_ID);
    
    commit;

  end;
  
  
  -- Update BPM Semantic records.
  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
    v_error_message clob := null;   
  begin
  
    if p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.OLD_DATA is null or p_bueq_row.NEW_DATA is null then
      BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,null,null,null,null,'Cannot process update from queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA or .NEW_DATA record(s).');
      return;
    end if;
 
    if p_bueq_row.BSL_ID = 1 then 
      MANAGE_WORK.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 2 then 
      NYEC_PROCESS_APP.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 4 then 
      NYEC_PROCESS_APP_MI.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    /*
    elsif p_bueq_row.BSL_ID = 5 then 
      NYEC_PROCESS_MI.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 6 then 
      NYEC_INITIATE_RENEWAL.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 7 then 
      MYEC_PROCESS_STATE_REVIEW.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 8 then 
      NYEC_SEND_INFO_TP.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);*/
    else
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20012,v_error_message);  
    end if;

    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID);
    
    commit;

  end;
  
  
  -- Update BPM Semantic records from conversion queue.
  procedure UPDATE_BPM_SEMANTIC_CONV
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC_CONV';
    v_error_message clob := null;   
  begin
  
    if p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.OLD_DATA is null or p_bueq_row.NEW_DATA is null then
      BPM_COMMON.ERROR_MSG(sysdate,$$PLSQL_UNIT,null,null,null,null,'Cannot process update from queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA or .NEW_DATA record(s).');
      return;
    end if;
 
    if p_bueq_row.BSL_ID = 1 then 
      MANAGE_WORK.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 2 then 
      NYEC_PROCESS_APP.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 4 then 
      NYEC_PROCESS_APP_MI.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    /*
    elsif p_bueq_row.BSL_ID = 5 then 
      NYEC_PROCESS_MI.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 6 then 
      NYEC_INITIATE_RENEWAL.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 7 then 
      MYEC_PROCESS_STATE_REVIEW.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    elsif p_bueq_row.BSL_ID = 8 then 
      NYEC_SEND_INFO_TP.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    */
    else
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20012,v_error_message);  
    end if;

    UPDATE_BPM_QUEUE_CONV(p_bueq_row.BUEQ_ID);
    
    commit;

  end;
  
  
  -- Update queue with date data added to data model.
  procedure UPDATE_BPM_QUEUE
    (p_bueq_id number)
  as
    
  begin
    
    update BPM_UPDATE_EVENT_QUEUE
    set WROTE_BPM_SEMANTIC_DATE = sysdate
    where BUEQ_ID = p_bueq_id;
    
  end;


  -- Update conversion queue with date data added to data model.
  procedure UPDATE_BPM_QUEUE_CONV
    (p_bueq_id number)
  as
    
  begin
    
    update BPM_UPDATE_EVENT_QUEUE_CONV
    set WROTE_BPM_SEMANTIC_DATE = sysdate
    where BUEQ_ID = p_bueq_id;
    
  end;
  
end;
/

commit;

alter session set plsql_code_type = interpreted;