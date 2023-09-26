DROP VIEW MAXDAT_LAEB.EMRS_F_ENROLLMENT_SV;

CREATE OR REPLACE VIEW MAXDAT_LAEB.EMRS_F_ENROLLMENT_SV
AS
SELECT 
    st.selection_txn_id AS SELECTION_TRANSACTION_ID,
    st.selection_segment_id AS SELECTION_SEGMENT_ID,
    st.ENROLLMENT_ID AS ENROLLMENT_ID,   
    cs.case_id AS CASE_ID,
    st.disenroll_reason_cd_1 AS CHANGE_REASON_CODE,
    st.client_id AS CLIENT_ID,
    st.county AS COUNTY_CODE,
    '0' AS CSDA_CODE, 
    COALESCE(CASE WHEN st.SELECTION_SOURCE_CD = 'AT' AND st.TRANSACTION_TYPE_CD = 'Transfer' THEN 'AutoTransfer' ELSE st.TRANSACTION_TYPE_CD END, 'NotDefined') AS TRANSACTION_TYPE_CD,
    st.plan_id AS PLAN_ID, --get the plan info by joining to emrs_d_plan_sv.plan_id
    st.program_type_cd AS PROGRAM_CODE,
    st.network_id AS PROVIDER_NUMBER, --get provider info by joining to emrs_d_provider_sv.network_id
    CASE WHEN TRUNC(st.status_date) >= TO_DATE('11/01/2022','mm/dd/yyyy') AND TRUNC(cs.dob) > TRUNC(st.CREATE_TS) - 365 THEN 'NE' ELSE COALESCE(st.SELECTION_SOURCE_CD, 'A') END AS SELECTION_SOURCE_CODE,
    CASE WHEN st.selection_source_cd IN ('P','C','W')
         THEN 'Y'
         ELSE 'N'
    END AS IS_CHOICE_IND,
    CASE
      WHEN TRUNC(st.status_date) >= TO_DATE('11/01/2022','mm/dd/yyyy') AND TRUNC(cs.dob) > TRUNC(st.CREATE_TS) - 365 THEN 'Newborn'
      WHEN st.SELECTION_SOURCE_CD in('P','GS','G','OP','OL') THEN 'Phone' 
      WHEN st.SELECTION_SOURCE_CD = 'A' AND st.OVERRIDE_REASON_CD IS NULL AND st.TRANSACTION_TYPE_CD IN ('NewEnrollment','Disenrollment','Transfer') THEN 'Phone'  
      WHEN st.SELECTION_SOURCE_CD = 'A' AND st.OVERRIDE_REASON_CD = '20' AND st.TRANSACTION_TYPE_CD IN ('NewEnrollment','Disenrollment','Transfer') THEN 'Phone'  
      WHEN st.SELECTION_SOURCE_CD = 'A' AND st.OVERRIDE_REASON_CD = 'M005' AND st.TRANSACTION_TYPE_CD = 'Disenrollment' THEN 'Phone' 
      WHEN st.SELECTION_SOURCE_CD = 'IV' THEN 'IVR' 
      WHEN st.SELECTION_SOURCE_CD = 'W' THEN  'Web' 
      WHEN st.SELECTION_SOURCE_CD = 'M' THEN  'Mobile' 
      WHEN st.SELECTION_SOURCE_CD = 'C' THEN 'MailFax' 
      WHEN st.SELECTION_SOURCE_CD = 'RE' THEN 'Reinstatement'  
      WHEN st.SELECTION_SOURCE_CD = 'D' AND st.OVERRIDE_REASON_CD IS NULL AND st.TRANSACTION_TYPE_CD = 'NewEnrollment' THEN 'Reinstatement'  
      WHEN st.SELECTION_SOURCE_CD = 'NE' THEN 'Newborn'  
      WHEN st.SELECTION_SOURCE_CD IN ('A','NE') AND st.OVERRIDE_REASON_CD = 'M070' THEN 'Newborn' 
      WHEN st.SELECTION_SOURCE_CD = 'SA' AND st.TRANSACTION_TYPE_CD = 'NewEnrollment' THEN 'DEFile' 
      WHEN st.SELECTION_SOURCE_CD IN ('CA','PC','PP','JC','EX','DCFS') THEN 'AutoEnrollments' 
      WHEN st.SELECTION_SOURCE_CD ='A' AND st.TRANSACTION_TYPE_CD = 'DefaultEnroll' THEN 'AutoEnrollments' 
      WHEN st.TRANSACTION_TYPE_CD IS NULL THEN 'AutoEnrollments'
      WHEN st.SELECTION_SOURCE_CD = 'AT' THEN 'AutoEnrollments'
      ELSE 'AutoEnrollments'
    END AS CHANNEL_CODE,
    st.choice_reason_cd AS SELECTION_REASON_CODE, 
    st.client_aid_category_cd AS AID_CATEGORY_CODE,
    '0' AS REASON_CODE, --term reason code 
    st.status_date AS STATUS_DATE,
    st.start_date AS MANAGED_CARE_START_DATE,
    st.end_date AS MANAGED_CARE_END_DATE,
    st.plan_type_cd AS PLAN_TYPE,      
    -- sel_txn data that we will probably need for enrollment reports
    --start
    st.prior_selection_start_date AS PRIOR_SELECTION_START_DATE,
    st.prior_selection_end_date AS PRIOR_SELECTION_END_DATE,
    st.prior_provider_id AS PRIOR_PROVIDER_ID,
    st.prior_provider_id_ext AS PRIOR_PROVIDER_ID_EXT,
    st.prior_provider_first_name AS PRIOR_PROVIDER_FIRST_NAME,
    st.prior_provider_middle_name AS PRIOR_PROVIDER_MIDDLE_NAME,
    st.prior_provider_last_name AS PRIOR_PROVIDER_LAST_NAME,  
    st.prior_contract_id AS PRIOR_CONTRACT_ID,
    st.prior_network_id AS PRIOR_NETWORK_ID,
    st.prior_choice_reason_cd AS PRIOR_CHOICE_REASON_CD,
    st.prior_disenroll_reason_cd_1 AS PRIOR_DISENROLL_REASON_CD_1,
    st.prior_disenroll_reason_cd_2 AS PRIOR_DISENROLL_REASON_CD_2,
    st.prior_client_aid_category_cd AS PRIOR_CLIENT_AID_CATEGORY_CD,
    st.prior_county_cd AS PRIOR_COUNTY_CD,
    st.prior_zipcode AS PRIOR_ZIPCODE,
    st.original_start_date AS ORIGINAL_START_DATE,
    st.original_end_date AS ORIGINAL_END_DATE,
    st.create_ts AS RECORD_DATE,
    TO_CHAR(st.create_ts, 'hh24mi') AS RECORD_TIME,
    st.created_by AS RECORD_NAME,
    st.update_ts AS MODIFIED_DATE,
    st.updated_by AS MODIFIED_NAME,
    TO_CHAR(st.update_ts, 'hh24mi') AS MODIFIED_TIME,    
    st.start_nd AS START_ND,
    st.end_nd AS END_ND,
    st.plan_id_ext AS PLAN_ID_EXT,
    st.contract_id AS CONTRACT_ID, --why isn't this in the list, we have prior_contract_id
    st.network_id AS NETWORK_ID,
    st.provider_id AS PROVIDER_ID,
    st.provider_id_ext AS PROVIDER_ID_EXT,
    CASE WHEN st.PROVIDER_ID_EXT IS NULL THEN 'N'
          ELSE 'Y'
    END AS PCP_SELECTED,
    st.provider_first_name AS PROVIDER_FIRST_NAME,
    st.provider_middle_name AS PROVIDER_MIDDLE_NAME,
    st.provider_last_name AS PROVIDER_LAST_NAME,
    st.disenroll_reason_cd_2 AS DISENROLL_REASON_CD_2, 
    st.zipcode AS zip_code,    
    st.prior_selection_segment_id AS PRIOR_SELECTION_SEGMENT_ID,
    st.status_cd AS STATUS_CD,
    -- end sel txn data
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM MAXDAT_LAEB.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(st.create_ts) AND TRUNC(st.status_date)
    ) AS AGE_IN_BUSINESS_DAYS,  
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM MAXDAT_LAEB.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(st.create_ts) AND COALESCE(
      (SELECT MIN(TRUNC(sh.create_ts))
      FROM EMRS_D_selectn_txn_stat_hist sh
      WHERE sh.selection_txn_id = st.selection_txn_id AND sh.status_cd = 'readyToUpload'
      ),TRUNC(st.status_date))
    ) AS HISTORY_AGE_IN_BUSINESS_DAYS,
    CASE
       WHEN FLOOR(months_between(TRUNC(st.create_ts),cs.dob)/12) < 1 
      THEN 'Y'
      ELSE 'N'
    END AS NEWBORN_FLAG , 
    FLOOR(months_between(TRUNC(st.create_ts),cs.dob)/12) AS CLIENT_AGE,
    NULL AS ENROLLMENT_FEE_ASSESSED,
    NULL AS ENROLLMENT_FEE_ASSESSED_DATE,
    NULL AS ENROLLMENT_FEE_PAID,
    NULL AS ENROLLMENT_FEE_PAID_DATE,
    NULL AS CO_PAY_AMOUNT,
    NULL AS MET_COST_SHARE_CAP_DATE,
    NULL AS COST_SHARE_START_DATE,
    NULL AS COST_SHARE_END_DATE,
    NULL AS ENROLLMENT_FEE_FREQUENCY,
    NULL AS CHIP_ANNUAL_ENROLL_DATE, 
    NULL AS JYEAR_OF_LAST_ENROLLMENT_FORM,
    NULL AS MEDICAID_BUY_IN_FEE,
    NULL AS MEDICAID_BUY_IN_FEE_DATE,
    NULL AS MEDICAID_RECERTIFICATION_DATE,
    NULL AS FPL_PERCENTAGE,
    NULL AS ELIGIBILITY_RECEIPT_DATE ,
    1    AS NUMBER_COUNT
  FROM 
  (SELECT 
    COALESCE(txn.selection_txn_id, seg.SELECTION_SEGMENT_ID*-1) AS SELECTION_TXN_ID,
    COALESCE(seg.SELECTION_SEGMENT_ID, txn.SELECTION_TXN_ID*-1) AS SELECTION_SEGMENT_ID,    
    COALESCE(seg.SELECTION_SEGMENT_ID, txn.SELECTION_TXN_ID*-1) AS ENROLLMENT_ID,
    ROW_NUMBER() OVER(PARTITION BY COALESCE(txn.client_id, seg.client_id), COALESCE(seg.start_nd, txn.start_nd),  COALESCE(txn.plan_type_cd,seg.plan_type_cd), CASE WHEN txn.TRANSACTION_TYPE_CD = 'Disenrollment' THEN 1 ELSE 0 END ORDER BY txn.selection_txn_id, seg.SELECTION_SEGMENT_ID DESC) as rn,
    COALESCE(txn.disenroll_reason_cd_1, seg.disenroll_reason_cd_1, '0') AS DISENROLL_REASON_CD_1,
    COALESCE(txn.client_id, seg.client_id) AS CLIENT_ID,
    COALESCE(txn.county, seg.county_cd,'0') AS COUNTY,
    txn.TRANSACTION_TYPE_CD AS TRANSACTION_TYPE_CD,
    COALESCE(txn.plan_id, seg.plan_id, 0) AS PLAN_ID, --get the plan info by joining to emrs_d_plan_sv.plan_id
    COALESCE(txn.program_type_cd, seg.program_type_cd, '0') AS PROGRAM_TYPE_CD,
    COALESCE(txn.network_id,seg.network_id, 0) AS NETWORK_ID, --get provider info by joining to emrs_d_provider_sv.network_id
    COALESCE(txn.selection_source_cd,'A') AS SELECTION_SOURCE_CD,
    COALESCE(txn.choice_reason_cd, seg.choice_reason_cd, '0') AS CHOICE_REASON_CD, 
    COALESCE(txn.OVERRIDE_REASON_CD, '0') AS OVERRIDE_REASON_CD,
    COALESCE(txn.client_aid_category_cd,seg.client_aid_category_cd, '0') AS CLIENT_AID_CATEGORY_CD,
    COALESCE(txn.status_date, seg.status_date) AS STATUS_DATE,
    COALESCE(seg.start_date, txn.start_date) AS START_DATE,
    COALESCE(seg.end_date, txn.end_date) AS END_DATE,
    COALESCE(txn.plan_type_cd, seg.plan_type_cd, '0') AS PLAN_TYPE_CD,      
    -- sel_txn data that we will probably need for enrollment reports
    --start
    txn.prior_selection_start_date AS PRIOR_SELECTION_START_DATE,
    txn.prior_selection_end_date AS PRIOR_SELECTION_END_DATE,
    txn.prior_provider_id AS PRIOR_PROVIDER_ID,
    txn.prior_provider_id_ext AS PRIOR_PROVIDER_ID_EXT,
    txn.prior_provider_first_name AS PRIOR_PROVIDER_FIRST_NAME,
    txn.prior_provider_middle_name AS PRIOR_PROVIDER_MIDDLE_NAME,
    txn.prior_provider_last_name AS PRIOR_PROVIDER_LAST_NAME,  
    txn.prior_contract_id AS PRIOR_CONTRACT_ID,
    txn.prior_network_id AS PRIOR_NETWORK_ID,
    txn.prior_choice_reason_cd AS PRIOR_CHOICE_REASON_CD,
    txn.prior_disenroll_reason_cd_1 AS PRIOR_DISENROLL_REASON_CD_1,
    txn.prior_disenroll_reason_cd_2 AS PRIOR_DISENROLL_REASON_CD_2,
    COALESCE(txn.prior_client_aid_category_cd, '0') AS PRIOR_CLIENT_AID_CATEGORY_CD,
    txn.prior_county_cd AS PRIOR_COUNTY_CD,
    txn.prior_zipcode AS PRIOR_ZIPCODE,
    txn.original_start_date AS ORIGINAL_START_DATE,
    txn.original_end_date AS ORIGINAL_END_DATE,
    COALESCE(txn.create_ts,seg.create_ts) AS CREATE_TS,
    COALESCE(txn.created_by,seg.created_by) AS CREATED_BY,
    COALESCE(txn.update_ts,seg.update_ts) AS UPDATE_TS,
    COALESCE(txn.updated_by,seg.updated_by) AS UPDATED_BY,   
    COALESCE(seg.start_nd, txn.start_nd) AS START_ND,
    COALESCE(seg.end_nd, txn.end_nd) AS END_ND,
    COALESCE(txn.plan_id_ext, seg.plan_id_ext) AS PLAN_ID_EXT,
    COALESCE(txn.contract_id, seg.contract_id) AS CONTRACT_ID, --why isn't this in the list, we have prior_contract_id
    txn.provider_id AS PROVIDER_ID,
    COALESCE(txn.provider_id_ext, seg.provider_id_ext) AS PROVIDER_ID_EXT,
    COALESCE(txn.provider_first_name, seg.provider_first_name) AS PROVIDER_FIRST_NAME,
    COALESCE(txn.provider_middle_name, seg.provider_middle_name) AS PROVIDER_MIDDLE_NAME,
    COALESCE(txn.provider_last_name, seg.provider_last_name) AS PROVIDER_LAST_NAME,
    COALESCE(txn.disenroll_reason_cd_2, seg.disenroll_reason_cd_2) AS DISENROLL_REASON_CD_2,   
    COALESCE(txn.zipcode, seg.zipcode, '0') AS zipcode,    
    txn.prior_selection_segment_id AS PRIOR_SELECTION_SEGMENT_ID,
    COALESCE(txn.status_cd, 'acceptedByState') AS STATUS_CD
    -- end sel txn data    
    FROM MAXDAT_LAEB.EMRS_D_selection_txn txn
    FULL OUTER JOIN MAXDAT_LAEB.EMRS_D_selection_segment seg on (txn.client_id = seg.client_id AND txn.plan_id = seg.plan_id AND txn.start_nd = seg.start_nd) 
   WHERE (txn.STATUS_CD = 'acceptedByState' OR (seg.SELECTION_SEGMENT_ID IS NOT NULL AND txn.SELECTION_TXN_ID IS NULL))
    AND (txn.TRANSACTION_TYPE_CD = 'Disenrollment' OR seg.SELECTION_SEGMENT_ID IS NOT NULL)
    AND ((COALESCE(txn.STATUS_DATE, seg.STATUS_DATE) >= (ADD_MONTHS(TRUNC(sysdate, 'mm'), -12)) and COALESCE(seg.end_nd, txn.end_nd) > COALESCE(seg.start_nd, txn.start_nd))
          OR (COALESCE(seg.end_nd, txn.end_nd) >= TO_NUMBER(TO_CHAR(LAST_DAY(TRUNC(SYSDATE, 'MM')-1), 'yyyymmdd'))))
    ) st  
  JOIN MAXDAT_LAEB.EMRS_D_client_supplementary_info cs ON (st.client_id = cs.client_id AND st.program_type_cd = cs.program_cd) 
  WHERE st.rn = 1
WITH READ ONLY;

GRANT SELECT ON MAXDAT_LAEB.EMRS_F_ENROLLMENT_SV TO MAXDAT_LAEB_READ_ONLY;