INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST1', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYSOH-MAIL', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST2', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYSOH-FAX', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('MFB_ARS_FLAG', 'V', 'Y', 'Flag to run MFB ARS ETL processing, Y run, N skip', sysdate, sysdate);
insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('MFB_REMOTE_FLAG', 'V', 'Y', 'Flag to run MFB Remote ETL processing, Y run, N skip', sysdate, sysdate);
insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('MFB_CENTRAL_FLAG', 'V', 'Y', 'Flag to run MFB Central ETL processing, Y run, N skip', sysdate, sysdate);

Delete from corp_etl_control 
where name like 'MFB_BATCH_CLASS_LIST%'
and value in ('NYSOH-MAIL','NYSOH-FAX')
;

commit;