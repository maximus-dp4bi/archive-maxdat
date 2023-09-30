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
    'MAX_DOC_LINK_HIST_STG'
    , 'D'
    , '2014/01/01 01:01:01'
    , 'This is the max doc_link_hist_id creat_ts inserted by the last run'
    , sysdate
    , sysdate
    )	
;

commit;
	