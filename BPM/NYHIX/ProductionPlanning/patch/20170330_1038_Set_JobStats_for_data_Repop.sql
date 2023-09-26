/*
Created on 03/30/2017 by Raj A.
Description: Per NYHIX-26477. Added "and SD.end_date is null" filter to the ktrs after checking with Alex. 
This is to fix deadlock and Primary Key violations on PP_BO_TASK and PP_BO SCHEDULE_MONITOR tables.

Rerunning the PP_Back_Office_RUNALL ETL from 03/34/2017.
*/
INSERT INTO corp_etl_job_statistics
(
job_id, job_name, job_status_cd, job_start_date, job_end_date
)
VALUES (
SEQ_JOB_ID.Nextval
,'PP_Back_Office_RUNALL'
,'COMPLETED'
,to_date('03/24/2017','mm/dd/yyyy')
,to_date('03/24/2017','mm/dd/yyyy')
);
COMMIT;