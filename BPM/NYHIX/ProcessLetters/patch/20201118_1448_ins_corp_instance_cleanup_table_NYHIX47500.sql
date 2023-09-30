INSERT INTO corp_instance_cleanup_table(system_name,cleanup_name,run,start_date,start_time,end_date,end_time,statement,created_ts,last_update_ts)
VALUES('PROCESS_LETTERS',
'CLEANUP_mismatched_letter_status',
'Y',
TRUNC(sysdate),
'00:00:00',
TO_DATE('07/07/7777','mm/dd/yyyy'),
'23:59:00',
'MERGE INTO corp_etl_proc_letters cp USING(SELECT p.letter_request_id,p.status,s.letter_status,s.letter_sent_on, s.letter_printed_on, s.letter_mailed_date FROM corp_etl_proc_letters p JOIN letters_stg s on p.letter_request_id = s.letter_id WHERE instance_status = ''Complete'' AND p.status <> s.letter_status) ncp ON (cp.letter_request_id = ncp.letter_request_id) 
WHEN MATCHED THEN UPDATE SET cp.status = ncp.letter_status,cp.sent_dt = ncp.letter_sent_on,cp.print_dt = ncp.letter_printed_on,cp.mailed_dt = ncp.letter_mailed_date',
sysdate,
sysdate);

commit;