-- Stop currently executing jobs

execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_985');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_986');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_987');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_988');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_989');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_990');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_991');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_992');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_993');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_994');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_995');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_996');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_997');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_998');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_999');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1000');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1001');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1002');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1003');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1004');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1005');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1006');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1007');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1008');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1009');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1010');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1011');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1012');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1013');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1014');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1015');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1016');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1017');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1018');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1019');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1020');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1021');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1022');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1023');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1024');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1025');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1026');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1027');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1028');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1029');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1030');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1031');
execute PROCESS_BPM_QUEUE.STOP_JOB('PROCESS_ALL_ROWS_BY_BSL_1032');


-- Release any user locks that may still be held
select user_lock.release(120011) from dual;
select user_lock.release(120012) from dual;
select user_lock.release(120021) from dual;
select user_lock.release(120022) from dual;
select user_lock.release(120041) from dual;
select user_lock.release(120042) from dual;


-- Reset end data for any queue jobs that were previously killed
update PROCESS_BPM_QUEUE_JOB
   set END_DATE=START_DATE
 where END_DATE is null;

update PROCESS_BPM_QUEUE_JOB
   set STATUS='STOPPED';

commit;


-- Reset queue jobs that were in process
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null;

commit;