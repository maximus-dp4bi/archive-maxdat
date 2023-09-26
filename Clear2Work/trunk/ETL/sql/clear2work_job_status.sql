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
  JOB_STATUS||'&v_column_separator'||
  DESCRIPTION||'&v_column_separator'||
  JOB_BEGIN_DT||'&v_column_separator'||
  JOB_END_DT
from CLEAR2WORK_JOB_STATUS
where JOB_ID = (select max(JOB_ID) from CLEAR2WORK_JOB_STATUS);

exit;
