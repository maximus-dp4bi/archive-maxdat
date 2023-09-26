INSERT
INTO
  CORP_ETL_CONTROL
  (
    NAME,
    VALUE_TYPE,
    VALUE,
    DESCRIPTION,
    CREATED_TS,
    UPDATED_TS
  )
  VALUES
  (
    'MAX_DCN_DETAIL_ID',
    'N',
    '1',
    'This is the max dcn detail id for csc errors',
    sysdate,
    sysdate
  );
COMMIT;


INSERT
INTO
  CORP_ETL_LIST_LKUP
  (
    CELL_ID,
    NAME,
    LIST_TYPE,
    VALUE,
    OUT_VAR,
    REF_TYPE,
    REF_ID,
    START_DATE,
    END_DATE,
    COMMENTS,
    CREATED_TS,
    UPDATED_TS
  )
  VALUES
  (
    SEQ_CELL_ID.nextval,
    'LAST_ETL_COMP_PIVOT',
    'PIVOT',
    'NYHIX MAIL FAX DOC V2',
    '24',
    'BPM_EVENT_MASTER',
    24,
    TRUNC(sysdate - 1),
    to_date('07077777','mmddyyyy'),
    'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID'
    ,
    sysdate,
    sysdate
  );
  
  INSERT
INTO
  CORP_ETL_LIST_LKUP
  (
    CELL_ID,
    NAME,
    LIST_TYPE,
    VALUE,
    OUT_VAR,
    REF_TYPE,
    REF_ID,
    START_DATE,
    END_DATE,
    COMMENTS,
    CREATED_TS,
    UPDATED_TS
  )
  VALUES
  (
    SEQ_CELL_ID.nextval,
    'LAST_ETL_COMP_PIVOT',
    'PIVOT',
    'NYHIX DOC NOTIFICATIONS',
    '30',
    'BPM_EVENT_MASTER',
    30,
    TRUNC(sysdate - 1),
    to_date('07077777','mmddyyyy'),
    'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID'
    ,
    sysdate,
    sysdate
  );
  
  commit;