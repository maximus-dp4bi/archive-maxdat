-- BPM_UPDATE_EVENT_QUEUE
alter index BUEQ_PK rebuild online tablespace MAXDAT_INDX parallel compute statistics;
alter index BUEQ_IX1 rebuild online tablespace MAXDAT_INDX parallel compute statistics;
drop index BUEQ_LX1;
drop index BUEQ_LX2;
drop index BUEQ_LX3;
drop index BUEQ_LX4;
drop index BUEQ_LX5;
drop index BUEQ_LX6;
create index BUEQ_LX1 on BPM_UPDATE_EVENT_QUEUE (EVENT_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX2 on BPM_UPDATE_EVENT_QUEUE (PROCESS_BUEQ_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX3 on BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX4 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_EVENT_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX5 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_SEMANTIC_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX6 on BPM_UPDATE_EVENT_QUEUE (BUE_ID) local online tablespace MAXDAT_INDX parallel compute statistics;

-- BPM_UPDATE_EVENT_QUEUE_ARCHIVE
alter index BUEQA_PK rebuild tablespace MAXDAT_INDX parallel compute statistics;

-- Semantic - Manage Mail Fax Doc
alter index DMFDOCCUR_PK rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FMFDOCBD_PK rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FMFDOCBD_UIX1 rebuild tablespace MAXDAT_INDX parallel compute statistics; 
alter index FMFDOCBD_UIX2 rebuild tablespace MAXDAT_INDX parallel compute statistics; 
alter index FMFDOCBD_IX1 rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FMFDOCBD_IX2 rebuild tablespace MAXDAT_INDX parallel compute statistics;
drop index FMFDOCBD_IXL1;
create index FMFDOCBD_IXL1 on F_MFDOC_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

-- Semantic - Process Incidents
alter index DPICUR_PK rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index DPICUR_UIX1 rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FPIBD_PK rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FPIBD_UIX1 rebuild tablespace MAXDAT_INDX parallel compute statistics; 
alter index FPIBD_UIX2 rebuild tablespace MAXDAT_INDX parallel compute statistics; 
alter index FPIBD_IX1 rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FPIBD_IX2 rebuild tablespace MAXDAT_INDX parallel compute statistics;
drop index FPIBD_IXL1;
create index FPIBD_IXL1 on F_PI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

-- Semantic - Process Letters
alter index DPLCUR_PK rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index DPLCUR_UIX1  rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FPLBD_PK rebuild tablespace MAXDAT_INDX parallel compute statistics;
alter index FPLBD_UIX1 rebuild tablespace MAXDAT_INDX parallel compute statistics; 
alter index FPLBD_UIX2 rebuild tablespace MAXDAT_INDX parallel compute statistics;
drop index FPLBD_IXL1;
create index FPLBD_IXL1 on F_PL_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;

-- Reset queue.
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where
  BSL_ID in (9,10,12)
  and PROCESS_BUEQ_ID is not null;
  
commit;