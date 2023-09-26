delete from CORP_ETL_CONTROL Where name like '%CALLREC%' OR name LIKE '%EVENT%' OR name LIKE '%INCIDENT%';

delete from corp_etl_list_lkup where name IN('INCIDENT_HEADER_TYPE','EVENT_TYPE');
commit;

insert into CORP_ETL_CONTROL
values ('MAX_CALLREC_CREATE_DATE','D','2017/01/01 00:00:00','Max call record creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_CALLREC_UPDATE_DATE','D','2017/01/01 00:00:00','Max call record update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_CALLREC_LINK_CREATE_DATE','D','2017/01/01 00:00:00','Max call record link creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_CALLREC_LINK_UPDATE_DATE','D','2017/01/01 00:00:00','Max call record link update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_EVENT_CREATE_DATE','D','2017/01/01 00:00:00','Max event creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_EVENT_UPDATE_DATE','D','2017/01/01 00:00:00','Max event update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_INCIDENT_CREATE_DATE','D','2017/01/01 00:00:00','Max incidents creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_INCIDENT_UPDATE_DATE','D','2017/01/01 00:00:00','Max incidents update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('CALLREC_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Call Records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('CALLREC_LINK_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Call Record Link records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EVENT_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Event records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('INCIDENT_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Incident records in each run', sysdate, sysdate);

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
,'INCIDENT_HEADER_TYPE'
,'INCIDENT_TYPE'
,'Holds the incident header type'
,'''COMPLAINT'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ; 

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
,'EVENT_TYPE'
,'EVENT_TYPE'
,'Holds the event types'
,'''MANUAL_ACTION'',''COMPLAINT_INITIATED'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ; 


commit;
