alter session set plsql_code_type = native;

create or replace 
package body BPM_SEMANTIC_PROJECT as

  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageEnrollmentActivity/patch/BPM_SEMANTIC_PROJECT_pkg_body.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 5659 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2013-09-26 11:25:05 -0700 (Thu, 26 Sep 2013) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';

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

    elsif p_bueq_row.BSL_ID = 9 then
      MANAGE_MAIL_FAX_DOC.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 10 then
      DPY_PROCESS_INCIDENTS.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 11 then
      MANAGE_JOBS.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 12 then
      PROCESS_LETTERS.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 13 then
      CLIENT_INQUIRY.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 14 then 
      MANAGE_ENROLL.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 15 then 
      CLIENT_OUTREACH.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 17 then
      COMMUNITY_OUTREACH.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

    /*
    elsif p_bueq_row.BSL_ID = XX then
      ILEB_XX.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
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

    elsif p_bueq_row.BSL_ID = 9 then
      MANAGE_MAIL_FAX_DOC.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 10 then
      DPY_PROCESS_INCIDENTS.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 11 then
      MANAGE_JOBS.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 12 then
      PROCESS_LETTERS.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 13 then
      CLIENT_INQUIRY.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 14 then 
      MANAGE_ENROLL.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 15 then 
      CLIENT_OUTREACH.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    elsif p_bueq_row.BSL_ID = 17 then
      COMMUNITY_OUTREACH.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    /*
    elsif p_bueq_row.BSL_ID = XX then
      ILEB_XX.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
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