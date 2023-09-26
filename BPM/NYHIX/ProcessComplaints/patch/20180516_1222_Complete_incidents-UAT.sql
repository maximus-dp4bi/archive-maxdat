---- NYHIX-40557 close really old complaints (6,444 rows)

update MAXDAT.corp_etl_complaints_incidents 
set incident_status = 'Incident Closed', 
instance_status = 'Complete', 
last_update_by_dt= sysdate,
complete_dt = sysdate,
STAGE_DONE_DT = sysdate 
where last_update_by_dt <= sysdate - interval '2' year;

commit;