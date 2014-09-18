declare
  v_jobnum number := null;
begin
  dbms_job.submit(
    job => v_jobnum,
    what => 'MAINTAIN_BPM_D_DATES;',
    next_date => sysdate,
    interval => 'trunc(sysdate + 1)');
  commit;
end;
/

commit;

