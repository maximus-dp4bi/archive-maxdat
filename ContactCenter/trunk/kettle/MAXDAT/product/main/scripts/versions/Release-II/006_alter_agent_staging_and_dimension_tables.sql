
ALTER TABLE CC_S_ACD_INTERVAL ADD (HANDLE_TIME NUMBER, CTVRU_TIME NUMBER, SERVICE_LEVEL_CALLS NUMBER, ROUTER_QUEUE_WAIT_TIME NUMBER);

ALTER TABLE CC_S_ACD_QUEUE_INTERVAL ADD (HANDLE_TIME NUMBER, CTVRU_TIME NUMBER, SERVICE_LEVEL_CALLS NUMBER, ROUTER_QUEUE_WAIT_TIME NUMBER);

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD (HANDLE_TIME NUMBER, CTVRU_TIME NUMBER, SERVICE_LEVEL_CALLS NUMBER, ROUTER_QUEUE_WAIT_TIME NUMBER, RAW_CONTACTS_OFFERED NUMBER);

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD (HANDLE_TIME NUMBER, CTVRU_TIME NUMBER, SERVICE_LEVEL_CALLS NUMBER, ROUTER_QUEUE_WAIT_TIME NUMBER, RAW_CONTACTS_OFFERED NUMBER);


 CREATE OR REPLACE FORCE VIEW CC_F_ACTUALS_QUEUE_INTERVAL_SV (F_CALL_CENTER_ACTLS_INTRVL_ID, D_DATE_ID, D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_UNIT_OF_WORK_ID, D_CONTACT_QUEUE_ID, D_INTERVAL_ID, D_AGENT_ID, CONTACTS_RECEIVED_FROM_IVR, CALLS_ANSWERED, CONTACTS_OFFERED, CONTACTS_HANDLED, CONTACTS_ABANDONED, MIN_HANDLE_TIME, MAX_HANDLE_TIME, MEAN_HANDLE_TIME, MEDIAN_HANDLE_TIME, STDDEV_HANDLE_TIME, MIN_SPEED_TO_HANDLE, MAX_SPEED_TO_HANDLE, MEAN_SPEED_TO_HANDLE, MEDIAN_SPEED_TO_HANDLE, STDDEV_SPEED_TO_HANDLE, MIN_SPEED_OF_ANSWER, MAX_SPEED_OF_ANSWER, MEAN_SPEED_OF_ANSWER, MEDIAN_SPEED_OF_ANSWER, STDDEV_SPEED_OF_ANSWER, SPEED_OF_ANSWER_PERIOD_1, SPEED_OF_ANSWER_PERIOD_2, SPEED_OF_ANSWER_PERIOD_3, SPEED_OF_ANSWER_PERIOD_4, SPEED_OF_ANSWER_PERIOD_5, SPEED_OF_ANSWER_PERIOD_6, SPEED_OF_ANSWER_PERIOD_7, SPEED_OF_ANSWER_PERIOD_8, SPEED_OF_ANSWER_PERIOD_9, SPEED_OF_ANSWER_PERIOD_10,
  CALLS_ABANDONED_PERIOD_1, CALLS_ABANDONED_PERIOD_2, CALLS_ABANDONED_PERIOD_3, CALLS_ABANDONED_PERIOD_4, CALLS_ABANDONED_PERIOD_5, CALLS_ABANDONED_PERIOD_6, CALLS_ABANDONED_PERIOD_7, CALLS_ABANDONED_PERIOD_8, CALLS_ABANDONED_PERIOD_9, CALLS_ABANDONED_PERIOD_10, LABOR_MINUTES_TOTAL, LABOR_MINUTES_AVAILABLE, LABOR_MINUTES_WAITING, HEADCOUNT_TOTAL, HEADCOUNT_AVAILABLE, HEADCOUNT_UNAVAILABLE, CONTACT_INVENTORY, CONTACT_INVENTORY_JEOPARDY, MIN_CONTACT_INVENTORY_AGE, MAX_CONTACT_INVENTORY_AGE, MEAN_CONTACT_INVENTORY_AGE, MEDIAN_CONTACT_INVENTORY_AGE, STDDEV_CONTACT_INVENTORY_AGE, CONTACTS_TRANSFERRED, OUTFLOW_CONTACTS, ANSWER_WAIT_TIME_TOTAL, ABANDON_TIME_TOTAL, TALK_TIME_TOTAL, AFTER_CALL_WORK_TIME_TOTAL, SERVICE_LEVEL_ANSWERED_PERCENT, SERVICE_LEVEL_ANSWERED_COUNT, SERVICE_LEVEL_ABANDONED, CALLS_ON_HOLD, HOLD_TIME_TOTAL, SHORT_ABANDONS, CONTACTS_BLOCKED, ICR_DEFAULT_ROUTED, NETWORK_DEFAULT_ROUTED, RETURN_BUSY,
  CALLS_RONA, RETURN_RELEASE, CALLS_ROUTED_NON_AGENT, ERROR_COUNT, AGENT_ERROR_COUNT, RETURN_RING, INCOMPLETE_CALLS, CALLS_GIVEN_FORCE_DISCONNECT, CALLS_GIVEN_ROUTE_TO, CREATE_DATE, SHORT_CALLS, LAST_UPDATE_DATE, MAX_ABANDON_TIME, QUEUE_NUMBER, AGENT_LOGIN_ID, ABANDON_THRESHOLD, MAX_CALLS_QUEUED, HANDLE_TIME, CTVRU_TIME, SERVICE_LEVEL_CALLS, ROUTER_QUEUE_WAIT_TIME,RAW_CONTACTS_OFFERED, AVG_TIME_TO_ABANDON)
AS
  SELECT CC_F_ACTUALS_QUEUE_INTERVAL.F_CALL_CENTER_ACTLS_INTRVL_ID,
    CC_F_ACTUALS_QUEUE_INTERVAL.D_DATE_ID,
    CC_D_CONTACT_QUEUE.D_PROJECT_ID,
    CC_D_CONTACT_QUEUE.D_PROGRAM_ID,
    CC_D_CONTACT_QUEUE.D_GEOGRAPHY_MASTER_ID,
    CC_D_CONTACT_QUEUE.D_UNIT_OF_WORK_ID,
    CC_F_ACTUALS_QUEUE_INTERVAL.D_CONTACT_QUEUE_ID,
    CC_F_ACTUALS_QUEUE_INTERVAL.D_INTERVAL_ID,
    CC_F_ACTUALS_QUEUE_INTERVAL.D_AGENT_ID,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_RECEIVED_FROM_IVR,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ANSWERED,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_OFFERED,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_HANDLED,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_ABANDONED,
    CC_F_ACTUALS_QUEUE_INTERVAL.MIN_HANDLE_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.MAX_HANDLE_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEAN_HANDLE_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEDIAN_HANDLE_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.STDDEV_HANDLE_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.MIN_SPEED_TO_HANDLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MAX_SPEED_TO_HANDLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEAN_SPEED_TO_HANDLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEDIAN_SPEED_TO_HANDLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.STDDEV_SPEED_TO_HANDLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MIN_SPEED_OF_ANSWER,
    CC_F_ACTUALS_QUEUE_INTERVAL.MAX_SPEED_OF_ANSWER,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEAN_SPEED_OF_ANSWER,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEDIAN_SPEED_OF_ANSWER,
    CC_F_ACTUALS_QUEUE_INTERVAL.STDDEV_SPEED_OF_ANSWER,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_1,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_2,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_3,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_4,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_5,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_6,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_7,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_8,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_9,
    CC_F_ACTUALS_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_10,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_1,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_2,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_3,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_4,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_5,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_6,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_7,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_8,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_9,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_10,
    CC_F_ACTUALS_QUEUE_INTERVAL.LABOR_MINUTES_TOTAL,
    CC_F_ACTUALS_QUEUE_INTERVAL.LABOR_MINUTES_AVAILABLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.LABOR_MINUTES_WAITING,
    CC_F_ACTUALS_QUEUE_INTERVAL.HEADCOUNT_TOTAL,
    CC_F_ACTUALS_QUEUE_INTERVAL.HEADCOUNT_AVAILABLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.HEADCOUNT_UNAVAILABLE,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACT_INVENTORY,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACT_INVENTORY_JEOPARDY,
    CC_F_ACTUALS_QUEUE_INTERVAL.MIN_CONTACT_INVENTORY_AGE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MAX_CONTACT_INVENTORY_AGE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEAN_CONTACT_INVENTORY_AGE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MEDIAN_CONTACT_INVENTORY_AGE,
    CC_F_ACTUALS_QUEUE_INTERVAL.STDDEV_CONTACT_INVENTORY_AGE,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_TRANSFERRED,
    CC_F_ACTUALS_QUEUE_INTERVAL.OUTFLOW_CONTACTS,
    CC_F_ACTUALS_QUEUE_INTERVAL.ANSWER_WAIT_TIME_TOTAL,
    CC_F_ACTUALS_QUEUE_INTERVAL.ABANDON_TIME_TOTAL,
    CC_F_ACTUALS_QUEUE_INTERVAL.TALK_TIME_TOTAL,
    CC_F_ACTUALS_QUEUE_INTERVAL.AFTER_CALL_WORK_TIME_TOTAL,
    CC_F_ACTUALS_QUEUE_INTERVAL.SERVICE_LEVEL_ANSWERED_PERCENT,
    CC_F_ACTUALS_QUEUE_INTERVAL.SERVICE_LEVEL_ANSWERED_COUNT,
    CC_F_ACTUALS_QUEUE_INTERVAL.SERVICE_LEVEL_ABANDONED,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ON_HOLD,
    CC_F_ACTUALS_QUEUE_INTERVAL.HOLD_TIME_TOTAL,
    CC_F_ACTUALS_QUEUE_INTERVAL.SHORT_ABANDONS,
    CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_BLOCKED,
    CC_F_ACTUALS_QUEUE_INTERVAL.ICR_DEFAULT_ROUTED,
    CC_F_ACTUALS_QUEUE_INTERVAL.NETWORK_DEFAULT_ROUTED,
    CC_F_ACTUALS_QUEUE_INTERVAL.RETURN_BUSY,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_RONA,
    CC_F_ACTUALS_QUEUE_INTERVAL.RETURN_RELEASE,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_ROUTED_NON_AGENT,
    CC_F_ACTUALS_QUEUE_INTERVAL.ERROR_COUNT,
    CC_F_ACTUALS_QUEUE_INTERVAL.AGENT_ERROR_COUNT,
    CC_F_ACTUALS_QUEUE_INTERVAL.RETURN_RING,
    CC_F_ACTUALS_QUEUE_INTERVAL.INCOMPLETE_CALLS,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_GIVEN_FORCE_DISCONNECT,
    CC_F_ACTUALS_QUEUE_INTERVAL.CALLS_GIVEN_ROUTE_TO,
    CC_F_ACTUALS_QUEUE_INTERVAL.CREATE_DATE,
    CC_F_ACTUALS_QUEUE_INTERVAL.SHORT_CALLS,
    CC_F_ACTUALS_QUEUE_INTERVAL.LAST_UPDATE_DATE,
    CC_F_ACTUALS_QUEUE_INTERVAL.MAX_ABANDON_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.QUEUE_NUMBER,
    CC_F_ACTUALS_QUEUE_INTERVAL.AGENT_LOGIN_ID,
    CC_F_ACTUALS_QUEUE_INTERVAL.ABANDON_THRESHOLD,
    CC_F_ACTUALS_QUEUE_INTERVAL.MAX_CALLS_QUEUED,
    CC_F_ACTUALS_QUEUE_INTERVAL.HANDLE_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.CTVRU_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.SERVICE_LEVEL_CALLS,
    CC_F_ACTUALS_QUEUE_INTERVAL.ROUTER_QUEUE_WAIT_TIME,
    CC_F_ACTUALS_QUEUE_INTERVAL.RAW_CONTACTS_OFFERED,
    ROUND( ( CASE WHEN (CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_ABANDONED)!=0 THEN ((CC_F_ACTUALS_QUEUE_INTERVAL.ABANDON_TIME_TOTAL)/(CC_F_ACTUALS_QUEUE_INTERVAL.CONTACTS_ABANDONED))ELSE NULL END ),2) AVG_TIME_TO_ABANDON
  FROM CC_F_ACTUALS_QUEUE_INTERVAL
  INNER JOIN CC_D_CONTACT_QUEUE
  ON CC_F_ACTUALS_QUEUE_INTERVAL.D_CONTACT_QUEUE_ID = CC_D_CONTACT_QUEUE.D_CONTACT_QUEUE_ID; 
  
CREATE OR REPLACE FORCE VIEW CC_F_ACD_QUEUE_INTERVAL_SV (F_CC_ACD_QUEUE_INTRVL_ID, D_DATE_ID, D_PROJECT_ID, D_PROGRAM_ID, D_GEOGRAPHY_MASTER_ID, D_UNIT_OF_WORK_ID, D_CONTACT_QUEUE_ID, D_INTERVAL_ID, CONTACTS_RECEIVED_FROM_IVR, CALLS_ANSWERED, CONTACTS_OFFERED, CONTACTS_HANDLED, CONTACTS_ABANDONED, MIN_HANDLE_TIME, MAX_HANDLE_TIME, MEAN_HANDLE_TIME, MEDIAN_HANDLE_TIME, STDDEV_HANDLE_TIME, MIN_SPEED_TO_HANDLE, MAX_SPEED_TO_HANDLE, MEAN_SPEED_TO_HANDLE, MEDIAN_SPEED_TO_HANDLE, STDDEV_SPEED_TO_HANDLE, MIN_SPEED_OF_ANSWER, MAX_SPEED_OF_ANSWER, MEAN_SPEED_OF_ANSWER, MEDIAN_SPEED_OF_ANSWER, STDDEV_SPEED_OF_ANSWER, SPEED_OF_ANSWER_PERIOD_1, SPEED_OF_ANSWER_PERIOD_2, SPEED_OF_ANSWER_PERIOD_3, SPEED_OF_ANSWER_PERIOD_4, SPEED_OF_ANSWER_PERIOD_5, SPEED_OF_ANSWER_PERIOD_6, SPEED_OF_ANSWER_PERIOD_7, SPEED_OF_ANSWER_PERIOD_8, SPEED_OF_ANSWER_PERIOD_9, SPEED_OF_ANSWER_PERIOD_10,
  CALLS_ABANDONED_PERIOD_1, CALLS_ABANDONED_PERIOD_2, CALLS_ABANDONED_PERIOD_3, CALLS_ABANDONED_PERIOD_4, CALLS_ABANDONED_PERIOD_5, CALLS_ABANDONED_PERIOD_6, CALLS_ABANDONED_PERIOD_7, CALLS_ABANDONED_PERIOD_8, CALLS_ABANDONED_PERIOD_9, CALLS_ABANDONED_PERIOD_10, LABOR_MINUTES_TOTAL, LABOR_MINUTES_AVAILABLE, LABOR_MINUTES_WAITING, HEADCOUNT_TOTAL, HEADCOUNT_AVAILABLE, HEADCOUNT_UNAVAILABLE, CONTACT_INVENTORY, CONTACT_INVENTORY_JEOPARDY, MIN_CONTACT_INVENTORY_AGE, MAX_CONTACT_INVENTORY_AGE, MEAN_CONTACT_INVENTORY_AGE, MEDIAN_CONTACT_INVENTORY_AGE, STDDEV_CONTACT_INVENTORY_AGE, CONTACTS_TRANSFERRED, OUTFLOW_CONTACTS, ANSWER_WAIT_TIME_TOTAL, ABANDON_TIME_TOTAL, TALK_TIME_TOTAL, AFTER_CALL_WORK_TIME_TOTAL, SERVICE_LEVEL_ANSWERED_PERCENT, SERVICE_LEVEL_ANSWERED_COUNT, SERVICE_LEVEL_ABANDONED, CALLS_ON_HOLD, HOLD_TIME_TOTAL, SHORT_ABANDONS, SHORT_CALLS, CONTACTS_BLOCKED, ICR_DEFAULT_ROUTED, NETWORK_DEFAULT_ROUTED,
  RETURN_BUSY, CALLS_RONA, RETURN_RELEASE, CALLS_ROUTED_NON_AGENT, ERROR_COUNT, AGENT_ERROR_COUNT, RETURN_RING, INCOMPLETE_CALLS, CALLS_GIVEN_FORCE_DISCONNECT, CALLS_GIVEN_ROUTE_TO, CREATE_DATE, LAST_UPDATE_DATE, MAX_ABANDON_TIME, QUEUE_NUMBER, ABANDON_THRESHOLD, MAX_CALLS_QUEUED, HANDLE_TIME, CTVRU_TIME, SERVICE_LEVEL_CALLS, ROUTER_QUEUE_WAIT_TIME, RAW_CONTACTS_OFFERED, AVG_TIME_TO_ABANDON)
AS
  SELECT CC_F_ACD_QUEUE_INTERVAL.F_CC_ACD_QUEUE_INTRVL_ID,
    CC_F_ACD_QUEUE_INTERVAL.D_DATE_ID,
    CC_D_CONTACT_QUEUE.D_PROJECT_ID,
    CC_D_CONTACT_QUEUE.D_PROGRAM_ID,
    CC_D_CONTACT_QUEUE.D_GEOGRAPHY_MASTER_ID,
    CC_D_CONTACT_QUEUE.D_UNIT_OF_WORK_ID,
    CC_F_ACD_QUEUE_INTERVAL.D_CONTACT_QUEUE_ID,
    CC_F_ACD_QUEUE_INTERVAL.D_INTERVAL_ID,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_RECEIVED_FROM_IVR,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ANSWERED,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_OFFERED,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_HANDLED,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_ABANDONED,
    CC_F_ACD_QUEUE_INTERVAL.MIN_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MAX_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MIN_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MAX_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MIN_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.MAX_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_1,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_2,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_3,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_4,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_5,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_6,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_7,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_8,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_9,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_10,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_1,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_2,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_3,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_4,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_5,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_6,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_7,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_8,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_9,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_10,
    CC_F_ACD_QUEUE_INTERVAL.LABOR_MINUTES_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.LABOR_MINUTES_AVAILABLE,
    CC_F_ACD_QUEUE_INTERVAL.LABOR_MINUTES_WAITING,
    CC_F_ACD_QUEUE_INTERVAL.HEADCOUNT_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.HEADCOUNT_AVAILABLE,
    CC_F_ACD_QUEUE_INTERVAL.HEADCOUNT_UNAVAILABLE,
    CC_F_ACD_QUEUE_INTERVAL.CONTACT_INVENTORY,
    CC_F_ACD_QUEUE_INTERVAL.CONTACT_INVENTORY_JEOPARDY,
    CC_F_ACD_QUEUE_INTERVAL.MIN_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.MAX_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_TRANSFERRED,
    CC_F_ACD_QUEUE_INTERVAL.OUTFLOW_CONTACTS,
    CC_F_ACD_QUEUE_INTERVAL.ANSWER_WAIT_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.ABANDON_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.TALK_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.AFTER_CALL_WORK_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.SERVICE_LEVEL_ANSWERED_PERCENT,
    CC_F_ACD_QUEUE_INTERVAL.SERVICE_LEVEL_ANSWERED_COUNT,
    CC_F_ACD_QUEUE_INTERVAL.SERVICE_LEVEL_ABANDONED,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ON_HOLD,
    CC_F_ACD_QUEUE_INTERVAL.HOLD_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.SHORT_ABANDONS,
    CC_F_ACD_QUEUE_INTERVAL.SHORT_CALLS,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_BLOCKED,
    CC_F_ACD_QUEUE_INTERVAL.ICR_DEFAULT_ROUTED,
    CC_F_ACD_QUEUE_INTERVAL.NETWORK_DEFAULT_ROUTED,
    CC_F_ACD_QUEUE_INTERVAL.RETURN_BUSY,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_RONA,
    CC_F_ACD_QUEUE_INTERVAL.RETURN_RELEASE,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ROUTED_NON_AGENT,
    CC_F_ACD_QUEUE_INTERVAL.ERROR_COUNT,
    CC_F_ACD_QUEUE_INTERVAL.AGENT_ERROR_COUNT,
    CC_F_ACD_QUEUE_INTERVAL.RETURN_RING,
    CC_F_ACD_QUEUE_INTERVAL.INCOMPLETE_CALLS,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_GIVEN_FORCE_DISCONNECT,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_GIVEN_ROUTE_TO,
    CC_F_ACD_QUEUE_INTERVAL.CREATE_DATE,
    CC_F_ACD_QUEUE_INTERVAL.LAST_UPDATE_DATE,
    CC_F_ACD_QUEUE_INTERVAL.MAX_ABANDON_TIME,
    CC_F_ACD_QUEUE_INTERVAL.QUEUE_NUMBER,
    CC_F_ACD_QUEUE_INTERVAL.ABANDON_THRESHOLD,
    CC_F_ACD_QUEUE_INTERVAL.MAX_CALLS_QUEUED,
    CC_F_ACD_QUEUE_INTERVAL.HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.CTVRU_TIME,
    CC_F_ACD_QUEUE_INTERVAL.SERVICE_LEVEL_CALLS,
    CC_F_ACD_QUEUE_INTERVAL.ROUTER_QUEUE_WAIT_TIME,
    CC_F_ACD_QUEUE_INTERVAL.RAW_CONTACTS_OFFERED,
    ROUND( ( CASE WHEN (CC_F_ACD_QUEUE_INTERVAL.CONTACTS_ABANDONED)!=0 THEN ((CC_F_ACD_QUEUE_INTERVAL.ABANDON_TIME_TOTAL)/(CC_F_ACD_QUEUE_INTERVAL.CONTACTS_ABANDONED))ELSE NULL END ),2) AVG_TIME_TO_ABANDON
  FROM CC_F_ACD_QUEUE_INTERVAL
  INNER JOIN CC_D_CONTACT_QUEUE
  ON CC_F_ACD_QUEUE_INTERVAL.D_CONTACT_QUEUE_ID = CC_D_CONTACT_QUEUE.D_CONTACT_QUEUE_ID;  
  

grant select on CC_F_ACTUALS_QUEUE_INTERVAL_SV to MAXDAT_READ_ONLY;
grant select on CC_F_ACD_QUEUE_INTERVAL_SV to MAXDAT_READ_ONLY;