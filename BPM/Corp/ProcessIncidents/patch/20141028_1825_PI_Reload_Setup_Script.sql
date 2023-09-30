/*
Created on 28-Oct-2014 by Raj A.
Description: This script deletes the data in the ETL stages tables (ILEB PI) for a fresh reload.
Also, sets the global controls accordingly.
*/
delete from F_PI_BY_DATE;

delete from D_PI_CURRENT;

delete from D_PI_ENROLLMENT_STATUS;

delete from D_PI_INCIDENT_ABOUT;

delete from D_PI_INSTANCE_STATUS;

delete from D_PI_JEOPARDY_STATUS;

delete from D_PI_LAST_UPDATE_BY;

delete from D_PI_INCIDENT_REASON;

delete from D_PI_TASK_ID;

delete from D_PI_INCIDENT_STATUS;

delete from BPM_UPDATE_EVENT_QUEUE
where bsl_id=10;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
where bsl_id=10;

delete from corp_etl_process_incidents;

update corp_etl_control
   set value = 0
 where name = 'LAST_INCIDENT_ID';    
 
commit;