 exec DBMS_STATS.GATHER_TABLE_STATS( 	OWNNAME  =>  'MAXDAT', 	TABNAME  =>  'BPM_UPDATE_EVENT_QUEUE',  	CASCADE  =>  TRUE,  	DEGREE	 =>  16,  	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE, 	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

 exec DBMS_STATS.GATHER_TABLE_STATS( 	OWNNAME  =>  'MAXDAT',  	TABNAME  =>  'BPM_UPDATE_EVENT_QUEUE_ARCHIVE',  	CASCADE  =>  TRUE, 	DEGREE	 =>  16,  	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,  	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',    	TABNAME  =>  'PROCESS_BPM_QUEUE_JOB',    	CASCADE  =>  TRUE,    	DEGREE	 =>  16,  	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',  	TABNAME  =>  'D_MFDOC_CURRENT',    	CASCADE  =>  TRUE,    	DEGREE	 =>  16,    	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',  	TABNAME  =>  'D_MFDOC_BATCH',    	CASCADE  =>  TRUE,    	DEGREE	 =>  16,   	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',    	TABNAME  =>  'D_MFDOC_DCN_JEOPARDY_STATUS',   	CASCADE  =>  TRUE,  	DEGREE	 =>  16,   	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',   	TABNAME  =>  'D_MFDOC_DOCUMENT_STATUS',    	CASCADE  =>  TRUE,    	DEGREE	 =>  16,   	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',   	TABNAME  =>  'D_MFDOC_INSTANCE_STATUS',    	CASCADE  =>  TRUE,   	DEGREE	 =>  16,    	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',   	TABNAME  =>  'D_MFDOC_TIMELINESS_STATUS',   	CASCADE  =>  TRUE,    	DEGREE	 =>  16,  	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');

exec DBMS_STATS.GATHER_TABLE_STATS(   	OWNNAME  =>  'MAXDAT',    	TABNAME  =>  'F_MFDOC_BY_DATE',    	CASCADE  =>  TRUE,   	DEGREE	 =>  16,    	ESTIMATE_PERCENT  =>  DBMS_STATS.AUTO_SAMPLE_SIZE,    	METHOD_OPT  =>  'FOR ALL COLUMNS SIZE AUTO');


