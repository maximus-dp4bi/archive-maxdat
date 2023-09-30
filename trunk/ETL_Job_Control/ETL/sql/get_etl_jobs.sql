/*
	Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '$URL$'; 
    SVN_REVISION varchar2(20) := '$Revision$'; 
    SVN_REVISION_DATE varchar2(60) := '$Date$'; 
    SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
*/
set feedback off
set heading off
set linesize 6000
set newpage none
set verify off

define v_column_separator = ';'

select 
  JOB_ID||'&v_column_separator'||
  PROJECT_NAME||'&v_column_separator'||
  JOB_NAME||'&v_column_separator'||
  JOB_TYPE||'&v_column_separator'||
  PARENT_JOB_ID||'&v_column_separator'||
  JOB_SCRIPT_NAME||'&v_column_separator'||
  JOB_LOG_PATH||'&v_column_separator'||
  JOB_NEXT_EXEC_DT
from ETL_JOB_LIST
where JOB_STUCK='N'
order by JOB_ID asc;

exit;
