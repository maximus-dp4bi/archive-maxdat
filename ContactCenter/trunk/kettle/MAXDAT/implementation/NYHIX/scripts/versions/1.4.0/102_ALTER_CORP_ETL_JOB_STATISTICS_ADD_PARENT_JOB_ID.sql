
ALTER TABLE CORP_ETL_JOB_STATISTICS 
ADD ( PARENT_JOB_ID Number );

INSERT INTO CC_L_PATCH_LOG (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
VALUES ('1.4.0',102,'102_ALTER_CORP_ETL_JOB_STATISTICS_ADD_PARENT_JOB_ID');

COMMIT;