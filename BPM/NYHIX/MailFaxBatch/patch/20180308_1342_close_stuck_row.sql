
execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete from maxdat.bpm_update_event_queue where bsl_id=16 and
 IDENTIFIER ='{03037dd3-9a33-4d29-b71c-e661ca86cfa1}';
 
commit;

execute MAXDAT_ADMIN.STARTUP_JOBS;