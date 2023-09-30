execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(14,1,'ENABLED','N');

update BPM_UPDATE_EVENT_QUEUE
set WROTE_BPM_EVENT_DATE = QUEUE_DATE
where BSL_ID = 14
  and WROTE_BPM_EVENT_DATE is null;

commit;

execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(14);
