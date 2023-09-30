create or replace procedure sp_load_cdc_all
(
	p_subscription_name	VARCHAR2,
	p_begin_date		date,
	p_end_date			date,
	p_debug				boolean default false
)
/******************************************

	v6.3	8/5/2014	David Giorno
		put code into standards compliance
        
            12/1/2022   Russell Bergeron
        replace EXTEND_WINDOW with support for Shareplex

******************************************/
IS

  v_err_code    NUMBER;
  v_err_msg     VARCHAR2(255);
  v_inserts	  	INTEGER;
  v_cdc       	cdc_parameters%ROWTYPE;
  v_sql         VARCHAR2(4000);
  v_sql_vw      VARCHAR2(4000);
  v_sql_max     VARCHAR2(1000);
  v_start_dt    DATE;
  v_start_ts	TIMESTAMP;
  v_begin_ts	timestamp;
  v_end_ts		timestamp;
  v_start_cscn		number;
  v_end_cscn		number;
  v_max_date	date;
  v_extend_date	date;

  BEGIN

    v_start_ts  := SYSTIMESTAMP;
    v_start_dt  := SYSDATE;

    SELECT *
	  into v_cdc
      FROM cdc_parameters
     WHERE subscription_name = p_subscription_name;

	if	v_cdc.target_hist != 'COVERAGE_HIST' then
   		v_sql := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT commit_timestamp$,to_char(commit_timestamp$,''YYYYMM''),SUBSTR(operation$,1,1),cscn$,rsid$,decode(operation$,''I '',''Y'',''N''),'||
			v_cdc.column_list||' FROM '||v_cdc.source_view||' WHERE operation$ IN (''I '',''UN'',''D '')';
	else
   		v_sql := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			'health_plan_type,'||v_cdc.column_list||') SELECT commit_timestamp$,to_char(commit_timestamp$,''YYYYMM''),SUBSTR(operation$,1,1),cscn$,rsid$,'||
			'decode(operation$,''I '',''Y'',''N''),hp.health_plan_type,'||'c.'||replace(v_cdc.column_list,',',',c.')||
			' FROM '||v_cdc.source_view||' c '||
			'left join health_plan_county  HPC on  hpc.health_plan_county_id   = c.health_plan_county_id '||
        	'left join health_plan         HP  on  hp.health_plan_id           = hpc.health_plan_id '||
			'WHERE operation$ IN (''I '',''UN'',''D '')';
	end if;

	if	p_debug then
		dbms_output.put_line('v_sql='||v_sql);
		RETURN;
	end  if;

	-- GET MAX DATE OF EXISTING ROWS BECAUSE DBMS_CDC_SUBSCRIBE.EXTEND_WINDOW
	-- ERRORS OUT IF YOU TRY TO EXTEND PAST WHEN THERE IS DATA
	v_sql_max := 'select max(Shareplex_source_TIME) from '||v_cdc.cdc_table;
    EXECUTE IMMEDIATE v_sql_max INTO v_max_date;

	if	v_max_date is NULL
	or	v_max_date < p_begin_date then
		insert into job_control (TABLE_NAME,START_TS,p_run_begin_ts,p_run_end_ts,status) values (p_subscription_name,V_START_TS,p_begin_date,p_end_date,'NO_DATA');
		COMMIT;
		RETURN;
	else
		v_extend_date := least (v_max_date, p_end_date);
	end if;

	insert into job_control (TABLE_NAME,START_TS,p_run_begin_ts,p_run_end_ts) values (p_subscription_name,V_START_TS,p_begin_date,v_extend_date);
    COMMIT;

    -- extend the CDC window and PURGE AT THE END IF NO ERRORS OCCUR
    -- DBMS_CDC_SUBSCRIBE.EXTEND_WINDOW (subscription_name => p_subscription_name, upper_bound => v_extend_date)

    -- Added sp_bld_cdc_views to replace EXTEND_WINDOW
    sp_bld_cdc_views (p_subscription_name, FALSE);


    EXECUTE IMMEDIATE v_sql;
    v_inserts := SQL%ROWCOUNT;
	COMMIT;

    UPDATE job_control
	     SET   end_ts		= SYSTIMESTAMP
		     , elapsed_time	= ROUND((SYSDATE - v_start_dt)*86400, 0)
		     , num_inserts	= v_inserts
         	 , status		= 'SUCCESS'
     WHERE table_name	= p_subscription_name
	   AND start_ts		= v_start_ts;

	COMMIT;

    -- Purge CDC window so that no rows will be processed twice
	-- DBMS_CDC_SUBSCRIBE.PURGE_WINDOW (subscription_name => p_subscription_name);

  EXCEPTION
    WHEN OTHERS THEN
      v_err_code := SQLCODE;
	  v_err_msg  := SUBSTR(SQLERRM, 1, 255);
    ROLLBACK;

	dbms_output.put_line('v_sql='||v_sql);

    UPDATE job_control
	     SET   end_ts		= SYSTIMESTAMP
		     , elapsed_time	= ROUND((SYSDATE - v_start_dt)*86400, 0)
         	 , status		= 'ERROR'
		     , error_id		= v_err_code
		     , error_msg	= v_err_msg
     WHERE table_name	= p_subscription_name
	   AND start_ts		= v_start_ts;
	COMMIT;

	RAISE;

END;