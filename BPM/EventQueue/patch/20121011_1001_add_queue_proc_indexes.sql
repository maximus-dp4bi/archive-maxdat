create index BUEQ_IX3 on BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_IX4 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_EVENT_DATE) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_IX5 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_SEMANTIC_DATE) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQ_IX6 on BPM_UPDATE_EVENT_QUEUE (BUE_ID) tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_UPDATE_EVENT_QUEUE compute statistics;

create index BUEQC_IX1 on BPM_UPDATE_EVENT_QUEUE_CONV (BSL_ID,EVENT_DATE) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQC_IX2 on BPM_UPDATE_EVENT_QUEUE_CONV (PROCESS_BUEQ_ID) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQC_IX3 on BPM_UPDATE_EVENT_QUEUE_CONV (IDENTIFIER) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQC_IX4 on BPM_UPDATE_EVENT_QUEUE_CONV (WROTE_BPM_EVENT_DATE) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQC_IX5 on BPM_UPDATE_EVENT_QUEUE_CONV (WROTE_BPM_SEMANTIC_DATE) tablespace MAXDAT_INDX parallel compute statistics;
create index BUEQC_IX6 on BPM_UPDATE_EVENT_QUEUE_CONV (BUE_ID) tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_UPDATE_EVENT_QUEUE_CONV compute statistics;

create index BUE_IX1 on BPM_UPDATE_EVENT (BI_ID) tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_UPDATE_EVENT_QUEUE compute statistics;

create index BPM_INSTANCE_ATTRIBUTE_IX7 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_INSTANCE_ATTRIBUTE estimate statistics;