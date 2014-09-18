-- Stop control job.
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_CONTROL_JOB;

-- Fix incorrect meta-data.
update PROCESS_BPM_QUEUE_JOB
set 
  BSL_ID = 1,
  BDM_ID = 1,
  BATCH_SIZE = 1
where
  BSL_ID  is null
  and BDM_ID is null;
  
commit;

-- Stop jobs with incorrect meta-data.
update PROCESS_BPM_QUEUE_JOB
set 
  STATUS = 'STOPPED',
  END_DATE = sysdate,
  STATUS_DATE = sysdate
where
  STATUS = 'STARTED';
  
commit;

-- Stop 'STARTED' jobs.

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(5459);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(5559);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(5759);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(5859);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(6103);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(6107);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(6439);
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_JOB_BY_ID(6603);

-- Stop all jobs.  (will take about 15 minutes to run)
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_ALL_JOBS;

-- Drop constraints and indexes.
alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop constraint BUEQA_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_CONV drop constraint BUEQC_BUE_ID_FK;
drop index BUEQ_LX6;

-- Create table with list of duplicate BI_IDs.
create table TMP_DUP_IDENTIFIERS
as 
select bi.BI_ID
from 
  BPM_INSTANCE bi,
  (select IDENTIFIER
   from BPM_INSTANCE
   where BSL_ID = 2
   group by IDENTIFIER
   having count(IDENTIFIER) > 1) dup_identifiers
where 
  bi.IDENTIFIER = dup_identifiers.IDENTIFIER
  and BIL_ID = 3;
    
-- Cleanup duplicate instances.
declare
  cursor c_bi_ids 
  is 
  select BI_ID
  from TMP_DUP_IDENTIFIERS;
begin
  for r_bi_id in c_bi_ids
  loop
  
    delete from BPM_INSTANCE_ATTRIBUTE
    where BI_ID = r_bi_id.BI_ID;

    delete from BPM_UPDATE_EVENT 
    where BI_ID = r_bi_id.BI_ID;

    delete from BPM_INSTANCE 
    where BI_ID = r_bi_id.BI_ID
      and BEM_ID = 2 
      and BIL_ID = 3;
    
    commit;
    
  end loop;
end;
/

-- Drop temp table.
drop table TMP_DUP_IDENTIFIERS;

-- Recreate constraints and indexes.
create index BUEQ_LX6 on BPM_UPDATE_EVENT_QUEUE (BUE_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT_QUEUE_CONV add constraint BUEQC_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

-- Fix BIL_ID;
update BPM_INSTANCE
set BIL_ID = 2
where BEM_ID = 2 and BIL_ID != 2;

commit;

-- Fix stuck processing queue rows.
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where PROCESS_BUEQ_ID is not null;

commit;

-- Start BPM processing jobs.
execute PROCESS_BPM_QUEUE_JOB_CONTROL.CREATE_CONTROL_JOB;
