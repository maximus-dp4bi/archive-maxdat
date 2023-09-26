







Delete from CORP_ETL_LIST_LKUP 
where name like 'MFB_BATCH_CLASS_LIST%'
;

INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST1', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYSOH-INT-MAIL', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST2', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYHIXUAT - Individual Apps', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST3', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'SHOP Application SIT', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST4', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYHIXUAT - Individual Apps FAX', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST5', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYHIXINT � Individual Apps', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST6', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYSOH-UAT-FAX', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST7', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYHIXINT- Individual Apps', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO CORP_ETL_LIST_LKUP (NAME, LIST_TYPE, VALUE, OUT_VAR, START_DATE, END_DATE) VALUES ('MFB_BATCH_CLASS_LIST8', 'MFB_BATCH_CLASS_LIST', 'These are the NYHIX PROD Batch Classes', 'NYHIXPRD � Individual Apps', TO_DATE('2016-01-14 19:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1977-07-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));


Delete from corp_etl_control 
where name like 'MFB_BATCH_CLASS_LIST%'
;

commit;