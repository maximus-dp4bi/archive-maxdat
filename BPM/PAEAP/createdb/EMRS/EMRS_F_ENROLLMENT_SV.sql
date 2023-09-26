CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_SV
 AS     
 SELECT 
    ss.selection_segment_id enrollment_id,
    COALESCE(s.selection_txn_id,0) selection_transaction_id,
    cs.case_id case_number,
    COALESCE(ss.disenroll_reason_cd_1,s.disenroll_reason_cd_1, '0') change_reason_code,
    ss.client_id client_number,
    COALESCE(ss.county_cd, s.county,'0') county_code,
    '0' coverage_category_code,
    '0' csda_code, 
    COALESCE(s.transaction_type_cd,'State_Facilitated_Enrollment') enrollment_action_status_code,
    '0' citizenship_code, -- get these data from client
    '0' language_code,
    '0' race_code,
    cs.GENDER_CD AS sex,
    cs.DOB,
    EXTRACT(YEAR FROM(TRUNC(sysdate) - cs.dob) YEAR TO MONTH) AS AGE ,    
    COALESCE(ss.plan_id, s.plan_id, 0) plan_id, --get the plan info by joining to emrs_d_plan_sv.plan_id
    COALESCE(ss.program_type_cd, s.program_type_cd, '0') program_code,
    COALESCE(ss.network_id,s.network_id, 0) provider_number, --get provider info by joining to emrs_d_provider_sv.network_id
    COALESCE(s.selection_source_cd,'State Facilitated') selection_source_code,
    DECODE(s.selection_source_cd,'6','N','Y') is_choice_ind ,
    COALESCE(ss.choice_reason_cd, s.choice_reason_cd) selection_reason_code,    
    '0' status_in_group_code,
    '0' risk_group_code,    
    COALESCE(ss.client_aid_category_cd,s.client_aid_category_cd, '0') aid_category_code,
    '0' reason_code, --term reason code    
    '0' rejection_code,
    COALESCE(ac.subprogram_codes, '0') subprogram_code ,
    COALESCE(ss.status_date, s.status_date) status_date,
    ss.start_date managed_care_start_date,
    ss.end_date managed_care_end_date,
    COALESCE(ss.plan_type_cd, s.plan_type_cd) plan_type,      
    -- sel_txn data that we will probably need for enrollment reports
    --start
    s.prior_selection_start_date ,
    s.prior_selection_end_date ,
    COALESCE(s.prior_plan_id,0) AS prior_plan_id,
    s.prior_plan_id_ext ,
    s.prior_provider_id ,
    s.prior_provider_id_ext ,
    s.prior_provider_first_name ,
    s.prior_provider_middle_name ,
    s.prior_provider_last_name ,  
    s.prior_contract_id ,
    s.prior_network_id ,
    s.prior_choice_reason_cd ,
    s.prior_disenroll_reason_cd_1 ,
    s.prior_disenroll_reason_cd_2 ,
    s.prior_client_aid_category_cd ,
    s.prior_county_cd ,
    s.prior_zipcode ,
    s.original_start_date ,
    s.original_end_date ,
    COALESCE(ss.create_ts,s.create_ts) record_date ,
    TO_CHAR(COALESCE(ss.create_ts,s.create_ts), 'hh24mi') record_time ,
    COALESCE(ss.created_by,s.created_by) record_name ,
    COALESCE(ss.update_ts,s.update_ts) modified_date ,
    COALESCE(ss.updated_by,s.updated_by) modified_name ,
    TO_CHAR(COALESCE(ss.update_ts,s.update_ts), 'hh24mi') modified_time ,    
    s.start_nd ,
    s.end_nd , 
    s.plan_id_ext ,
    s.contract_id ,
    s.network_id ,
    s.provider_id,
    s.provider_id_ext ,
    s.provider_first_name ,
    s.provider_middle_name ,
    s.provider_last_name ,
    s.disenroll_reason_cd_2 , 
    s.selection_segment_id ,   
    s.zipcode zip_code ,    
    s.prior_selection_segment_id ,
    COALESCE(s.status_cd, 'acceptedByState') AS status_cd ,
    COALESCE(ss.created_by,s.created_by) created_by ,
    COALESCE(ss.update_ts,s.update_ts) date_updated ,
    COALESCE(ss.updated_by,s.updated_by) updated_by ,
    COALESCE(ss.create_ts,s.create_ts) date_created ,
    -- end sel txn data
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_support.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(COALESCE(ss.create_ts,s.create_ts)) AND TRUNC(COALESCE(ss.status_date,s.status_date))
    ) age_in_business_days ,  
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
    ) history_age_in_business_days,
    CASE
       WHEN FLOOR(months_between(TRUNC(COALESCE(ss.create_ts,s.create_ts)),cs.dob)/12) < 1 
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
    'SELECTION_SEGMENT' source_table_name,  
    ss.selection_segment_id source_record_id        
  FROM eb.selection_segment ss
  JOIN client_supplementary_info cs ON (ss.client_id = cs.client_id AND ss.program_type_cd = cs.program_cd)
  JOIN enum_aid_category ac ON (ss.client_aid_category_cd = ac.value)
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
  WHERE (s.start_nd >= to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -3), 'yyyymmdd')) and s.end_nd > s.start_nd );

  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLLMENT_SV TO EB_MAXDAT_REPORTS;  