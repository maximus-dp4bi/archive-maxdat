
delete from pp_bo_schedule_monitor
where trunc(task_start) = trunc(sysdate-1);

delete from pp_bo_task
where trunc(task_start) = trunc(sysdate-1);

delete from pp_bo_actuals
where trunc(task_start) = trunc(sysdate-1); 


commit;


INSERT INTO CORP_ETL_JOB_STATISTICS (JOB_ID, JOB_NAME, JOB_STATUS_CD, RECORD_COUNT, PROCESSED_COUNT, ERROR_COUNT, WARNING_COUNT, RECORD_INSERTED_COUNT, RECORD_UPDATED_COUNT, JOB_START_DATE, JOB_END_DATE) 
VALUES (SEQ_JOB_ID.nextval, 'PP_Back_Office_RUNALL', 'COMPLETED', 0, 0, 0, 0, 0, 0, to_date('08-JAN-15','DD-MON-YY'), to_date('08-JAN-15','DD-MON-YY'));

commit;