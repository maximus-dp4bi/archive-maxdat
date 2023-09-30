create index CORP_ETL_CLNT_OUTREACH_IDX2 on corp_etl_clnt_outreach(outreach_status) tablespace maxdat_indx;

create index DCORCUR_IX2 on D_COR_CURRENT (OUTREACH_REQUEST_STATUS) online tablespace MAXDAT_INDX parallel compute statistics;