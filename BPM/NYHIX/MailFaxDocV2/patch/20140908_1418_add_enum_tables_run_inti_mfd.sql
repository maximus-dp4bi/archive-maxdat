Alter table APP_DOC_DATA_STG ADD PRIORITY NUMBER(18,0);

create table ENUM_ENVELOPE_STATUS_STG
  (
    value        varchar2(32 byte),
    REPORT_LABEL varchar2(64 byte),
    CREATE_TS    date,
    UPDATE_TS    date
  );

create table ENUM_DOC_CODE_TO_TYPE_STG
  (
    value        varchar2(32 byte),
    REPORT_LABEL varchar2(64 byte),
    CREATE_TS    date,
    UPDATE_TS    date
  );

create index IDX3_APP_DOC_DATA_DCN on APP_DOC_DATA_STG (DCN) TABLESPACE  MAXDAT_INDX ;
