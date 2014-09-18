
update corp_etl_list_lkup
set out_var='''OUTREACH REQUEST'''
where name='PI_INCIDENT_HEADER_TYPE';

update corp_etl_control
set value=30
where name='INC_LOOK_BACK_DAYS';

update corp_etl_control
set value=0
where name='LAST_INCIDENT_ID';

delete from corp_etl_process_incidents;

delete from process_incidents_oltp;

delete from process_incidents_wip_bpm;

delete from bpm_update_event_queue
where bsl_id=10;

delete from bpm_update_event_queue_archive
where bsl_id=10;

delete from bpm_instance_attribute
where bi_id in (select bi_id from bpm_instance where bsl_id=10);

delete from bpm_update_event
where bi_id in (select bi_id from bpm_instance where bsl_id=10);

delete from bpm_instance
where bsl_id=10;

delete from F_PI_BY_DATE;

delete from D_PI_CURRENT;

commit;

