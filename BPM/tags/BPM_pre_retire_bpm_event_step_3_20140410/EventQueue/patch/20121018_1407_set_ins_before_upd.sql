-- Fix conversion queue rows where insert shows as having occurred after update due to incorrect EVENT_DATE.

declare

  cursor c_unproc_ins
  is
  select 
    BUEQ_ID,
    prev_event_date - (1/86400) lt_prev_event_date
  from 
    (select
       BUEQ_ID,
       BUE_ID,
       EVENT_DATE,
       lag(BUE_ID,1,BUE_ID) over (partition by IDENTIFIER order by EVENT_DATE asc) prev_bue_id,
       lag(EVENT_DATE,1,EVENT_DATE) over (partition by IDENTIFIER order by EVENT_DATE asc) prev_event_date,
       OLD_DATA
     from BPM_UPDATE_EVENT_QUEUE_CONV
     where 
       PROCESS_BUEQ_ID  is not null 
       and WROTE_BPM_SEMANTIC_DATE is null)
  where
    BUE_ID < prev_bue_id
    and OLD_DATA is null
  order by 
    lt_prev_event_date asc,
    BUEQ_ID asc;
     
begin
  
  for r_unproc_ins in c_unproc_ins
  loop
    update BPM_UPDATE_EVENT_QUEUE_CONV
    set EVENT_DATE = r_unproc_ins.lt_prev_event_date
    where BUEQ_ID = r_unproc_ins.BUEQ_ID;
  end loop;
  commit;

end;
/

-- Reset unprocessed rows so they can be processed.
update BPM_UPDATE_EVENT_QUEUE_CONV
set PROCESS_BUEQ_ID = null
where 
  PROCESS_BUEQ_ID is not null
  and WROTE_BPM_SEMANTIC_DATE is null;
  
commit;