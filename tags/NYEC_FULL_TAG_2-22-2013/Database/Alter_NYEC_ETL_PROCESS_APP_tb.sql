alter table nyec_etl_process_app add   AUTO_REPROCESS_FLAG_DT         DATE;
alter table nyec_etl_process_app add   REFER_LDSS_FLAG_DT             DATE;
alter table nyec_etl_process_app add   PENDING_MI_TYPE                VARCHAR2(20);
alter table nyec_etl_process_app add   CURRENT_MI_LETTER_ID           NUMBER(10);
alter table nyec_etl_process_app add   OUTBOUND_CALL_EVENT_ID         NUMBER(18);
alter table nyec_etl_process_app add   OUTBOUND_CALL_COUNT            NUMBER(10);
