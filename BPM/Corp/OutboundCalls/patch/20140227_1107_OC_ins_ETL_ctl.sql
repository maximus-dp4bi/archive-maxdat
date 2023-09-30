-- Update batch scheduling
update CORP_ETL_CONTROL set VALUE = '0900' where NAME = 'OUTBOUNDCALL_DAILY_START';
update CORP_ETL_CONTROL set VALUE = '1059' where NAME = 'OUTBOUNDCALL_DAILY_END';

-- New control
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('OUTBOUNDCALL_LAST_ROW_ID','N','0','Value of the last successful Outbound Call job''s  ending row ID.',SYSDATE,SYSDATE);

commit;