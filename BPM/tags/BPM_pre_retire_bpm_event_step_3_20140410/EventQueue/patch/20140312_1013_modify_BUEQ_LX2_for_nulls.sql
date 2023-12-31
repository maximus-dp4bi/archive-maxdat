drop index BUEQ_LX2;
create index BUEQ_LX2 on BPM_UPDATE_EVENT_QUEUE (PROCESS_BUEQ_ID,0) local online tablespace MAXDAT_INDX parallel compute statistics;
exec DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT',TABNAME => 'BPM_UPDATE_EVENT_QUEUE',CASCADE => TRUE,DEGREE  => 16,ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE,METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');
