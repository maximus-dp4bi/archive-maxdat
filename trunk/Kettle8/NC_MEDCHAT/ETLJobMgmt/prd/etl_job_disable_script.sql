Update MAXDAT_SUPPORT.ETL_JOB_CONFIG 
 set JOB_ENABLED = 'N'
where JOB_SCRIPT_NAME = 'run_medchat_report.sh'
;

COMMIT;