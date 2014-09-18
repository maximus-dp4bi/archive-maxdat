alter table corp_etl_clnt_outreach_oltp
drop constraint CORP_ETL_CLNT_OUTREACH_OLTP_PK;

DROP INDEX CORP_ETL_CLNT_OUT_OLTP_IDX1;
DROP INDEX CORP_ETL_CLNT_OUTREACH_OLTP_PK;

ALTER TABLE corp_etl_clnt_outreach
ADD MAX_INCI_HEADER_STAT_HIST_ID NUMBER;

ALTER TABLE corp_etl_clnt_outreach_wip_bpm
ADD MAX_INCI_HEADER_STAT_HIST_ID NUMBER;

ALTER TABLE corp_etl_clnt_outreach_oltp
ADD (INCIDENT_HEADER_STAT_HIST_ID NUMBER, HIST_OUTREACH_STATUS VARCHAR2(128 BYTE));

CREATE INDEX CORP_ETL_CLNT_OUT_OLTP_IDX1 ON CORP_ETL_CLNT_OUTREACH_OLTP (OUTREACH_ID)  TABLESPACE MAXDAT_INDX ;
CREATE INDEX CORP_ETL_CLNT_OUT_OLTP_IDX2 ON CORP_ETL_CLNT_OUTREACH_OLTP (INCIDENT_HEADER_STAT_HIST_ID)  TABLESPACE MAXDAT_INDX ;

create index CORP_ETL_CLNT_OUT_EVENTS_IDX2 on CORP_ETL_CLNT_OUTREACH_EVENTS(EVENT_REF_ID) TABLESPACE MAXDAT_INDX;

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
,'CO_EXTRACT_STATUS'
,'OUTREACH_STATUS'
,'Various incident status to extract for Client Outreach'
,'''Outreach Request Initiated'',''Outreach Successful'',''Outreach Unsuccessful'',''Existing Request - Home Visit'',''Outreach No Longer Required'',''Outreach Invalid Request'',''Withdrawn''' 
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

commit;