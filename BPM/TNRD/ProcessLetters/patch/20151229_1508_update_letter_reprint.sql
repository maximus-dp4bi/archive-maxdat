update corp_etl_proc_letters
set reprint = 'Y'
where letter_request_id in(320,
10340,
10341);

commit;