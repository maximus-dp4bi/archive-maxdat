update BPM_UPDATE_EVENT_QUEUE_CONV
set PROCESS_BUEQ_ID = null
where 
  PROCESS_BUEQ_ID is not null
  and WROTE_BPM_SEMANTIC_DATE is null;
  
commit;

--execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_ALL_ROWS_ALL_BSL','100,''BPM_EVENT''');

execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');

execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');
execute PROCESS_BPM_QUEUE.CREATE_JOB('PROCESS_CONV_ROWS_BY_BSL','50,''BPM_SEMANTIC'',1');
