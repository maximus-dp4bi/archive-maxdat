--------------------------------------------------------
--  File created - Thursday-July-19-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package BPM_SEMANTIC_PROJECT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BPM_SEMANTIC_PROJECT as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/ManageWork/createdb/BPM_SEMANTIC_PROJECT_pkg.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 3584 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2013-07-02 15:20:36 -0400 (Tue, 02 Jul 2013) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';


  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

end;

/
--------------------------------------------------------
--  DDL for Package Body BPM_SEMANTIC_PROJECT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY BPM_SEMANTIC_PROJECT as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/CADIR/createdb/BPM_SEMANTIC_PROJECT_pkg_body.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 11080 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2014-07-23 19:25:11 -0400 (Wed, 23 Jul 2014) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: fm18957 $';

  -- Insert BPM Semantic records.
  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_SEMANTIC';
    v_log_message clob := null;
    v_error_number number := null;
  begin

    if p_bueq_row.BSL_ID = 2003 then 
      MW.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
      null;
    elsif p_bueq_row.BSL_ID = 2004 then
      Process_Appeals.INSERT_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA);
      null;
    else
      v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      v_error_number := -20012;

      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,v_log_message,v_error_number);         

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

      if p_bueq_row.BSL_ID = 2003 then 
      MW.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

      elsif p_bueq_row.BSL_ID = 2004 then 
      Process_Appeals.UPDATE_BPM_SEMANTIC(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA);

    else
      v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      v_error_number := -20012;

      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,v_log_message,v_error_number);         

      RAISE_APPLICATION_ERROR(v_error_number,v_log_message);  
    end if;

  end;

end;

/
