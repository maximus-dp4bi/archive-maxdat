create index BUEQ_IX5 on BPM_UPDATE_EVENT_QUEUE (WROTE_BPM_SEMANTIC_DATE) tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_UPDATE_EVENT_QUEUE compute statistics;

ccreate index BUEQC_IX5 on BPM_UPDATE_EVENT_QUEUE_CONV (WROTE_BPM_SEMANTIC_DATE) tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_UPDATE_EVENT_QUEUE_CONV compute statistics;
