declare
  cursor c_reset
  is
  select 
    BUEQ_ID,
    QUEUE_DATE
  from 
    BPM_UPDATE_EVENT_QUEUE bueq,
    BPM_INSTANCE bi
  where 
    bueq.BSL_ID = 1
    and bueq.PROCESS_BUEQ_ID is null
    and bueq.WROTE_BPM_EVENT_DATE is null
    and bueq.OLD_DATA is null
    and bueq.IDENTIFIER = bi.IDENTIFIER
    and bueq.BSL_ID = bi.BSL_ID;
begin
  for r_reset in c_reset
  loop
    update BPM_UPDATE_EVENT_QUEUE 
    set WROTE_BPM_EVENT_DATE = r_reset.QUEUE_DATE
    where BUEQ_ID = r_reset.BUEQ_ID;
    commit;
  end loop;
end;
/