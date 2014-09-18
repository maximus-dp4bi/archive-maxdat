alter session set plsql_code_type = native;

-- Project-specific calls to process-specific BPM Semantic insert and update procedures.
create or replace package BPM_SEMANTIC_PROJECT as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


  procedure INSERT_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BPM_SEMANTIC
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);
  
end;
/

alter session set plsql_code_type = interpreted;