/*
Created on 01/22/2016 by Raj A.
Description: Index created for Document Notification process; Used in ProcessDocNotifications_Update1_150.ktr
*/
create index IDX_MW_V2_Src_proc_inst_id on CORP_ETL_MW_V2 (SOURCE_PROCESS_INSTANCE_ID) TABLESPACE  MAXDAT_INDX ;