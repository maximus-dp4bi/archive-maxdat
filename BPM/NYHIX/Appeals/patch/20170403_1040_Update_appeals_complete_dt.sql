update MAXDAT.NYHBE_ETL_PROCESS_APPEALS
set complete_dt = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INSTANCE_COMPLETE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   STAGE_DONE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INCIDENT_STATUS = 'Incident Closed - Duplicate'
,   INSTANCE_STATUS = 'Complete'
,   CURRENT_STEP = 'Closed'
WHERE INCIDENT_ID = 26623762
;

commit;

update MAXDAT.NYHBE_ETL_PROCESS_APPEALS
set complete_dt = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INSTANCE_COMPLETE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   STAGE_DONE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INCIDENT_STATUS = 'Dismissed'
,   INSTANCE_STATUS = 'Complete'
,   CURRENT_STEP = 'Closed'
WHERE INCIDENT_ID = 26731321
;

commit;

update MAXDAT.NYHBE_PROCESS_APPEALS_OLTP
set complete_dt = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INSTANCE_COMPLETE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   STAGE_DONE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INCIDENT_STATUS = 'Incident Closed - Duplicate'
,   INSTANCE_STATUS = 'Complete'
,   CURRENT_STEP = 'Closed'
WHERE INCIDENT_ID = 26623762
;

commit;

update MAXDAT.NYHBE_PROCESS_APPEALS_OLTP
set complete_dt = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INSTANCE_COMPLETE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   STAGE_DONE_DT = to_date('11/21/2016 15:20:21','mm/dd/yyyy hh24:mi:ss')
,   INCIDENT_STATUS = 'Dismissed'
,   INSTANCE_STATUS = 'Complete'
,   CURRENT_STEP = 'Closed'
WHERE INCIDENT_ID = 26731321
;

commit;
