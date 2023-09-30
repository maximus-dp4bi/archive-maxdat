-- Outbound Calls, missing temp table indexes


create index CORP_ETL_OUTBND_CALL_OLTP_IDX1 on CORP_ETL_PROC_OUTBND_CALL_OLTP (CEPOC_ID)
tablespace MAXDAT_INDX;

create index CORP_ETL_OUTBND_CALL_WIP_IDX1 on CORP_ETL_PROC_OUTBND_CALL_WIP (CEPOC_ID)
tablespace MAXDAT_INDX;



