create index BUE_IX1 on BPM_UPDATE_EVENT (BI_ID) online tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_UPDATE_EVENT_QUEUE estimate statistics;

create index BPM_INSTANCE_ATTRIBUTE_IX7 on BPM_INSTANCE_ATTRIBUTE (BUE_ID) online tablespace MAXDAT_INDX parallel compute statistics;
analyze table BPM_INSTANCE_ATTRIBUTE estimate statistics;