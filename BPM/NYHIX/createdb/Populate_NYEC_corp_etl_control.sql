
INSERT INTO MAXDAT.CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    )
VALUES
    (
    'MAX_UPDATE_TS_NYEC_DMS_BATCHES'
    , 'D'
    , '2000/01/01 00:00:00'
    , 'Max Update Date for NYEC DMS BATCHES Stage table'
    );

INSERT INTO MAXDAT.CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    )
VALUES
    (
    'MAX_UPDATE_TS_NYEC_DMS_DOCUMENTS'
    , 'D'
    , '2000/01/01 00:00:00'
    , 'Max Update Date for NYEC DMS DOCUMENTS Stage table'
    );

INSERT INTO MAXDAT.CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    )
VALUES
    (
    'MAX_UPDATE_TS_NYEC_APP_DOC'
    , 'D'
    , '2000/01/01 00:00:00'
    , 'Max Update Date for NYEC APP_DOC_DATA Stage table'
    );


COMMIT;