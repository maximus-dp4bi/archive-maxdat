execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_CONTROL_JOB;

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_ALL_JOBS;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where PROCESS_BUEQ_ID is not null;

commit;

execute PROCESS_BPM_QUEUE_JOB_CONTROL.CREATE_CONTROL_JOB;