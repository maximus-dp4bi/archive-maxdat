-- Remove from queue.
delete from BPM_UPDATE_EVENT_QUEUE where BSL_ID = 16;

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
   WROTE_BPM_SEMANTIC_DATE date, 
   DATA_VERSION number not null,
   OLD_DATA xmltype,
   NEW_DATA xmltype not null,
   CEJS_JOB_ID number)
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
  WROTE_BPM_SEMANTIC_DATE, 
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA,
  CEJS_JOB_ID
from BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
where BSL_ID != 16;

commit;

drop table BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BUEQ_ARCHIVE_TEMP rename to BPM_UPDATE_EVENT_QUEUE_ARCHIVE;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_PK primary key (BUEQ_ID) using index tablespace MAXDAT_INDX;

grant select on BPM_UPDATE_EVENT_QUEUE_ARCHIVE to MAXDAT_READ_ONLY;


--------------------------------------------------------------------------------------
-- Remove from BPM Semantic.
truncate table F_MFB_BY_HOUR;
alter table F_MFB_BY_HOUR drop constraint FMFBBH_DMFBCUR_FK;

truncate table D_MFB_CURRENT;
alter table F_MFB_BY_HOUR add constraint FMFBBH_DMFBCUR_FK foreign key (MFB_BI_ID) references D_MFB_CURRENT (MFB_BI_ID);

-- These tables may or may not have data or be truncated by ETL, truncate all just to ensure they are empty
truncate table CORP_ETL_MFB_BATCH_EVENTS;				
truncate table CORP_ETL_MFB_DOCUMENT;					
truncate table CORP_ETL_MFB_ENVELOPE;					
truncate table CORP_ETL_MFB_FORM;						
delete from CORP_ETL_MFB_BATCH;						
truncate table CORP_ETL_MFB_BATCH_ARS_OLTP;				
truncate table CORP_ETL_MFB_BATCH_ARS_STG;				
truncate table CORP_ETL_MFB_BATCH_EVENTS_OLTP;			
truncate table CORP_ETL_MFB_BATCH_EVENTS_STG;			
truncate table CORP_ETL_MFB_BATCH_EVENTS_WIP;			
truncate table CORP_ETL_MFB_BATCH_OLTP;					
truncate table CORP_ETL_MFB_BATCH_STG;					
truncate table CORP_ETL_MFB_BATCH_WIP;					
truncate table CORP_ETL_MFB_DOCUMENT_OLTP;				
truncate table CORP_ETL_MFB_DOCUMENT_STG;				
truncate table CORP_ETL_MFB_DOCUMENT_WIP;				
truncate table CORP_ETL_MFB_ENVELOPE_OLTP;				
truncate table CORP_ETL_MFB_ENVELOPE_STG;				
truncate table CORP_ETL_MFB_ENVELOPE_WIP;				
truncate table CORP_ETL_MFB_FORM_OLTP;					
truncate table CORP_ETL_MFB_FORM_STG;					
truncate table CORP_ETL_MFB_FORM_WIP;					
truncate table CORP_ETL_MFB_SB_OLTP;					
truncate table CORP_ETL_MFB_SBM_OLTP;					
truncate table CORP_ETL_MFB_SML_OLTP;					
truncate table CORP_ETL_MFB_BATCH_TEMP;



-- NOTE the following tables were are NOT being Truncated
-- in the original script.  They are being added 4/17/20
-- 
truncate table  CORP_ETL_MFB_ECN_STG;
truncate table  ERRLOG_MFB;
truncate table  ERRLOG_MFBD;
truncate table  ERRLOG_MFBE;
truncate table  ERRLOG_MFBEN;
truncate table  ERRLOG_MFBF;

-- Per Jerome set date back 2 weeks

update corp_etl_control
set value = '4-ARP-20'  -- set value = '3-SEP-15'
where NAME in (
'MFB_REMOTE_LAST_UPDATE_DATE',
'MFB_CENTRAL_LAST_UPDATE_DATE',
'MFB_ARS_LAST_UPDATE_DATE');

-- Not sure if the below are needed but included for completeness
DELETE FROM CORP_ETL_ERROR_LOG
WHERE PROCESS_NAME ='PROCESSMAILFAXBATCH';

DELETE FROM CORP_ETL_JOB_STATISTICS
WHERE JOB_NAME IN (
'CORP_ETL_MFB_FORM',
'CORP_ETL_MFB_BATCH_COUNTS',
'CORP_ETL_MFB_DOCUMENT',
'CORP_ETL_MFB_BATCH_EVENTS',
'CORP_ETL_MFB_BATCH',
'CORP_ETL_MFB_ENVELOPE');

commit;

















