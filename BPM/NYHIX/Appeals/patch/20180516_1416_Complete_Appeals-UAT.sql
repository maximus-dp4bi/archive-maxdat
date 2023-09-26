---- NYHIX-40557 close really old complaints (4541 rows)

update MAXDAT.NYHBE_ETL_PROCESS_APPEALS
set incident_status = 'Appeal Closed', 
instance_status = 'Complete', 
last_update_by_dt= sysdate,
complete_dt = sysdate,
STAGE_DONE_DT = sysdate 
where incident_status_dt <= sysdate - interval '1' year
and instance_status = 'Active';

commit;