-- Add missing Kofax batch records to staging table. - Repair to use correct stg_insert_job_id

update CORP_ETL_MFB_BATCH_STG 
set STG_INSERT_JOB_ID = 4
where 
  STG_INSERT_JOB_ID = 3
  and CREATION_USER_NAME = 'Randall Kolb';

commit;