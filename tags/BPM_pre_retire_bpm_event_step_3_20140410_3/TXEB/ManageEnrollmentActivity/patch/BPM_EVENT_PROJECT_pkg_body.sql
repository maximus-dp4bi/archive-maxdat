alter session set plsql_code_type = native;

create or replace 
package body BPM_EVENT_PROJECT as

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  -- Insert BPM Event records.
  procedure INSERT_BPM_EVENT
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype,
     p_bue_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_EVENT';
    v_log_message clob := null;
    v_error_number number := null;
  begin

    if p_bueq_row.NEW_DATA is null then
      v_log_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE.NEW_DATA value.';
      v_error_number := -20015;
      BPM_COMMON.LOGGER
       (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
        p_bueq_row.IDENTIFIER,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
    end if;

    if p_bueq_row.WROTE_BPM_EVENT_DATE is not null then
      return;
    end if;

    if p_bueq_row.BSL_ID = 1 then
      MANAGE_WORK.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 9 then
      MANAGE_MAIL_FAX_DOC.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 10 then
      DPY_PROCESS_INCIDENTS.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 11 then
      MANAGE_JOBS.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 12 then
      PROCESS_LETTERS.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 13 then
      CLIENT_INQUIRY.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 14 then
      MANAGE_ENROLL.INSERT_BPM_EVENT(P_BUEQ_ROW.DATA_VERSION,P_BUEQ_ROW.NEW_DATA,P_BUE_ID); 
      
    elsif p_bueq_row.BSL_ID = 15 then
      CLIENT_OUTREACH.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);
    
    
    /*
    elsif p_bueq_row.BSL_ID = XX then
      ILEB_XX.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,p_bue_id);
    */

    else
      v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '".';
      v_error_number := -20012;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BSL_ID,
         p_bueq_row.IDENTIFIER,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
    end if;

  end;


  -- Update BPM Event records.
  procedure UPDATE_BPM_EVENT
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype,
     p_bue_id out number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_EVENT';
    v_log_message clob := null;
    v_error_number number := null;
  begin

    if p_bueq_row.WROTE_BPM_EVENT_DATE is not null then
      return;
    end if;

    if p_bueq_row.OLD_DATA is null or p_bueq_row.NEW_DATA is null then
      v_log_message := 'Cannot process update from queue.  BPM_UPDATE_EVENT_QUEUE .OLD_DATA and/or NEW_DATA record is null.';
      v_error_number := -20014;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
    end if;

    if p_bueq_row.BSL_ID = 1 then
      MANAGE_WORK.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 9 then
      MANAGE_MAIL_FAX_DOC.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 10 then
      DPY_PROCESS_INCIDENTS.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 11 then
      MANAGE_JOBS.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 12 then
      PROCESS_LETTERS.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 13 then
      CLIENT_INQUIRY.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);

    elsif p_bueq_row.BSL_ID = 14 then
      MANAGE_ENROLL.UPDATE_BPM_EVENT(P_BUEQ_ROW.DATA_VERSION,P_BUEQ_ROW.OLD_DATA,P_BUEQ_ROW.NEW_DATA,P_BUE_ID);

    elsif p_bueq_row.BSL_ID = 15 then
      CLIENT_OUTREACH.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);

    /*
    elsif p_bueq_row.BSL_ID = XX then
      ILEB_XX.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,p_bue_id);
    */

    else
      v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      v_error_number := -20012;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,
         null,null,null,v_log_message,v_error_number);
      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
      return;
    end if;

  end;


end;
/
alter session set plsql_code_type = interpreted;