/*
Created on 24-Aug-2012 by Rajneesh.
Description: Created these columns due to mismath while updating between NYEC_ETL_MONITOR_RENEWAL 
and monitor_renewal_stg

*/
Alter table NYEC_ETL_MONITOR_RENEWAL
add app_status_dt date;

Alter table NYEC_ETL_MONITOR_RENEWAL
add app_status varchar2(40);

Alter table NYEC_ETL_MONITOR_RENEWAL
add  app_in_process varchar2(1);

Alter table NYEC_ETL_MONITOR_RENEWAL
add  STG_LAST_PROCESSED_DT date;
