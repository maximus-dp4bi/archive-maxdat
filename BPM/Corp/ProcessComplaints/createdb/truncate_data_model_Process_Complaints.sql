/*
Created on 25-sep-2013 by Sumi.
Description:
This script is created to clean the BPM events and Semantic layer for a fresh reload of the Process complaint nyhix_etl_complaints_incidents Stage table.

steps:
1. Deleting BPM Event Queue.
2. Deleting Semantic layer.
BEM_id need to hard coded for the process at 3 places and bsl_id at 2 places
*/

-- Remove from queue.
delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 22;

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
tablespace MAXDAT_DATA;

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
where BSL_ID != 7;

commit;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE; 

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

grant select on BPM_UPDATE_EVENT_QUEUE_ARCHIVE to MAXDAT_READ_ONLY;


--------------------------------------------------------------------------------------
-- Remove from BPM Semantic.
truncate table F_COMPLAINT_BY_DATE;
alter table F_COMPLAINT_BY_DATE drop constraint FCMPLBD_DCMPLCUR_FK;

truncate table D_COMPLAINT_CURRENT;
alter table F_COMPLAINT_BY_DATE add constraint FCMPLBD_DCMPLCUR_FK foreign key (CMPL_BI_ID) references D_COMPLAINT_CURRENT (CMPL_BI_ID);
--------------------------------------------------------------------------------------

truncate table corp_etl_complaints_incidents;

update corp_etl_control set value = '0' where name = 'PC_LAST_COMPLAINT';

update corp_etl_control set value = '100' where name = 'COMPLAINTS_TO_LOOK_BACK';

update corp_etl_control set value = '200' where name = 'COMP_LOOK_BACK_DAYS';

commit;
