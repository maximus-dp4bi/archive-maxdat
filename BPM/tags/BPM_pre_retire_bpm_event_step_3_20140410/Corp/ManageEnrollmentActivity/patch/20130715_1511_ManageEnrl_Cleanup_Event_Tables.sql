/*
Created on 15-Jul-2013 by Raj A.
Description:
This script cleans up the Event tables for Manage enrollment activity so the queue can start fresh.
*/
update BPM_UPDATE_EVENT_QUEUE
   set process_bueq_id      = null,
       wrote_bpm_event_date = null,
       BUE_ID               = null 
where bsl_id = 14;
commit;


delete bpm_instance_attribute
where bi_id in (select bi_id from bpm_instance where bem_id = 14);
commit;


delete bpm_update_event
where bi_id in (select bi_id from bpm_instance where bem_id = 14);
commit;


delete bpm_instance
where bem_id = 14;
commit;
