alter table BPM_UPDATE_EVENT_QUEUE modify (IDENTIFIER varchar2(35));

update BPM_UPDATE_EVENT_QUEUE
set IDENTIFIER = IDENTIFIER || '_0'
where BSL_ID = 2;

commit;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE modify (IDENTIFIER varchar2(35));

update BPM_UPDATE_EVENT_QUEUE_ARCHIVE
set IDENTIFIER = IDENTIFIER || '_0'
where BSL_ID = 2;

commit;