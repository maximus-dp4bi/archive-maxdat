insert into CORP_ETL_CONTROL
values ('ELIGSEGMENT_LOOKBACK_DAYS_ELIG','N','3','This is the number of lookback days used to get the elig segments records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_CREATE_DATE_ELIG','D','2011/12/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_UPDATE_DATE_ELIG','D','2011/12/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

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
,'ELIG_SEGMENT_WHERE_CLAUSE_ELIG'
,'ELIG_SEGMENT'
,'Holds additional conditions for loading elig segment and details if needed.'
,' AND end_nd >= TO_NUMBER(TO_CHAR(sysdate,''yyyymmdd''))'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

insert into CORP_ETL_CONTROL
values ('ELIGSEGMENT_LOOKBACK_DAYS_OHC','N','2','This is the number of lookback days used to get the elig segments records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_CREATE_DATE_OHC','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_UPDATE_DATE_OHC','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

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
,'ELIG_SEGMENT_WHERE_CLAUSE_OHC'
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

insert into CORP_ETL_CONTROL
values ('ELIGSEGMENT_LOOKBACK_DAYS_LTC','N','2','This is the number of lookback days used to get the elig segments records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_CREATE_DATE_LTC','D','2013/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_UPDATE_DATE_LTC','D','2013/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

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
,'ELIG_SEGMENT_WHERE_CLAUSE_LTC'
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

insert into CORP_ETL_CONTROL
values ('ELIGSEGMENT_LOOKBACK_DAYS_MI','N','2','This is the number of lookback days used to get the elig segments records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_CREATE_DATE_MI','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_UPDATE_DATE_MI','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

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
,'ELIG_SEGMENT_WHERE_CLAUSE_MI'
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

insert into CORP_ETL_CONTROL
values ('ELIGSEGMENT_LOOKBACK_DAYS_ME','N','2','This is the number of lookback days used to get the elig segments records in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_CREATE_DATE_ME','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_ELIGSEGMENT_UPDATE_DATE_ME','D','2017/01/01 00:00:00','Min Date to start looking for discrepancies for elig segment and details', sysdate, sysdate);

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
,'ELIG_SEGMENT_WHERE_CLAUSE_ME'
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

insert into CORP_ETL_CONTROL
values ('EMRS_LTCSEGMENTDTL_RELOAD_DAY','V','9','Day to run the truncate and reload for LTC segments and detail data. Set to any number between 0 and 7 for Sun to Sat or set to a bigger number if reload is not needed', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_LTC_SEGMENTDTL_TRUNC_INS_YN','V','Y','Switch to enable or disable truncate/insert logic for LTC segments and detail data', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('EMRS_OHCSEGMENTDTL_RELOAD_DAY','V','9','Day to run the truncate and reload for OHC segments and detail data. Set to any number between 0 and 7 for Sun to Sat or set to a bigger number if reload is not needed', sysdate, sysdate);

commit;