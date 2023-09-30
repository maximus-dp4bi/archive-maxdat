/*
Created on 08/12/2015 by Raj A.
Description: Per NYHIX-16896, created this script to undo the Completion of the three instances (Incident_IDs: 26269604, 26300531, 26336160) and reprocess
them.
*/
delete bpm_update_event_queue
WHERE bsl_id = 23
AND IDENTIFIER IN (26269604, 26300531, 26336160);
commit;

delete f_appeals_by_date
where 1=1
and apl_bi_id in (select apl_bi_id from d_appeals_current where incident_id in (26269604, 26300531, 26336160))
and complete_date is not null;
commit;

update NYHBE_ETL_PROCESS_APPEALS
  set 
incident_status = 'Reschedule Hearing- DOH Request',      
incident_status_dt = to_date('8/3/2015 9:31:31 AM','mm/dd/yyyy hh:mi:ss AM'),   
max_inci_stat_hist_id = 1335467,
cancel_dt = null,
cancel_by = null,
cancel_reason = null,
cancel_method = null,
instance_status = 'Active',
complete_dt = null,
instance_complete_dt = null
WHERE 1=1
AND incident_id in (26269604);

update NYHBE_ETL_PROCESS_APPEALS
  set 
incident_status = 'Hearing Set - No Disposition Review',      
incident_status_dt = to_date('5/14/2015 1:13:11 PM','mm/dd/yyyy hh:mi:ss AM'),
max_inci_stat_hist_id = 1085532,
cancel_dt = null,
cancel_by = null,
cancel_reason = null,
cancel_method = null,
instance_status = 'Active',
complete_dt = null,
instance_complete_dt = null
WHERE 1=1
AND incident_id in (26300531);

update NYHBE_ETL_PROCESS_APPEALS
  set 
incident_status = 'Hearing Set - No Disposition Review',      
incident_status_dt = to_date('6/10/2015 1:02:21 PM','mm/dd/yyyy hh:mi:ss AM'),   
max_inci_stat_hist_id = 1168601,
cancel_dt = null,
cancel_by = null,
cancel_reason = null,
cancel_method = null,
instance_status = 'Active',
complete_dt = null,
instance_complete_dt = null
WHERE 1=1
AND incident_id in (26336160);
commit;