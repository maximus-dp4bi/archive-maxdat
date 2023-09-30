/*
Created on 18-Jul-2013 by Raj A.
Description:
This script is created to clean the BPM events and Semantic layer for a fresh reload of the Manage Enrollment Activity 
(corp_etl_manage_enroll) Stage table.

steps:
1. Deleting BPM Event Queue.
2. Deleting Semantic layer.
BEM_id need to hard coded for the process at 3 places and bsl_id at 2 places
*/

-- Remove from queue.
DELETE FROM BPM_UPDATE_EVENT_QUEUE WHERE bsl_id = 14;
COMMIT;


-- Remove from queue archive.  Also remove any event, for all processes, over 7 days old.

-- OK if this drop table fails because table does not exist.
drop table BUEQ_ARCHIVE_TEMP;

create table BUEQ_ARCHIVE_TEMP
  (BUEQ_ID number not null,
   BSL_ID number not null,
   BIL_ID number not null,
   IDENTIFIER varchar2(100) not null,
   EVENT_DATE date not null,
   QUEUE_DATE date not null,
   PROCESS_BUEQ_ID number,
   WROTE_BPM_EVENT_DATE date,
   WROTE_BPM_SEMANTIC_DATE date, 
   DATA_VERSION number not null,
   OLD_DATA xmltype,
   NEW_DATA xmltype not null)
xmltype column OLD_DATA store as binary xml
xmltype column NEW_DATA store as binary xml
partition by range (BSL_ID)
interval (1) (partition PT_BUEQ_LT_0 values less than (0)) 
parallel;

insert into BUEQ_ARCHIVE_TEMP
select * from BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
where BSL_ID != 14;


insert into BUEQ_ARCHIVE_TEMP
select 
  BUEQ_ID,
  BSL_ID,
  BIL_ID,
  IDENTIFIER,
  EVENT_DATE,
  QUEUE_DATE,
  PROCESS_BUEQ_ID,
  WROTE_BPM_EVENT_DATE,
  WROTE_BPM_SEMANTIC_DATE, 
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
from BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
where BSL_ID != 14;

commit;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

create or replace public synonym BPM_UPDATE_EVENT_QUEUE_ARCHIVE for BPM_UPDATE_EVENT_QUEUE_ARCHIVE;
grant select on BPM_UPDATE_EVENT_QUEUE_ARCHIVE to MAXDAT_READ_ONLY;


--------------------------------------------------------------------------------------
-- Remove from BPM Semantic.
truncate table F_ME_BY_DATE;
alter table F_ME_BY_DATE drop constraint FMEBD_DMECUR_FK;

truncate table D_ME_CURRENT;
alter table F_ME_BY_DATE add constraint FMEBD_DMECUR_FK foreign key (ME_BI_ID) references D_ME_CURRENT (ME_BI_ID);
--------------------------------------------------------------------------------------
