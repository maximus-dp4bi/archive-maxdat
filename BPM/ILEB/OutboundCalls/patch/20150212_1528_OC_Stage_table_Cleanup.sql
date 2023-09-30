/*
Created on 04/08/2015 by Raj A.
Description: The stage table, ETL_E_DIALER_RUN_STG has many duplicates and missing many records when compared to the source system.
So, we are cleaning up all stage tables and reloading data from 01-Mar-2015.
*/
truncate table ETL_E_DIALER_RUN_STG;
truncate table corp_etl_proc_outbnd_call;
truncate table CORP_ETL_PROC_OUTBND_CALL_DTL;
truncate table F_OBC_BY_DATE;
alter table F_OBC_BY_DATE disable constraint FOBCBD_DOBCCUR_FK; 
truncate table D_OBC_CURRENT;        
alter table F_OBC_BY_DATE enable constraint FOBCBD_DOBCCUR_FK;   

update  corp_etl_job_statistics
   set job_start_date = to_date('2015/02/28 00:00:00','yyyy/mm/dd hh24:mi:ss')
  WHERE 1=1
    AND job_status_cd = 'COMPLETED'
    AND job_name = 'OutboundCalls_Runall';
update corp_etl_control
   set value = 0
 where Name = 'OUTBOUNDCALL_LAST_JOB_ID';
update corp_etl_control
   set value = 0
 where Name = 'OUTBOUNDCALL_LAST_ROW_ID';
update corp_etl_control
   set value = 350
 where Name = 'OUTBOUNDCALL_NUM_OF_DAYS'; 
update corp_etl_control
   set value =  3166336
 WHERE name = 'OUTBOUNDCALL_LAST_ATTEMPT_ID';
commit;