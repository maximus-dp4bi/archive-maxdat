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
    'AGENCY_REPORTS_LOOK_BACK'
    , 'N'
    , '-2'
    , 'Number of months to look back for Agency Reports 402X'
    , sysdate
    , sysdate
    );

commit;
