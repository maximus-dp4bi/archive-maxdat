BEGIN

    BEGIN

        DBMS_SCHEDULER.DROP_JOB
        (
            job_name    =>  'CREATE_LOAD_EYR_FILES_REQ'
        );
    
    EXCEPTION
    
        WHEN    OTHERS
        THEN    NULL;
    
    END;

    DBMS_SCHEDULER.CREATE_JOB
    (
       job_name             => 'CREATE_LOAD_EYR_FILES_REQ',
       job_type             => 'PLSQL_BLOCK',
       job_action           => 'BEGIN mieb_letters_etl_pkg.ins_load_eyr_files_req(''LOAD_EYR_FILES'', ''.*\.csv''); END;',
       start_date           =>  SYSTIMESTAMP + INTERVAL '10' SECOND,
       repeat_interval      => 'FREQ=MINUTELY;INTERVAL=30', 
       enabled              =>  TRUE,
       comments             => 'Create requests for job LOAD_EYR_FILES.'
    );
    
    COMMIT;
    
END;
/