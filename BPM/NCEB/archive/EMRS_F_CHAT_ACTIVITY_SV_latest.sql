drop view EMRS_F_CHAT_ACTIVITY_SV;
CREATE OR REPLACE VIEW EMRS_F_CHAT_ACTIVITY_SV AS
SELECT
    CR.CALL_DATE RECORD_DATE
    , CR.RECORD_NAME
    , CR.CALL_RECORD_ID CHAT_RECORD_ID
    , CR.CALL_TYPE_CD CHAT_TYPE_CD
    , CR.CHAT_REASON_CD
    , CR.CALL_LANGUAGE_CD CHAT_LANGUAGE_CD
    , CR.CREATE_TS
    , CR.UPDATE_TS
    , CR.CREATED_BY
    , CR.UPDATED_BY
    , CR.CALL_START_TS CHAT_START_TS
    , CR.CALL_END_TS CHAT_END_TS
    , CR.CASE_ID
    , CR.CLIENT_ID
    , CASE WHEN UPPER(CR.CALL_TYPE_CD) = 'WEBCHAT'  THEN 1 ELSE 0 END WEBCHAT_IND
    FROM MAXDAT_SUPPORT.EMRS_D_CHAT_RECORD_SV CR
    WHERE UPPER(CR.CALL_TYPE_CD) = 'WEBCHAT'
    and CR.MEDCHAT_ID is not null 
UNION ALL
SELECT
D.D_DATE AS RECORD_DATE
, NULL RECORD_NAME
, NULL CHAT_RECORD_ID
, CT.CALL_TYPE_CD CHAT_TYPE_CD
, CHREA.CHAT_REASON_CD
, LS.LANGUAGE_CD CALL_LANGUAGE_CD
, NULL CREATE_TS
, NULL UPDATE_TS
, NULL CREATED_BY
, NULL UPDATED_BY
, NULL CHAT_START_TS
, NULL CHAT_END_TS
, NULL CASE_ID
, NULL CLIENT_ID
, 0 WEBCHAT_IND
FROM MAXDAT_SUPPORT.D_DATES d
JOIN MAXDAT_SUPPORT.EMRS_D_CALL_TYPE_SV CT ON CT.CALL_TYPE_CD = 'WEBCHAT' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_CHAT_REASON_SV CHREA ON 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV LS ON LS.LANGUAGE_CD = 'EN' AND 1=1
WHERE D.D_DATE >= GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
AND D.D_DATE <= TRUNC(SYSDATE)
;

GRANT SELECT ON EMRS_F_CHAT_ACTIVITY_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON EMRS_F_CHAT_ACTIVITY_SV TO MAXDAT_REPORTS;
