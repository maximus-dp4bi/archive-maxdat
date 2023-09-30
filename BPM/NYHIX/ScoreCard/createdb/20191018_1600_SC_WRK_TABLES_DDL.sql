
  CREATE TABLE DP_SCORECARD.SC_STAFF_FILTER_WRK 
   (	STAFF_STAFF_ID NUMBER(38,0), 
	STAFF_NATID VARCHAR2(250 BYTE), 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	STAFF_COUNT NUMBER, 
	STAFF_STAFF_NAME VARCHAR2(100 BYTE), 
	SUPERVISOR_STAFF_ID NUMBER(38,0), 
	SUPERVISOR_NATID VARCHAR2(250 BYTE), 
	HIRE_DATE DATE, 
	ADJUSTED_TERMINATION_DATE DATE,
	DEPARTMENT                 VARCHAR2(50),
	BUILDING                   VARCHAR2(100) 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  CREATE INDEX DP_SCORECARD.SC_STAFF_FILTER_WRK_AGENT_IDX ON DP_SCORECARD.SC_STAFF_FILTER_WRK (STAFF_NATID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX ;

  CREATE INDEX DP_SCORECARD.SC_STAFF_FILTER_WRK_STAFF_IDX ON DP_SCORECARD.SC_STAFF_FILTER_WRK (STAFF_STAFF_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX ;
  
  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_EXCLUSIONS_WRK 
   (	EXCLUSION_DATE DATE NOT NULL ENABLE, 
	AGENT_ID NUMBER(38,0), 
	STAFF_ID NUMBER(38,0), 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	EXCLUSION_ID NUMBER(38,0) NOT NULL ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_ENGAGE_DAILY_WRK 
   (	AGENT_ID VARCHAR2(250 BYTE), 
	EVAL_DATE DATE, 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	AVG_QC_SCORE NUMBER, 
	SUM_QC_SCORE NUMBER, 
	COUNT_QC_SCORE NUMBER, 
	QCS_PERFORMED NUMBER, 
	QCS_REMAINING NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_SCORECARD_QUALITY_WRK 
   (	AGENT_ID VARCHAR2(250 BYTE), 
	DATES_MONTH_NUM CHAR(6 BYTE), 
	AVG_QC_SCORE NUMBER, 
	SUM_QC_SCORE NUMBER, 
	COUNT_QC_SCORE NUMBER, 
	QCS_PERFORMED NUMBER, 
	QCS_REMAINING NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_LAG_TIME_WRK 
   (	STAFF_STAFF_ID NUMBER, 
	AGENT_ID NUMBER(38,0) NOT NULL ENABLE, 
	LAG_DATE DATE NOT NULL ENABLE, 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	TOT_SCHED_PRODUCTIVE_TIME VARCHAR2(50 BYTE), 
	ADHERENCE_FLAG NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_AGENT_STAT_WRK 
   (	AS_DATE DATE NOT NULL ENABLE, 
	AGENT_ID NUMBER(38,0) NOT NULL ENABLE, 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	CALLS_ANSWERED NUMBER(6,0), 
	SHORT_CALLS_ANSWERED NUMBER(6,0), 
	AVERAGE_HANDLE_TIME VARCHAR2(50 BYTE), 
	TOT_RETURN_TO_QUEUE NUMBER, 
	TOT_RETURN_TO_QUEUE_TIMEOUT NUMBER(6,0), 
	TOT_RET_TO_QUEUE_TOTAL NUMBER, 
	TOT_SCHED_PRODUCTIVE_TIME VARCHAR2(50 BYTE), 
	ACTUAL_PRODUCTIVE_TIME VARCHAR2(50 BYTE), 
	TALK_TIME VARCHAR2(50 BYTE), 
	WRAP_UP_TIME VARCHAR2(50 BYTE), 
	LOGGED_IN_TIME VARCHAR2(50 BYTE), 
	NOT_READY_TIME VARCHAR2(50 BYTE), 
	BREAK_TIME VARCHAR2(50 BYTE), 
	LUNCH_TIME VARCHAR2(50 BYTE), 
	CALLS_OFFERED NUMBER(6,0), 
	EXCLUSION_FLAG VARCHAR2(1 BYTE), 
	AGENT_DISCONNECTED_SHORT_CALLS NUMBER(5,0), 
	CONSUMER_DISCONNECTED_SHORT_CALLS NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  
  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_NON_STD_USE_WRK 
   (	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	EMPLOYEE_ID VARCHAR2(250 BYTE) NOT NULL ENABLE, 
	TOT_CALL_RECORDS NUMBER, 
	TOT_CUSTOMER_COUNT NUMBER, 
	TOT_CALL_WRAP_UP_COUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_WUE_METRICS_WRK 
   (	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	AGENT_ID NUMBER(38,0) NOT NULL ENABLE, 
	TOT_WRAP_UP_ERROR NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  -- ******************************************************
 
  CREATE TABLE DP_SCORECARD.SC_ATTENDANCE_MTHLY_WRK 
   (	MANAGER_STAFF_ID NUMBER(38,0), 
	STAFF_STAFF_ID NUMBER(38,0), 
	DATES_MONTH VARCHAR2(36 BYTE), 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	DATES_YEAR VARCHAR2(41 BYTE), 
	BALANCE NUMBER, 
	TOTAL_BALANCE NUMBER, 
	SC_ATTENDANCE_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;
 
  -- ******************************************************
  
  CREATE TABLE DP_SCORECARD.SC_PERMFORMANCE_TKR_WRK 
   (	STAFF_STAFF_ID NUMBER, 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	CORRECTIVE_ACTION_FLAG NUMBER, 
	ONE_ON_ONE_FLAG NUMBER, 
	OBSERVATION_FLAG NUMBER, 
	RECORDED_CALL_REVIEW_FLAG NUMBER, 
	LIVE_PHONE_OBSERVATION_FLAG NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
 -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_SHORT_CALL_AGENT_COUNT_WRK 
   (	STAFF_STAFF_ID NUMBER(38,0), 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	SHORT_CALL_AGENT_COUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_INCDEFS_WRK 
   (	STAFF_ID NUMBER NOT NULL ENABLE, 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	DAYS_INCDEF_COMPLETED NUMBER, 
	INCIDENTS_COMPLETED NUMBER, 
	DAYS_INCIDENTS_COMPLETED NUMBER, 
	DEFECTS_COMPLETED NUMBER, 
	DAYS_DEFECTS_COMPLETED NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  
  -- ******************************************************
  
  
  CREATE TABLE DP_SCORECARD.SC_CALL_DAYS_WRK 
   (	AGENT_ID NUMBER(38,0) NOT NULL ENABLE, 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	DAYS_SHORT_CALLS_GT_10 NUMBER, 
	DAYS_CALLS_ANSWERED NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  
  -- ******************************************************


  CREATE TABLE DP_SCORECARD.SC_LAG_METRICS_WRK 
   (	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	AGENT_ID NUMBER(38,0) NOT NULL ENABLE, 
	LAG_TIME_TOT_SCHED_PROD_TIME NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  -- ******************************************************

DROP TABLE DP_SCORECARD.SC_SUMMARY_CC_WRK;
 
  
  CREATE TABLE DP_SCORECARD.SC_SUMMARY_CC_WRK 
   (	SUPERVISOR_STAFF_ID NUMBER(38,0), 
	SUPERVISOR_NATID VARCHAR2(250 BYTE), 
	STAFF_STAFF_ID NUMBER(38,0), 
	STAFF_NATID VARCHAR2(250 BYTE), 
	CALC_DATE_TM DATE, 
	DEPARTMENT VARCHAR2(50 BYTE), 
	BUILDING VARCHAR2(100 BYTE), 
	STAFF_STAFF_NAME VARCHAR2(100 BYTE), 
	DATES_MONTH VARCHAR2(36 BYTE), 
	DATES_MONTH_NUM VARCHAR2(6 BYTE), 
	DATES_YEAR VARCHAR2(41 BYTE), 
	EXCLUSION_FLAG VARCHAR2(1 BYTE), 
	TOT_CALLS_ANSWERED NUMBER, 
	TOT_SHORT_CALLS_ANSWERED NUMBER, 
	TOT_TOT_RETURN_TO_QUEUE NUMBER, 
	TOT_AVERAGE_HANDLE_TIME NUMBER, 
	TOT_SCHED_PRODUCTIVE_TIME NUMBER, 
	TOT_ACTUAL_PRODUCTIVE_TIME NUMBER, 
	TOT_TALK_TIME NUMBER, 
	TOT_WRAP_UP_TIME NUMBER, 
	TOT_LOGGED_IN_TIME NUMBER, 
	TOT_NOT_READY_TIME NUMBER, 
	TOT_BREAK_TIME NUMBER, 
	TOT_LUNCH_TIME NUMBER, 
	QCS_PERFORMED NUMBER, 
	AVG_QC_SCORE NUMBER, 
	TOT_INCIDENTS_COMPLETED NUMBER, 
	DAYS_INCIDENTS_COMPLETED NUMBER, 
	TOT_DEFECTS_COMPLETED NUMBER, 
	DAYS_DEFECTS_COMPLETED NUMBER, 
	LAG_TIME_TOT_SCHED_PROD_TIME NUMBER, 
	TOT_CALL_RECORDS NUMBER, 
	TOT_CUSTOMER_COUNT NUMBER, 
	TOT_CALL_WRAP_UP_COUNT NUMBER, 
	TOT_WRAP_UP_ERROR NUMBER, 
	DAYS_SHORT_CALLS_GT_10 NUMBER, 
	DAYS_CALLS_ANSWERED NUMBER, 
	ADHERENCE NUMBER, 
	TOT_RETURN_TO_QUEUE_TIMEOUT NUMBER, 
	CORRECTIVE_ACTION_FLAG NUMBER, 
	ONE_ON_ONE_FLAG NUMBER, 
	OBSERVATION_FLAG NUMBER, 
	TOT_HANDLE_TIME NUMBER, 
	TOT_HANDLE_TIME_COUNT NUMBER, 
	TRTQ NUMBER, 
	SHORT_CALL_AGENT_COUNT NUMBER, 
	SUM_QC_SCORE NUMBER, 
	COUNT_QC_SCORE NUMBER, 
	QCS_REMAINING NUMBER, 
	AVG_ATTENDANCE_BALANCE NUMBER, 
	AVG_ATTENDANCE_TOTAL_BALANCE NUMBER, 
	STAFF_COUNT NUMBER, 
	RECORDED_CALL_REVIEW_FLAG VARCHAR2(1 BYTE), 
	LIVE_PHONE_OBSERVATION_FLAG VARCHAR2(1 BYTE), 
	ADHERENCE_TOT_LOGGED_IN_TIME NUMBER, 
	ADHERENCE_TOT_NOT_READY_TIME NUMBER, 
	DAYS_DEF_INC_COMPLETED NUMBER, 
	CALLS_OFFERED NUMBER(6,0), 
	WEBCHAT_ASSIGNED NUMBER, 
	WEBCHAT_TRANSFERRED NUMBER, 
	WEBCHAT_CONFERENCED NUMBER, 
	WEBCHAT_TOTAL_NUMBER NUMBER, 
	AGENT_DISCONNECTED_SHORT_CALLS NUMBER(5,0), 
	CONSUMER_DISCONNECTED_SHORT_CALLS NUMBER(5,0), 
	CURRENT_MONTH_EVENTS_SCHEDULED NUMBER(5,0), 
	CURRENT_MONTH_EVENTS_MET NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

  CREATE INDEX DP_SCORECARD.SC_SUMMARY_CC_WRK_DATES_MONTH_NUM_NDX ON DP_SCORECARD.SC_SUMMARY_CC_WRK (DATES_MONTH_NUM DESC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX ;

  -- ******************************************************

  -- ******************************************************

  -- ******************************************************

  -- ******************************************************

  