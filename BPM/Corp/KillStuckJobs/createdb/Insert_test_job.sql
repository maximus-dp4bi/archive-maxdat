
INSERT INTO MAXDAT.CORP_JOB_PROCESS_STUCK
    (
    JOB_NAME
    , JOB_CHECK_FILE_NAME
    , JOB_PID
    , JOB_ACTION_KILL
    , REMOVE_CHECK_FILE_ONLY
    )
VALUES
    (
    'test_job2'
    , 'NYHIX_test_job2_run_check.txt'
    , null
    , 'Y'
    , 'N'
    );
    
    COMMIT;
    