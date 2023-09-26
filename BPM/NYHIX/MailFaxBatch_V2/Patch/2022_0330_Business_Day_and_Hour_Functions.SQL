--------------------------------------------------------------------------
-- Run this script in MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU to make it look like MAXDAT@NHX1DORD1HXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMD.
--
-- Please review the script before using it to make sure it won't cause any unacceptable data loss.
--
-- MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU schema extracted by user WL134672
-- MAXDAT@NHX1DORD1HXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMD schema extracted by user MAXDAT
--------------------------------------------------------------------------
-- "Set define off" turns off substitution variables.
Set define off;

CREATE OR REPLACE function MAXDAT.BUS_HRS_BETWEEN
    (p_business_day_flag  in varchar default 'Y',
	 p_d_date 		    in date,
	 p_start_date 		in date,
     p_end_date 		in date, --<< could be NULL for 'Active' batches
     p_bus_day_count    in number DEFAULT 0, --<< represents a 'complete day' 
	 p_bus_day_start_hr in varchar default '07:00',
	 p_bus_day_end_hr 	in varchar default '19:00'
	 )
    return NUMBER  
  as

	LV_SQL_CODE                 NUMBER 				:= NULL;
    LV_LOG_MESSAGE              CLOB 			    := NULL;
	
   -- lv_num_hours 				number(10,5) := 0;
    lv_first_day_hours 			number(10,5) := 0;
    lv_whole_day_hours 			number(10,5) := 0;
    lv_last_day_hours 				number(10,5) := 0;
    --lv_start_date_TIME          date := null;
    lv_start_of_first_day       date := null;
    lv_end_of_first_day         date := null;
    lv_start_of_last_day        date := null;
    lv_end_of_last_day        	date := null;
    lv_hrs_per_day              number(10,5) := 0;

  begin
  -- the purpose of this function is to determine the number of business hours
  -- between the a "start date" and "end date" or "P_D_date"

    -- lv_num_hours 			:= 0;
    lv_first_day_hours 		:= 0;
    lv_whole_day_hours 		:= 0;
    lv_last_day_hours 			:= 0;
    lv_start_of_first_day   := null;
    lv_end_of_first_day     := null;
    lv_start_of_last_day    := null;
    lv_end_of_last_day      := null;
    lv_hrs_per_day          := 0;

   
  -- NOTE this procedure is called for a single date ( p_d_date )
  
    if p_bus_day_count < 0
    or p_start_date is null
    then
        return 0;
    end if;

	lv_start_of_first_day := p_start_date;

	-- determine the end of first business day
	-- the end date could be null or after the normal close of business

	lv_end_of_first_day := least(p_end_date,
							to_date(to_char(p_start_date,'yyyymmdd')||p_bus_day_end_hr,'yyyymmddhh24:mi')
							);
	-- add the hours for day 1
	lv_first_day_hours := ROUND(((lv_end_of_first_day-lv_start_of_first_day)*24),2);
		
	-- determine the hours for the whole days between  the first and last day
	if p_bus_day_count > 1
	and trunc(nvl(p_end_date,sysdate)) >= trunc(p_d_date)  
    then -- its not the last day 
	    lv_hrs_per_day	:= (to_date(p_bus_day_end_hr,'hh24:mi') - to_date(p_bus_day_start_hr,'hh24:mi'))*24;
		lv_whole_day_hours := lv_hrs_per_day * (p_bus_day_count-1);
	end if;
	
	-- determine the hours for the last day ( probably partial hours )
	if p_bus_day_count > 1
	and trunc(p_d_date) = trunc(nvl(p_end_date,sysdate)) 
    then -- its is the last day 
	-- Add hours for the last day
		lv_start_of_last_day := to_date(to_char(p_d_date,'yyyymmdd')||p_bus_day_start_hr,'yyyymmddhh24:mi');
		if p_end_date is null
		then
			lv_end_of_last_day := to_date(to_char(p_d_date,'yyyymmdd')||p_bus_day_end_hr,'yyyymmddhh24:mi');
		else
			lv_end_of_last_day := p_end_date;
		end if;
		lv_last_day_hours :=  round((lv_end_of_last_day - lv_start_of_last_day )*24,2);
	end if;

	if p_bus_day_count < 10 -- << DEBUG
	then
		DBMS_OUTPUT.PUT_LINE('p_D_date :'||TO_CHAR(p_D_date,'yyyymmdd hh24:MI:SS')); 
		DBMS_OUTPUT.PUT_LINE('p_start_date :'||TO_CHAR(p_start_date,'yyyymmdd hh24:MI:SS'));
		DBMS_OUTPUT.PUT_LINE('p_end_date :'||TO_CHAR(p_end_date,'yyyymmdd hh24:MI:SS'));
		DBMS_OUTPUT.PUT_LINE('p_bus_day_count :'||p_bus_day_count);
		DBMS_OUTPUT.PUT_LINE('lv_first_day_hours :'||lv_first_day_hours);
		DBMS_OUTPUT.PUT_LINE('lv_whole_day_hours :'||lv_whole_day_hours);
		DBMS_OUTPUT.PUT_LINE('lv_last_day_hours :'||lv_last_day_hours);
    end if;

 
    RETURN GREATEST(0,ROUND(lv_first_day_hours+lv_whole_day_hours+lv_last_day_hours,1));
    
  EXCEPTION  
  
        WHEN OTHERS THEN
        
    		LV_SQL_CODE 			:= SQLCODE;
			LV_LOG_MESSAGE 			:= SQLERRM;

			DBMS_OUTPUT.PUT_LINE('FAILED IN BUS_HRS_BETWEEN for PARMS:');

			DBMS_OUTPUT.PUT_LINE(' lv_end_of_first_day '||TO_CHAR(lv_end_of_first_day,'YYYYMMDD HH24:MI:SS'));
			DBMS_OUTPUT.PUT_LINE(' p_d_date: '||to_char(p_d_date,'yyyymmdd hh24:mi'));
			DBMS_OUTPUT.PUT_LINE(' p_start_date: '||to_char(p_start_date,'yyyymmdd hh24:mi'));
			DBMS_OUTPUT.PUT_LINE(' p_end_date: '||to_char(p_end_date,'yyyymmdd hh24:mi'));
			DBMS_OUTPUT.PUT_LINE(' p_bus_day_count: '||p_bus_day_count);
			DBMS_OUTPUT.PUT_LINE(' p_bus_day_start_hr: '||p_bus_day_start_hr);
			DBMS_OUTPUT.PUT_LINE(' p_bus_day_end_hr: '||p_bus_day_end_hr);
			DBMS_OUTPUT.PUT_LINE(' SQLCODE '||LV_SQL_CODE
			||' '||LV_LOG_MESSAGE);

        raise;
        
  end;
/

SHOW ERRORS;