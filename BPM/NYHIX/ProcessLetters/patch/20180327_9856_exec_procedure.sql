alter session set current_schema = MAXDAT;

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID=12;
commit;

Begin 
 FIX_PROCESS_LETTERS_BPM;
End;


execute MAXDAT_ADMIN.STARTUP_JOBS;
 