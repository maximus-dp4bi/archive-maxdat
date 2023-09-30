INSERT INTO CORP_ETL_JOB_STATISTICS (JOB_ID, JOB_NAME, JOB_STATUS_CD, RECORD_COUNT, PROCESSED_COUNT, ERROR_COUNT, WARNING_COUNT, RECORD_INSERTED_COUNT, RECORD_UPDATED_COUNT, JOB_START_DATE, JOB_END_DATE) 
VALUES (SEQ_JOB_ID.nextval, 'S_CRS_IMR_PRELIMINARY_REVIEW', 'COMPLETED', 0, 0, 0, 0, 0, 0,to_date('09-FEB-15','DD-MON-YY'), to_date('09-FEB-15','DD-MON-YY'));

INSERT INTO CORP_ETL_JOB_STATISTICS (JOB_ID, JOB_NAME, JOB_STATUS_CD, RECORD_COUNT, PROCESSED_COUNT, ERROR_COUNT, WARNING_COUNT, RECORD_INSERTED_COUNT, RECORD_UPDATED_COUNT, JOB_START_DATE, JOB_END_DATE) 
VALUES (SEQ_JOB_ID.nextval, 'S_CRS_IMR_EXP_REVIEW_HIST', 'COMPLETED', 0, 0, 0, 0, 0, 0,to_date('09-FEB-15','DD-MON-YY'), to_date('09-FEB-15','DD-MON-YY'));

COMMIT;