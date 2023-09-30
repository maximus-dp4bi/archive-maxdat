/*
Created on 08/17/2015 by Raj A.
Description: Per NYHIX-16896, created the script, (20150812_1622_Reset_Three_Completed_Instances.sql) to undo the Completion of the three instances (Incident_IDs: 26269604, 26300531, 26336160) and reprocess
them. These three instances got instance_status = null and was choking up in the semantic layer. So, we are doing this update.
*/
delete bpm_update_event_queue
WHERE bsl_id = 23
AND IDENTIFIER IN (26269604, 26300531, 26336160);
commit;

update NYHBE_ETL_PROCESS_APPEALS
  set instance_status = 'Active'
WHERE 1=1
AND incident_id in (26269604);

update NYHBE_ETL_PROCESS_APPEALS
  set instance_status = 'Active'
WHERE 1=1
AND incident_id in (26300531);

update NYHBE_ETL_PROCESS_APPEALS
  set instance_status = 'Active'
WHERE 1=1
AND incident_id in (26336160);
commit;