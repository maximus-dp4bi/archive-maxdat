CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_SUMMARY_CC_SV
AS 
SELECT 
  STAFF_STAFF_ID                ,
  STAFF_STAFF_NAME              ,
  DATES_MONTH                   ,
  DATES_MONTH_NUM               ,
  DATES_YEAR                    ,
  EXCLUSION_FLAG                ,
  TOT_CALLS_ANSWERED            ,
  TOT_SHORT_CALLS_ANSWERED      ,
  TOT_TOT_RETURN_TO_QUEUE       ,
  TOT_AVERAGE_HANDLE_TIME       ,
  TOT_SCHED_PRODUCTIVE_TIME     ,
  TOT_ACTUAL_PRODUCTIVE_TIME    ,
  TOT_TALK_TIME                 ,
  TOT_WRAP_UP_TIME              ,
  TOT_LOGGED_IN_TIME            ,
  TOT_NOT_READY_TIME            ,
  TOT_BREAK_TIME                ,
  TOT_LUNCH_TIME                ,
  QCS_PERFORMED                 ,
  AVG_QC_SCORE                  ,
  TOT_INCIDENTS_COMPLETED       ,
  DAYS_INCIDENTS_COMPLETED      ,
  TOT_DEFECTS_COMPLETED         ,
  DAYS_DEFECTS_COMPLETED        ,
  LAG_TIME_TOT_SCHED_PROD_TIME  ,
  TOT_CALL_RECORDS              ,
  TOT_CUSTOMER_COUNT            ,
  TOT_CALL_WRAP_UP_COUNT        ,
  TOT_WRAP_UP_ERROR             ,
  DAYS_SHORT_CALLS_GT_10        ,
  DAYS_CALLS_ANSWERED           ,
  ADHERENCE                     ,
  TOT_RETURN_TO_QUEUE_TIMEOUT   ,
  CORRECTIVE_ACTION_FLAG        ,
  ONE_ON_ONE_FLAG               ,
  OBSERVATION_FLAG              ,
  Recorded_Call_Review_flag     ,
  Live_Phone_Observation_flag   ,
  MER_FLAG 
  FROM DP_SCORECARD.SC_SUMMARY_CC;


GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_SUMMARY_CC_SV TO MAXDAT_READ_ONLY;
