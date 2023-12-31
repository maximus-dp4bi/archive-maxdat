CREATE OR REPLACE PACKAGE "BPM_SEMANTIC_PROJECT" as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/DataModel/BpmSemantic/createdb/BPM_SEMANTIC_PROJECT_pkg_spec.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 3584 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2013-07-02 13:20:36 -0600 (Tue, 02 Jul 2013) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';


  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);
  
end;
/


CREATE OR REPLACE PACKAGE BODY "BPM_SEMANTIC_PROJECT" as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/createdb/BPM_SEMANTIC_PROJECT_pkg_body.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 4989 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2013-08-31 17:04:52 -0400 (Sat, 31 Aug 2013) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: sp57859 $';

  -- Insert BPM Semantic records.
  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_log_message clob := null;
    v_error_number number := null;
  begin
    
--    if p_bueq_row.BSL_ID = 1 then 
--      MANAGE_WORK.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
      
    if p_bueq_row.BSL_ID = 16 then 
    MAIL_FAX_BATCH.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);   

--    elsif p_bueq_row.BSL_ID = 18 then 
--    NYHIX_MAIL_FAX_DOC.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);   

--    elsif p_bueq_row.BSL_ID = 22 then
--      PROCESS_COMPLAINTS_INCIDENTS.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);

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
  
--    if p_bueq_row.BSL_ID = 1 then 
--      MANAGE_WORK.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
      
    if p_bueq_row.BSL_ID = 16 then 
    MAIL_FAX_BATCH.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

--    elsif p_bueq_row.BSL_ID = 18 then 
--    NYHIX_MAIL_FAX_DOC.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

--    elsif p_bueq_row.BSL_ID = 22 then
--     PROCESS_COMPLAINTS_INCIDENTS.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);
  
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
