update nyhx_etl_idr_incidents
set INSTANCE_STATUS ='Complete',
    instance_complete_dt=incident_status_dt,
    complete_dt=incident_status_dt,
    stage_done_date=incident_status_dt
where INCIDENT_STATUS like 'Incident Closed - IDR%';
commit;

   