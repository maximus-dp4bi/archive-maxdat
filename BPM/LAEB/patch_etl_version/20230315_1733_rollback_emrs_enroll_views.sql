CREATE OR REPLACE VIEW MAXDAT_LAEB.EMRS_D_SELECTION_TRANS_SV AS
SELECT
    st.SELECTION_TXN_ID AS SELECTION_TRANSACTION_ID,
    st.SELECTION_TXN_ID AS SOURCE_RECORD_ID,
    st.SELECTION_SEGMENT_ID AS SELECTION_SEGMENT_ID,
    st.CLIENT_ID AS CLIENT_ID,
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
      FROM MAXDAT_LAEB.d_dates d
      WHERE d.business_day_flag = 'Y' AND d.d_date BETWEEN TRUNC(st.create_ts) AND TRUNC(st.status_date)
    ) AS AGE_IN_BUSINESS_DAYS,
    st.CLIENT_AID_CATEGORY_CD AS AID_CATEGORY_CODE,
    COALESCE(st.BENEFITS_PACKAGE_CD, '0') AS BENEFITS_PACKAGE_CD,
    st.DISENROLL_REASON_CD_1 AS CHANGE_REASON_CODE,
    st.CHOICE_REASON_CD AS CHOICE_REASON_CD,
    COALESCE(st.CLIENT_RESIDENCE_ADDRESS_ID, 0) AS CLIENT_RESIDENCE_ADDRESS_ID,
    st.CONTRACT_ID AS CONTRACT_ID,
    st.COUNTY_CODE AS COUNTY_CODE,
    st.TRANSACTION_COUNTY_CD AS TRANSACTION_COUNTY_CODE,
    NULL AS CSDA_CODE,
    NULL AS CURRENT_SELECTION_STATUS_ID,
    NULL AS CUSTOM_FIELD1,
    NULL AS CUSTOM_FIELD2,
    NULL AS CUSTOM_FIELD3,
    NULL AS CUSTOM_FIELD4,
    NULL AS CUSTOM_FIELD5,
    st.DISENROLL_REASON_CD_2 AS DISENROLL_REASON_CD_2,
    st.FOLLOWUP_BY AS FOLLOWUP_BY,
    st.FOLLOWUP_CALL_DATE AS FOLLOWUP_CALL_DATE,
    st.FOLLOWUP_FORM_RCV_DATE AS FOLLOWUP_FORM_RCV_DATE,
    st.FOLLOWUP_REASON_CD AS FOLLOWUP_REASON_CD,
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM MAXDAT_LAEB.d_dates d
    WHERE d.business_day_flag = 'Y' AND d.d_date BETWEEN TRUNC(st.create_ts)
    AND COALESCE(
      (SELECT MIN(TRUNC(sh.create_ts))
      FROM maxdat_laeb.EMRS_D_SELECTN_TXN_STAT_HIST sh
      WHERE sh.selection_txn_id = st.selection_txn_id AND sh.status_cd = 'readyToUpload'
      ),TRUNC(st.status_date))
    ) AS HISTORY_AGE_IN_BUSINESS_DAYS,
    st.MISSING_INFO_ID AS MISSING_INFO_ID,
    st.MISSING_SIGNATURE_IND AS MISSING_SIGNATURE_IND,
    st.NETWORK_ID AS NETWORK_ID,
    st.NETWORK_ID AS PROVIDER_NUMBER,
    NULL AS NEWBORN_FLAG,
    st.ORIGINAL_END_DATE AS ORIGINAL_END_DATE,
    st.ORIGINAL_START_DATE AS ORIGINAL_START_DATE,
    st.OUTREACH_SESSION_ID AS OUTREACH_SESSION_ID,
    COALESCE(st.OVERRIDE_REASON_CD, '0') AS OVERRIDE_REASON_CD,
    st.PLAN_ID AS PLAN_ID,
    st.PLAN_ID_EXT AS PLAN_ID_EXT,
    st.PLAN_TYPE_CD AS PLAN_TYPE,
    COALESCE(st.PRIOR_CHOICE_REASON_CD, '0') AS PRIOR_CHOICE_REASON_CD,
    st.PRIOR_CLIENT_AID_CATEGORY_CD AS PRIOR_CLIENT_AID_CATEGORY_CD,
    st.PRIOR_CONTRACT_ID AS PRIOR_CONTRACT_ID,
    COALESCE(st.PRIOR_COUNTY_CD, '0') AS PRIOR_COUNTY_CD,
    st.PRIOR_DISENROLL_REASON_CD_1 AS PRIOR_DISENROLL_REASON_CD_1,
    st.PRIOR_DISENROLL_REASON_CD_2 AS PRIOR_DISENROLL_REASON_CD_2,
    st.PRIOR_NETWORK_ID AS PRIOR_NETWORK_ID,
    CASE WHEN st.START_DATE - to_date(p.PRIOR_SEGMENT_END_ND,'yyyymmdd') <= 65 THEN COALESCE(p.PRIOR_PLAN_ID, 0) ELSE 0 END AS PRIOR_PLAN_ID,
    CASE WHEN st.START_DATE - to_date(p.PRIOR_SEGMENT_END_ND,'yyyymmdd') > 65 THEN 1 ELSE 0 END AS OLD_PRIOR_PLAN_EXISTS,
    p.PRIOR_PLAN_ID_EXT AS PRIOR_PLAN_ID_EXT,
    p.PRIOR_SLCTION_GEN_FIELD5_TXT,
    st.PRIOR_PROVIDER_FIRST_NAME AS PRIOR_PROVIDER_FIRST_NAME,
    st.PRIOR_PROVIDER_ID AS PRIOR_PROVIDER_ID,
    st.PRIOR_PROVIDER_ID_EXT AS PRIOR_PROVIDER_ID_EXT,
    st.PRIOR_PROVIDER_LAST_NAME AS PRIOR_PROVIDER_LAST_NAME,
    st.PRIOR_PROVIDER_MIDDLE_NAME AS PRIOR_PROVIDER_MIDDLE_NAME,
    st.PRIOR_SELECTION_END_DATE AS PRIOR_SELECTION_END_DATE,
    st.PRIOR_SELECTION_SEGMENT_ID AS PRIOR_SELECTION_SEGMENT_ID,
    st.PRIOR_SELECTION_START_DATE AS PRIOR_SELECTION_START_DATE,
    st.PRIOR_ZIPCODE AS PRIOR_ZIPCODE,
    COALESCE(st.PROGRAM_TYPE_CD, '0') AS PROGRAM_CODE,
    COALESCE(st.PROGRAM_TYPE_CD, '0') AS PROGRAM_TYPE_CD,
    st.PROVIDER_FIRST_NAME AS PROVIDER_FIRST_NAME,
    st.PROVIDER_ID AS PROVIDER_ID,
    st.PROVIDER_ID_EXT AS PROVIDER_ID_EXT,
    CASE WHEN st.PROVIDER_ID_EXT IS NULL THEN 'N'
          ELSE 'Y'
    END AS PCP_SELECTED,
    st.PROVIDER_LAST_NAME AS PROVIDER_LAST_NAME,
    st.PROVIDER_MIDDLE_NAME AS PROVIDER_MIDDLE_NAME,
    st.REF_EXT_TXN_ID AS REF_EXT_TXN_ID,
    st.REF_SELECTION_TXN_ID AS REF_SELECTION_TXN_ID,
    st.REF_SOURCE_ID AS REF_SOURCE_ID,
    st.REF_SOURCE_TYPE AS REF_SOURCE_TYPE,
    st.SELECTION_GENERIC_FIELD1_DATE AS SELECTION_GENERIC_FIELD1_DATE,
    st.SELECTION_GENERIC_FIELD10_TXT AS SELECTION_GENERIC_FIELD10_TXT,
    st.SELECTION_GENERIC_FIELD2_DATE AS SELECTION_GENERIC_FIELD2_DATE,
    st.SELECTION_GENERIC_FIELD3_NUM AS SELECTION_GENERIC_FIELD3_NUM,
    st.SELECTION_GENERIC_FIELD4_NUM AS SELECTION_GENERIC_FIELD4_NUM,
    st.SELECTION_GENERIC_FIELD5_TXT AS SELECTION_GENERIC_FIELD5_TXT,
    st.SELECTION_GENERIC_FIELD6_TXT AS SELECTION_GENERIC_FIELD6_TXT,
    st.SELECTION_GENERIC_FIELD7_TXT AS SELECTION_GENERIC_FIELD7_TXT,
    st.SELECTION_GENERIC_FIELD8_TXT AS SELECTION_GENERIC_FIELD8_TXT,
    st.SELECTION_GENERIC_FIELD9_TXT AS SELECTION_GENERIC_FIELD9_TXT,
    st.CHOICE_REASON_CD AS SELECTION_REASON_CODE,
    COALESCE(st.SELECTION_SOURCE_CD, 'A') AS SELECTION_SOURCE_CD,
    CASE      
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
    st.STATUS_CD AS SELECTION_STATUS_CODE,
    st.SELECTION_TXN_GROUP_ID AS SELECTION_TXN_GROUP_ID,
    st.START_DATE AS START_DATE,
    ST.PLAN_START_DATE AS PLAN_START_DATE,
    st.END_DATE AS END_DATE,
    st.START_ND AS START_ND,
    st.END_ND AS END_ND,
    st.STATUS_CD AS STATUS_CD,
    st.STATUS_DATE AS STATUS_DATE,
    COALESCE(ceg.SUBPROGRAM_TYPE, 'UD') AS SUBPROGRAM_CODE ,
   CASE
        WHEN ceg.SUBPROGRAM_TYPE = 'AC_BH'
              OR (ceg.SUBPROGRAM_TYPE IS NULL AND st.SELECTION_GENERIC_FIELD5_TXT = 'P')
              OR (ceg.SUBPROGRAM_TYPE = 'AC_BH' AND st.SELECTION_GENERIC_FIELD5_TXT IS NULL)
              OR (ceg.SUBPROGRAM_TYPE IS NULL AND st.SELECTION_GENERIC_FIELD5_TXT IS NULL)
        THEN 'GROUP_1'
        WHEN ceg.SUBPROGRAM_TYPE  ='BH_ONLY'
              OR (ceg.SUBPROGRAM_TYPE IS NULL AND st.SELECTION_GENERIC_FIELD5_TXT = 'B')
              OR (ceg.SUBPROGRAM_TYPE  ='BH_ONLY' AND st.SELECTION_GENERIC_FIELD5_TXT IS NULL)
        THEN 'GROUP_2'
        WHEN ceg.SUBPROGRAM_TYPE= 'OPT_IN' AND st.SELECTION_GENERIC_FIELD5_TXT = 'P'
        THEN 'GROUP_3'
        WHEN ceg.SUBPROGRAM_TYPE= 'OPT_IN' AND (COALESCE(st.SELECTION_GENERIC_FIELD5_TXT, 'B') = 'B')
        THEN 'GROUP_4'
        ELSE 'UD'
        END AS SUBPROGRAM_CAT_CODE,
    ceg.mvx_core_reason,
    st.SURPLUS_INFO AS SURPLUS_INFO,
    COALESCE(CASE WHEN st.SELECTION_SOURCE_CD = 'AT' AND st.TRANSACTION_TYPE_CD = 'Transfer' THEN 'AutoTransfer' ELSE st.TRANSACTION_TYPE_CD END, 'NotDefined') AS TRANSACTION_TYPE_CD,
    st.ZIPCODE AS ZIP_CODE,
    st.CREATE_TS AS RECORD_DATE,
    st.CREATED_BY AS RECORD_NAME,
    st.CREATE_TS AS RECORD_TIME,
    st.UPDATE_TS AS MODIFIED_DATE,
    st.UPDATED_BY AS MODIFIED_NAME,
    st.UPDATE_TS AS MODIFIED_TIME,  
     CASE WHEN st.transaction_type_cd IN('NewEnrollment','DefaultEnroll') THEN TRUNC(st.status_date)
          WHEN st.transaction_type_cd = 'Transfer' THEN TRUNC(p.prior_status_date)
      ELSE NULL END grace_period_start,
     CASE WHEN st.transaction_type_cd IN('NewEnrollment','DefaultEnroll') THEN TRUNC(st.status_date) + 90
          WHEN st.transaction_type_cd = 'Transfer' THEN TRUNC(p.prior_status_date) + 90
      ELSE NULL END grace_period_end,
     CASE WHEN st.transaction_type_cd = 'Transfer' THEN
        CASE WHEN st.status_date <= TRUNC(p.prior_status_date) + 90 THEN 1
             WHEN st.status_date > TRUNC(p.prior_status_date) + 90 THEN 2
      ELSE 0 END
     ELSE 0 END in_grace_period
     ,CASE WHEN st.plan_type_cd = 'DENTAL' THEN
        CASE WHEN st.start_date IS NOT NULL AND cl.clnt_dob IS NOT NULL THEN 
          CASE WHEN FLOOR(MONTHS_BETWEEN(TRUNC(st.start_date,'mm'),cl.clnt_dob)/12) < 21 THEN 'Under 21'
          ELSE '21 and Over' END 
        ELSE NULL END ELSE NULL END dental_age_group
          , future_enroll_flag
          , ss_generic_field5_txt    
  FROM
    (SELECT
      COALESCE(txn.selection_txn_id, seg.SELECTION_SEGMENT_ID*-1) AS SELECTION_TXN_ID,
      COALESCE(seg.SELECTION_SEGMENT_ID, txn.SELECTION_TXN_ID*-1) AS SELECTION_SEGMENT_ID,
      COALESCE(seg.SELECTION_SEGMENT_ID, txn.SELECTION_TXN_ID*-1) AS ENROLLMENT_ID,
      ROW_NUMBER() OVER(PARTITION BY COALESCE(txn.client_id, seg.client_id), COALESCE(seg.start_nd, txn.start_nd), COALESCE(txn.plan_type_cd,seg.plan_type_cd), CASE WHEN txn.TRANSACTION_TYPE_CD = 'Disenrollment' THEN 1 ELSE 0 END ORDER BY txn.selection_txn_id, seg.SELECTION_SEGMENT_ID DESC) as rn,
      COALESCE(txn.CLIENT_ID, seg.CLIENT_ID) AS CLIENT_ID,
      COALESCE(txn.CLIENT_AID_CATEGORY_CD, seg.CLIENT_AID_CATEGORY_CD,  '0' ) AS CLIENT_AID_CATEGORY_CD,
      txn.BENEFITS_PACKAGE_CD AS BENEFITS_PACKAGE_CD,
      COALESCE(txn.DISENROLL_REASON_CD_1, seg.DISENROLL_REASON_CD_1, '0') AS DISENROLL_REASON_CD_1,
      COALESCE(txn.CHOICE_REASON_CD, seg.CHOICE_REASON_CD, '0') AS CHOICE_REASON_CD,
      txn.CLIENT_RESIDENCE_ADDRESS_ID AS CLIENT_RESIDENCE_ADDRESS_ID,
      COALESCE(txn.contract_id, seg.contract_id) AS CONTRACT_ID,
      txn.COUNTY AS COUNTY_CODE,
      COALESCE(txn.COUNTY, seg.COUNTY_CD) AS TRANSACTION_COUNTY_CD,
      COALESCE(txn.DISENROLL_REASON_CD_2, seg.DISENROLL_REASON_CD_2) AS DISENROLL_REASON_CD_2,
      txn.FOLLOWUP_BY AS FOLLOWUP_BY,
      txn.FOLLOWUP_CALL_DATE AS FOLLOWUP_CALL_DATE,
      txn.FOLLOWUP_FORM_RCV_DATE AS FOLLOWUP_FORM_RCV_DATE,
      txn.FOLLOWUP_REASON_CD AS FOLLOWUP_REASON_CD,
      txn.MISSING_INFO_ID AS MISSING_INFO_ID,
      txn.MISSING_SIGNATURE_IND AS MISSING_SIGNATURE_IND,
      COALESCE(txn.NETWORK_ID, seg.NETWORK_ID, 0) AS NETWORK_ID,
      txn.ORIGINAL_END_DATE AS ORIGINAL_END_DATE,
      txn.ORIGINAL_START_DATE AS ORIGINAL_START_DATE,
      txn.OUTREACH_SESSION_ID AS OUTREACH_SESSION_ID,
      txn.OVERRIDE_REASON_CD AS OVERRIDE_REASON_CD,
      COALESCE(txn.PLAN_ID, seg.PLAN_ID, 0) AS PLAN_ID,
      COALESCE(txn.PLAN_ID_EXT, seg.PLAN_ID_EXT, '0') AS PLAN_ID_EXT,
      COALESCE(txn.PLAN_TYPE_CD, seg.PLAN_TYPE_CD, '0') AS PLAN_TYPE_CD,
      txn.PRIOR_CHOICE_REASON_CD AS PRIOR_CHOICE_REASON_CD,
      COALESCE(txn.PRIOR_CLIENT_AID_CATEGORY_CD, '0') AS PRIOR_CLIENT_AID_CATEGORY_CD,
      txn.PRIOR_CONTRACT_ID AS PRIOR_CONTRACT_ID,
      txn.PRIOR_COUNTY_CD AS PRIOR_COUNTY_CD,
      txn.PRIOR_DISENROLL_REASON_CD_1 AS PRIOR_DISENROLL_REASON_CD_1,
      txn.PRIOR_DISENROLL_REASON_CD_2 AS PRIOR_DISENROLL_REASON_CD_2,
      txn.PRIOR_NETWORK_ID AS PRIOR_NETWORK_ID,
      txn.PRIOR_PROVIDER_FIRST_NAME AS PRIOR_PROVIDER_FIRST_NAME,
      txn.PRIOR_PROVIDER_ID AS PRIOR_PROVIDER_ID,
      txn.PRIOR_PROVIDER_ID_EXT AS PRIOR_PROVIDER_ID_EXT,
      txn.PRIOR_PROVIDER_LAST_NAME AS PRIOR_PROVIDER_LAST_NAME,
      txn.PRIOR_PROVIDER_MIDDLE_NAME AS PRIOR_PROVIDER_MIDDLE_NAME,
      txn.PRIOR_SELECTION_END_DATE AS PRIOR_SELECTION_END_DATE,
      txn.PRIOR_SELECTION_SEGMENT_ID AS PRIOR_SELECTION_SEGMENT_ID,
      txn.PRIOR_SELECTION_START_DATE AS PRIOR_SELECTION_START_DATE,
      txn.PRIOR_ZIPCODE AS PRIOR_ZIPCODE,
      COALESCE(txn.program_type_cd, seg.program_type_cd, '0') AS PROGRAM_TYPE_CD,
      txn.provider_first_name AS PROVIDER_FIRST_NAME,
      txn.PROVIDER_ID AS PROVIDER_ID,
      txn.provider_id_ext AS PROVIDER_ID_EXT,
      txn.provider_last_name AS PROVIDER_LAST_NAME,
      txn.provider_middle_name AS PROVIDER_MIDDLE_NAME,
      txn.REF_EXT_TXN_ID AS REF_EXT_TXN_ID,
      txn.REF_SELECTION_TXN_ID AS REF_SELECTION_TXN_ID,
      txn.REF_SOURCE_ID AS REF_SOURCE_ID,
      txn.REF_SOURCE_TYPE AS REF_SOURCE_TYPE,
      txn.SELECTION_GENERIC_FIELD1_DATE AS SELECTION_GENERIC_FIELD1_DATE,
      txn.SELECTION_GENERIC_FIELD10_TXT AS SELECTION_GENERIC_FIELD10_TXT,
      txn.SELECTION_GENERIC_FIELD2_DATE AS SELECTION_GENERIC_FIELD2_DATE,
      txn.SELECTION_GENERIC_FIELD3_NUM AS SELECTION_GENERIC_FIELD3_NUM,
      txn.SELECTION_GENERIC_FIELD4_NUM AS SELECTION_GENERIC_FIELD4_NUM,
      txn.SELECTION_GENERIC_FIELD5_TXT AS SELECTION_GENERIC_FIELD5_TXT,
      txn.SELECTION_GENERIC_FIELD6_TXT AS SELECTION_GENERIC_FIELD6_TXT,
      txn.SELECTION_GENERIC_FIELD7_TXT AS SELECTION_GENERIC_FIELD7_TXT,
      txn.SELECTION_GENERIC_FIELD8_TXT AS SELECTION_GENERIC_FIELD8_TXT,
      txn.SELECTION_GENERIC_FIELD9_TXT AS SELECTION_GENERIC_FIELD9_TXT,
      txn.SELECTION_SOURCE_CD AS SELECTION_SOURCE_CD,
      COALESCE(txn.STATUS_CD, '0') AS STATUS_CD,
      txn.SELECTION_TXN_GROUP_ID AS SELECTION_TXN_GROUP_ID,
      COALESCE(seg.START_DATE, txn.START_DATE) AS START_DATE,
      seg.START_DATE AS PLAN_START_DATE,
      COALESCE(seg.END_DATE, txn.END_DATE) AS END_DATE,
      COALESCE(seg.START_ND,txn.START_ND) AS START_ND,
      COALESCE(seg.END_ND,txn.END_ND) AS END_ND,
      COALESCE(txn.STATUS_DATE, seg.STATUS_DATE) AS STATUS_DATE,
      txn.SURPLUS_INFO AS SURPLUS_INFO,
      txn.TRANSACTION_TYPE_CD AS TRANSACTION_TYPE_CD,
      COALESCE(txn.ZIPCODE, seg.ZIPCODE, '0') AS ZIPCODE,
      txn.CREATE_TS AS CREATE_TS,
      txn.CREATED_BY AS CREATED_BY,
      txn.UPDATE_TS AS UPDATE_TS,
      txn.UPDATED_BY AS UPDATED_BY,
      case when seg1.selection_segment_id is not null then 1 else 0 end future_enroll_flag
      ,seg.ss_generic_field5_txt      
    FROM MAXDAT_LAEB.EMRS_D_SELECTION_TXN txn
    FULL OUTER JOIN MAXDAT_LAEB.EMRS_D_SELECTION_SEGMENT seg on (txn.client_id = seg.client_id AND txn.plan_id = seg.plan_id AND txn.start_nd = seg.start_nd)
    left join maxdat_laeb.emrs_d_selection_segment seg1 on (seg1.client_id = seg.client_id and seg1.plan_type_cd = seg.plan_type_cd and seg1.start_nd < seg1.end_nd and seg1.start_date = seg.end_date +1)
    WHERE (txn.STATUS_CD = 'acceptedByState' OR (seg.SELECTION_SEGMENT_ID IS NOT NULL AND txn.SELECTION_TXN_ID IS NULL))
    AND (txn.TRANSACTION_TYPE_CD = 'Disenrollment' OR seg.SELECTION_SEGMENT_ID IS NOT NULL)
    AND ((COALESCE(txn.STATUS_DATE, seg.STATUS_DATE) >= (ADD_MONTHS(TRUNC(sysdate, 'mm'), -12)) and COALESCE(seg.end_nd, txn.end_nd) > COALESCE(seg.start_nd, txn.start_nd))
          OR (COALESCE(seg.end_nd, txn.end_nd) >= TO_NUMBER(TO_CHAR(LAST_DAY(TRUNC(SYSDATE, 'MM')-1), 'yyyymmdd'))))
    ) st
  LEFT JOIN MAXDAT_LAEB.EMRS_D_CLIENT cl ON st.client_id = cl.client_id
  LEFT JOIN MAXDAT_LAEB.EMRS_D_CLIENT_ELIGIBILITY ceg ON (st.client_id = ceg.client_id AND st.plan_type_cd = ceg.plan_type_cd AND st.status_date >= TRUNC(ceg.start_date) AND st.status_date < TRUNC(COALESCE(ceg.end_date, sysdate))) 
  LEFT JOIN (SELECT
              a.SELECTION_TXN_ID,
              a.SELECTION_SEGMENT_ID,
              a.CLIENT_ID,
              a.STATUS_CD,
              a.STATUS_DATE,
              a.START_DATE,
              a.SEGMENT_START_ND,
              a.SEGMENT_END_ND,
              a.PLAN_ID,
              a.PLAN_ID_EXT,
              a.PLAN_TYPE_CD,
              LAG(a.SELECTION_TXN_ID, 1) OVER (PARTITION BY a.client_id,a.plan_type_cd ORDER BY a.SEGMENT_START_ND, a.SELECTION_SEGMENT_ID ASC) PRIOR_SELECTION_TXN_ID,
              LAG(a.SEGMENT_START_ND, 1) OVER (PARTITION BY a.client_id,a.plan_type_cd ORDER BY a.SEGMENT_START_ND, a.SELECTION_SEGMENT_ID ASC) PRIOR_SEGMENT_START_ND,
              LAG(a.SEGMENT_END_ND, 1) OVER (PARTITION BY a.client_id,a.plan_type_cd ORDER BY a.SEGMENT_START_ND, a.SELECTION_SEGMENT_ID ASC) PRIOR_SEGMENT_END_ND,
              LAG(a.PLAN_ID, 1) OVER (PARTITION BY a.client_id,a.plan_type_cd ORDER BY a.SEGMENT_START_ND, a.SELECTION_SEGMENT_ID ASC) PRIOR_PLAN_ID,
              LAG(a.PLAN_ID_EXT, 1) OVER (PARTITION BY a.client_id,a.plan_type_cd ORDER BY a.SEGMENT_START_ND, a.SELECTION_SEGMENT_ID ASC) PRIOR_PLAN_ID_EXT,
              LAG(a.SELECTION_GENERIC_FIELD5_TXT, 1) OVER (PARTITION BY a.client_id,a.plan_type_cd ORDER BY a.SEGMENT_START_ND, a.SELECTION_SEGMENT_ID ASC) PRIOR_SLCTION_GEN_FIELD5_TXT,
              LAG(a.STATUS_DATE, 1) OVER (PARTITION BY a.client_id,a.plan_type_cd ORDER BY a.SEGMENT_START_ND, a.SELECTION_SEGMENT_ID ASC) PRIOR_STATUS_DATE
              FROM
              (SELECT
                st1.SELECTION_TXN_ID,
                ss1.SELECTION_SEGMENT_ID,
                ss1.CLIENT_ID AS CLIENT_ID,
                st1.STATUS_CD,
                st1.STATUS_DATE,
                ss1.START_DATE AS START_DATE,
                ss1.START_ND AS SEGMENT_START_ND,
                ss1.END_ND AS SEGMENT_END_ND,
                ss1.PLAN_ID AS PLAN_ID,
                ss1.PLAN_ID_EXT AS PLAN_ID_EXT,
                ss1.PLAN_TYPE_CD AS PLAN_TYPE_CD,
                st1.SELECTION_GENERIC_FIELD5_TXT,
                ROW_NUMBER() OVER(PARTITION BY ss1.CLIENT_ID, ss1.plan_type_cd, ss1.START_ND ORDER BY ss1.START_ND DESC) as rn
                FROM MAXDAT_LAEB.EMRS_D_SELECTION_SEGMENT ss1
                LEFT JOIN MAXDAT_LAEB.EMRS_D_SELECTION_TXN st1 ON (ss1.CLIENT_ID = st1.CLIENT_ID
                                                    AND ss1.START_ND = st1.START_ND
                                                    AND st1.PLAN_ID = st1.PLAN_ID
                                                    AND st1.TRANSACTION_TYPE_CD <> 'Disenrollment'
                                                    AND st1.STATUS_CD = 'acceptedByState'
                                                    AND st1.START_ND <> st1.END_ND)
                WHERE ss1.START_ND <> ss1.END_ND) a
                WHERE RN = 1) p ON (st.CLIENT_ID = p.CLIENT_ID AND st.plan_type_cd = p.plan_type_cd AND st.START_DATE = p.START_DATE AND st.TRANSACTION_TYPE_CD = 'Transfer')  --only join on transer transactions
WHERE st.rn = 1
WITH READ ONLY
;

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
    COALESCE(st.SELECTION_SOURCE_CD, 'A') AS SELECTION_SOURCE_CODE,
    CASE WHEN st.selection_source_cd IN ('P','C','W')
         THEN 'Y'
         ELSE 'N'
    END AS IS_CHOICE_IND,
    CASE      
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