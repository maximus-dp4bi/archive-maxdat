-- ILEB-3488 new R3 campaign indicator

insert into corp_etl_list_lkup (NAME, LIST_TYPE, VALUE, OUT_VAR, REF_TYPE, REF_ID, START_DATE, END_DATE, COMMENTS, CREATED_TS, UPDATED_TS)
values ('OUTBOUND_CALL', 'LIST', 'R3', '3', 'OUTBND_CAMPAIGN', 2, null, null, null, SYSDATE, SYSDATE);

commit;
