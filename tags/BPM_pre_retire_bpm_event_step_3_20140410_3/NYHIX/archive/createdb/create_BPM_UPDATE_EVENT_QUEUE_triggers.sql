alter session set plsql_code_type = native;

create or replace trigger TRG_BI_BPM_UPDATE_EVENT_QUEUE
before insert on BPM_UPDATE_EVENT_QUEUE 
for each row
begin
  if :new.BSL_ID in (1,16,18,21,22,23) then
    :new.WROTE_BPM_EVENT_DATE := :new.QUEUE_DATE;
  end if;
end;
/
 
alter session set plsql_code_type = interpreted;