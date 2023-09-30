insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_INST_START_DATE','D','01/09/2016','Alert Monitoring Instance Creation Start Date MM/DD/YYYY',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_INST_ALERT_STATUS','V','Ready','Alert Monitoring Instance Start status',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_ACTIVITY_PARSE_MAIL','V','Y','Alert Monitoring Activity using Mail',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_PARSE_THRESHOLD','N','30','Alert Monitoring - max how many hours to go back for parsing',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_ACTIVITY_PARSE_LOG','V','Y','Alert Monitoring Activity using Log',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_LOG_PARSE_TIME','V',to_char(sysdate,'YYYYMMDDHH24MISS'),'Alert Monitoring Activity using Log',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REPORTS_LOG_DIR','V','/ptxe4t/3rdparty/app/product/microstrategy/log','Alert Monitoring log file location',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_EMAIL_PARSE_TIME','V',to_char(sysdate,'YYYYMMDDHH24MISS'),'Alert Monitoring Activity using Email',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_EMAIL_IMAP_HOST','V','imap.gmail.com','Alert Monitoring Activity using Email Host',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_EMAIL_IMAP_PORT','V','993','Alert Monitoring Activity using Email Port',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_EMAIL_IMAP_USER','V','MSTR3MON','Alert Monitoring Activity using Email - User',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_EMAIL_IMAP_PWD','V','Monitor123','Alert Monitoring Activity using Email - PWD',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_EMAIL_IMAP_FLD','V','INBOX','Alert Monitoring Activity using Email - Folder',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AM_EMAIL_IMAP_DB','V','TXEBMXDP','Alert Monitoring Activity using Email - Database name',sysdate,sysdate);


commit;


