/*
Created on 05/05/2015 by Raj A.
Adding indexes to the Outbound Calls stage tables.
*/
create index MAXDAT.OC_OLTP_instance_status on MAXDAT.CORP_ETL_PROC_OUTBND_CALL_OLTP (INSTANCE_STATUS)
  tablespace MAXDAT_INDX
  ;
  
create index MAXDAT.OC_WIP_instance_status on MAXDAT.CORP_ETL_PROC_OUTBND_CALL_WIP (INSTANCE_STATUS)
  tablespace MAXDAT_INDX
  ;