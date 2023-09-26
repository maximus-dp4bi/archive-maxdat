declare
  v_jobnum number := null;
begin
  dbms_job.submit(
    job => v_jobnum,
    what => 'LOAD_DEMO_DATA_PKG.REFRESH_ALL_DEMO_DATA;',
    next_date => trunc(sysdate),
     interval => 'trunc(sysdate) + 27/24');
  commit;
end;
/
