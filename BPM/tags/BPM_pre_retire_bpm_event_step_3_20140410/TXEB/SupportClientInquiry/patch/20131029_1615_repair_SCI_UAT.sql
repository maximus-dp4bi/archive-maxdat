create table BPM_UPDATE_EVENT_QUEUE_BCK
as select * from BPM_UPDATE_EVENT_QUEUE;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where BSL_ID = 13;

commit;

declare
  cursor c_first_bueq_ids
  is
  select 
    IDENTIFIER,
    min(BUEQ_ID) min_bueq_id
  from BPM_UPDATE_EVENT_QUEUE 
  where 
    BSL_ID = 13 
    and IDENTIFIER not in ('26216060','26216061','26233065')
  group by IDENTIFIER;

begin
  for r_first_bueq_id in c_first_bueq_ids
  loop
    update BPM_UPDATE_EVENT_QUEUE
    set OLD_DATA = null
    where 
      BUEQ_ID = r_first_bueq_id.min_bueq_id
      and IDENTIFIER = r_first_bueq_id.IDENTIFIER
      and BSL_ID = 13;
      
    commit;
  end loop;
end;
/

update F_SCI_
6585	2013-09-10 18:10:27	2013-09-10 00:00:00	2013-09-11 00:00:00	6833259
6586	2013-09-11 05:01:48	2013-09-11 00:00:00	2077-07-07 00:00:00	6833259
6605	2013-09-11 11:43:47	2013-09-11 00:00:00	2013-09-12 00:00:00	13073277
6606	2013-09-12 05:04:13	2013-09-12 00:00:00	2077-07-07 00:00:00	13073277
22470	2013-09-17 09:54:15	2013-09-17 00:00:00	2013-09-18 00:00:00	23897449
22471	2013-09-18 05:03:30	2013-09-18 00:00:00	2077-07-07 00:00:00	23897449