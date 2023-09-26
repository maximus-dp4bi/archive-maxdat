CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
  SELECT 
    pl.plan_id AS PLAN_ID,
    pl.plan_id_ext as plan_id_ext,
    pl.plan_code AS PLAN_CODE,
    case when c.plan_Service_type_Cd = 'ACC' then substr(pl.plan_code,4,1) ||'-'|| pl.plan_name else pl.plan_name end AS PLAN_NAME,
    pl.plan_name AS PLAN_ABBREVIATION,
    c.program_type_cd AS MANAGED_CARE_PROGRAM,
    ca.start_date AS PLAN_EFFECTIVE_DATE,
    cn.first_name AS CONTACT_FIRST_NAME,
    cn.middle_name AS CONTACT_MIDDLE_NAME,
    cn.last_name AS CONTACT_LAST_NAME,
    cn.first_name||
    TRIM(CASE
      WHEN SUBSTR(cn.middle_name,1,1) IS NULL
      THEN ' '
      ELSE ' '||SUBSTR(cn.middle_name,1,1)||' '
    END ||cn.last_name) AS CONTACT_FULL_NAME,
    cad.street_1 AS ADDRESS1,
    cad.street_2 AS ADDRESS2,
    cad.city AS CITY,
    cad.state AS STATE,
    cad.zipcode AS ZIP,
    cn.phone AS CONTACT_PHONE, --contact info
    CASE
      WHEN ca.status_cd = 'CLOSED'
      THEN 'N'
      ELSE 'Y'
    END AS ACTIVE,
    CASE
      WHEN ca.auto_assignment_type_cd <> 'NO_TRANSACTIONS'
      THEN 'Y'
      ELSE 'N'
    END AS ENROLLOK,
    CASE
      WHEN ca.auto_assignment_type_cd = 'ALL_TRANSACTIONS'
      THEN 'Y'
      ELSE 'N'
    END AS PLAN_ASSIGN,
    CASE
      WHEN c.plan_service_type_cd = 'DENTAL'
      THEN 'DENTAL'
      ELSE 'MEDICAL'
    END AS PLAN_TYPE,
    ca.create_ts AS RECORD_DATE,
    TO_CHAR(ca.create_ts,'HH24MI') AS RECORD_TIME,
    ca.created_by AS RECORD_NAME    
--    ,CCON.COUNTY_CD COUNTY_CODE        
  FROM EB.plans pl
  JOIN EB.contract c ON pl.plan_id = c.plan_id
  JOIN EB.contract_amendment ca ON c.contract_id =ca.contract_id
--  JOIN EB.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id  
  LEFT JOIN EB.contact cn ON (c.contract_id = cn.contract_id)
  LEFT JOIN EB.contact_address cad ON cn.contact_id = cad.contact_id
  WHERE 1=1
  and ca.end_date IS NULL
  AND ca.status_cd = 'ACTIVE'
  AND c.end_date IS NULL
  UNION
  SELECT 0 AS PLAN_ID,
    '0' as plan_id_ext,
    '0' AS PLAN_CODE,
    'No Plan Designated' AS PLAN_NAME,
    'No Plan Designated' AS PLAN_ABBREVIATION,
    'MEDICAID' AS MANAGED_CARE_PROGRAM,
    TO_DATE('01/01/1900','MM/DD/YYYY') AS PLAN_EFFECTIVE_DATE,
    NULL AS CONTACT_FIRST_NAME,
    NULL AS CONTACT_MIDDLE_NAME,
    NULL AS CONTACT_LAST_NAME,
    NULL AS CONTACT_FULL_NAME,
    NULL AS ADDRESS1,
    NULL AS ADDRESS2,
    NULL AS CITY,
    NULL AS STATE,
    NULL AS ZIP,
    NULL AS CONTACT_PHONE, --contact info
     'N' AS ACTIVE,
    'N' AS ENROLLOK,
    'N' AS PLAN_ASSIGN,
    '0' AS PLAN_TYPE,
    NULL AS RECORD_DATE,
    NULL AS RECORD_TIME,
    NULL AS RECORD_NAME
 --   ,null COUNTY_CODE        
 FROM DUAL
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SV TO MAXDATSUPPORT_READ_ONLY;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_PLAN_SV TO MAXDAT_REPORTS; 
  
drop materialized view EMRS_F_ENROLL_ACTIVITY_STUB_MV;
CREATE MATERIALIZED VIEW EMRS_F_ENROLL_ACTIVITY_STUB_MV
REFRESH FORCE ON DEMAND
AS
SELECT /*+ PARALLEL(10) */
--D.D_DATE AS RECORD_DATE
--, LAST_DAY(D.D_DATE) RECORD_MONTH
--, NULL RECORD_NAME
PRG.program_code
,PT.PLAN_TYPE
,'TRANSFER' ACTIVITY_TYPE
, CASE WHEN DSNT.DISENROLL_TYPE_CD = 'WITHCAUSE' THEN 'DISENROLLMENT_WITHCAUSE'
       WHEN DSNT.DISENROLL_TYPE_CD = 'WITHOUTCAUSE' THEN 'DISENROLLMENT_WITHOUTCAUSE'
       ELSE NULL END SUB_ACTIVITY_TYPE
,ACTIVITY_STATUS
,SELS.SELECTION_SOURCE_CODE
,PLN.PLAN_ID CURRENT_PLAN_ID
,PLNT.PLAN_ID PRIOR_PLAN_ID
,DSNR.REASON_CD
,DSNT.DISENROLL_TYPE_CD
,CTY.COUNTY_CODE
,CSD.CSDA_CODE
,MC.MANAGED_CARE_STATUS
,0 NEW_ENROLL_CNT
,0 TRANSFER_CNT
,0 DISENROLL_CNT
, DSNR.PHP_INITIATED PHP_DISENROLL_IND
,'N' PCP_SELECTED_IND
,CASE WHEN PLN.plan_code = 'FFS' THEN 'Y' ELSE 'N' END PLAN_FFS_IND
,CASE WHEN PLNT.plan_code = 'FFS' THEN 'Y' ELSE 'N' END TO_PLAN_FFS_IND
, DSNR.urgent URGENT_IND
,0 ACTIVITY_PROCESSING_CAL_DAYS_CNT
FROM maxdat_support.emrs_d_PROGRAM_SV PRG --ON PRG.program_code = 'MEDICAID' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_TYPE_SV PT ON PT.PLAN_TYPE = 'MEDICAL' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_ACTIVITY_STATUS_SV ACTS ON 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_SELECTION_SOURCE_SV SELS ON  SELS.SELECTION_SOURCE_CODE <> '0' AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_SV PLN ON PLN.plan_id <> 0
JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_SV PLNT ON PLNT.PLAN_ID <> 0
JOIN MAXDAT_SUPPORT.EMRS_D_DISENROLL_TYPE_SV DSNT ON 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV DSNR ON DSNR.managed_care_program = PRG.program_code AND DSNR.DISENROLL_TYPE_CD = DSNT.DISENROLL_TYPE_CD AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_COUNTY_SV CTY ON CTY.COUNTY_CODE <> 0
JOIN MAXDAT_SUPPORT.EMRS_D_CARE_SERV_DELIV_AREA_SV CSD ON CSD.CSDA_CODE = CTY.CSDA_CODE AND 1=1
JOIN MAXDAT_SUPPORT.EMRS_D_MANAGED_CARE_STATUS_SV MC ON (MC.MANAGED_CARE_STATUS = 'MCS001' OR MC.MANAGED_CARE_STATUS = 'MCS026') AND 1=1
--JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_COUNTY_PROGRAM_SV PCP ON PCP.program_code = PRG.PROGRAM_CODE AND PCP.plan_type_cd = PT.PLAN_TYPE AND PCP.plan_id = PLN.PLAN_ID
WHERE 1=1
AND PRG.program_code = 'MEDICAID'
and (PLN.PLAN_ID IS NULL OR CTY.COUNTY_CODE IS NULL OR 
 (PRG.PROGRAM_CODE, PT.PLAN_TYPE, PLN.PLAN_ID, CTY.COUNTY_CODE) IN (
          SELECT PCP.PROGRAM_CODE, PCP.PLAN_TYPE_CD, PCP.PLAN_ID, PCP.COUNTY_CODE
          FROM EMRS_D_PLAN_COUNTY_PROGRAM_SV PCP
          )
)
and (PLNT.PLAN_ID IS NULL OR CTY.COUNTY_CODE IS NULL OR (PRG.PROGRAM_CODE, PT.PLAN_TYPE, PLNT.PLAN_ID, CTY.COUNTY_CODE) IN (
          SELECT PCP.PROGRAM_CODE, PCP.PLAN_TYPE_CD, PCP.PLAN_ID, PCP.COUNTY_CODE
          FROM EMRS_D_PLAN_COUNTY_PROGRAM_SV PCP
          )
)
--AND D.D_DATE >= GREATEST(TO_DATE('4/1/2019','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
--AND D.D_DATE <= TRUNC(SYSDATE+365)
--tablespace MAXDAT_TBS
;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_STUB_MV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_STUB_MV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_STUB_MV TO MAXDAT_REPORTS;
commit;


create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX1 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE, ACTIVITY_STATUS, SELECTION_SOURCE_CODE, CURRENT_PLAN_ID, PRIOR_PLAN_ID, DISENROLL_TYPE_CD, MANAGED_CARE_STATUS, CSDA_CODE, COUNTY_CODE) tablespace MAXDAT_TBS ;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX2 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,CSDA_CODE, COUNTY_CODE, MANAGED_CARE_STATUS) parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX3 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,CSDA_CODE, COUNTY_CODE, SELECTION_SOURCE_CODE) tablespace maxdat_tbs parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX5 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,SELECTION_SOURCE_CODE) parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX6 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,MANAGED_CARE_STATUS) parallel 10;
create index EMRS_F_ENROLL_ACTIVITY_STUB_MV_IDX7 on EMRS_F_ENROLL_ACTIVITY_STUB_MV(PROGRAM_CODE, PLAN_TYPE, ACTIVITY_TYPE, SUB_ACTIVITY_TYPE,PRIOR_PLAN_ID) parallel 10;

DROP VIEW MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_CNT_SV;


  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_F_ENROLL_ACTIVITY_CNT_SV" ("RECORD_DATE", "RECORD_MONTH", "RECORD_NAME", "PROGRAM_CODE", "PLAN_TYPE", "ACTIVITY_TYPE", "SUB_ACTIVITY_TYPE", "ACTIVITY_STATUS", "SELECTION_SOURCE_CODE", "CURRENT_PLAN_ID", "PRIOR_PLAN_ID", "REASON_CD", "DISENROLL_TYPE_CD", "COUNTY_CODE", "CSDA_CODE", "MANAGED_CARE_STATUS", "NEW_ENROLL_CNT", "TRANSFER_CNT", "DISENROLL_CNT", "PHP_DISENROLL_IND", "PCP_SELECTED_IND", "PLAN_FFS_IND", "TO_PLAN_FFS_IND", "URGENT_IND", "ACTIVITY_CNT", "APPROVED_URGENT_TRANSFER_CNT", "APPROVED_NONURGENT_TRANSFER_CNT", "APPROVED_URGENT_DISENROLL_CNT", "APPROVED_NONURGENT_DISENROLL_CNT", "DENIED_URGENT_TRANSFER_CNT", "DENIED_NONURGENT_TRANSFER_CNT", "DENIED_URGENT_DISENROLL_CNT", "DENIED_NONURGENT_DISENROLL_CNT", "INPROCESS_URGENT_TRANSFER_CNT", "INPROCESS_NONURGENT_TRANSFER_CNT", "INPROCESS_URGENT_DISENROLL_CNT", "INPROCESS_NONURGENT_DISENROLL_CNT", "ACTIVITY_PROCESSING_CAL_DAYS_CNT", "SELECTION_TRANSACTION_ID", "SELECTION_SEGMENT_ID", "DOCUMENT_ID", "DOCUMENT_RECEIVED_DATE", "CALL_RECORD_ID", "EVENT_ID", "ACTIVITY_ID") AS 
  SELECT --/*+ PARALLEL(10) */
ACT.RECORD_DATE
, ACT.RECORD_MONTH
, NULL RECORD_NAME
, ACT.PROGRAM_CODE
, ACT.PLAN_TYPE
, ACT.ACTIVITY_TYPE
, ACT.SUB_ACTIVITY_TYPE
, ACT.ACTIVITY_STATUS
, ACT.SELECTION_SOURCE_CODE
, ACT.CURRENT_PLAN_ID
, ACT.PRIOR_PLAN_ID
, ACT.REASON_CD
, ACT.DISENROLL_TYPE_CD
, ACT.COUNTY_CODE
, ACT.CSDA_CODE
, ACT.MANAGED_CARE_STATUS
, (ACT.NEW_ENROLL_IND) NEW_ENROLL_CNT
, (ACT.TRANSFER_IND) TRANSFER_CNT
, (ACT.DISENROLL_IND) DISENROLL_CNT
, ACT.PHP_DISENROLL_IND
, ACT.PCP_SELECTED_IND
, ACT.PLAN_FFS_IND
, ACT.TO_PLAN_FFS_IND
, ACT.URGENT_IND
, ACT.ACTIVITY_IND ACTIVITY_CNT
, CASE WHEN ACTIVITY_STATUS = 'APPROVED' AND URGENT_IND = 'Y' AND TRANSFER_IND = 1 THEN 1 ELSE 0 END APPROVED_URGENT_TRANSFER_CNT
, CASE WHEN ACTIVITY_STATUS = 'APPROVED' AND URGENT_IND = 'N' AND TRANSFER_IND = 1 THEN 1 ELSE 0 END APPROVED_NONURGENT_TRANSFER_CNT
, CASE WHEN ACTIVITY_STATUS = 'APPROVED' AND URGENT_IND = 'Y' AND DISENROLL_IND = 1 THEN 1 ELSE 0 END APPROVED_URGENT_DISENROLL_CNT
, CASE WHEN ACTIVITY_STATUS = 'APPROVED' AND URGENT_IND = 'N' AND DISENROLL_IND = 1 THEN 1 ELSE 0 END APPROVED_NONURGENT_DISENROLL_CNT
, CASE WHEN ACTIVITY_STATUS = 'DENIED' AND URGENT_IND = 'Y' AND TRANSFER_IND = 1 THEN 1 ELSE 0 END DENIED_URGENT_TRANSFER_CNT
, CASE WHEN ACTIVITY_STATUS = 'DENIED' AND URGENT_IND = 'N' AND TRANSFER_IND = 1 THEN 1 ELSE 0 END DENIED_NONURGENT_TRANSFER_CNT
, CASE WHEN ACTIVITY_STATUS = 'DENIED' AND URGENT_IND = 'Y' AND DISENROLL_IND = 1 THEN 1 ELSE 0 END DENIED_URGENT_DISENROLL_CNT
, CASE WHEN ACTIVITY_STATUS = 'DENIED' AND URGENT_IND = 'N' AND DISENROLL_IND = 1 THEN 1 ELSE 0 END DENIED_NONURGENT_DISENROLL_CNT
, CASE WHEN ACTIVITY_STATUS = 'INPROCESS' AND URGENT_IND = 'Y' AND TRANSFER_IND = 1 THEN 1 ELSE 0 END INPROCESS_URGENT_TRANSFER_CNT
, CASE WHEN ACTIVITY_STATUS = 'INPROCESS' AND URGENT_IND = 'N' AND TRANSFER_IND = 1 THEN 1 ELSE 0 END INPROCESS_NONURGENT_TRANSFER_CNT
, CASE WHEN ACTIVITY_STATUS = 'INPROCESS' AND URGENT_IND = 'Y' AND DISENROLL_IND = 1 THEN 1 ELSE 0 END INPROCESS_URGENT_DISENROLL_CNT
, CASE WHEN ACTIVITY_STATUS = 'INPROCESS' AND URGENT_IND = 'N' AND DISENROLL_IND = 1 THEN 1 ELSE 0 END INPROCESS_NONURGENT_DISENROLL_CNT
,(ACT.ACTIVITY_PROCESSING_CAL_DAYS_CNT) ACTIVITY_PROCESSING_CAL_DAYS_CNT
, ACT.SELECTION_TRANSACTION_ID
, ACT.SELECTION_SEGMENT_ID
, ACT.DOCUMENT_ID
, ACT.document_received_date
, ACT.CALL_RECORD_ID
, ACT.EVENT_ID
, ACT.ACTIVITY_ID
FROM --EMRS_F_ENROLL_ACTIVITY_SV ACT
(
SELECT
CASE WHEN SELT.SELECTION_STATUS_CODE IN 'acceptedByState' then coalesCe(SELT.ACCEPTED_DATE,SELT.STATUS_DATE)
     WHEN SELT.SELECTION_STATUS_CODE IN ('denied','invalid') THEN COALESCE(SELT.DENIED_DATE, SELT.STATUS_DATE)
     ELSE SELT.RECORD_DATE
     END RECORD_DATE
, LAST_DAY(CASE WHEN SELT.SELECTION_STATUS_CODE IN 'acceptedByState' then coalesCe(SELT.ACCEPTED_DATE,SELT.STATUS_DATE)
     WHEN SELT.SELECTION_STATUS_CODE IN ('denied','invalid') THEN COALESCE(SELT.DENIED_DATE, SELT.STATUS_DATE)
     ELSE SELT.RECORD_DATE
     END) RECORD_MONTH
, NULL RECORD_NAME
,SELT.PROGRAM_CODE
,selt.PLAN_TYPE
,case when SELT.TRANSACTION_TYPE_CD = 'NewEnrollment' then 'ENROLLMENT'
      WHEN SELT.TRANSACTION_TYPE_CD = 'Transfer' THEN 'TRANSFER'
      WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then 'TRANSFER'
      WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' then 'DISENROLLMENT'
      ELSE NULL END ACTIVITY_TYPE
, CASE WHEN DSNT.DISENROLL_TYPE_CD = 'WITHCAUSE' THEN 'DISENROLLMENT_WITHCAUSE'
       WHEN DSNT.DISENROLL_TYPE_CD = 'WITHOUTCAUSE' THEN 'DISENROLLMENT_WITHOUTCAUSE'
       ELSE NULL END SUB_ACTIVITY_TYPE
, CASE WHEN SELT.SELECTION_STATUS_CODE IN 'acceptedByState' then 'APPROVED'
     WHEN SELT.SELECTION_STATUS_CODE IN ('denied','invalid') THEN 'DENIED'
     WHEN SELT.SELECTION_STATUS_CODE IN ('readyToUpload','uploadedToState','pendToRecycle') then 'INPROCESS'
     ELSE SELT.SELECTION_STATUS_CODE
     END ACTIVITY_STATUS
, SELT.SELECTION_SOURCE_CD SELECTION_SOURCE_CODE
, case when SELT.TRANSACTION_TYPE_CD = 'NewEnrollment' then SELT.PLAN_ID
      WHEN SELT.TRANSACTION_TYPE_CD = 'Transfer' THEN SELT.PLAN_ID
      WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then PLNT.PLAN_ID
      ELSE 601 END  CURRENT_PLAN_ID
, case WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then SELT.PLAN_ID
       when SELT.TRANSACTION_TYPE_CD = 'Disenrollment' then SELT.PLAN_ID
      WHEN SELT.TRANSACTION_TYPE_CD = 'Transfer' THEN SELT.PRIOR_PLAN_ID
      ELSE NULL END PRIOR_PLAN_ID
,DSNR.REASON_CD
,DSNT.DISENROLL_TYPE_CD
, CASE WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then SELT.COUNTY_CODE
       WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' then NVL(SELT.PRIOR_COUNTY_CD, SELT.COUNTY_CODE)
       ELSE SELT.COUNTY_CODE
       END COUNTY_CODE
, CASE WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then SELT.CSDA_CODE
       WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' then NVL(SELT.PRIOR_CSDA_CODE, SELT.CSDA_CODE)
       ELSE SELT.CSDA_CODE
       END CSDA_CODE
,SELT.MANAGED_CARE_STATUS
, CASE WHEN SELT.TRANSACTION_TYPE_CD = 'NewEnrollment' then 1 ELSE 0 END NEW_ENROLL_IND
, CASE WHEN SELT.TRANSACTION_TYPE_CD = 'Transfer' or (SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1')) THEN 1 ELSE 0 END TRANSFER_IND
, CASE WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE not in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') THEN 1 ELSE 0 END DISENROLL_IND
, DSNR.PHP_INITIATED PHP_DISENROLL_IND
, CASE WHEN SELT.TRANSACTION_TYPE_CD in ('NewEnrollment', 'Transfer') and NVL(SELT.PROVIDER_ID, SELT.PROVIDER_ID_EXT) IS NOT NULL THEN 'Y' ELSE 'N' END PCP_SELECTED_IND
, CASE WHEN PLN.plan_code = 'FFS' THEN 'Y'
       ELSE 'N' END PLAN_FFS_IND
, CASE WHEN PLNT.plan_code = 'FFS' THEN 'Y' ELSE 'N' END TO_PLAN_FFS_IND
, DSNR.urgent URGENT_IND
, case WHEN DSNT.DISENROLL_TYPE_CD = 'WITHOUTCAUSE' and  SELT.SELECTION_SOURCE_CD = 'C' and SELT.SELECTION_STATUS_CODE in 'acceptedByState' and SELT.DOCUMENT_ID is not null and SELT.MODIFIED_NAME = '-415' then SELT.RECORD_DATE - SELT.document_received_date 
       WHEN DSNT.DISENROLL_TYPE_CD = 'WITHOUTCAUSE' and  SELT.SELECTION_SOURCE_CD = 'C' and SELT.SELECTION_STATUS_CODE in 'acceptedByState' and SELT.DOCUMENT_ID is not null then SELT.ACCEPTED_DATE - SELT.document_received_date 
         else 0 end ACTIVITY_PROCESSING_CAL_DAYS_CNT
, case WHEN DSNT.DISENROLL_TYPE_CD = 'WITHOUTCAUSE' and  SELT.SELECTION_SOURCE_CD = 'C' and SELT.SELECTION_STATUS_CODE in 'acceptedByState' and SELT.DOCUMENT_ID is not null then 1 else 0 end ACTIVITY_IND
, SELT.SELECTION_TRANSACTION_ID
, SELT.SELECTION_SEGMENT_ID
, SELT.DOCUMENT_ID
, SELT.document_received_date
, SELT.CALL_RECORD_ID
, SELT.EVENT_ID
, NVL(TO_NUMBER(
  LPAD(TO_CHAR(NVL(SELECTION_TRANSACTION_ID,0)),10,'0')
  ||LPAD(TO_CHAR(NVL(EVENT_ID,0)),10,'0')
  ||LPAD(TO_CHAR(NVL(CALL_RECORD_ID,0)),10,'0')
  ||LPAD(TO_CHAR(NVL(DOCUMENT_ID,0)),10,'0')
  ||LPAD(TO_CHAR(NVL(SELECTION_SEGMENT_ID,0)),10,'0')
  ),-1) ACTIVITY_ID
FROM MAXDAT_SUPPORT.EMRS_D_SELECTION_TRANS_SV SELT
LEFT JOIN MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV DSNR ON DSNR.reason_cd = SELT.CHANGE_REASON_CODE
left join MAXDAT_SUPPORT.Emrs_d_Disenroll_Type_Sv dsnt on dsnt.DISENROLL_TYPE_CD = dsnr.DISENROLL_TYPE_CD
left join maxdat_support.emrs_d_plan_sv pln on pln.plan_id = (case WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then selt.plan_id else selt.prior_plan_id end)
left join maxdat_support.emrs_d_plan_sv plnt on plnt.plan_id = (case WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then 601 else selt.plan_id end)
where 1=1
and SELT.SELECTION_STATUS_CODE IN ('readyToUpload','uploadedToState','pendToRecycle','acceptedByState','denied','invalid')
--and selt.selection_transaction_id = 16422793
) ACT
UNION ALL
---ZERO COUNT SQL BELOW
SELECT --/*+ PARALLEL(10) */
to_date('2019/1/1','yyyy/mm/dd') RECORD_DATE
, LAST_DAY(to_date('2019/1/1','yyyy/mm/dd')) RECORD_MONTH
, NULL RECORD_NAME
,program_code
,PLAN_TYPE
,ACTIVITY_TYPE
, SUB_ACTIVITY_TYPE
,ACTIVITY_STATUS
,SELECTION_SOURCE_CODE
,CURRENT_PLAN_ID
,PRIOR_PLAN_ID
,REASON_CD
,DISENROLL_TYPE_CD
,COUNTY_CODE
,CSDA_CODE
,MANAGED_CARE_STATUS
,NEW_ENROLL_CNT
,TRANSFER_CNT
,DISENROLL_CNT
,PHP_DISENROLL_IND
,PCP_SELECTED_IND
,PLAN_FFS_IND
,TO_PLAN_FFS_IND
,URGENT_IND
,0 ACTIVITY_IND
,0 APPROVED_URGENT_TRANSFER_CNT
,0 APPROVED_NONURGENT_TRANSFER_CNT
,0 APPROVED_URGENT_DISENROLL_CNT
,0 APPROVED_NONURGENT_DISENROLL_CNT
,0 DENIED_URGENT_TRANSFER_CNT
,0 DENIED_NONURGENT_TRANSFER_CNT
,0 DENIED_URGENT_DISENROLL_CNT
,0 DENIED_NONURGENT_DISENROLL_CNT
,0 INPROCESS_URGENT_TRANSFER_CNT
,0 INPROCESS_NONURGENT_TRANSFER_CNT
,0 INPROCESS_URGENT_DISENROLL_CNT
,0 INPROCESS_NONURGENT_DISENROLL_CNT
,0 ACTIVITY_PROCESSING_CAL_DAYS_CNT
,0 SELECTION_TRANSACTION_ID
,0 SELECTION_SEGMENT_ID
,0 DOCUMENT_ID
, null document_received_date
,0 CALL_RECORD_ID
,0 EVENT_ID
,0 ACTIVITY_ID
FROM EMRS_F_ENROLL_ACTIVITY_STUB_MV;
--JOIN  D_DATES d on 1=1
--AND D.D_DATE >= GREATEST(TO_DATE('4/1/2019','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
--AND D.D_DATE <= TRUNC(add_months(SYSDATE,6));

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_CNT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_CNT_SV TO MAXDAT_REPORTS;  

DROP VIEW F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV;
CREATE OR REPLACE VIEW F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV
AS
SELECT /*+ parallel(10) */ dd.d_date mailed_date
      ,lr.letter_type_code
      ,lr.letter_type
      ,COALESCE(lr.county,'Undefined') county
      ,COALESCE(lr.region,'Undefined') region     
      ,SUM(CASE WHEN is_digital_ind = 0 AND mailed_date IS NOT NULL THEN 1 ELSE 0 END) mailed_letter_count
      ,SUM(CASE WHEN is_digital_ind = 1 AND mailed_date IS NOT NULL THEN 1 ELSE 0 END) digital_letter_count
      ,SUM(CASE WHEN mailed_date IS NOT NULL THEN 1 ELSE 0 END) letter_count
      ,SUM(CASE WHEN error_type = 'NCOA' AND reject_date IS NOT NULL THEN 1 ELSE 0 END) ncoa_error_letter_count
      ,SUM(CASE WHEN error_type = 'INTERNAL' AND reject_date IS NOT NULL THEN 1 ELSE 0 END) internal_error_letter_count      
      ,COALESCE(language_code,'EN') language_code
      ,COALESCE(language_description,'English') language_description
      ,lr.plan_type_indicator
FROM d_dates dd 
  JOIN (SELECT /*+ parallel(10) */ * 
            FROM(SELECT lr.lmreq_id,lr.lmdef_id, rs.enroll_county , TRUNC(lr.mailed_date) mailed_date,is_digital_ind
                      , row_number() over(partition by lr.lmreq_id order by rs.addr_id) rown
                      ,TRUNC(reject_date) reject_date
                      ,lr.reject_reason_cd
                      ,lr.language_cd language_code
                      ,el.report_label language_description
                      ,CASE WHEN lr.reject_reason_cd IN('1001','1002','1003','1100','1101','3111','3112','3113','3211','3215','3216','3311','3313','3411','3419','3422') THEN 'NCOA' 
                            WHEN lr.reject_reason_cd IS NULL THEN NULL
                         ELSE 'INTERNAL' END error_type
                      ,ld.name letter_type_code
                      ,ld.description letter_type
                      ,rs.county
                      ,rs.region
                      ,CASE WHEN (ld.name LIKE 'TP%' OR ld.name LIKE 'IATP%' OR ld.name LIKE 'OTTP%') THEN 'TP' ELSE 'SP' END plan_type_indicator
                 FROM eb.letter_request lr                
                    --JOIN eb.letter_request_link ll ON lr.lmreq_id = ll.lmreq_id                    
                    JOIN eb.cases cs ON lr.case_id = cs.case_id                  
                    JOIN eb.letter_definition ld ON lr.lmdef_id = ld.lmdef_id
                    LEFT JOIN eb.enum_language el ON lr.language_cd = el.value                    
                    LEFT JOIN (SELECT rs.addr_id, rs.addr_case_id,rs.addr_end_date,rs.addr_begin_date,COALESCE(ec.value,'UD') enroll_county, ec.report_label county,ed.report_label region
                              FROM eb.address rs 
                                 LEFT JOIN eb.enum_county ec ON rs.addr_ctlk_id = ec.value
                                 LEFT JOIN eb.enum_district ed ON ec.attrib_district_cd = ed.value
                               WHERE rs.addr_type_cd = 'RS' ) rs 
                       ON lr.case_id = rs.addr_case_id
                       AND lr.create_ts BETWEEN rs.addr_begin_date AND COALESCE(rs.addr_end_date,TO_DATE('12/31/2099','mm/dd/yyyy'))      
                    LEFT JOIN (SELECT *
                               FROM(SELECT h.create_ts reject_date
                                     ,lmreq_id                                     
                                     ,status_cd
                                     ,row_number() over(partition by h.lmreq_id order by h.create_ts desc) hrn
                                    FROM letter_req_status_history h
                                    WHERE status_cd = 'REJ')
                                WHERE hrn = 1 ) lh ON lr.lmreq_id = lh.lmreq_id    
                 WHERE (lr.mailed_date IS NOT NULL OR (lh.reject_date IS NOT NULL AND lr.reject_reason_cd IS NOT NULL))                                        
                 )
            WHERE rown = 1) lr  ON COALESCE(lr.mailed_date,lr.reject_date) = dd.d_date 
WHERE dd.d_date >=  GREATEST(TO_DATE('06/28/2019','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))
AND dd.d_date <= TRUNC(sysdate)
GROUP BY dd.d_date
        ,lr.letter_type_code
        ,lr.letter_type
        ,COALESCE(lr.county,'Undefined')
        ,COALESCE(lr.region,'Undefined')
        ,COALESCE(language_code,'EN')
        ,COALESCE(language_description,'English') 
        ,lr.plan_type_indicator;

GRANT SELECT ON MAXDAT_SUPPORT.F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV TO MAXDAT_REPORTS ;
GRANT SELECT ON MAXDAT_SUPPORT.F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV TO MAXDATSUPPORT_READ_ONLY ;
 
DROP VIEW MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_SURVEY_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_TAILORED_PLAN_SURVEY_SV" ("SURVEY_ID", "SURVEY_TEMPLATE_ID", "TITLE", "SURVEY_DATE", "SURVEY_TIME", "STATUS_CD2", "STAFF_ID", "CREATED_BY", "CLIENT_ID", "CLIENT_CIN", "CASE_ID", "CASE_CIN", "STATUS_DATE", "MVX", "MCS", "SUBPROGRAM_TYPE", "ANSWER_1", "ANSWER_2", "ANSWER_3", "ANSWER_4", "ANSWER_5", "TRANSACTION_TYPE_CD", "STATUS_CD", "PLAN_ID_EXT", "START_DATE", "SELECTION_TXN_ID", "Survey Completed Before Enrollment") AS 
  select x."SURVEY_ID",x."SURVEY_TEMPLATE_ID",x."TITLE",x."SURVEY_DATE",x."SURVEY_TIME",x."STATUS_CD2",x."STAFF_ID",x."CREATED_BY",x."CLIENT_ID",x."CLIENT_CIN",x."CASE_ID",x."CASE_CIN",x."STATUS_DATE",x."MVX",x."MCS",x."SUBPROGRAM_TYPE",x."ANSWER_1",x."ANSWER_2",x."ANSWER_3",x."ANSWER_4",x."ANSWER_5"
, t.transaction_type_cd , t.status_cd , t.plan_id_ext , t.start_date , t.selection_txn_id 
, case when t.selection_txn_id is null then null
       when x.status_date < t.create_ts then 'Yes' else 'No' end "Survey Completed Before Enrollment"
from (
select s.survey_id, st.survey_template_id, st.title, trunc(s.status_date) survey_date , to_char(s.status_date,'HH:MM AM') survey_time , s.status_cd status_cd2, st.staff_id , st.last_name||', '||st.first_name created_by
, sc1.ref_value client_id , i.client_cin , sc2.ref_value case_id , i.case_cin , s.status_date
, es.elig_status_cd mvx , es.reasons mcs , es.subprogram_type
, sq1.answer_text answer_1 , sq2.answer_text answer_2 , sq3.answer_text answer_3 , sq4.answer_text answer_4 , sq5.answer_text answer_5
from survey s
join survey_template st on st.survey_template_id = s.survey_template_id
and st.title = 'Tailored Plan Acknowledgement'
join survey_context sc1 on sc1.survey_id = s.survey_id
join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
and stc1.ref_type = 'CLIENT' 
join client_supplementary_info i on i.client_id = sc1.ref_value
join client_elig_status es on es.client_id = i.client_id
and es.end_date is null
join survey_context sc2 on sc2.survey_id = s.survey_id
join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
and stc2.ref_type = 'CASE' 
join staff st on st.staff_id = s.created_by
-- question #1
left outer join ( select sr1.survey_id , at1.*
      from survey_response sr1 
      join survey_template_question q1 on q1.survey_template_question_id = sr1.template_question_id
       and q1.question_number = '1'
      join svey_tmpl_answer_text at1 on at1.survey_template_answer_id = sr1.survey_template_answer_id ) sq1 on sq1.survey_id = s.survey_id
-- question #2
left outer join ( select sr2.survey_id , at2.*
      from survey_response sr2 
      join survey_template_question q2 on q2.survey_template_question_id = sr2.template_question_id
       and q2.question_number = '2'
      join svey_tmpl_answer_text at2 on at2.survey_template_answer_id = sr2.survey_template_answer_id ) sq2 on sq2.survey_id = s.survey_id
-- question #3
left outer join ( select sr3.survey_id , at3.*
      from survey_response sr3 
      join survey_template_question q3 on q3.survey_template_question_id = sr3.template_question_id
       and q3.question_number = '3'
      join svey_tmpl_answer_text at3 on at3.survey_template_answer_id = sr3.survey_template_answer_id ) sq3 on sq3.survey_id = s.survey_id
-- question #4
left outer join ( select sr4.survey_id , at4.*
      from survey_response sr4 
      join survey_template_question q4 on q4.survey_template_question_id = sr4.template_question_id
       and q4.question_number = '4'
      join svey_tmpl_answer_text at4 on at4.survey_template_answer_id = sr4.survey_template_answer_id ) sq4 on sq4.survey_id = s.survey_id
-- question #5
left outer join ( select sr5.survey_id , at5.*
      from survey_response sr5 
      join survey_template_question q5 on q5.survey_template_question_id = sr5.template_question_id
       and q5.question_number = '5'
      join svey_tmpl_answer_text at5 on at5.survey_template_answer_id = sr5.survey_template_answer_id ) sq5 on sq5.survey_id = s.survey_id ) x
left outer join ( select tx.* , rank() over ( partition by tx.client_id order by tx.selection_txn_id desc ) ranking 
                   from selection_txn tx
                  where tx.status_cd <> 'invalid' ) t on t.client_id = x.client_id
and t.ranking = 1
--where x.status_date like sysdate - 1
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY')
UNION all
select x."SURVEY_ID",x."SURVEY_TEMPLATE_ID",x."TITLE",x."SURVEY_DATE",x."SURVEY_TIME",x."STATUS_CD2",x."STAFF_ID",x."CREATED_BY",x."CLIENT_ID",x."CLIENT_CIN",x."CASE_ID",x."CASE_CIN",x."STATUS_DATE",x."MVX",x."MCS",x."SUBPROGRAM_TYPE",x."ANSWER_1",x."ANSWER_2",x."ANSWER_3",x."ANSWER_4",x."ANSWER_5"
, t.transaction_type_cd , t.status_cd , t.plan_id_ext , t.start_date , t.selection_txn_id 
, case when t.selection_txn_id is null then null
       when x.status_date < t.create_ts then 'No' else 'Yes' end "Survey Completed After Enrollment"
from (
select s.survey_id , st.survey_template_id, st.title, trunc(s.status_date) survey_date , to_char(s.status_date,'HH:MM AM') survey_time , s.status_cd status_cd2, st.staff_id , st.last_name||', '||st.first_name created_by
, sc1.ref_value client_id , i.client_cin , sc2.ref_value case_id , i.case_cin , s.status_date
, es.elig_status_cd mvx , es.reasons mcs , es.subprogram_type
, sq1.answer_text answer_1 , sq2.answer_text answer_2 , sq3.answer_text answer_3 , sq4.answer_text answer_4 , sq5.answer_text answer_5
from survey s
join survey_template st on st.survey_template_id = s.survey_template_id
and st.title like 'Enrollment Confirmation%'
join survey_context sc1 on sc1.survey_id = s.survey_id
join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
and stc1.ref_type = 'CLIENT' 
join client_supplementary_info i on i.client_id = sc1.ref_value
join client_elig_status es on es.client_id = i.client_id
and es.end_date is null
join survey_context sc2 on sc2.survey_id = s.survey_id
join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
and stc2.ref_type = 'CASE' 
join staff st on st.staff_id = s.created_by
-- question #1
left outer join ( select sr1.survey_id , at1.*
      from survey_response sr1 
      join survey_template_question q1 on q1.survey_template_question_id = sr1.template_question_id
       and q1.question_number = '1'
      join svey_tmpl_answer_text at1 on at1.survey_template_answer_id = sr1.survey_template_answer_id ) sq1 on sq1.survey_id = s.survey_id
-- question #2
left outer join ( select sr2.survey_id , at2.*
      from survey_response sr2 
      join survey_template_question q2 on q2.survey_template_question_id = sr2.template_question_id
       and q2.question_number = '2'
      join svey_tmpl_answer_text at2 on at2.survey_template_answer_id = sr2.survey_template_answer_id ) sq2 on sq2.survey_id = s.survey_id
-- question #3
left outer join ( select sr3.survey_id , at3.*
      from survey_response sr3 
      join survey_template_question q3 on q3.survey_template_question_id = sr3.template_question_id
       and q3.question_number = '3'
      join svey_tmpl_answer_text at3 on at3.survey_template_answer_id = sr3.survey_template_answer_id ) sq3 on sq3.survey_id = s.survey_id
-- question #4
left outer join ( select sr4.survey_id , at4.*
      from survey_response sr4 
      join survey_template_question q4 on q4.survey_template_question_id = sr4.template_question_id
       and q4.question_number = '4'
      join svey_tmpl_answer_text at4 on at4.survey_template_answer_id = sr4.survey_template_answer_id ) sq4 on sq4.survey_id = s.survey_id
-- question #5
left outer join ( select sr5.survey_id , at5.*
      from survey_response sr5 
      join survey_template_question q5 on q5.survey_template_question_id = sr5.template_question_id
       and q5.question_number = '5'
      join svey_tmpl_answer_text at5 on at5.survey_template_answer_id = sr5.survey_template_answer_id ) sq5 on sq5.survey_id = s.survey_id ) x
left outer join ( select tx.* , rank() over ( partition by tx.client_id order by tx.selection_txn_id desc ) ranking 
                   from selection_txn tx
                  where tx.status_cd <> 'invalid' ) t on t.client_id = x.client_id
and t.ranking = 1
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY');

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_SURVEY_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_SURVEY_SV TO MAXDAT_REPORTS;

DROP VIEW MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_TAILORED_PLAN_TRANS_SV"  AS 
  select x.CLIENT_ID, x.client_cin, x.CASE_ID, x.case_cin, x.STAFF_ID, x.trans_date, x.trans_time, x.selection_source_cd, x.transaction_type_cd 
, x.mvx, x.mcs, x.plan_id_ext, x.start_date, x.status_cd
, case when x.ack_ct = 0 then 'No' else 'Yes' end "Acknowledgment Exists"
, case when x.conf_ct = 0 then 'No' else 'Yes' end "Confirmation Exists"
, x.created_by
from (
select i.CLIENT_ID, I.CASE_ID, i.case_cin , i.client_cin , st.STAFF_ID, trunc(t.create_ts) trans_date , to_char(t.create_ts,'MI:HH AM') trans_time
, st.last_name||', '||st.first_name created_by , t.transaction_type_cd , es.elig_status_cd mvx, es.reasons mcs, t.selection_source_cd , t.plan_id_ext , t.start_date
, t.status_cd  
, ( select count(1) from survey s1
      join survey_template st1 on st1.survey_template_id = s1.survey_template_id
       and st1.title = 'Tailored Plan Acknowledgement'
      join survey_context sc1 on sc1.survey_id = s1.survey_id
      join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
       and stc1.ref_type = 'CLIENT' 
     where sc1.ref_value = t.client_id
       AND s1.CASE_ID = i.case_id ) ack_ct
, ( select count(1) from survey s2
      join survey_template st2 on st2.survey_template_id = s2.survey_template_id
       and st2.title like 'Enrollment Confirmation%'
      join survey_context sc2 on sc2.survey_id = s2.survey_id
      join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
       and stc2.ref_type = 'CLIENT' 
     where sc2.ref_value = t.client_id
       AND s2.CASE_ID = i.case_id 
 ) conf_ct
from (SELECT * FROM selection_txn WHERE LENGTH(TRIM(TRANSLATE(created_by, ' +-.0123456789',' '))) IS NULL) t -- verify created_by contains only numeric data
join client_supplementary_info i on i.client_id = t.client_id
join client_elig_status es on es.client_id = t.client_id
and es.end_date is null
and es.elig_status_cd = 'V'
and es.reasons in ('MCS005','MCS027','MCS035')
join staff st on st.staff_id = t.created_by
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY') 
and t.status_cd <> 'invalid' ) x
order by x.case_cin , x.client_cin;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV TO MAXDAT_REPORTS;


