insert into CORP_ETL_CONTROL
values ('EMAILADDRESS_LOOKBACK_DAYS','N','3','This is the number of lookback days used to get the email address records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_EMAILADDRESS_CREATE_DATE','D','2011/12/01 00:00:00','Min Date to start getting new records', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_EMAILADDRESS_UPDATE_DATE','D','2011/12/01 00:00:00','Min Date to start getting updated records', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('DIGITAL_EVENT_LOOKBACK_DAYS','N','3','This is the number of lookback days used to get the digital events records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_DIGITAL_EVENT_CREATE_DATE','D','2019/01/01 00:00:00','Min Date to start getting new records', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_DIGITAL_EVENT_UPDATE_DATE','D','2019/01/01 00:00:00','Min Date to start getting updated records', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('AUTODISENROLL_LOOKBACK_DAYS','N','3','This is the number of lookback days used to get the autodisenroll request records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_AUTODISNRLREQ_CREATE_DATE','D','2018/01/01 00:00:00','Min Date to start getting new records', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_AUTODISNRLREQ_UPDATE_DATE','D','2018/01/01 00:00:00','Min Date to start getting updated records', sysdate, sysdate);

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'DIGITAL_EVENT_TYPE'
,'EVENT_TYPE'
,'Event Types to pull for Digital Reporting'
,'''OPT_IN_EMAIL'',''CASE_PREFERRED_TO_DIGITAL'',''DIG_OPT_OUT_EMAIL'',''DIG_OPT_OUT_SMS'',''CASE_PREFERRED_TO_POSTAL'',''OPT_OUT_EMAIL'',''OPT_IN_SMS'',''OPT_OUT_SMS'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

commit;

