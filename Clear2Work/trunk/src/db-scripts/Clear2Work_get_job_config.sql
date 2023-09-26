set feedback off
set heading off
set linesize 5000
set newpage none
set verify off

define v_column_separator = ';'

select 
  ENABLED_FLAG||'&v_column_separator'||
  DEBUG_FLAG||'&v_column_separator'||
  PRESERVE_FILES_FLAG||'&v_column_separator'||
  INPUT_FILE_DIR
from CLEAR2WORK_JOB_CONFIG;

exit;