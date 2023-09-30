alter session set current_schema = MAXDAT;


update /+ parallel(10)/ maxdat.txeb_etl_chip_elig_events set
 instance_status = 'Complete'
 ,complete_dt = sysdate
 ,cancel_by = 'TXEB-13339'
 ,cancel_reason = 'Instance did not complete as expected'
 ,cancel_dt = sysdate
 ,cancel_method = 'JIRA'
 ,update_dt = sysdate
 ,update_by_name = 'TXEB-13339'
 where instance_status = 'Active'
 and tecee_id >= 3981845
 AND create_dt < to_date('01/23/2019 00:00:00','mm/dd/yyyy hh24:mi:ss');

commit;

update /+ parallel(10)/ maxdat.txeb_etl_chip_elig_events 
set stage_done_date = complete_dt
where instance_status = 'Complete'
and tecee_id >= 3981845
AND create_dt < to_date('01/23/2019 00:00:00','mm/dd/yyyy hh24:mi:ss')
AND stage_done_date IS NULL;

commit;