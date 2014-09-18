-- Remove BPM instance incorrectly inserted.
delete from BPM_INSTANCE_ATTRIBUTE where BI_ID = 497314;
delete from BPM_UPDATE_EVENT where BI_ID = 497314;
delete from BPM_INSTANCE where BI_ID = 497314;
update BPM_UPDATE_EVENT_QUEUE set WROTE_BPM_EVENT_DATE = null where IDENTIFIER = 3856142;

-- Temporarily mark all newer CDATA XML as processed so processor skips it.
update BPM_UPDATE_EVENT_QUEUE 
set PROCESS_BUEQ_ID = -1 
where QUEUE_DATE >= to_date('2012-09-26 21','YYYY-MM-DD HH24');

-- Mark some older non-CDATA XML as not processed so processor reruns it.
update BPM_UPDATE_EVENT_QUEUE 
set PROCESS_BUEQ_ID = null
where to_char(QUEUE_DATE,'YYYY-MM-DD HH24') = '2012-09-26 08';

commit;