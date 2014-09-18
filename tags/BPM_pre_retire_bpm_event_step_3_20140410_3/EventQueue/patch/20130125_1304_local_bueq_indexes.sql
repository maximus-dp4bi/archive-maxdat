drop index BUEQ_IX2;
drop index BUEQ_IX3;
drop index BUEQ_IX4;
drop index BUEQ_IX5;
drop index BUEQ_IX6;

create index BUEQ_LX1 on BPM_UPDATE_EVENT_QUEUE (EVENT_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX2 on BPM_UPDATE_EVENT_QUEUE (PROCESS_BUEQ_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX3 on BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX4 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_EVENT_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX5 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_SEMANTIC_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_LX6 on BPM_UPDATE_EVENT_QUEUE (BUE_ID) local online tablespace MAXDAT_INDX parallel compute statistics;