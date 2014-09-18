alter table PROCESS_APP_STG add   AUTO_REPROCESS_FLAG_DT         DATE;
alter table PROCESS_APP_STG add   REFER_LDSS_FLAG_DT             DATE;
alter table PROCESS_APP_STG add   PENDING_MI_TYPE                VARCHAR2(20);
alter table PROCESS_APP_STG add   CURRENT_MI_LETTER_ID           NUMBER(10);
alter table PROCESS_APP_STG add   OUTBOUND_CALL_EVENT_ID         NUMBER(18);
alter table PROCESS_APP_STG add   OUTBOUND_CALL_COUNT            NUMBER(10);
alter table PROCESS_APP_STG add   PENDING_MI_DATA_COUNT          NUMBER(2) default 0;
alter table PROCESS_APP_STG add   PENDING_MI_DOC_COUNT           NUMBER(2) default 0;