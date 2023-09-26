INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP
    (
      NAME
    , LIST_TYPE
    , VALUE
    , OUT_VAR
    , REF_TYPE
    , REF_ID
    , START_DATE
    , END_DATE
    , COMMENTS
    )
VALUES
    (
      'DP_SCORECARD_ALERT_EMAIL'
    , 'DP_SCORECARD'
    , 'List of Email Addresses to receive OBIEE file data errors'
    , 'KennethMMartin@maximus.com,guydthibodeau@maximus.com,alexanderbpiusz@maximus.com,ToddAHimes@maximus.com,StevenJSarsfield@maximus.com,NYHBEReportingTeamInbox@maximus.com,ScottRHughes@maximus.com'
    , null
    , null
    , sysdate
    , to_date('07/07/7777','dd/mm/yyyy')
    , 'List of Email Addresses to receive OBIEE file data errors'
    );

COMMIT;
