-- Mark newer CDATA XML as not processed so processor runs it.
update BPM_UPDATE_EVENT_QUEUE 
set PROCESS_BUEQ_ID = null
where PROCESS_BUEQ_ID = -1 and to_char(QUEUE_DATE,'YYYY-MM-DD HH24') = '2012-09-26 21';

commit;