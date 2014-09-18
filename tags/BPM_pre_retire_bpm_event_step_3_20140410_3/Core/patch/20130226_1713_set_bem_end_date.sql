update BPM_EVENT_MASTER 
set END_DATE = to_date('2077-07-07','YYYY-MM-DD')
where END_DATE = to_date('7777-07-07','YYYY-MM-DD')

commit;