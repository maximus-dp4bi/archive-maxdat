CREATE OR REPLACE VIEW EMRS_D_SELECTION_TRANS_SV AS
SELECT s.created_by ,
    s.update_ts date_updated ,
    s.updated_by ,
    s.prior_selection_start_date ,
    s.prior_selection_end_date ,
    COALESCE(s.prior_plan_id, 0) AS prior_plan_id,
    s.prior_plan_id_ext ,
    s.prior_provider_id,
    s.prior_provider_id_ext ,
    s.prior_provider_first_name ,
    s.prior_provider_middle_name ,
    s.prior_provider_last_name ,
    s.ref_selection_txn_id ,
    s.surplus_info ,
    s.create_ts record_date ,
    TO_CHAR(s.create_ts, 'hh24mi') record_time ,
    s.created_by record_name ,
    s.update_ts modified_date ,
    s.updated_by modified_name ,
    TO_CHAR(s.update_ts, 'hh24mi') modified_time ,
    s.prior_contract_id ,
    s.prior_network_id ,
    s.start_nd ,
    s.end_nd ,
    s.prior_choice_reason_cd ,
    s.prior_disenroll_reason_cd_1 ,
    s.prior_disenroll_reason_cd_2 ,
    s.prior_client_aid_category_cd ,
    s.prior_county_cd ,
    s.prior_zipcode ,
    s.original_start_date ,
    s.original_end_date ,
    s.selection_generic_field1_date ,
    s.selection_generic_field2_date ,
    s.selection_generic_field3_num ,
    s.selection_generic_field4_num ,
    s.selection_generic_field5_txt ,
    s.selection_generic_field6_txt ,
    s.selection_generic_field7_txt ,
    s.selection_generic_field8_txt ,
    s.selection_generic_field9_txt ,
    s.selection_generic_field10_txt ,
    s.create_ts date_created ,
    s.selection_txn_id selection_transaction_id ,
    s.selection_txn_id source_record_id ,
    s.selection_txn_group_id ,
    COALESCE(s.program_type_cd, '0') AS program_type_cd,
    s.transaction_type_cd ,
    s.selection_source_cd ,
    s.ref_source_id ,
    s.ref_source_type ,
    s.ref_ext_txn_id ,
    s.plan_type_cd plan_type,
    COALESCE(s.plan_id, 0) AS plan_id,
    s.plan_id_ext ,
    s.contract_id ,
    s.network_id ,
    s.provider_id,
    s.provider_id_ext ,
    s.provider_first_name ,
    s.provider_middle_name ,
    s.provider_last_name ,
    s.start_date ,
    s.end_date ,
    s.choice_reason_cd ,
    COALESCE(s.disenroll_reason_cd_1, disenroll_reason_cd_2,'0') AS disenroll_reason_cd_1,
    s.disenroll_reason_cd_2 ,
    s.override_reason_cd ,
    s.followup_reason_cd ,
    s.followup_call_date ,
    s.followup_form_rcv_date ,
    s.followup_by ,
    s.missing_info_id ,
    s.missing_signature_ind ,
    s.outreach_session_id ,
    s.benefits_package_cd ,
    s.selection_segment_id ,
    s.client_id client_number ,
    NULL current_selection_status_id ,
    s.status_date ,
    COALESCE(s.client_aid_category_cd, '0') AS client_aid_category_cd ,
    s.county ,
    s.zipcode zip_code ,
    s.client_residence_address_id ,
    s.prior_selection_segment_id ,
    s.status_cd ,
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_support.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(s.create_ts) AND TRUNC(s.status_date)
    ) age_in_business_days ,
    CASE
      --there is no indicator in seltrans if newborn. either calculate age or set this to N if joining to client causes performance issues
      WHEN FLOOR(months_between(TRUNC(s.create_ts),cl.clnt_dob)/12) < 1  
      THEN 'Y'
      ELSE 'N'
    END newborn_flag ,
    --COALESCE(ca.subprogram_codes,'0') AS subprogram_code ,
    COALESCE(ca.plan_service_type_cd,'0') AS subprogram_code ,
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
    CASE WHEN COALESCE(s.disenroll_reason_cd_1, disenroll_reason_cd_2,'0') IN ('2002','2008','2009','1007','1002','1010')
      THEN COALESCE(s.selection_generic_field5_txt,n.note_text) ELSE NULL END custom_field1,
    null custom_field2,
    null custom_field3,
    null custom_field4,
    null custom_field5,
    CASE WHEN client_aid_category_cd IN('100', '101', '102', '103', '106','108') THEN 1 ELSE 0 END medicaid_expansion_indicator
  FROM eb.selection_txn s
  INNER JOIN client cl ON s.client_id = cl.clnt_client_id
  --LEFT JOIN enum_aid_category ca ON  s.client_aid_category_cd = ca.value
  LEFT JOIN contract ca ON s.contract_id = ca.contract_id
  LEFT JOIN event e ON (e.ref_id = s.selection_txn_id AND e.ref_type = 'SELECTION_TXN' AND e.event_type_cd IN('PHONE_ENROLLMENT','CHOICE_ENROLLMENT'))
  LEFT JOIN call_record cr ON e.call_record_id = cr.call_record_id
  LEFT JOIN (SELECT n.note_refid,n.note_text,n.case_id
             FROM note n 
             WHERE note_id = (SELECT MAX(note_id)
                              FROM note n1
                              WHERE n1.note_refid = n.note_refid )) n
             ON n.note_refid = cr.note_ref_id    
  WHERE (s.create_ts >= add_months(TRUNC(sysdate,'mm'),-2) OR s.status_date >= add_months(TRUNC(sysdate,'mm'),-2) );
  
GRANT SELECT ON maxdat_support.EMRS_D_SELECTION_TRANS_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.EMRS_D_SELECTION_TRANS_SV TO MAXDATSUPPORT_READ_ONLY;

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
  WHERE (ss.create_ts >= add_months(TRUNC(sysdate,'mm'),-2) OR ss.status_date >= add_months(TRUNC(sysdate,'mm'),-2) );



  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENROLLMENT_SV TO MAXDAT_REPORTS;  
  GRANT SELECT ON maxdat_support.EMRS_F_ENROLLMENT_SV TO MAXDATSUPPORT_READ_ONLY;