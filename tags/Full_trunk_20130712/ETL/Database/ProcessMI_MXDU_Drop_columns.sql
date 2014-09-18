/*
Created on 14-Sep-2012 by Raj A.
Description:
This script is needed to drop the columns in NYEC_ETL_PROCESS_MI BPM stage table.
These should not exist. Pre-BPM stage table, PROCESS_MI_STG does NOT have too.

This is not needed during promotion to MXDP, as I changed the create table script today.
*/
alter table nyec_etl_process_mi
drop (
ST_ACCEPT_TASK_ID,
ST_ACCEPT_COMPLETE_DATE,
ST_ACCEPT_COMPLETED_BY
)
;