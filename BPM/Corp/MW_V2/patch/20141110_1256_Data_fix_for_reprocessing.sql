/*
Created on 11/10/2014 by Raj A.
Description: NYHIX-11287.
This script will reprocess some missed step_instance_stg records. This happened because MW V2 wasn't running 24x7. On 11/04 , it ran until 8PM only.
Along with this script, we change global controls to run 24x7 now.
*/
begin

for cur_rec in (
select v2.task_id, v2.complete_date, sis.status, sis.completed_ts, sis.create_ts
  from step_instance_stg sis
  join corp_etl_mw_v2 v2 on sis.step_instance_id = v2.task_id
                       and sis.status = 'COMPLETED'
                       and v2.complete_date is null
                  ) 
loop
  update step_instance_stg
    set mw_v2_processed = 'N'
   where hist_status = 'COMPLETED'
     and step_instance_id = cur_rec.task_id; 
     
    update  corp_etl_mw_v2
      set task_status = 'CLAIMED'
    where task_id = cur_rec.task_id; 
  
end loop;
commit;
end;