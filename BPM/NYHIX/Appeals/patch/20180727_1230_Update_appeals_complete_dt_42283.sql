-- NYHIX-42283 - UAT
select incident_id, complete_dt, instance_complete_dt, stage_done_dt, incident_status, instance_status, current_step
from   MAXDAT.NYHBE_ETL_PROCESS_APPEALS
where  INCIDENT_ID = 26131271;

update MAXDAT.NYHBE_ETL_PROCESS_APPEALS
set complete_dt = to_date('06/25/2018 00:00:00','mm/dd/yyyy hh24:mi:ss')
,   INSTANCE_COMPLETE_DT = to_date('06/25/2018 00:00:00','mm/dd/yyyy hh24:mi:ss')
,   STAGE_DONE_DT = to_date('06/25/2018 00:00:00','mm/dd/yyyy hh24:mi:ss')
,   INCIDENT_STATUS = 'Incident Closed - Duplicate'
,   INSTANCE_STATUS = 'Complete'
,   CURRENT_STEP = 'Closed'
WHERE INCIDENT_ID = 26131271
;

commit;

select incident_id, complete_dt, instance_complete_dt, stage_done_dt, incident_status, instance_status, current_step
from   MAXDAT.NYHBE_ETL_PROCESS_APPEALS
where  INCIDENT_ID = 26131271;
----------------------------------------------
select incident_id, complete_dt, instance_complete_dt, stage_done_dt, incident_status, instance_status, current_step
from   MAXDAT.NYHBE_PROCESS_APPEALS_OLTP
where  INCIDENT_ID = 26131271;

update MAXDAT.NYHBE_PROCESS_APPEALS_OLTP
set complete_dt = to_date('06/25/2018 00:00:00','mm/dd/yyyy hh24:mi:ss')
,   INSTANCE_COMPLETE_DT = to_date('06/25/2018 00:00:00','mm/dd/yyyy hh24:mi:ss')
,   STAGE_DONE_DT = to_date('06/25/2018 00:00:00','mm/dd/yyyy hh24:mi:ss')
,   INCIDENT_STATUS = 'Incident Closed - Duplicate'
,   INSTANCE_STATUS = 'Complete'
,   CURRENT_STEP = 'Closed'
WHERE INCIDENT_ID = 26131271
;

commit;

select incident_id, complete_dt, instance_complete_dt, stage_done_dt, incident_status, instance_status, current_step
from   MAXDAT.NYHBE_PROCESS_APPEALS_OLTP
where  INCIDENT_ID = 26131271;
