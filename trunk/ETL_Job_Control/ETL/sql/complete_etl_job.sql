/*
	Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '$URL$'; 
    SVN_REVISION varchar2(20) := '$Revision$'; 
    SVN_REVISION_DATE varchar2(60) := '$Date$'; 
    SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
*/
set feedback off
set heading off
set linesize 5000
set newpage none
set verify off

define p_job_id = &1

BEGIN
    ETL_JOB.COMPLETE_ETL_JOB(&p_job_id);
    COMMIT;
END;
/

exit;
