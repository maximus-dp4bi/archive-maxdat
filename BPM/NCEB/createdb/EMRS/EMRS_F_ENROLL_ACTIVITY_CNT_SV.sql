DROP VIEW MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_CNT_SV;


  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_F_ENROLL_ACTIVITY_CNT_SV" ("RECORD_DATE", "RECORD_MONTH", "RECORD_NAME", "PROGRAM_CODE", "PLAN_TYPE", "ACTIVITY_TYPE", "SUB_ACTIVITY_TYPE", "ACTIVITY_STATUS", "SELECTION_SOURCE_CODE", "CURRENT_PLAN_ID", "PRIOR_PLAN_ID", "REASON_CD", "DISENROLL_TYPE_CD", "COUNTY_CODE", "CSDA_CODE", "MANAGED_CARE_STATUS", "NEW_ENROLL_CNT", "TRANSFER_CNT", "DISENROLL_CNT", "PHP_DISENROLL_IND", "PCP_SELECTED_IND", "PLAN_FFS_IND", "TO_PLAN_FFS_IND", "URGENT_IND", "ACTIVITY_CNT", "APPROVED_URGENT_TRANSFER_CNT", "APPROVED_NONURGENT_TRANSFER_CNT", "APPROVED_URGENT_DISENROLL_CNT", "APPROVED_NONURGENT_DISENROLL_CNT", "DENIED_URGENT_TRANSFER_CNT", "DENIED_NONURGENT_TRANSFER_CNT", "DENIED_URGENT_DISENROLL_CNT", "DENIED_NONURGENT_DISENROLL_CNT", "INPROCESS_URGENT_TRANSFER_CNT", "INPROCESS_NONURGENT_TRANSFER_CNT", "INPROCESS_URGENT_DISENROLL_CNT", "INPROCESS_NONURGENT_DISENROLL_CNT", "ACTIVITY_PROCESSING_CAL_DAYS_CNT", "SELECTION_TRANSACTION_ID", "SELECTION_SEGMENT_ID", "DOCUMENT_ID", "DOCUMENT_RECEIVED_DATE", "CALL_RECORD_ID", "EVENT_ID", "ACTIVITY_ID","CURRENT_PLAN_SERVICE_TYPE_CD","PRIOR_PLAN_SERVICE_TYPE_CD") AS 
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
,CURRENT_PLAN_SERVICE_TYPE_CD
,PRIOR_PLAN_SERVICE_TYPE_CD
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
, case when SELT.TRANSACTION_TYPE_CD IN('NewEnrollment','Transfer') then SELT.PLAN_SERVICE_TYPE_CD      
      WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then PLNT.PLAN_SERVICE_TYPE_CD
      ELSE 'NCMD' END  CURRENT_PLAN_SERVICE_TYPE_CD
, case WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then SELT.PLAN_SERVICE_TYPE_CD
       when SELT.TRANSACTION_TYPE_CD = 'Disenrollment' then SELT.PLAN_SERVICE_TYPE_CD
      WHEN SELT.TRANSACTION_TYPE_CD = 'Transfer' THEN SELT.PRIOR_PLAN_SERVICE_TYPE_CD
      ELSE NULL END PRIOR_PLAN_SERVICE_TYPE_CD  
FROM MAXDAT_SUPPORT.EMRS_D_SELECTION_TRANS_SV SELT
LEFT JOIN MAXDAT_SUPPORT.EMRS_D_DISENROLL_REASON_SV DSNR ON DSNR.reason_cd = SELT.CHANGE_REASON_CODE
left join MAXDAT_SUPPORT.Emrs_d_Disenroll_Type_Sv dsnt on dsnt.DISENROLL_TYPE_CD = dsnr.DISENROLL_TYPE_CD
left join maxdat_support.emrs_d_plan_sv pln on pln.plan_id = (case WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then selt.plan_id else selt.prior_plan_id end)
left join maxdat_support.emrs_d_plan_sv plnt on plnt.plan_id = (case WHEN SELT.TRANSACTION_TYPE_CD = 'Disenrollment' and CHANGE_REASON_CODE in ('NFPHPCR13','NFPHPCR22','NFPHPCR22-1') then 601 else selt.plan_id end)
where 1=1
and SELT.SELECTION_STATUS_CODE IN ('readyToUpload','uploadedToState','pendToRecycle','acceptedByState','denied','invalid')
--and selt.selection_transaction_id = 16422793
) ACT
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_CNT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLL_ACTIVITY_CNT_SV TO MAXDAT_REPORTS;