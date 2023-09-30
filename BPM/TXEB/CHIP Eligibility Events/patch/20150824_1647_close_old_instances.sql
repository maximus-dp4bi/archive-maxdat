 UPDATE txeb_etl_chip_elig_events
 SET instance_end_date = sysdate,
 instance_status = 'Complete',
 stage_done_date = sysdate,
 complete_dt = sysdate,
 ased_process_elig_event = sysdate,
 asf_process_elig_event = 'Y',
 aspb_process_elig_event = 'TXEB-5620'
 WHERE  SYS_TRAN_STAGE_NAME in ('POST_PROCESS_PASS', 'REPROCESSED_FINAL_PASS')
 AND instance_status = 'Active'
 AND (( create_dt < to_date('08/15/2015','mm/dd/yyyy') AND event_cd in ('ADDR_UPDATED', 'NEW', 'RENEWAL', 'REACTIVATION') )
 OR (create_dt < to_date('07/01/2015','mm/dd/yyyy')) );

commit;