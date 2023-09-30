alter table
   CORP_ETL_CLNT_OUTREACH_EVENTS
add
(
   EVENT_EVENT_HISTORY_ID number
);




CREATE INDEX CORP_ETL_CLNT_OUT_EVENTS_IDX6 ON CORP_ETL_CLNT_OUTREACH_EVENTS (EVENT_CREATE_DT) TABLESPACE MAXDAT_INDX ;

CREATE INDEX CORP_ETL_CLNT_OUT_EVENTS_IDX7 ON CORP_ETL_CLNT_OUTREACH_EVENTS(EVENT_EVENT_HISTORY_ID) TABLESPACE MAXDAT_INDX ;
