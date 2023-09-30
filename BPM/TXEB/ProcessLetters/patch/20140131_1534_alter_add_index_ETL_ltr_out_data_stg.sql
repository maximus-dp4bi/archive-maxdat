-- Process Letters, missing table indexes

create index LETTER_OUT_DATA_CONT_STG_IDX2 on LETTER_OUT_DATA_CONTENT_STG (LETTER_OUT_DATA_ID)
tablespace MAXDAT_INDX;

create index LETTER_OUT_DATA_CONT_STG_IDX3 on LETTER_OUT_DATA_CONTENT_STG (JOB_ID)
tablespace MAXDAT_INDX;