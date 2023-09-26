create or replace procedure sp_load_cdc_specific
(
	p_subscription_name	VARCHAR2,
	p_begin_date		date,
	p_end_date			date,
	p_debug				boolean default false
)
/****************************************

	v6.3	8/5/2014	David Giorno
		put code into standards compliance
            12/1/2022   Russell Bergeron
        replace EXTEND_WINDOW with support for Shareplex
****************************************/
IS

  v_err_code    	NUMBER;
  v_err_msg     	VARCHAR2(255);
  v_inserts	  		NUMBER;
  v_cdc       		cdc_parameters%ROWTYPE;
  v_sql 	    	VARCHAR2(4000);
  v_sql_vw          VARCHAR2(4000);
  v_sql_I_D     	VARCHAR2(4000);
  v_sql_UO_UN   	VARCHAR2(4000);
  v_sql_UO_UN_KEY   VARCHAR2(4000);
  v_sql_U     		VARCHAR2(4000);
  v_sql_max     	VARCHAR2(1000);
  v_start_dt    	DATE		:= sysdate;
  v_start_ts		TIMESTAMP	:= systimestamp;
  v_start_cscn		number;
  v_end_cscn		number;
  v_begin_ts		timestamp;
  v_end_ts			timestamp;
  v_max_date		date;
  v_extend_date		date;

  BEGIN

    SELECT *
	  into v_cdc
      FROM cdc_parameters
     WHERE subscription_name = p_subscription_name;

	-- FIRST ADD ALL INSERTS AND DELETES TO THE _HIST TABLE
	v_sql_I_D := 'INSERT /*+ append */ INTO '||v_cdc.target_HIST||'(META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT commit_timestamp$,to_char(commit_timestamp$,''YYYYMM''),SUBSTR(operation$,1,1),cscn$,rsid$,decode(operation$,''I '',''Y'',''N''),'||
			v_cdc.column_list||' FROM '||v_cdc.source_view||' WHERE operation$ IN (''I '',''D '')';

	-- THEN, ADD ALL UPDATES(UO AND UN) TO THE _UO_UN TABLE AS A REFERENCE
	v_sql_UO_UN := 'INSERT /*+ append */ INTO '||v_cdc.target_UO_UN||'(OPERATION$, CSCN$, COMMIT_TIMESTAMP$, RSID$, TIMESTAMP$, USERNAME$,'||v_cdc.column_list||
											   ') SELECT OPERATION$, CSCN$, COMMIT_TIMESTAMP$, RSID$, TIMESTAMP$, USERNAME$,'||v_cdc.column_list||
			' FROM '||v_cdc.source_view||' WHERE operation$ IN (''UO'',''UN'')';

	-- THEN, SELECT DISTINCT CSCN$,RSID$ FROM _UO_UN AND INSERT INTO PREVIOUSLY TRUNCATED GENERIC 'UO_UN_KEY' TABLE
	v_sql_UO_UN_KEY := 'INSERT /*+ append */ INTO UO_UN_KEY (CSCN$,RSID$) SELECT distinct CSCN$,RSID$ from '||v_cdc.target_UO_UN||
			' group by cscn$,rsid$,'||v_cdc.imp_cols||' having count(*) = 1';

	-- FINALLY, ADD ONLY THE UPDATES THAT HAD A CHANGE TO ONE OF THE IMPORTANT COLUMNS TO THE _HIST TABLE
	v_sql_U := 'INSERT /*+ append */ INTO '||v_cdc.target_HIST||'(META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT commit_timestamp$,to_char(commit_timestamp$,''YYYYMM''),''U'',T.cscn$,T.rsid$,''N'','||
			v_cdc.column_list||' FROM '||v_cdc.target_UO_UN||' T join uo_un_key K on k.cscn$ = t.cscn$ and k.rsid$ = t.rsid$ where  operation$ = ''UN''';

	if	P_DEBUG then
		dbms_output.put_line('v_sql_I_D='		||v_sql_I_D);
		dbms_output.put_line('v_sql_UO_UN='		||v_sql_UO_UN);
		dbms_output.put_line('v_sql_UO_UN_KEY='	||v_sql_UO_UN_KEY);
		dbms_output.put_line('v_sql_U='			||v_sql_U);
		RETURN;
	end  if;

   	EXECUTE IMMEDIATE 'truncate table UO_UN_KEY';
   	EXECUTE IMMEDIATE 'truncate table '||v_cdc.target_UO_UN;

	-- GET MAX DATE OF EXISTING ROWS BECAUSE DBMS_CDC_SUBSCRIBE.EXTEND_WINDOW
	-- ERRORS OUT IF YOU TRY TO EXTEND PAST WHEN THERE IS DATA
	v_sql_max := 'select max(Shareplex_source_TIME) from '||v_cdc.cdc_table;
    EXECUTE IMMEDIATE v_sql_max INTO v_max_date;

	if	v_max_date is NULL
	or	v_max_date < p_begin_date then
		insert into job_control (table_name,start_ts,p_run_begin_ts,p_run_end_ts,status) values (p_subscription_name||'_ND',v_start_ts,p_begin_date,p_end_date,'NO_DATA');
		COMMIT;
		RETURN;
	else
		v_extend_date := least (v_max_date, p_end_date);
	end if;

    -- extend the CDC window and PURGE AT THE END IF NO ERRORS OCCUR
   	--DBMS_CDC_SUBSCRIBE.EXTEND_WINDOW (subscription_name => p_subscription_name, upper_bound => v_extend_date);
    
    -- Added sp_bld_cdc_views to replace EXTEND_WINDOW    
    sp_bld_cdc_views (p_subscription_name, FALSE);

	-- RUN THE 4 SQLS IN ORDER
	-- IF ANY ERRORS OCCUR THEN PURGE WILL NOT BE CALLED
   	v_start_ts  := SYSTIMESTAMP;
	v_start_dt  := SYSDATE;
	v_sql 		:= v_sql_I_D;
   	EXECUTE IMMEDIATE v_sql;
   	v_inserts := SQL%ROWCOUNT;
	insert into job_control (table_name,start_ts,end_ts,p_run_begin_ts,p_run_end_ts,elapsed_time,num_inserts,status)
					 values (p_subscription_name||'_I_D',v_start_ts,systimestamp,p_begin_date,v_extend_date,ROUND((SYSDATE - v_start_dt)*86400, 0),v_inserts,'SUCCESS');
	COMMIT;

   	v_start_ts  := SYSTIMESTAMP;
	v_start_dt  := SYSDATE;
	v_sql 		:= v_sql_UO_UN;
   	EXECUTE IMMEDIATE v_sql;
   	v_inserts := SQL%ROWCOUNT;
	insert into job_control (table_name,start_ts,end_ts,p_run_begin_ts,p_run_end_ts,elapsed_time,num_inserts,status)
					 values (p_subscription_name||'_UO_UN',v_start_ts,systimestamp,p_begin_date,v_extend_date,ROUND((SYSDATE - v_start_dt)*86400, 0),v_inserts,'SUCCESS');
	COMMIT;

   	v_start_ts  := SYSTIMESTAMP;
	v_start_dt  := SYSDATE;
	v_sql 		:= v_sql_UO_UN_KEY;
   	EXECUTE IMMEDIATE v_sql;
   	v_inserts := SQL%ROWCOUNT;
	insert into job_control (table_name,start_ts,end_ts,p_run_begin_ts,p_run_end_ts,elapsed_time,num_inserts,status)
					 values (p_subscription_name||'_UO_UN_KEY',v_start_ts,systimestamp,p_begin_date,v_extend_date,ROUND((SYSDATE - v_start_dt)*86400, 0),v_inserts,'SUCCESS');
	COMMIT;

   	v_start_ts  := SYSTIMESTAMP;
	v_start_dt  := SYSDATE;
	v_sql 		:= v_sql_U;
   	EXECUTE IMMEDIATE v_sql;
   	v_inserts := SQL%ROWCOUNT;
	insert into job_control (table_name,start_ts,end_ts,p_run_begin_ts,p_run_end_ts,elapsed_time,num_inserts,status)
					 values (p_subscription_name||'_U',v_start_ts,systimestamp,p_begin_date,v_extend_date,ROUND((SYSDATE - v_start_dt)*86400, 0),v_inserts,'SUCCESS');
   	COMMIT;

    -- Purge CDC window so that no rows will be processed twice
	--DBMS_CDC_SUBSCRIBE.PURGE_WINDOW (subscription_name => p_subscription_name);

  EXCEPTION
    WHEN OTHERS THEN
      v_err_code := SQLCODE;
	  v_err_msg  := SUBSTR(SQLERRM, 1, 255);
    ROLLBACK;

	dbms_output.put_line('v_sql='||v_sql);

	insert into job_control (table_name,start_ts,end_ts,p_run_begin_ts,p_run_end_ts,elapsed_time,status,error_id,error_msg)
					 values (p_subscription_name||'_ERR',v_start_ts,systimestamp,p_begin_date,v_extend_date,ROUND((SYSDATE - v_start_dt)*86400, 0),'ERROR',v_err_code,v_err_msg);
	COMMIT;

	RAISE;

END;