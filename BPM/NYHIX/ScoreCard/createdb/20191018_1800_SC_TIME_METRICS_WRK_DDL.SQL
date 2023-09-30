
CREATE TABLE DP_SCORECARD.SC_TIME_METRICS_WRK 
   (	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	AGENT_ID VARCHAR2(40 BYTE), 
	STAFF_STAFF_ID NUMBER(38,0), 
	EXCLUSION_FLAG VARCHAR2(1 BYTE), 
	TOT_CALLS_ANSWERED NUMBER, 
	TOT_SHORT_CALLS_ANSWERED NUMBER, 
	TOT_TOT_RETURN_TO_QUEUE NUMBER, 
	TOT_RETURN_TO_QUEUE_TIMEOUT NUMBER, 
	TOT_AVERAGE_HANDLE_TIME NUMBER, 
	TOT_SCHED_PRODUCTIVE_TIME NUMBER, 
	TOT_ACTUAL_PRODUCTIVE_TIME NUMBER, 
	TOT_TALK_TIME NUMBER, 
	TOT_WRAP_UP_TIME NUMBER, 
	TOT_LOGGED_IN_TIME NUMBER, 
	TOT_NOT_READY_TIME NUMBER, 
	TOT_BREAK_TIME NUMBER, 
	TOT_LUNCH_TIME NUMBER, 
	TOT_HANDLE_TIME NUMBER, 
	TOT_HANDLE_TIME_COUNT NUMBER, 
	TRTQ NUMBER, 
	CALLS_OFFERED NUMBER, 
	AGENT_DISCONNECTED_SHORT_CALL NUMBER, 
	CONSUMER_DISCONNECTED_SHORT_CALL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

grant select on DP_SCORECARD.SC_TIME_METRICS_WRK to maxdat;  
grant select on  DP_SCORECARD.SC_STAFF_FILTER_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_EXCLUSIONS_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_ENGAGE_DAILY_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_SCORECARD_QUALITY_WRK to maxdat;
grant select on  DP_SCORECARD.SC_LAG_TIME_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_AGENT_STAT_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_NON_STD_USE_WRK to maxdat;
grant select on  DP_SCORECARD.SC_WUE_METRICS_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_ATTENDANCE_MTHLY_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_PERMFORMANCE_TKR_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_SHORT_CALL_AGENT_COUNT_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_INCDEFS_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_CALL_DAYS_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_LAG_METRICS_WRK to maxdat; 
grant select on  DP_SCORECARD.SC_SUMMARY_CC_WRK to maxdat; 

grant select on DP_SCORECARD.SC_TIME_METRICS_WRK to maxdat_read_only;  
grant select on  DP_SCORECARD.SC_STAFF_FILTER_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_EXCLUSIONS_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_ENGAGE_DAILY_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_SCORECARD_QUALITY_WRK to maxdat_read_only;
grant select on  DP_SCORECARD.SC_LAG_TIME_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_AGENT_STAT_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_NON_STD_USE_WRK to maxdat_read_only;
grant select on  DP_SCORECARD.SC_WUE_METRICS_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_ATTENDANCE_MTHLY_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_PERMFORMANCE_TKR_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_SHORT_CALL_AGENT_COUNT_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_INCDEFS_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_CALL_DAYS_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_LAG_METRICS_WRK to maxdat_read_only; 
grant select on  DP_SCORECARD.SC_SUMMARY_CC_WRK to maxdat_read_only; 

grant select on DP_SCORECARD.SC_TIME_METRICS_WRK to dp_scorecard_read_only;  
grant select on  DP_SCORECARD.SC_STAFF_FILTER_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_EXCLUSIONS_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_ENGAGE_DAILY_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_SCORECARD_QUALITY_WRK to dp_scorecard_read_only;
grant select on  DP_SCORECARD.SC_LAG_TIME_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_AGENT_STAT_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_NON_STD_USE_WRK to dp_scorecard_read_only;
grant select on  DP_SCORECARD.SC_WUE_METRICS_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_ATTENDANCE_MTHLY_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_PERMFORMANCE_TKR_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_SHORT_CALL_AGENT_COUNT_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_INCDEFS_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_CALL_DAYS_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_LAG_METRICS_WRK to dp_scorecard_read_only; 
grant select on  DP_SCORECARD.SC_SUMMARY_CC_WRK to dp_scorecard_read_only; 
