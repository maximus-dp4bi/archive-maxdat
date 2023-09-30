update corp_etl_process_incidents
set assd_identify_rsrch_incident = create_dt
where instance_status = 'Active'
and assd_identify_rsrch_incident != create_dt;

update corp_etl_process_incidents
set assd_identify_rsrch_incident = create_dt
where instance_status = 'Complete'
and assd_identify_rsrch_incident != create_dt
and trunc(create_dt) >= trunc(sysdate,'mm');

commit;