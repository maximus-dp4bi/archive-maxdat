--------------------------------------------------------
--  File created - Monday-November-21-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure SP_LOAD_CDC_GAP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FLCPD0_STAGE"."SP_LOAD_CDC_GAP" 
(
	p_target_hist	VARCHAR2,
	p_load_date		date 		:= trunc(sysdate+1),
	p_cscn			number 		:= to_number(to_char(trunc(sysdate+1),'YYYYMMDD')),
	p_debug			boolean 	:= false
)

IS

  v_err_code    NUMBER;
  v_err_msg     VARCHAR2(255);
  v_ins		  	INTEGER;
  v_impl  		INTEGER;
  v_upd		  	INTEGER;
  v_cdc       	cdc_parameters%ROWTYPE;
  v_sql_1       VARCHAR2(4000);
  v_sql_2       VARCHAR2(4000);
  v_sql_3       VARCHAR2(4000);
  v_start_dt    DATE;
  v_start_ts	TIMESTAMP;
  v_begin_ts	timestamp;
  v_end_ts		timestamp;
  v_table		varchar2(256);

  BEGIN

    v_start_ts  := SYSTIMESTAMP;
    v_start_dt  := SYSDATE;

    SELECT *
	  into v_cdc
      FROM cdc_parameters
     WHERE target_hist = p_target_hist;

	v_table := 'GAP_'||v_cdc.target_hist;

	if	v_cdc.target_hist = 'FINANCIAL_TRANSACTION_HIST' then

   		v_sql_1 := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(load_date,META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT :load_date,insert_date,to_char(insert_date,''YYYYMM''),''I'',:cscn,1,''Y'','||
			v_cdc.column_list||' FROM ff_tmp_INS join flcpd0_vida.financial_transaction on financial_transaction_id = fin_trans_id';

   		v_sql_2 := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(load_date,meta_current_flag,meta_end_ts,'||
			'META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT :load_date,''N'',update_date,insert_date,to_char(insert_date,''YYYYMM''),''I'',:cscn,1,''Y'','||
			v_cdc.column_list||' FROM ff_tmp_ins_IMPL join flcpd0_vida.financial_transaction on financial_transaction_id = fin_trans_id';

   		v_sql_3 := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(load_date,META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT :load_date,update_date,to_char(update_date,''YYYYMM''),''U'',:cscn,2,''Y'','||
			v_cdc.column_list||' FROM ff_tmp_UPD join flcpd0_vida.financial_transaction on financial_transaction_id = fin_trans_id';

	elsif v_cdc.target_hist = 'SUSPENSE_TRANSACTION_HIST' then

   		v_sql_1 := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(load_date,META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT :load_date,insert_date,to_char(insert_date,''YYYYMM''),''I'',:cscn,1,''Y'','||
			v_cdc.column_list||' FROM sf_tmp_INS join flcpd0_vida.suspense_transaction on suspense_transaction_id = susp_trans_id';

   		v_sql_2 := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(load_date,meta_current_flag,meta_end_ts,'||
			'META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT :load_date,''N'',update_date,insert_date,to_char(insert_date,''YYYYMM''),''I'',:cscn,1,''Y'','||
			v_cdc.column_list||' FROM sf_tmp_ins_IMPL join flcpd0_vida.suspense_transaction on suspense_transaction_id = susp_trans_id';

   		v_sql_3 := 'INSERT /*+ append */ INTO '||v_cdc.target_hist||'(load_date,META_BEGIN_TS,META_BEGIN_YYYYMM,META_ACTION_CD,cscn$,rsid$,meta_processed_flag,'||
			v_cdc.column_list||') SELECT :load_date,update_date,to_char(update_date,''YYYYMM''),''U'',:cscn,2,''Y'','||
			v_cdc.column_list||' FROM sf_tmp_UPD join flcpd0_vida.suspense_transaction on suspense_transaction_id = susp_trans_id';

	end if;

	if	p_debug then
		dbms_output.put_line('v_sql_1='||v_sql_1);
		dbms_output.put_line('v_sql_2='||v_sql_2);
		dbms_output.put_line('v_sql_3='||v_sql_3);
		RETURN;
	end  if;

    EXECUTE IMMEDIATE v_sql_1 using p_load_date, p_cscn;
    v_ins := SQL%ROWCOUNT;
	commit;

    EXECUTE IMMEDIATE v_sql_2 using p_load_date, p_cscn;
    v_impl := SQL%ROWCOUNT;
	commit;

    EXECUTE IMMEDIATE v_sql_3 using p_load_date, p_cscn;
    v_upd := SQL%ROWCOUNT;
	commit;

 	insert into job_control (	 TABLE_NAME,
                                 START_TS,
                                 p_run_begin_ts,
                                 p_run_end_ts,
                                 end_ts,
                                 elapsed_time,
                                 num_inserts,
                                 num_updates,
                                 num_deletes,
                                 status)
                         values (v_table,
                                 V_START_TS,
                                 trunc(sysdate+1),
                                 trunc(sysdate+1),
                                 SYSTIMESTAMP,
                                 ROUND((SYSDATE - v_start_dt)*86400, 0),
                                 v_ins,
                                 v_upd,
                                 v_impl,
                                 'SUCCESS');
	COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      v_err_code := SQLCODE;
	  v_err_msg  := SUBSTR(SQLERRM, 1, 255);
    ROLLBACK;

 	insert into job_control (	 TABLE_NAME,
                                 START_TS,
                                 p_run_begin_ts,
                                 p_run_end_ts,
                                 end_ts,
                                 elapsed_time,
                                 num_inserts,
                                 num_updates,
                                 num_deletes,
                                 status)
                         values (v_table,
                                 V_START_TS,
                                 trunc(sysdate+1),
                                 trunc(sysdate+1),
                                 SYSTIMESTAMP,
                                 ROUND((SYSDATE - v_start_dt)*86400, 0),
                                 v_ins,
                                 v_upd,
                                 v_impl,
                                 'ERROR');

	dbms_output.put_line('v_sql_1='||v_sql_1);
	dbms_output.put_line('v_sql_2='||v_sql_2);
	dbms_output.put_line('v_sql_3='||v_sql_3);

	COMMIT;

	RAISE;

END;
/
