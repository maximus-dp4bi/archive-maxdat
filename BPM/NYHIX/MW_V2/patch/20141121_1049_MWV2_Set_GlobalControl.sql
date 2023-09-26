/*
Created on 11/21/2014 by Raj A.
Description: Setting global control to load all Completed Instances on or after 07/01/2014. 
First batch: Loaded in-process only.
second batch: Loaded completed instances on or after 09/01/2014.
*/
update corp_etl_list_lkup
   set out_var = 'and exists (select 1 from step_instance_stg sis where task_id = sis.step_instance_id and sis.status = ''COMPLETED'' and COMPLETED_TS >= to_date(''07/01/2014 00:00:00'',''mm/dd/yyyy hh24:mi:ss''))'
  where name = 'MW_V2_ADD_TO_WHERE_CLAUSE';
  commit;
