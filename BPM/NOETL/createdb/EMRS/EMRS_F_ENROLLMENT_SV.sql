CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_SV
 AS     
 SELECT 
    ss.selection_segment_id AS ENROLLMENT_ID,
    COALESCE(s.selection_txn_id,0) AS SELECTION_TRANSACTION_ID,
    cs.case_id AS CASE_ID,
    COALESCE(ss.disenroll_reason_cd_1,s.disenroll_reason_cd_1, '0') AS CHANGE_REASON_CODE,
    ss.client_id AS CLIENT_ID,
    COALESCE(ss.county_cd, s.county,'0') AS COUNTY_CODE,
    '0' AS CSDA_CODE, 
    COALESCE(s.transaction_type_cd,'NotDefined') AS TRANSACTION_TYPE_CD,
    COALESCE(ss.plan_id, s.plan_id, 0) AS PLAN_ID, --get the plan info by joining to emrs_d_plan_sv.plan_id
    COALESCE(ss.program_type_cd, s.program_type_cd, '0') AS PROGRAM_CODE,
    COALESCE(ss.network_id,s.network_id, 0) AS PROVIDER_NUMBER, --get provider info by joining to emrs_d_provider_sv.network_id
    COALESCE(s.selection_source_cd,'0') AS SELECTION_SOURCE_CODE,
    CASE WHEN s.selection_source_cd IN ('P','C','W')
         THEN 'Y'
         ELSE 'N'
    END AS IS_CHOICE_IND,
    COALESCE(ss.choice_reason_cd, s.choice_reason_cd, '0') AS SELECTION_REASON_CODE, 
    COALESCE(ss.client_aid_category_cd,s.client_aid_category_cd, '0') AS AID_CATEGORY_CODE,
    '0' AS REASON_CODE, --term reason code  
--    COALESCE(ac.subprogram_codes, '0') AS SUBPROGRAM_CODE , --on Aid Category, this field is not used
    COALESCE(ss.status_date, s.status_date) AS STATUS_DATE,
    ss.start_date AS MANAGED_CARE_START_DATE,
    ss.end_date AS MANAGED_CARE_END_DATE,
    COALESCE(ss.plan_type_cd, s.plan_type_cd, '0') AS PLAN_TYPE,      
    -- sel_txn data that we will probably need for enrollment reports
    --start
    s.prior_selection_start_date AS PRIOR_SELECTION_START_DATE,
    s.prior_selection_end_date AS PRIOR_SELECTION_END_DATE,
    COALESCE(s.prior_plan_id,0) AS PRIOR_PLAN_ID,
    s.prior_plan_id_ext AS PRIOR_PLAN_ID_EXT,
    s.prior_provider_id AS PRIOR_PROVIDER_ID,
    s.prior_provider_id_ext AS PRIOR_PROVIDER_ID_EXT,
    s.prior_provider_first_name AS PRIOR_PROVIDER_FIRST_NAME,
    s.prior_provider_middle_name AS PRIOR_PROVIDER_MIDDLE_NAME,
    s.prior_provider_last_name AS PRIOR_PROVIDER_LAST_NAME,  
    s.prior_contract_id AS PRIOR_CONTRACT_ID,
    s.prior_network_id AS PRIOR_NETWORK_ID,
    s.prior_choice_reason_cd AS PRIOR_CHOICE_REASON_CD,
    s.prior_disenroll_reason_cd_1 AS PRIOR_DISENROLL_REASON_CD_1,
    s.prior_disenroll_reason_cd_2 AS PRIOR_DISENROLL_REASON_CD_2,
    COALESCE(s.prior_client_aid_category_cd, '0') AS PRIOR_CLIENT_AID_CATEGORY_CD,
    s.prior_county_cd AS PRIOR_COUNTY_CD,
    s.prior_zipcode AS PRIOR_ZIPCODE,
    s.original_start_date AS ORIGINAL_START_DATE,
    s.original_end_date AS ORIGINAL_END_DATE,
    COALESCE(ss.create_ts,s.create_ts) AS RECORD_DATE,
    TO_CHAR(COALESCE(ss.create_ts,s.create_ts), 'hh24mi') AS RECORD_TIME,
    COALESCE(ss.created_by,s.created_by) AS RECORD_NAME,
    COALESCE(ss.update_ts,s.update_ts) AS MODIFIED_DATE,
    COALESCE(ss.updated_by,s.updated_by) AS MODIFIED_NAME,
    TO_CHAR(COALESCE(ss.update_ts,s.update_ts), 'hh24mi') AS MODIFIED_TIME,    
    s.start_nd AS START_ND,
    s.end_nd AS END_ND,
    s.plan_id_ext AS PLAN_ID_EXT,
    s.contract_id AS CONTRACT_ID, --why isn't this in the list, we have prior_contract_id
    COALESCE(ss.network_id,s.network_id, 0) AS NETWORK_ID,
    s.provider_id AS PROVIDER_ID,
    s.provider_id_ext AS PROVIDER_ID_EXT,
    s.provider_first_name AS PROVIDER_FIRST_NAME,
    s.provider_middle_name AS PROVIDER_MIDDLE_NAME,
    s.provider_last_name AS PROVIDER_LAST_NAME,
    s.disenroll_reason_cd_2 AS DISENROLL_REASON_CD_2, 
    s.selection_segment_id AS SELECTION_SEGMENT_ID,   
    COALESCE(s.zipcode, '0') AS zip_code,    
    s.prior_selection_segment_id AS PRIOR_SELECTION_SEGMENT_ID,
    COALESCE(s.status_cd, 'acceptedByState') AS STATUS_CD,
    -- end sel txn data
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_support.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(COALESCE(ss.create_ts,s.create_ts)) AND TRUNC(COALESCE(ss.status_date,s.status_date))
    ) AS AGE_IN_BUSINESS_DAYS,  
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_support.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(s.create_ts) AND COALESCE(
      (SELECT MIN(TRUNC(sh.create_ts))
      FROM selection_txn_status_history sh
      WHERE sh.selection_txn_id = s.selection_txn_id AND sh.status_cd = 'readyToUpload'
      ),TRUNC(s.status_date))
    ) AS HISTORY_AGE_IN_BUSINESS_DAYS,
    CASE
       WHEN FLOOR(months_between(TRUNC(COALESCE(ss.create_ts,s.create_ts)),cs.dob)/12) < 1 
      THEN 'Y'
      ELSE 'N'
    END AS NEWBORN_FLAG , 
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
    1    AS NUMBER_COUNT        ,
    con.plan_service_type_cd PLAN_SERVICE_TYPE
  FROM eb.selection_segment ss
  JOIN client_supplementary_info cs ON (ss.client_id = cs.client_id AND ss.program_type_cd = cs.program_cd)
  left join eb.contract con on (con.contract_id = ss.contract_id and con.plan_id = ss.plan_id)
  LEFT JOIN (SELECT s1.selection_segment_id,
              s1.selection_txn_id,
              s1.disenroll_reason_cd_1,
              s1.county,
              s1.transaction_type_cd,
              s1.plan_id, 
              s1.program_type_cd,
              s1.network_id,
              s1.selection_source_cd,
              s1.choice_reason_cd,  
              s1.client_aid_category_cd,
              s1.status_date,
              s1.plan_type_cd,
              s1.prior_selection_start_date ,
              s1.prior_selection_end_date ,
              s1.prior_plan_id,
              s1.prior_plan_id_ext ,
              s1.prior_provider_id ,
              s1.prior_provider_id_ext ,
              s1.prior_provider_first_name ,
              s1.prior_provider_middle_name ,
              s1.prior_provider_last_name ,  
              s1.prior_contract_id ,
              s1.prior_network_id ,
              s1.prior_choice_reason_cd ,
              s1.prior_disenroll_reason_cd_1 ,
              s1.prior_disenroll_reason_cd_2 ,
              s1.prior_client_aid_category_cd ,
              s1.prior_county_cd ,
              s1.prior_zipcode ,
              s1.original_start_date ,
              s1.original_end_date ,
              s1.create_ts,
              s1.created_by,
              s1.update_ts,
              s1.updated_by,  
              s1.start_nd ,
              s1.end_nd , 
              s1.plan_id_ext ,
              s1.contract_id ,
              s1.provider_id,
              s1.provider_id_ext ,
              s1.provider_first_name ,
              s1.provider_middle_name ,
              s1.provider_last_name ,
              s1.disenroll_reason_cd_2 ,  
              s1.zipcode,    
              s1.prior_selection_segment_id ,
              s1.status_cd
              FROM eb.selection_txn s1
              WHERE selection_txn_id IN (select selection_txn_id from 
                                           (select selection_txn_id, rank() OVER (PARTITION BY selection_segment_id order by start_date, selection_txn_id desc ) rnk
                                              from eb.selection_txn
                                              where STATUS_CD = 'acceptedByState'
                                              and selection_segment_id in (select selection_segment_id
                                                                            FROM eb.selection_segment
                                                                            WHERE END_ND >= to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -3), 'yyyymmdd'))))
                                          where rnk = 1)) s ON ss.selection_segment_id = s.selection_segment_id
  WHERE (COALESCE(ss.start_nd, s.start_nd) >= to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -3), 'yyyymmdd')) and COALESCE(ss.end_nd, s.end_nd) > COALESCE(ss.start_nd, s.start_nd));

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLLMENT_SV TO MAXDAT_REPORTS;  
