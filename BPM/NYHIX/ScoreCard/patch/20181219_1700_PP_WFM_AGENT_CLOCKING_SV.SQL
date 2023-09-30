--DROP VIEW DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV
AS 
SELECT 
    HIER.MANAGER_NATID                                            AS MANAGER_NATIONAL_ID,    
    HIER.MANAGER_NAME                                               AS MANAGER,
    HIER.SUPERVISOR_NATID                                          AS SUPERVISOR_NATIONAL_ID,
    HIER.SUPERVISOR_NAME                                            AS SUPERVISOR,
    HIER.STAFF_NATID                                               AS STAFF_NATIONAL_ID,
    HIER.STAFF_STAFF_NAME                                                 AS STAFF,
    staff.termination_date                                          as termination_date,
    HIST.STAFF_ID                                                 	AS 	STAFF_ID,
	HIST.WORK_DAY								          		  	AS 	WORK_DATE,
    HIST.SCHEDULED_START											AS	SCHEDULE_START,
    -----------------------------------------------      
    HIST.LOG_START													AS	ACTUAL_START_TIME,
    -----------------------------------------------
    case when (
        HIST.SCHEDULED_START is null
        or HIST.LOG_START is null
    )
    then null
    else
        to_char(abs(extract ( hour from (cast(HIST.SCHEDULED_START as timestamp) - cast(HIST.LOG_START as timestamp))) ), 'FM00') ||':'||  
        to_char(abs(extract ( minute from (cast(HIST.SCHEDULED_START as timestamp) - cast(HIST.LOG_START as timestamp))) ), 'FM00') ||':'||  
        to_char(abs(extract ( second from (cast(HIST.SCHEDULED_START as timestamp) - cast(HIST.LOG_START as timestamp))) ), 'FM00')   
    end AS START_TIME_VARIANCE,
    ---------------------------------
        CASE WHEN  HIST.SCHEDULED_START IS NULL OR HIST.LOG_START IS NULL THEN 0
            WHEN ROUND(ABS(HIST.SCHEDULED_START - HIST.LOG_START)*(24*60),0) <= 8 THEN 0 
            ELSE 1 END AS START_TIME_VARIANCE_FLAG,
    -----------------------------------------------            
	HIST.SCHEDULED_END												AS	SCHEDULE_END_TIME,
	-----------------------------------------------      
	HIST.LOG_END													AS	ACTUAL_END_TIME,
    -----------------------------------------------            
     CASE WHEN HIST.SCHEDULED_END IS NULL 
		OR HIST.LOG_END IS NULL
		THEN NULL
        ELSE
--            CASE WHEN (HIST.LOG_END - HIST.SCHEDULED_END) <= 0 
--				THEN ' ' 
--                ELSE '-'  END  
			to_char(abs(extract( hour from cast(HIST.LOG_END as timestamp) - cast(HIST.SCHEDULED_END as timestamp))), 'FM00') || ':' ||
			to_char(abs(extract( minute from cast(HIST.LOG_END as timestamp) - cast(HIST.SCHEDULED_END as timestamp))), 'FM00') || ':' ||
			to_char(abs(extract( second from cast(HIST.LOG_END as timestamp) - cast(HIST.SCHEDULED_END as timestamp))), 'FM00') 
        END                                         												AS END_TIME_VARIANCE, 
        CASE 
            WHEN HIST.SCHEDULED_END IS NULL OR HIST.LOG_END IS NULL THEN 0
            WHEN  ROUND(ABS(HIST.SCHEDULED_END - HIST.LOG_END)*(24*60),0) <= 8 THEN 0 
            ELSE 1 END AS END_TIME_VARIANCE_FLAG,          
    -----------------------------------------------            
	ROUND(HIST.TOTAL_SCHEDULED_MINUTES,0)									AS TOTAL_SCHEDULED_MINUTES, 
	------------------------------------------------------------
	CASE WHEN HIST.TOTAL_SCHEDULED_MINUTES >= 466 THEN 30 ELSE 15 END  	                AS 	BREAK_ALLOWANCE,  
    ROUND(HIST.ACTUALS_BREAK_DURATION_sec/60,0)											AS	BREAK_DURATION,
    ROUND(HIST.ACTUALS_LUNCH_DURATION_sec/60,0)											AS 	LUNCH_DURATION
  --  ROUND((HIST.ACTUALS_END - HIST.ACTUALS_START )*(60*24),0)								AS	RT_ACTUALS_SHIFT_DURATION,
    -----------------------------------------------
  --  HIST.LOG_DURATION*(60*24),
  --  HIST.ACTUALS_BREAK_DURATION*(60*24),
  --  HIST.ACTUALS_LUNCH_DURATION*(60*24),
--    round((HIST.LOG_DURATION_sec 
--        -  HIST.ACTUALS_BREAK_DURATION_sec + HIST.ACTUALS_LUNCH_DURATION_sec   
--        +  ( CASE WHEN HIST.LOG_DURATION_sec >= 466*60 THEN 30*60 
--            ELSE 15*60 END ))/(60*60),2)  
--                        					AS TOTAL_WORKED_TIME_hrs
--                 -----------------------------------------------
 FROM PP_WFM_agent_CLOCKING_HISTORY HIST
 JOIN SCORECARD_HIERARCHY HIER
 ON HIER.STAFF_STAFF_ID = HIST.STAFF_ID 
 JOIN sc_hierarchy_staff staff
 on staff.staff_id = hist.staff_id
 WHERE DELETE_DETECTED_DATE IS NULL; 


GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV TO MAXDAT_REPORTS;
