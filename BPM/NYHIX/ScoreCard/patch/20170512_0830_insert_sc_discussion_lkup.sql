INSERT INTO DP_SCORECARD.SC_DISCUSSION_LKUP
    (
    DL_ID
    , DISCUSSION_TOPIC
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    )
VALUES
    (
    31
    , 'Real Time Phone Observation'
    , to_date('07/07/2077','mm/dd/yyyy')
    , 'script'
    , sysdate
    );
    
    COMMIT;