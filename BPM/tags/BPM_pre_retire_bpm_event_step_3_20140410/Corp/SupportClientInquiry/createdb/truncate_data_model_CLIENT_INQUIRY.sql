/* truncate_data_model_CLIENT_INQUIRY.sql
 Date: 5/21/13

 From truncate_data_model_Manage_Jobs.sql
 steps:
 1. Deleting BPM Event Queue and archive.
 2. Deleting Semantic layer.
 BEM_id needs to be hard-coded for the process at 3 places and bsl_id at 2 places
 4. per Gary, delete ETL instances. 20130528_0110_fix_populate_lkup script to reset global control.
 */


-- *** Step 1a: event queue
DELETE FROM BPM_UPDATE_EVENT_QUEUE WHERE bsl_id=13;
COMMIT;


-- *** Step 1b: event queue archive
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
where BSL_ID != 13;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;
alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

create or replace public synonym BPM_UPDATE_EVENT_QUEUE_ARCHIVE for BPM_UPDATE_EVENT_QUEUE_ARCHIVE;
grant select on BPM_UPDATE_EVENT_QUEUE_ARCHIVE to MAXDAT_READ_ONLY;


-- *** Step 2: Remove BPM Semantic layer
truncate table F_SCI_BY_DATE;
alter table F_SCI_BY_DATE drop constraint FSCIBD_DSCICUR_FK;

truncate table D_SCI_CURRENT;
alter table F_SCI_BY_DATE add constraint FSCIBD_DSCICUR_FK foreign key (SCI_BI_ID) references D_SCI_CURRENT(SCI_BI_ID);



-- *** Step 4: Remove ETL instances
/* 6/4/13 Not needed
TRUNCATE TABLE corp_etl_client_inquiry;
TRUNCATE TABLE corp_etl_client_inquiry_dtl;
TRUNCATE TABLE corp_etl_client_inquiry_event;
*/






