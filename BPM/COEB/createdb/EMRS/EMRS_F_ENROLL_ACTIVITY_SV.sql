CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_SV AS 
SELECT 
D.D_DATE AS RECORD_DATE
, LAST_DAY(D.D_DATE) RECORD_MONTH
, PST.VALUE PLAN_SERVICE_TYPE_CD
, ACT.RECORD_NAME
, ACT.ACTIVITY_RECORD
, ACT.ACTIVITY_TYPE       
, ACT.SUB_ACTIVITY_TYPE       
, ACT.ACTIVITY_ID
, ACT.ACTIVITY_CONTEXT
, ACT.CALL_RECORD_ID
, ACT.CALL_TYPE_CD
, ACT.EVENT_ID
, ACT.SELECTION_TXN_ID
, ACT.TRANSACTION_TYPE_CD
, ACT.SELECTION_SOURCE_CD
, ACT.PLAN_ID
, ACT.PLAN_ID_EXT
, ACT.CONTRACT_ID
, ACT.PROVIDER_ID
, ACT.PROVIDER_ID_EXT
, ACT.TO_PLAN_ID
, ACT.TO_PLAN_ID_EXT
, ACT.TO_PROVIDER_ID
, ACT.TO_PROVIDER_ID_EXT
, ACT.TO_CONTRACT_ID
, ACT.ACCEPTED_DATE
, CASE WHEN PST.VALUE = 'ACC' AND PLAN_ID_EXT IN ('99999901', '99999905') AND PROVIDER_ID_EXT IN ('07020368','23876239') THEN 'MCO' 
       ELSE 'PCMP' END PROVIDER_ORG_TYPE
, CASE WHEN PST.VALUE = 'ACC' AND PLAN_ID_EXT IN ('99999901', '99999905') AND PROVIDER_ID_EXT IN ('07020368','23876239') THEN PROVIDER_ID_EXT 
       ELSE 'PCMP' END PROVIDER_ORG_CD
, CASE WHEN ACT.SELECTION_TXN_ID IS NOT NULL AND ACT.TRANSACTION_TYPE_CD = 'NewEnrollment' then 1 else 0 end NEW_ENROLL
, CASE WHEN ACT.SELECTION_TXN_ID IS NOT NULL AND ACT.ACCEPTED_DATE IS NOT NULL AND ACT.TRANSACTION_TYPE_CD IN ('NewEnrollment','Transfer','PCPTransfer') AND ACT.SELECTION_SOURCE_CD IN ('M','W') THEN 1 ELSE 0 END WEB_ENROLL
, CASE WHEN PST.VALUE = 'ACC' AND ACT.ACCEPTED_DATE IS NOT NULL AND ACT.SELECTION_TXN_ID IS NOT NULL AND ACT.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer') AND PROVIDER_ID_EXT IN ('07020368','23876239') AND TO_PROVIDER_ID_EXT NOT IN ('07020368','23876239') then 1 else 0 END MCO_OPTOUT
, CASE WHEN ACT.SELECTION_TXN_ID IS NOT NULL AND ACT.ACCEPTED_DATE IS NOT NULL AND ACT.TRANSACTION_TYPE_CD IN ('NewEnrollment','Transfer','PCPTransfer') AND ACT.SELECTION_SOURCE_CD IN ('P') THEN 1 ELSE 0 END PH_ENROLL
, CASE WHEN ACT.SELECTION_TXN_ID IS NOT NULL AND ACT.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer') then 1 else 0 end TRANSFER
, CASE WHEN ACT.SELECTION_TXN_ID IS NOT NULL AND ACT.TRANSACTION_TYPE_CD = 'Disenrollment' then 1 else 0 end DISENROLL
, CASE WHEN ACT.SELECTION_TXN_ID IS NOT NULL AND ACT.TRANSACTION_TYPE_CD = 'Disenrollment' AND (DISENROLL_REASON_CD_1 IN ('21','22','23','24','25') OR DISENROLL_REASON_CD_2 IN ('21','22','23','24','25') ) then 1 else 0 end GOOD_CAUSE_DISENROLL
, null MAIL_RETURNED
FROM MAXDAT_SUPPORT.D_DATES d
JOIN &schema_name..ENUM_PLAN_SERVICE_TYPE PST ON 1=1
LEFT JOIN 
(
SELECT 
CR.CALL_DATE REC_DATE
, LAST_DAY(CR.CALL_DATE) REC_MONTH
, 'CALL_RECORD' ACTIVITY_RECORD
, CASE WHEN (CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT = 'ENROLLMENT') THEN 'ENROLLMENT'
       WHEN CR.EVENT_TYPE_CD LIKE '%ENROLL%TRANSFER%' THEN 'ENROLLMENT_CHANGE'
       WHEN CR.EVENT_TYPE_CD LIKE '%CHOICE%ENROLL%' THEN 'ENROLLMENT'
       WHEN CR.TRANSACTION_TYPE_CD IN ('NewEnrollment','Transfer','PCPTransfer') and cr.ERROR_CODE = 'M028' then 'UNSUCCESSFUL_ENROLL'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%INFO%' THEN 'INFO_REQUEST'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%DOCT_NOT_IN%' THEN 'DOCT_NOT_IN_PLAN'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%OPT_OUT%' THEN 'OPT_OUT'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%GOOD_CAUSE%' THEN 'GOOD_CAUSE'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%ONLINE%WEB%' THEN 'ONLINE_WEB'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND (CONTEXT LIKE '%MATERIAL%' OR CONTEXT LIKE '%HANDBOOK%REQUEST%') THEN 'MATERIAL_REQUEST'
       ELSE 'OTHER_CALLS'
       END ACTIVITY_TYPE
, CASE WHEN (CR.PLAN_SERVICE_TYPE_CD = 'ACC' AND CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT = 'ENROLLMENT') THEN 'ACC_ENROLLMENT'
       WHEN (CR.PLAN_SERVICE_TYPE_CD = 'CHP' AND CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT = 'ENROLLMENT') THEN 'CHP_ENROLLMENT'
       WHEN CR.PLAN_SERVICE_TYPE_CD = 'ACC' AND CR.EVENT_TYPE_CD LIKE '%ENROLL%TRANSFER%' THEN 'ACC_ENROLLMENT_CHANGE'
       WHEN CR.PLAN_SERVICE_TYPE_CD = 'CHP' AND CR.EVENT_TYPE_CD LIKE '%ENROLL%TRANSFER%' THEN 'CHP_ENROLLMENT_CHANGE'
       WHEN CR.PLAN_SERVICE_TYPE_CD = 'ACC' AND CR.EVENT_TYPE_CD LIKE '%CHOICE%ENROLL%' THEN 'ACC_ENROLLMENT'
       WHEN CR.PLAN_SERVICE_TYPE_CD = 'CHP' AND CR.EVENT_TYPE_CD LIKE '%CHOICE%ENROLL%' THEN 'CHP_ENROLLMENT'
       WHEN CR.TRANSACTION_TYPE_CD IN ('NewEnrollment','Transfer','PCPTransfer') and cr.ERROR_CODE = 'M028' then 'UNSUCCESSFUL_ENROLL'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%INFO%' THEN 'INFO_REQUEST'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%DOCT_NOT_IN%' THEN 'DOCT_NOT_IN_PLAN'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%OPT_OUT%' THEN 'OPT_OUT'
       WHEN CR.PLAN_SERVICE_TYPE_CD = 'ACC' AND CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%GOOD_CAUSE%' THEN 'ACC_GOOD_CAUSE'
       WHEN CR.PLAN_SERVICE_TYPE_CD = 'CHP' AND CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%GOOD_CAUSE%' THEN 'CHP_GOOD_CAUSE'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND CONTEXT LIKE '%ONLINE%WEB%' THEN 'ONLINE_WEB'
       WHEN CR.EVENT_TYPE_CD = 'MANUAL_ACTION' AND (CONTEXT LIKE '%MATERIAL%' OR CONTEXT LIKE '%HANDBOOK%REQUEST%') THEN 'MATERIAL_REQUEST'
       ELSE 'OTHER_CALLS'
       END SUB_ACTIVITY_TYPE
, NVL(TO_NUMBER(LPAD(TO_CHAR(NVL(EVENT_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(CALL_RECORD_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(SELECTION_TXN_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(SELECTION_SEGMENT_ID,0)),10,'0')),-1) ACTIVITY_ID
, UPPER(CONTEXT) ACTIVITY_CONTEXT
, CR.RECORD_NAME
, CR.CALL_RECORD_ID
, CR.CALL_TYPE_CD
, CR.EVENT_ID
, CR.SELECTION_TXN_ID
, CR.PLAN_SERVICE_TYPE_CD
, CR.DISENROLL_REASON_CD_1
, CR.DISENROLL_REASON_CD_2
, CR.SELECTION_SOURCE_CD
, CR.ACCEPTED_DATE
, CR.CHOICE_REASON_CD
, CR.PLAN_ID
, CR.PLAN_ID_EXT
, CR.CONTRACT_ID
, CR.TRANSACTION_TYPE_CD
, CR.PROVIDER_ID
, CR.PROVIDER_ID_EXT
, CR.TO_PLAN_ID
, CR.TO_PLAN_ID_EXT
, CR.TO_CONTRACT_ID
, CR.TO_PROVIDER_ID
, CR.TO_PROVIDER_ID_EXT
FROM MAXDAT_SUPPORT.EMRS_D_CALL_RECORD_SV CR
UNION ALL
SELECT 
TRUNC(ST.RECORD_DATE) REC_DATE
, TRUNC(LAST_DAY(ST.RECORD_DATE)) REC_MONTH
, 'SELECTION_TXN' ACTIVITY_RECORD
, CASE WHEN ST.TRANSACTION_TYPE_CD = 'NewEnrollment' THEN 'NEW_ENROLLMENT' 
       WHEN ST.TRANSACTION_TYPE_CD IN ('Disenrollment') THEN 'DISENROLLMENT'
       WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer', 'PCPTransfer') THEN 'TRANSFER'
       ELSE 'OTHER_SELECTION_TXN'
       END ACTIVITY_TYPE       
, CASE WHEN ST.TRANSACTION_TYPE_CD = 'NewEnrollment' THEN 'NEW_ENROLLMENT' 
       WHEN ST.TRANSACTION_TYPE_CD IN ('Disenrollment') THEN 'DISENROLLMENT'
       WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer', 'PCPTransfer') THEN 'TRANSFER'
       ELSE 'OTHER_SELECTION_TXN'
       END SUB_ACTIVITY_TYPE       
, NVL(TO_NUMBER(LPAD(TO_CHAR(NVL(ST.EVENT_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(ST.CALL_RECORD_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(ST.SELECTION_TRANSACTION_ID,0)),10,'0')||LPAD(TO_CHAR(NVL(ABS(ST.SELECTION_SEGMENT_ID),0)),10,'0')),-1) ACTIVITY_ID
, UPPER(TRANSACTION_TYPE_CD) ACTIVITY_CONTEXT       
, ST.RECORD_NAME
, ST.CALL_RECORD_ID
, NULL CALL_TYPE_CD
, ST.EVENT_ID
, ST.SELECTION_TRANSACTION_ID SELECTION_TXN_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PRIOR_PLAN_SERVICE_TYPE_CD else ST.PLAN_SERVICE_TYPE_CD end PLAN_SERVICE_TYPE_CD
, ST.CHANGE_REASON_CODE DISENROLL_REASON_CD_1
, ST.DISENROLL_REASON_CD_2
, ST.SELECTION_SOURCE_CD
, ST.ACCEPTED_DATE
, ST.CHOICE_REASON_CD
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PRIOR_PLAN_ID else ST.PLAN_ID end PLAN_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PRIOR_PLAN_ID_EXT else ST.PLAN_ID_EXT end PLAN_ID_EXT
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') THEN ST.PRIOR_CONTRACT_ID ELSE ST.CONTRACT_ID END CONTRACT_ID
, ST.TRANSACTION_TYPE_CD
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PRIOR_PROVIDER_ID else ST.PROVIDER_ID end PROVIDER_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PRIOR_PROVIDER_ID_EXT else ST.PROVIDER_ID_EXT end PROVIDER_ID_EXT
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PLAN_ID else NULL end TO_PLAN_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PLAN_ID_EXT else NULL end TO_PLAN_ID_EXT
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') THEN ST.CONTRACT_ID ELSE NULL END TO_CONTRACT_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PROVIDER_ID else NULL end TO_PROVIDER_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer','PCPTransfer','Disenrollment') then ST.PROVIDER_ID_EXT else NULL end TO_PROVIDER_ID_EXT
FROM MAXDAT_SUPPORT.EMRS_D_SELECTION_TRANS_SV ST
WHERE ST.CALL_RECORD_ID IS NULL
) ACT ON ACT.REC_DATE = D.D_DATE AND ACT.PLAN_SERVICE_TYPE_CD = PST.VALUE
WHERE 1=1
AND PST.VALUE IN ('CHP','ACC')
AND D.D_DATE >= TO_DATE('8/1/2018','MM/DD/YYYY')
AND D.D_DATE <= TRUNC(SYSDATE)
;

GRANT SELECT ON maxdat_support.EMRS_F_ENROLL_ACTIVITY_SV TO MAXDAT_REPORTS;




