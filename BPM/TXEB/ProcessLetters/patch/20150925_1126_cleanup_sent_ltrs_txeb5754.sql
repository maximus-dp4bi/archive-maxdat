update corp_etl_proc_letters
set status = 'Sent', sent_dt = status_dt
where letter_request_id in(33168053, 33168173);

commit;