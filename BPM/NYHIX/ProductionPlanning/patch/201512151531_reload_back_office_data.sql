delete from pp_bo_schedule_monitor
where task_start >= to_date('01-NOV-15', 'dd-MON-yy');

delete from pp_bo_task
where task_start >= to_date('01-NOV-15', 'dd-MON-yy');

delete from pp_bo_actuals
where task_start >= to_date('01-NOV-15', 'dd-MON-yy');


INSERT INTO CORP_ETL_JOB_STATISTICS (JOB_ID, JOB_NAME, JOB_STATUS_CD, RECORD_COUNT, PROCESSED_COUNT, ERROR_COUNT, WARNING_COUNT, RECORD_INSERTED_COUNT, RECORD_UPDATED_COUNT, JOB_START_DATE, JOB_END_DATE) 
VALUES (SEQ_JOB_ID.nextval, 'PP_Back_Office_RUNALL', 'COMPLETED', 0, 0, 0, 0, 0, 0, to_date('01-NOV-15','DD-MON-YY'), to_date('01-NOV-15','DD-MON-YY'));


commit;