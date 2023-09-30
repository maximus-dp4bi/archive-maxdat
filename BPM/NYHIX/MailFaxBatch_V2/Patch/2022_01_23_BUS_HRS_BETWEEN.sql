CREATE OR REPLACE function MAXDAT.BUS_HRS_BETWEEN
    (p_d_date 		    in date,
	 p_start_date 		in date,
     p_end_date 		in date,
     p_bus_day_count    in number DEFAULT 1,
	 p_bus_day_start_hr in varchar default '07:00',
	 p_bus_day_end_hr 	in varchar default '19:00'
	 )
    return NUMBER
  as

	LV_SQL_CODE                 NUMBER 				:= NULL;
    LV_LOG_MESSAGE              CLOB 			    := NULL;
    --lv_bus_days                 integer := 0;
    lv_num_hours 				number(10,5) := 0;
    lv_start_date               date;
    lv_end_date                 date;
    lv_business_start_date_time date 	:= null;
    lv_business_end_date_time 	date 	:= null;
    lv_end_of_first_day         date := null;
    lv_start_of_last_day        date := null;
    lv_hrs_per_day              number(10,5) := 0;
  --  lv_nls_date_format          varchar(80) := 'alter session set nls_date_format = '||''''||'YYYY/mm/dd hh24:mi:ss'||'''' ;
 --   lv_holiday_count            integer := 0;
  begin
    
    
    --DBMS_OUTPUT.PUT_LINE('p_D_date :'||TO_CHAR(p_D_date,'yyyymmdd hh24:MI:SS')); 
    --DBMS_OUTPUT.PUT_LINE('p_start_date :'||TO_CHAR(p_start_date,'yyyymmdd hh24:MI:SS'));
    --DBMS_OUTPUT.PUT_LINE('p_end_date :'||TO_CHAR(p_end_date,'yyyymmdd hh24:MI:SS'));
    --DBMS_OUTPUT.PUT_LINE('p_bus_day_count :'||p_bus_day_count);
    --DBMS_OUTPUT.PUT_LINE('p_bus_day_start_hr :'||p_bus_day_start_hr);
    --DBMS_OUTPUT.PUT_LINE('p_bus_day_end_hr :'||p_bus_day_end_hr);
    --*/
    
    LV_SQL_CODE                 := NULL;
    LV_LOG_MESSAGE              := NULL;

	lv_num_hours        := 0;
    lv_start_date := to_date(to_char(p_start_date,'yyyymmdd hh24:mi:ss'),'yyyymmdd hh24:mi:ss');
    lv_end_date := to_date(to_char(p_end_date,'yyyymmdd hh24:mi:ss'),'yyyymmdd hh24:mi:ss');
	-- set the business_start_date_time
	lv_business_start_date_time := to_date(to_char(LV_start_date,'yyyymmdd')||p_bus_day_start_hr,'yyyymmddhh24:mi');
	-- set the business_end_date_time
	lv_business_end_date_time := to_date(to_char(LV_end_date,'yyyymmdd')||p_bus_day_end_hr,'yyyymmddhh24:mi');

    lv_end_of_first_day  := to_date(to_char(lv_start_date,'yyyymmdd')||' '||p_bus_day_end_hr,'yyyymmdd hh24:mi');
    lv_start_of_last_day := to_date(to_char(nvl(lv_end_date,sysdate),'yyyymmdd')||' '||p_bus_day_start_hr,'yyyymmdd hh24:mi');
    lv_hrs_per_day := (to_date(p_bus_day_end_hr,'hh24:mi') - to_date(p_bus_day_start_hr,'hh24:mi'))*24;

    if p_bus_day_count < 0
    then
        return 0;
    end if;

	-- calculate hours for the first day
    -- calc hours for the first day
    
    if p_bus_day_count >= 1
    then
    	lv_num_hours := 
    	LEAST( 
            ROUND(((lv_end_of_first_day  - lv_start_date) * 24),1),
            ROUND(((lv_end_date - lv_start_date)          * 24),1)
            );
    end if;

    -- add hours for days between
    IF P_BUS_DAY_COUNT >= 1
    AND TRUNC(P_D_DATE) < TRUNC(P_END_DATE)
    THEN
        LV_NUM_HOURS := LV_NUM_HOURS + ROUND(((P_BUS_DAY_COUNT-1) * LV_HRS_PER_DAY),1);
    END IF;

    -- Add in the hours for the last_day
    IF P_BUS_DAY_COUNT >= 1
    AND TRUNC(P_D_DATE) = TRUNC(P_END_DATE)
    then
        LV_NUM_HOURS := LV_NUM_HOURS + ROUND(((P_BUS_DAY_COUNT-1) * LV_HRS_PER_DAY),1);
        lv_num_hours := lv_num_hours + ROUND((( lv_end_date - lv_start_of_last_day ) * 24 ),1);
    end if;

 
    RETURN ROUND(LV_NUM_HOURS,1);
    
  EXCEPTION  
  
        WHEN OTHERS THEN
        
    		LV_SQL_CODE 			:= SQLCODE;
			LV_LOG_MESSAGE 			:= SQLERRM;
	--		GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||GV_BATCH_GUID;
	--		GV_DRIVER_TABLE_NAME  	:= 'F_MFB_V2_BY_DAY';
	--		GV_ERR_LEVEL		  	:= 'LOG';
	--		GV_JOB_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.LOAD_F_BY_DAY';
	--		POST_ERROR;

        DBMS_OUTPUT.PUT_LINE('lv_start_date '||TO_CHAR(lv_start_date,'YYYYMMDD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('lv_end_of_first_day '||TO_CHAR(lv_end_of_first_day,'YYYYMMDD HH24:MI:SS'));

			DBMS_OUTPUT.PUT_LINE('FAILED IN  Load_F_BY_DAY for SRC_BATCH_GUID: '
			||' p_start_date: '||p_start_date
			||' p_end_date: '||p_end_date
			||' p_bus_day_start_hr: '||p_bus_day_start_hr
			||' p_bus_day_end_hr: '||p_bus_day_end_hr
			||' SQLCODE '||LV_SQL_CODE
			||' '||LV_LOG_MESSAGE);

        raise;
        
  end;
/
show errors