update BPM_UPDATE_EVENT_QUEUE set PROCESS_BUEQ_ID = null where PROCESS_BUEQ_ID is not null;
commit;

execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');

execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_SEMANTIC''');


