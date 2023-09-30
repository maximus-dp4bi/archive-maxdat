delete from CORP_ETL_CONTROL 
Where name IN('MAX_ELIGSTATUS_CREATE_DATE',
'MAX_ELIGSTATUS_UPDATE_DATE',
'MAX_ENRLSTATUS_CREATE_DATE',
'MAX_ENRLSTATUS_UPDATE_DATE',
'MAX_ELIGSEGMENT_CREATE_DATE',
'MAX_ELIGSEGMENT_UPDATE_DATE',
'ELIGSTATUS_LOOKBACK_DAYS',
'ENRLSTATUS_LOOKBACK_DAYS',
'ELIGSEGMENT_LOOKBACK_DAYS');

delete from corp_etl_list_lkup
where name in('ELIG_SEGMENT_WHERE_CLAUSE','CLIENT_ELIG_WHERE_CLAUSE','CLIENT_ENROLL_WHERE_CLAUSE','ELIGSEGMENT_COUNT_WHERE_CLAUSE','ELIGSEGMENT_COUNT_DPWHERE_CLAUSE');

commit;

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSTATUS_CREATE_DATE','D','2017/01/01 00:00:00','Max client elig status creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSTATUS_UPDATE_DATE','D','2017/01/01 00:00:00','Max client elig status update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ENRLSTATUS_CREATE_DATE','D','2017/01/01 00:00:00','Max client enroll status creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ENRLSTATUS_UPDATE_DATE','D','2017/01/01 00:00:00','Max client enroll status update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_CREATE_DATE','D','2017/01/01 00:00:00','Max elig segment and details creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_UPDATE_DATE','D','2017/01/01 00:00:00','Max elig segment and details update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('ELIGSTATUS_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Elig status in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('ENRLSTATUS_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Enroll status records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('ELIGSEGMENT_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the elig segments records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_COUNT_CREATE_DATE','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_COUNT_UPDATE_DATE','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_SYNCH_ELIGSEGMENTDTL_RUN_JOB','V','Y','Flag to enable/disable the Synchronize job', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('ELIGSEGMENT_COUNT_LOOKBACK','N','2','This is the number of lookback months to use for elig segment synchronization in each run', sysdate, sysdate);


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
,'ELIG_SEGMENT_WHERE_CLAUSE'
,'ELIG_SEGMENT'
,'Holds additional conditions for loading elig segment and details if needed.'
,null
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
,'ELIGSEGMENT_COUNT_WHERE_CLAUSE'
,'ELIG_SEGMENT'
,'Holds additional conditions for getting the record count in source for elig segment and details.'
,null
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
,'ELIGSEGMENT_CNT_DPWHERE_CLAUSE'
,'ELIG_SEGMENT'
,'Holds additional conditions for getting the record count in DP for elig segment and details.'
,null
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
,'CLIENT_ELIG_WHERE_CLAUSE'
,'CLIENT_ELIG'
,'Holds additional conditions for loading client_elig_status data if needed.'
,null
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
,'CLIENT_ENROLL_WHERE_CLAUSE'
,'CLIENT_ENROLL'
,'Holds additional conditions for loading client_enroll_status data if needed.'
,null
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ; 

commit;
