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

-- Stop all jobs.  (will take about 15 minutes to run)
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STOP_ALL_JOBS;

-- Drop or truncate old temp tables.
drop table BIA_BACKUP;
drop table BPM_UPDATE_EVENT_BACKUP;
truncate table BPM_UPDATE_EVENT_QUEUE_CONV;
drop table BUEQ_ARCHIVE_BACKUP;  -- table exists only on UAT

-- Repartition PROCESS_BPM_QUEUE_JOB_BATCH table.
create table TMP_PBQJB
  (PBQJB_ID number not null,
   PBQJ_ID  number not null,
   BATCH_ID number,
   PROCESS_BUEQ_ID number,
   BATCH_START_DATE date not null,
   BATCH_END_DATE date,
   LOCKING_START_DATE date,
   LOCKING_END_DATE date,
   RESERVE_START_DATE date,
   RESERVE_END_DATE date,
   PROC_XML_START_DATE date,
   PROC_XML_END_DATE date,
   NUM_SLEEP_SECONDS number default(0) not null,
   NUM_QUEUE_ROWS_IN_BATCH number default(0) not null,
   NUM_BPM_EVENT_INSERT number default(0) not null,
   NUM_BPM_EVENT_UPDATE number default(0) not null,
   NUM_BPM_SEMANTIC_INSERT number default(0) not null,
   NUM_BPM_SEMANTIC_UPDATE number default(0) not null,
   STATUS_DATE date not null)
storage (initial 64K)
partition by range (BATCH_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BE_ERROR_DATE_LT_2013 values less than (to_date('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

insert into TMP_PBQJB
  (PBQJB_ID,
   PBQJ_ID,
   BATCH_ID,
   PROCESS_BUEQ_ID,
   BATCH_START_DATE,
   BATCH_END_DATE,
   LOCKING_START_DATE,
   LOCKING_END_DATE,
   RESERVE_START_DATE,
   RESERVE_END_DATE,
   PROC_XML_START_DATE,
   PROC_XML_END_DATE,
   NUM_SLEEP_SECONDS,
   NUM_QUEUE_ROWS_IN_BATCH,
   NUM_BPM_EVENT_INSERT,
   NUM_BPM_EVENT_UPDATE,
   NUM_BPM_SEMANTIC_INSERT,
   NUM_BPM_SEMANTIC_UPDATE,
   STATUS_DATE)
select
   PBQJB_ID,
   PBQJ_ID,
   BATCH_ID,
   PROCESS_BUEQ_ID,
   BATCH_START_DATE,
   BATCH_END_DATE,
   LOCKING_START_DATE,
   LOCKING_END_DATE,
   RESERVE_START_DATE,
   RESERVE_END_DATE,
   PROC_XML_START_DATE,
   PROC_XML_END_DATE,
   NUM_SLEEP_SECONDS,
   NUM_QUEUE_ROWS_IN_BATCH,
   NUM_BPM_EVENT_INSERT,
   NUM_BPM_EVENT_UPDATE,
   NUM_BPM_SEMANTIC_INSERT,
   NUM_BPM_SEMANTIC_UPDATE,
   STATUS_DATE
from PROCESS_BPM_QUEUE_JOB_BATCH;

drop table PROCESS_BPM_QUEUE_JOB_BATCH;

alter table TMP_PBQJB rename to PROCESS_BPM_QUEUE_JOB_BATCH;

alter table PROCESS_BPM_QUEUE_JOB_BATCH add constraint PBQJB_PK primary key (PBQJB_ID);
alter index PBQJB_PK  rebuild tablespace MAXDAT_INDX parallel;

create index PBQJB_LX1 on PROCESS_BPM_QUEUE_JOB_BATCH (PBQJ_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index PBQJB_LX2 on PROCESS_BPM_QUEUE_JOB_BATCH (BATCH_START_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

-- Recompile packages.
alter session set plsql_code_type = native;
alter package PROCESS_BPM_QUEUE compile;
alter package PROCESS_BPM_QUEUE_JOB_CONTROL compile;
alter session set plsql_code_type = interpreted;

-- Fix stuck processing queue rows.
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where PROCESS_BUEQ_ID is not null;

commit;

-- Start BPM processing jobs.
execute PROCESS_BPM_QUEUE_JOB_CONTROL.CREATE_CONTROL_JOB;