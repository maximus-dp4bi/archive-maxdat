-- Semantic View

CREATE OR REPLACE VIEW CC_F_DIALER_BY_DATE_SV AS
SELECT
   F.F_DIALER_ID
  ,F.D_DATE_ID
  ,D.D_DATE
  ,F.CAMPAIGN_NAME
  ,CASE WHEN F.CALL_RESULT=2 THEN 1 ELSE 0 END AS ERROR_COUNT
  ,CASE WHEN F.CALL_RESULT=3 THEN 1 ELSE 0 END AS NO_SERVICE_COUNT
  ,CASE WHEN F.CALL_RESULT=4 THEN 1 ELSE 0 END AS NO_RING_COUNT
  ,CASE WHEN F.CALL_RESULT=5 THEN 1 ELSE 0 END AS INTERCEPT_COUNT
  ,CASE WHEN F.CALL_RESULT=6 THEN 1 ELSE 0 END AS NO_DIAL_TONE_COUNT
  ,CASE WHEN F.CALL_RESULT=7 THEN 1 ELSE 0 END AS INVALID_NUMBER_COUNT
  ,CASE WHEN F.CALL_RESULT=8 THEN 1 ELSE 0 END AS NO_ANSWER_COUNT
  ,CASE WHEN F.CALL_RESULT=9 THEN 1 ELSE 0 END AS BUSY_COUNT
  ,CASE WHEN F.CALL_RESULT=10 THEN 1 ELSE 0 END AS ANSWERED_COUNT
  ,CASE WHEN F.CALL_RESULT=11 THEN 1 ELSE 0 END AS FAX_COUNT
  ,CASE WHEN F.CALL_RESULT=12 THEN 1 ELSE 0 END AS VOICEMAIL_COUNT
  ,CASE WHEN F.CALL_RESULT=13 THEN 1 ELSE 0 END AS NETWORK_STOPPED_COUNT
  ,CASE WHEN F.CALL_RESULT=14 THEN 1 ELSE 0 END AS CALLBACK_COUNT
  ,CASE WHEN F.CALL_RESULT=16 THEN 1 ELSE 0 END AS AGENTS_UNAVAILABLE_COUNT
  ,CASE WHEN F.CALL_RESULT=17 THEN 1 ELSE 0 END AS NOT_RESERVED_COUNT
  ,CASE WHEN F.CALL_RESULT=18 THEN 1 ELSE 0 END AS REJECTED_COUNT
  ,CASE WHEN F.CALL_RESULT=19 THEN 1 ELSE 0 END AS CLOSED_COUNT
  ,CASE WHEN F.CALL_RESULT=20 THEN 1 ELSE 0 END AS IVR_COUNT
  ,CASE WHEN F.CALL_RESULT=21 THEN 1 ELSE 0 END AS DROPPED_COUNT
  ,CASE WHEN F.CALL_RESULT=22 THEN 1 ELSE 0 END AS NETWORK_VOICEMAIL_COUNT
  ,CASE WHEN F.CALL_RESULT=23 THEN 1 ELSE 0 END AS WRONG_NUMBER_COUNT
  ,CASE WHEN F.CALL_RESULT=24 THEN 1 ELSE 0 END AS WRONG_PERSON_COUNT
  ,CASE WHEN F.CALL_RESULT=25 THEN 1 ELSE 0 END AS FLUSHED_COUNT
  ,CASE WHEN F.CALL_RESULT=26 THEN 1 ELSE 0 END AS DO_NOT_CALL_COUNT
  ,CASE WHEN F.CALL_RESULT=27 THEN 1 ELSE 0 END AS DISCONNECTED_COUNT
  ,CASE WHEN F.CALL_RESULT=28 THEN 1 ELSE 0 END AS DEAD_AIR_COUNT
  ,(SELECT PROJECT_ID FROM CC_D_PROJECT WHERE PROJECT_NAME = C.PROJECT_NAME) D_PROJECT_ID
  ,(SELECT PROGRAM_ID FROM CC_D_PROGRAM WHERE PROGRAM_NAME = C.PROGRAM_NAME) D_PROGRAM_ID
FROM CC_F_DIALER_BY_DATE F
INNER JOIN CC_D_DATES D ON (F.D_DATE_ID=D.D_DATE_ID)
LEFT OUTER JOIN CC_C_CAMPAIGN_SV C ON F.CAMPAIGN_ID = C.CAMPAIGN_ID;
  
GRANT SELECT ON CC_F_DIALER_BY_DATE_SV TO MAXDAT_READ_ONLY; 