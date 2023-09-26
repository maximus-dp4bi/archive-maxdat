drop view EMRS_F_CALL_ACTIVITY_SV;
CREATE OR REPLACE VIEW EMRS_F_CALL_ACTIVITY_SV AS
SELECT
ACT.REC_DATE AS RECORD_DATE
, LAST_DAY(ACT.REC_DATE) RECORD_MONTH
, ACT.RECORD_NAME
, ACT.CALL_RECORD_ID
, ACT.CALL_TYPE_CD
, ACT.EVENT_ID
, ACT.CONTEXT
, ACT.EVENT_TYPE_CD
, ACT.MANAGED_CARE_STATUS
, ACT.CALL_REASON_TYPE_CD
, ACT.FIRST_CALL_RESOLUTION
, ACT.CALL_LANGUAGE_CD
, ACT.REFERRAL_TO
, ACT.REFERRAL_REASON
, ACT.PARENT_CALL_RECORD_ID
, ACT.CREATE_TS
, ACT.UPDATE_TS
, ACT.CREATED_BY
, ACT.UPDATED_BY
, ACT.CALL_START_TS
, ACT.CALL_END_TS
, ACT.CASE_ID
, ACT.CLIENT_ID
, CASE WHEN ACT.CALL_EVENT_ORDER = 1 THEN 1 ELSE 0 END CALL_IND
, CASE WHEN ACT.CALL_TYPE_CD = 'INBOUND' AND ACT.CALL_EVENT_ORDER = 1 THEN 1 ELSE 0 END INBOUND_IND
, CASE WHEN ACT.CALL_TYPE_CD = 'OUTBOUND' AND ACT.CALL_EVENT_ORDER = 1  THEN 1 ELSE 0 END OUTBOUND_IND
, CASE WHEN ACT.CALL_TYPE_CD = 'WEBCHAT' AND ACT.CALL_EVENT_ORDER = 1  THEN 1 ELSE 0 END WEBCHAT_IND
, CASE WHEN ACT.REFERRAL_TO IS NOT NULL THEN 1 ELSE 0 END REFERRAL_IND
FROM
(
    SELECT
    CR.CALL_DATE REC_DATE
    , LAST_DAY(CR.CALL_DATE) REC_MONTH
    , UPPER(CONTEXT) CONTEXT
    , CR.RECORD_NAME
    , CR.CALL_RECORD_ID
    , CR.CALL_TYPE_CD
    , CR.EVENT_ID
    , CR.EVENT_TYPE_CD
    , NVL(CR.MANAGED_CARE_STATUS,'NONM') MANAGED_CARE_STATUS
    , NVL(CR.CALL_REASON_TYPE_CD, 'OTHER') CALL_REASON_TYPE_CD
    , CR.FIRST_CALL_RESOLUTION
    , CR.CALL_LANGUAGE_CD
    , CR.REFERRAL_TO
    , CR.REFERRAL_REASON
    , CR.PARENT_CALL_RECORD_ID
    , CR.CREATE_TS
    , CR.UPDATE_TS
    , CR.CREATED_BY
    , CR.UPDATED_BY
    , CR.CALL_START_TS
    , CR.CALL_END_TS
    , CR.CASE_ID
    , CR.CLIENT_ID
    , CR.CALL_EVENT_ORDER
    FROM MAXDAT_SUPPORT.EMRS_D_CALL_RECORD_SV CR
    WHERE CALL_TYPE_CD IN ('INBOUND','OUTBOUND')
) ACT
--LEFT JOIN MAXDAT_SUPPORT.EMRS_D_CALL_TYPE_SV CT ON ACT.CALL_TYPE_CD = CT.CALL_TYPE_CD
--LEFT JOIN MAXDAT_SUPPORT.EMRS_D_MANAGED_CARE_STATUS_SV MC ON ACT.MANAGED_CARE_STATUS = MC.MANAGED_CARE_STATUS
--LEFT JOIN MAXDAT_SUPPORT.EMRS_D_CALL_REASON_SV CREA ON ACT.CALL_REASON_TYPE_CD = CREA.CALL_REASON_TYPE_CD
--LEFT JOIN MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV LS ON ACT.CALL_LANGUAGE_CD = LS.LANGUAGE_CD
--LEFT JOIN MAXDAT_SUPPORT.D_CALL_ACTION_REFERRAL_SV CRF ON ACT.REFERRAL_TO = CRF.REFERRAL_TO AND ACT.REFERRAL_REASON = CRF.REFERRAL_REASON
UNION ALL
SELECT
D.D_DATE AS RECORD_DATE
, LAST_DAY(D.D_DATE) RECORD_MONTH
, NULL RECORD_NAME
, NULL CALL_RECORD_ID
, CT.CALL_TYPE_CD
, NULL EVENT_ID
, NULL CONTEXT
, NULL EVENT_TYPE_CD
, MC.MANAGED_CARE_STATUS
, CREA.CALL_REASON_TYPE_CD
, NULL FIRST_CALL_RESOLUTION
, LS.LANGUAGE_CD CALL_LANGUAGE_CD
, CRF.REFERRAL_TO
, CRF.REFERRAL_REASON
, NULL PARENT_CALL_RECORD_ID
, NULL CREATE_TS
, NULL UPDATE_TS
, NULL CREATED_BY
, NULL UPDATED_BY
, NULL CALL_START_TS
, NULL CALL_END_TS
, NULL CASE_ID
, NULL CLIENT_ID
, 0 CALL_IND
, 0 INBOUND_IND
, 0 OUTBOUND_IND
, 0 WEBCHAT_IND
, 0 REFERRAL_IND
FROM MAXDAT_SUPPORT.D_DATES d
JOIN MAXDAT_SUPPORT.EMRS_D_CALL_TYPE_SV CT ON CT.CALL_TYPE_CD = 'INBOUND' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_MANAGED_CARE_STATUS_SV MC ON MC.MANAGED_CARE_STATUS = 'MCS001' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_CALL_REASON_SV CREA ON 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_LANGUAGE_SV LS ON LS.LANGUAGE_CD = 'EN' AND 1=1
JOIN MAXDAT_SUPPORT.D_CALL_ACTION_REFERRAL_SV CRF ON 1=1
WHERE D.D_DATE >= GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
AND D.D_DATE <= TRUNC(SYSDATE)
;

GRANT SELECT ON EMRS_F_CALL_ACTIVITY_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON maxdat_support.EMRS_F_CALL_ACTIVITY_SV TO MAXDAT_REPORTS;

--drop view emrs_f_call_activity_sv
