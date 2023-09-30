/*
Created on 09-May-2013 by Mayuresh Bhalekar.
Description:
This script is created to clean the BPM events and Semantic layer for a fresh reload of the State Review BPM Stage table.

steps:
1. Deleting BPM Event Queue.
2. Deleting Semantic layer.
*/

-- Remove from queue.
delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 17;

commit;


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
where BSL_ID != 17;

commit;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE; 

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

create or replace public synonym BPM_UPDATE_EVENT_QUEUE_ARCHIVE for BPM_UPDATE_EVENT_QUEUE_ARCHIVE;
grant select on BPM_UPDATE_EVENT_QUEUE_ARCHIVE to MAXDAT_READ_ONLY;


--------------------------------------------------------------------------------------
-- Remove from BPM Semantic.
truncate table F_CMOR_BY_DATE;
alter table F_CMOR_BY_DATE drop constraint FCMORBD_DCMORCUR_FK;

truncate table D_CMOR_CURRENT;
alter table F_CMOR_BY_DATE add constraint FCMORBD_DCMORCUR_FK foreign key (CMOR_BI_ID) references D_CMOR_CURRENT (CMOR_BI_ID);

commit;
--------------------------------------------------------------------------------------


-- *** Step 4: Remove ETL instances and rename COMMUNITY_ACTIVITIES  and CORP_ETL_COMMUNITY_ACTIVITIES
truncate table CORP_ETL_COMM_OUTREACH;

update corp_etl_control set value = '0' 
where name = 'LAST_COMM_OUTREACH_SESSION_ID';
commit;


ALTER TABLE COMMUNITY_ACTIVITIES RENAME TO CORP_ETL_COMMUNITY_ACTIVITIES;

create or replace view D_CMOR_ACTIVITIES_SV as
select * from CORP_ETL_COMMUNITY_ACTIVITIES
with read only;

ALTER TABLE COMMUNITY_ACTVTY_DETAILS_CHLD RENAME TO CORP_ETL_COMM_ACTY_DETAIL_CHLD;

create or replace view D_CMOR_ACTIVITIES_DETAILS_SV as
select * from CORP_ETL_COMM_ACTY_DETAIL_CHLD
with read only;
