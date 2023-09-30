/*
Created on 04/14/2015 by Raj A.

Tickets created:
ILEB-4652
The stage table, ETL_E_DIALER_RUN_STG has many duplicates and missing many records when compared to the source system.
So, we are cleaning up all stage tables and reloading data from 01-Mar-2015.

Description: Loading the ETL_E_DIALER_RUN_STG from 1-Mar-2015 is taking several days. So, killing the cron job (ILEB-4666) and loading in chunks,
i.e., a week first and then another week, etc.
*/
update  corp_etl_job_statistics
   set job_start_date = to_date('2015/04/10 00:00:00','yyyy/mm/dd hh24:mi:ss')
  WHERE 1=1
    AND job_status_cd = 'COMPLETED'
    AND job_name = 'OutboundCalls_Runall';
update corp_etl_control
   set value = 65634
 where Name = 'OUTBOUNDCALL_LAST_JOB_ID';
update corp_etl_control
   set value = 0
 where Name = 'OUTBOUNDCALL_LAST_ROW_ID';
update corp_etl_control
   set value = 350
 where Name = 'OUTBOUNDCALL_NUM_OF_DAYS'; 
update corp_etl_control
   set value =  3246336
 WHERE name = 'OUTBOUNDCALL_LAST_ATTEMPT_ID';
commit;