insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('MFB_ARS_FLAG', 'V', 'Y', 'Flag to run MFB ARS ETL processing, Y run, N skip', sysdate, sysdate);
insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('MFB_REMOTE_FLAG', 'V', 'Y', 'Flag to run MFB Remote ETL processing, Y run, N skip', sysdate, sysdate);
insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) values ('MFB_CENTRAL_FLAG', 'V', 'Y', 'Flag to run MFB Central ETL processing, Y run, N skip', sysdate, sysdate);


commit;