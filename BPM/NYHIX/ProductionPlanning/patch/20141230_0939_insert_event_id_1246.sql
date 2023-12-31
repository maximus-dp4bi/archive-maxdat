insert into PP_D_UOW_SOURCE_REF (USR_ID, UOW_ID, SOURCE_REF_TYPE_ID, SOURCE_REF_VALUE, SOURCE_REF_DETAIL_IDENTIFIER, EFFECTIVE_DATE, END_DATE, SOURCE_REF_ID)
values (1030, 30, 4, 'Bucket Cases', 'PIPKINS EVENTS', sysdate, to_date('7/7/2077', 'mm/dd/yyyy'), 1246);

INSERT INTO CORP_ETL_JOB_STATISTICS (JOB_ID, JOB_NAME, JOB_STATUS_CD, RECORD_COUNT, PROCESSED_COUNT, ERROR_COUNT, WARNING_COUNT, RECORD_INSERTED_COUNT, RECORD_UPDATED_COUNT, JOB_START_DATE, JOB_END_DATE) 
VALUES (SEQ_JOB_ID.nextval, 'PP_Back_Office_RUNALL', 'COMPLETED', 0, 0, 0, 0, 0, 0, to_date('22-DEC-14','DD-MON-YY'), to_date('22-DEC-14','DD-MON-YY'));

commit;