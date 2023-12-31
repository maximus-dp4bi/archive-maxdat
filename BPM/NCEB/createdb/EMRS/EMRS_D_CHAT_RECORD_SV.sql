drop view EMRS_D_CHAT_RECORD_SV;
CREATE OR REPLACE VIEW EMRS_D_CHAT_RECORD_SV AS
SELECT 
CA.CALL_DATE
, CA.CALL_TYPE_CD
, CA.CALLER_TYPE_CD
, CA.CALLER_PHONE
, CA.ext_telephony_ref
, CA.caller_first_name
, CA.caller_last_name
, CA.CASE_ID
, CA.CLIENT_ID
, CA.parent_call_record_id
, CA.CREATE_TS
, CA.UPDATE_TS
, CA.created_by
, CA.updated_by
, CA.CALL_sTART_TS
, CA.CALL_END_TS
, CA.RECORD_NAME
, CA.CALL_RECORD_ID
, CA.CHAT_REASON_CD
, CA.LANGUAGE_CD CALL_LANGUAGE_CD
, CA.MEDCHAT_ID
FROM
(
SELECT /*+ PARALLEL(10) */
CR.CALL_RECORD_ID
, CR.CALL_TYPE_CD
, CR.CALLER_TYPE_CD
, CR.WORKER_ID
, CR.WORKER_USERNAME
, CR.LANGUAGE_CD
-- below is until https://jira.maximus.com/browse/NCEB-1574 is fixed by baseline. Medchat to EB, the Call_start_ts is UTC, need to change to Eastern
, CASE WHEN CR.CALL_TYPE_CD = 'WEBCHAT' and CR.MEDCHAT_ID is not NULL THEN (cast(FROM_TZ(cast( CR.CALL_sTART_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) ELSE (CR.CALL_START_TS) END CALL_START_TS
, CASE WHEN CR.CALL_TYPE_CD = 'WEBCHAT' and CR.MEDCHAT_ID is not NULL THEN (cast(FROM_TZ(cast( CR.CALL_END_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) ELSE TRUNC(CR.CALL_END_TS) END CALL_END_TS
, CASE WHEN CR.CALL_TYPE_CD = 'WEBCHAT' and CR.MEDCHAT_ID is not NULL THEN TRUNC(cast(FROM_TZ(cast( CR.CALL_sTART_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) ELSE TRUNC(CR.CALL_START_TS) END CALL_DATE
--, CR.CALL_START_TS
--, CR.CALL_END_TS
--, TRUNC(CR.CALL_START_TS) CALL_DATE
, CR.CALLER_PHONE
, cr.ext_telephony_ref 
, cr.caller_first_name 
, cr.caller_last_name
, cr.parent_call_record_id
, CRL.CASE_ID
, CRL.EXT_CASE_NUM
, CRL.CLIENT_ID
, CRL.EXT_CLIENT_NUM
, CRL.CLIENT_LAST_NAME
, CRL.CLIENT_FIRST_NAME
, CRL.CLIENT_MI
, CR.CREATE_TS
, CR.UPDATE_TS
, cr.created_by 
, cr.updated_by
, CR.CREATED_BY RECORD_NAME
, UPPER(CHRSN.VALUE) CHAT_REASON_CD
, ROW_NUMBER() OVER(PARTITION BY CR.CALL_RECORD_ID ORDER BY CRL.CLIENT_ID) ROWN
, MEDCHAT_ID
FROM EB.CALL_RECORD CR
LEFT JOIN EB.ENUM_MEDCHAT_TOPIC CHRSN ON UPPER(CHRSN.VALUE)=UPPER(CR.MEDCHAT_TOPIC)
LEFT JOIN EB.CALL_RECORD_LINK CRL ON CRL.CALL_RECORD_ID = CR.CALL_RECORD_ID
WHERE 1=1
AND CR.CALL_END_TS IS NOT NULL
AND CR.CALL_TYPE_CD = 'WEBCHAT'
--AND CR.CALL_RECORD_ID = 26051113--26051085
) CA
WHERE CA.ROWN = 1
AND CA.CALL_DATE >= GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
;

GRANT SELECT ON maxdat_support.EMRS_D_CHAT_RECORD_SV TO MAXDAT_REPORTS;


