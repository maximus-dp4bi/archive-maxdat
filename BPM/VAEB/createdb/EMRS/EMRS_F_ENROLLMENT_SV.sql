DROP VIEW EMRS_F_ENROLLMENT_SV;
CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_SV
 AS
     
SELECT 
    ss.selection_txn_id enrollment_id,
    COALESCE(ss.selection_txn_id,0) selection_transaction_id,
    cs.case_id case_number,
    COALESCE(ss.disenroll_reason_cd_1, ss.disenroll_reason_cd_2,'0') change_reason_code,
    ss.client_id client_number,
    COALESCE(ss.county, '0') county_code,
    '0' coverage_category_code,
    '0' csda_code, 
    ss.transaction_type_cd enrollment_action_status_code,
    '0' citizenship_code, -- get these data from client
    '0' language_code,
    '0' race_code,
    cs.GENDER_CD AS sex,
    cs.DOB,
    EXTRACT(YEAR FROM(TRUNC(sysdate) - cs.dob) YEAR TO MONTH) AS AGE ,    
    COALESCE(ss.plan_id, 0) plan_id, --get the plan info by joining to emrs_d_plan_sv.plan_id
    COALESCE(ss.program_type_cd, '0') program_code,
    COALESCE(ss.network_id, 0) provider_number, --get provider info by joining to emrs_d_provider_sv.network_id
    COALESCE(ss.selection_source_cd,'0') selection_source_code,
    DECODE(ss.selection_source_cd,'A','N','AN','N','Y') is_choice_ind,    
    COALESCE(ss.choice_reason_cd,'0') selection_reason_code,    
    '0' status_in_group_code,
    '0' risk_group_code,    
    COALESCE(ss.client_aid_category_cd, '0') aid_category_code,
    '0' reason_code, --term reason code    
    '0' rejection_code,
    COALESCE(ca.plan_service_type_cd,'0') subprogram_code ,
    ss.status_date status_date,
    ss.start_date managed_care_start_date,
    ss.end_date managed_care_end_date,
    COALESCE(ss.plan_type_cd,'0') plan_type,      
    -- sel_txn data that we will probably need for enrollment reports
    --start
    ss.prior_selection_start_date ,
    ss.prior_selection_end_date ,
    COALESCE(ss.prior_plan_id,0) AS prior_plan_id,
    ss.prior_plan_id_ext ,
    ss.prior_provider_id ,
    ss.prior_provider_id_ext ,
    ss.prior_provider_first_name ,
    ss.prior_provider_middle_name ,
    ss.prior_provider_last_name ,  
    ss.prior_contract_id ,
    ss.prior_network_id ,
    ss.prior_choice_reason_cd ,
    ss.prior_disenroll_reason_cd_1 ,
    ss.prior_disenroll_reason_cd_2 ,
    ss.prior_client_aid_category_cd ,
    ss.prior_county_cd ,
    ss.prior_zipcode ,
    ss.original_start_date ,
    ss.original_end_date ,
    ss.create_ts record_date ,
    TO_CHAR(ss.create_ts, 'hh24mi') record_time ,
    ss.created_by record_name ,
    ss.update_ts modified_date ,
    ss.updated_by modified_name ,
    TO_CHAR(ss.update_ts, 'hh24mi') modified_time ,    
    ss.start_nd ,
    ss.end_nd , 
    ss.plan_id_ext ,
    ss.contract_id ,
    ss.network_id ,
    ss.provider_id,
    ss.provider_id_ext ,
    ss.provider_first_name ,
    ss.provider_middle_name ,
    ss.provider_last_name ,
    ss.disenroll_reason_cd_2 , 
    ss.selection_segment_id ,   
    ss.zipcode zip_code ,    
    ss.prior_selection_segment_id ,
    ss.status_cd ,
    ss.created_by created_by ,
    ss.update_ts date_updated ,
    ss.updated_by updated_by ,
    ss.create_ts date_created ,
    -- end sel txn data
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_support.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(ss.create_ts) AND TRUNC(ss.status_date)
    ) age_in_business_days ,  
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_support.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(ss.create_ts) AND COALESCE(
      (SELECT MIN(TRUNC(sh.create_ts))
      FROM selection_txn_status_history sh
      WHERE sh.selection_txn_id = ss.selection_txn_id AND sh.status_cd = 'readyToUpload'
      ),TRUNC(ss.status_date))
    ) history_age_in_business_days,
    CASE
       WHEN FLOOR(months_between(TRUNC(ss.create_ts),cs.dob)/12) < 1 
      THEN 'Y'
      ELSE 'N'
    END newborn_flag , 
    NULL AS CERTIFICATION_DATE,
    NULL AS CSDA_CHANGE_DATE,
    NULL AS PEOPLE_IN_FAMILY,
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
    1    AS NUMBER_COUNT,
    'SELECTION_TXN' source_table_name,  
    ss.selection_txn_id source_record_id,
    CASE WHEN ss.client_aid_category_cd IN('100', '101', '102', '103', '106','108') THEN 1 ELSE 0 END medicaid_expansion_indicator
  FROM eb.selection_txn ss
  INNER JOIN client_supplementary_info cs ON ss.client_id = cs.client_id AND ss.program_type_cd = cs.program_cd  
--  LEFT JOIN enum_aid_category ac ON ss.client_aid_category_cd = ac.value  
--subprogram comes from contract
  LEFT JOIN contract ca ON ss.contract_id = ca.contract_id
  WHERE (ss.create_ts >= add_months(TRUNC(sysdate,'mm'),-6) OR ss.status_date >= add_months(TRUNC(sysdate,'mm'),-6) );



  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLLMENT_SV TO MAXDAT_REPORTS;  
  GRANT SELECT ON maxdat_support.EMRS_F_ENROLLMENT_SV TO MAXDATSUPPORT_READ_ONLY;