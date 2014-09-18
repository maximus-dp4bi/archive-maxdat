alter session set plsql_code_type = native;

create or replace package BPM_SEMANTIC as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BPM_QUEUE
    (p_bueq_id number);
  
end;
/


create or replace package body BPM_SEMANTIC as
  
  -- Insert BPM Semantic records.
  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_log_message clob := null;
    v_error_number number := null;
  begin
  
    if p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.NEW_DATA is null then
      v_log_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE.NEW_DATA record for IDENTIFIER value "' || p_bueq_row.IDENTIFIER || '".';
      v_error_number := -20015;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,null,v_log_message,null);
      RAISE_APPLICATION_ERROR(v_error_number ,v_log_message);   
    end if;
 
    BPM_SEMANTIC_PROJECT.INSERT_BPM_SEMANTIC(p_bueq_row);
    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID);
    
    commit;

  end;
  
  
  -- Update BPM Semantic records.
  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
    v_log_message clob := null;
  begin
  
    if p_bueq_row.WROTE_BPM_SEMANTIC_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.OLD_DATA is null or p_bueq_row.NEW_DATA is null then
      v_log_message := 'Cannot process update from queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA or .NEW_DATA record(s).';
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,null,v_log_message,null);
      return;
    end if;

    BPM_SEMANTIC_PROJECT.UPDATE_BPM_SEMANTIC(p_bueq_row);
    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID);
    
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

end;
/

alter session set plsql_code_type = interpreted;