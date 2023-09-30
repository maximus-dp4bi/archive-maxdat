/*
insert into BPM_UPDATE_EVENT_QUEUE_ARCHIVE
select *
from BPM_UPDATE_EVENT_QUEUE_CONV;

commit;
*/

truncate table BPM_UPDATE_EVENT_QUEUE_CONV;