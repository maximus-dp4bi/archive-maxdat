INSERT INTO MAXDAT.CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'MAX_CLIENT_STG'
    , 'D'
    , '2013/01/01 01:01:01'
    , 'This is the max Client_Stg creation_date/last_updated_date inserted by the last run'
    , sysdate
    , sysdate
    );
COMMIT;