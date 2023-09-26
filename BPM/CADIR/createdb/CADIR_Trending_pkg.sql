alter session set plsql_code_type = native;

create or replace package CADIR_TREND_CALC as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

		
procedure QUEUE_NUM_BY_DAY ;

procedure AVG_DAYS_IN_QUEUE ;

end;
/  

create or replace package body CADIR_TREND_CALC as

-- Initialize global variables

g_err_date date := sysdate;	
g_err_level varchar2(10) := 'Critical';	
g_create_ts date := sysdate;		
g_update_ts date := sysdate;
g_process_name varchar2(30) := 'CADIR_TREND_CALC';
g_driver_table_name1 varchar2(50):= 'QUEUE_NUM_BY_DAY';
g_driver_table_name2 varchar2(50):= 'AVG_DAYS_IN_QUEUE';

-- Calculate QUEUE_NUM_BY_DAY
  procedure QUEUE_NUM_BY_DAY
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'QUEUE_NUM_BY_DAY_proc';
   
  begin

     DELETE FROM F_QUEUE_NUM_BY_DAY_STG
	WHERE TRUNC(D_DATE) = TRUNC(SYSDATE);
  
     INSERT INTO F_QUEUE_NUM_BY_DAY_STG (D_DATE, TASK_TYPE, INVENTORY_COUNT)
	select a.d_date, b."Current Task Type", sum(inventory_count) i_count 
	from f_mw_by_date_sv a, d_mw_current_sv b, bpm_d_dates c
	where a.MW_BI_ID = b.MW_BI_ID
	and c.d_date = a.d_date
	and c.BUSINESS_DAY_FLAG = 'Y'
	and TRUNC(A.D_DATE) = TRUNC(SYSDATE)
	and (nvl("Complete Date","Cancel Work Date") is null or c.d_date between "Create Date" and nvl("Complete Date","Cancel Work Date"))
	group by a.d_date, b."Current Task Type"
	order by b."Current Task Type", a.d_date;

	commit;

	MERGE INTO F_QUEUE_NUM_BY_DAY_STG U1
	USING(   
      	with T1 as( SELECT TASK_TYPE, D_DATE, INVENTORY_COUNT, Row_Number()
                  OVER (PARTITION BY Task_Type order by task_type, d_date asc) as R_NUM 
                  FROM F_QUEUE_NUM_BY_DAY_STG 
                    )
                  SELECT A4.R_NUM, A1.INVENTORY_COUNT AS INV_COUNT, A1.TASK_TYPE, A4.D_DATE
                  FROM T1 A1
                  JOIN T1 A2 ON A1.TASK_TYPE = A2.TASK_TYPE AND (A1.R_NUM + 1) = A2.R_NUM AND A1.INVENTORY_COUNT < A2.INVENTORY_COUNT
                  JOIN T1 A3 ON A2.TASK_TYPE = A3.TASK_TYPE AND (A2.R_NUM + 1) = A3.R_NUM AND A2.INVENTORY_COUNT < A3.INVENTORY_COUNT
                  JOIN T1 A4 ON A3.TASK_TYPE = A4.TASK_TYPE AND (A3.R_NUM + 1) = A4.R_NUM AND A3.INVENTORY_COUNT < A4.INVENTORY_COUNT
	)C1 ON (U1.D_DATE = C1.D_DATE and U1.TASK_TYPE = C1.TASK_TYPE )
        WHEN MATCHED THEN UPDATE
        SET U1.INCR_TREND_IND = 'Y';
        
	COMMIT;       

	MERGE INTO F_QUEUE_NUM_BY_DAY_STG U1
	USING(   
     	 with T1 as( SELECT TASK_TYPE, D_DATE, INVENTORY_COUNT, Row_Number()
                  OVER (PARTITION BY Task_Type order by task_type, d_date asc) as R_NUM 
                  FROM F_QUEUE_NUM_BY_DAY_STG 
                    )
                  SELECT A4.R_NUM, A1.INVENTORY_COUNT AS INV_COUNT, A1.TASK_TYPE, A4.D_DATE
                  FROM T1 A1
                  JOIN T1 A2 ON A1.TASK_TYPE = A2.TASK_TYPE AND (A1.R_NUM + 1) = A2.R_NUM AND A1.INVENTORY_COUNT > A2.INVENTORY_COUNT
                  JOIN T1 A3 ON A2.TASK_TYPE = A3.TASK_TYPE AND (A2.R_NUM + 1) = A3.R_NUM AND A2.INVENTORY_COUNT > A3.INVENTORY_COUNT
                  JOIN T1 A4 ON A3.TASK_TYPE = A4.TASK_TYPE AND (A3.R_NUM + 1) = A4.R_NUM AND A3.INVENTORY_COUNT > A4.INVENTORY_COUNT
	)C1 ON (U1.D_DATE = C1.D_DATE and U1.TASK_TYPE = C1.TASK_TYPE )
        WHEN MATCHED THEN UPDATE
        SET U1.DECR_TREND_IND = 'Y';

	COMMIT;

	exception
		when others then
		insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
		      values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name1, 1 );


  end;

-- Calculate AVG_DAYS_IN_QUEUE
  procedure AVG_DAYS_IN_QUEUE
  as
   v_driver_key_number varchar2(100) :=null;
   v_job_name varchar2(50):= 'AVG_DAYS_IN_QUEUE_proc';
   
  begin

     DELETE FROM F_AVG_DAYS_IN_QUEUE_STG
	WHERE TRUNC(D_DATE) = TRUNC(SYSDATE);
  
     INSERT INTO F_AVG_DAYS_IN_QUEUE_STG (D_DATE, TASK_TYPE, AVG_DAYS_IN_QUEUE)
	select a.d_date, b."Current Task Type", round(avg(b."Age in Business Days"))
	from f_mw_by_date_sv a, d_mw_current_sv b, bpm_d_dates c
	where a.MW_BI_ID = b.MW_BI_ID
	and c.d_date = a.d_date
	and c.BUSINESS_DAY_FLAG = 'Y'
	and TRUNC(A.D_DATE) = TRUNC(SYSDATE)
	and (nvl("Complete Date","Cancel Work Date") is null or c.d_date between "Create Date" and nvl("Complete Date","Cancel Work Date"))
	group by a.d_date, b."Current Task Type"
	order by b."Current Task Type", a.d_date;

	commit;

	MERGE INTO F_AVG_DAYS_IN_QUEUE_STG U1
	USING(   
      	with T1 as( SELECT TASK_TYPE, D_DATE, AVG_DAYS_IN_QUEUE, Row_Number()
                  OVER (PARTITION BY Task_Type order by task_type, d_date asc) as R_NUM 
                  FROM F_AVG_DAYS_IN_QUEUE_STG 
                    )
                  SELECT A3.R_NUM, A1.AVG_DAYS_IN_QUEUE AS AVG_DAYS, A1.TASK_TYPE, A3.D_DATE
                  FROM T1 A1
                  JOIN T1 A2 ON A1.TASK_TYPE = A2.TASK_TYPE AND (A1.R_NUM + 1) = A2.R_NUM AND A1.AVG_DAYS_IN_QUEUE < A2.AVG_DAYS_IN_QUEUE
                  JOIN T1 A3 ON A2.TASK_TYPE = A3.TASK_TYPE AND (A2.R_NUM + 1) = A3.R_NUM AND A2.AVG_DAYS_IN_QUEUE < A3.AVG_DAYS_IN_QUEUE
                 -- JOIN T1 A4 ON A3.TASK_TYPE = A4.TASK_TYPE AND (A3.R_NUM + 1) = A4.R_NUM AND A3.AVG_DAYS_IN_QUEUE < A4.AVG_DAYS_IN_QUEUE
	)C1 ON (U1.D_DATE = C1.D_DATE and U1.TASK_TYPE = C1.TASK_TYPE )
        WHEN MATCHED THEN UPDATE
        SET U1.INCR_TREND_IND = 'Y';
        
	COMMIT;       

	MERGE INTO F_AVG_DAYS_IN_QUEUE_STG U1
	USING(   
     	 with T1 as( SELECT TASK_TYPE, D_DATE, AVG_DAYS_IN_QUEUE, Row_Number()
                  OVER (PARTITION BY Task_Type order by task_type, d_date asc) as R_NUM 
                  FROM F_AVG_DAYS_IN_QUEUE_STG 
                    )
                  SELECT A3.R_NUM, A1.AVG_DAYS_IN_QUEUE AS AVG_DAYS, A1.TASK_TYPE, A3.D_DATE
                  FROM T1 A1
                  JOIN T1 A2 ON A1.TASK_TYPE = A2.TASK_TYPE AND (A1.R_NUM + 1) = A2.R_NUM AND A1.AVG_DAYS_IN_QUEUE > A2.AVG_DAYS_IN_QUEUE
                  JOIN T1 A3 ON A2.TASK_TYPE = A3.TASK_TYPE AND (A2.R_NUM + 1) = A3.R_NUM AND A2.AVG_DAYS_IN_QUEUE > A3.AVG_DAYS_IN_QUEUE
                --  JOIN T1 A4 ON A3.TASK_TYPE = A4.TASK_TYPE AND (A3.R_NUM + 1) = A4.R_NUM AND A3.AVG_DAYS_IN_QUEUE > A4.AVG_DAYS_IN_QUEUE
	)C1 ON (U1.D_DATE = C1.D_DATE and U1.TASK_TYPE = C1.TASK_TYPE )
        WHEN MATCHED THEN UPDATE
        SET U1.DECR_TREND_IND = 'Y';

	COMMIT;

	exception
		when others then
		insert into corp_etl_error_log ( ERR_DATE , ERR_LEVEL, PROCESS_NAME , JOB_NAME , CREATE_TS, UPDATE_TS, DRIVER_TABLE_NAME , DRIVER_KEY_NUMBER) 
		      values (g_err_date, g_err_level,g_process_name, v_job_name, g_create_ts, g_update_ts, g_driver_table_name2, 1 );

  end;


end;
/    

alter session set plsql_code_type = interpreted;  