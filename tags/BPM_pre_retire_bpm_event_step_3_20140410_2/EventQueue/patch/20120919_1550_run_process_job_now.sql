declare
  jobno number := null;
begin
  dbms_job.submit(
    job => jobno,
    what => 'PROCESS_BPM_QUEUE.PROCESS_ALL_ROWS_ALL_BSL(100);',
    next_date => sysdate,
    interval => null);
end;
/

--select * from user_jobs;
