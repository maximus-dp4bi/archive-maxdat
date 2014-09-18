alter session set plsql_code_type = native;

-- Project-specific calls to process-specific BPM Semantic insert and update procedures.
create or replace package body BPM_SEMANTIC_PROJECT as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  -- Insert BPM Semantic records.
  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_log_message clob := null;
    v_error_number number := null;
  begin
    
    if p_bueq_row.BSL_ID = 1 then 
      MANAGE_WORK.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    /*  
    elsif p_bueq_row.BSL_ID = 16 then 
      MAIL_FAX_BATCH.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);   

    elsif p_bueq_row.BSL_ID = 18 then 
      NYHIX_MAIL_FAX_DOC.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA); 

    elsif p_bueq_row.BSL_ID = XX then 
      NYHIX_XX.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
    */
    else
      v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      v_error_number := -20012;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);  
    end if;

  end;
  

  -- Update BPM Semantic records.
  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_SEMANTIC';
    v_log_message clob := null;
    v_error_number number := null;
  begin
  
    if p_bueq_row.BSL_ID = 1 then 
      MANAGE_WORK.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    /*  
    elsif p_bueq_row.BSL_ID = 16 then 
      MAIL_FAX_BATCH.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
   
    elsif p_bueq_row.BSL_ID =  18 then 
      NYHIX_MAIL_FAX_DOC.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA); 
   

    elsif p_bueq_row.BSL_ID = XX then 
      NYHIX_XX.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
    */
    else
      v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      v_error_number := -20012;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);  
    end if;

  end;
  
end;
/

alter session set plsql_code_type = interpreted;