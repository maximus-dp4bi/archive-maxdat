update BPM_INSTANCE
set IDENTIFIER = IDENTIFIER || '_0'
where BEM_ID = 2;

commit;

update BPM_UPDATE_EVENT_QUEUE
set IDENTIFIER = IDENTIFIER || '_0'
where BSL_ID = 2;

commit;

update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
set IDENTIFIER = IDENTIFIER || '_0'
where BSL_ID = 2;

commit;