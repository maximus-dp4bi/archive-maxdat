CREATE OR REPLACE VIEW EMRS_D_SELECTION_TRANS_SV
AS
  SELECT s.created_by ,
    s.update_ts date_updated ,
    s.updated_by ,
    s.prior_selection_start_date ,
    s.prior_selection_end_date ,
    s.prior_plan_id source_prior_plan_id ,
    s.prior_plan_id_ext ,
    s.prior_provider_id source_prior_provider_id ,
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
    s.program_type_cd ,
    s.transaction_type_cd ,
    s.selection_source_cd ,
    s.ref_source_id ,
    s.ref_source_type ,
    s.ref_ext_txn_id ,
    s.plan_type_cd ,
    s.plan_id source_plan_id ,
    s.plan_id_ext ,
    s.contract_id ,
    s.network_id ,
    s.provider_id source_provider_id ,
    s.provider_id_ext ,
    s.provider_first_name ,
    s.provider_middle_name ,
    s.provider_last_name ,
    s.start_date ,
    s.end_date ,
    s.choice_reason_cd ,
    s.disenroll_reason_cd_1 ,
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
    s.client_aid_category_cd ,
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
    FROM maxdat_lookup.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(s.create_ts) AND TRUNC(s.status_date)
    ) age_in_business_days ,
    CASE
      WHEN s.selection_source_cd = 'NE'
      THEN 'Y'
      ELSE 'N'
    END newborn_flag ,
    
    es.report_label subprogram ,    
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_lookup.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(s.create_ts) AND COALESCE(
      (SELECT MIN(TRUNC(sh.create_ts))
      FROM selection_txn_status_history sh
      WHERE sh.selection_txn_id = s.selection_txn_id AND sh.status_cd = 'readyToUpload'
      ),TRUNC(s.status_date))
    ) history_age_in_business_days
  FROM eb.selection_txn s
  LEFT JOIN (SELECT es.client_id
              , st.report_label
              , RANK() OVER(PARTITION BY es.client_id ORDER BY client_elig_status_id DESC) as RNK
              FROM client_elig_status es
              JOIN enum_subprogram_type st ON (es.subprogram_type = st.value AND es.end_date IS NULL)) es ON (es.client_id = s.client_id AND es.rnk = 1)
  WHERE (s.create_ts >= add_months(TRUNC(sysdate,'mm'),-2) OR s.status_date >= add_months(TRUNC(sysdate,'mm'),-2) )
  
  
  UNION ALL
  
  
  SELECT j1.created_by ,
    TRUNC(j1.update_ts) date_updated ,
    j1.updated_by ,
    NULL prior_selection_start_date ,
    NULL prior_selection_end_date ,
    NULL source_prior_plan_id ,
    NULL prior_plan_id_ext ,
    NULL source_prior_provider_id ,
    NULL prior_provider_id_ext ,
    NULL prior_provider_first_name ,
    NULL prior_provider_middle_name ,
    NULL prior_provider_last_name ,
    NULL ref_selection_txn_id ,
    NULL surplus_info ,
    TRUNC(j1.start_ts) record_date ,
    TO_CHAR(j1.start_ts , 'hh24mi') record_time ,
    j1.created_by record_name ,
    TRUNC(j1.update_ts) modified_date ,
    j1.updated_by modified_name ,
    TO_CHAR(j1.update_ts , 'hh24mi') modified_time ,
    NULL prior_contract_id ,
    NULL prior_network_id ,
    NULL start_nd ,
    NULL end_nd ,
    NULL prior_choice_reason_cd ,
    NULL prior_disenroll_reason_cd_1 ,
    NULL prior_disenroll_reason_cd_2 ,
    NULL prior_client_aid_category_cd ,
    NULL prior_county_cd ,
    NULL prior_zipcode ,
    NULL original_start_date ,
    NULL original_end_date ,
    NULL selection_generic_field1_date ,
    NULL selection_generic_field2_date ,
    NULL selection_generic_field3_num ,
    NULL selection_generic_field4_num ,
    NULL selection_generic_field5_txt ,
    NULL selection_generic_field6_txt ,
    NULL selection_generic_field7_txt ,
    NULL selection_generic_field8_txt ,
    NULL selection_generic_field9_txt ,
    NULL selection_generic_field10_txt ,
    j1.start_ts date_created ,
    to_number(ss1.etl_selection_segment_id||st.client_id) selection_transaction_id ,
    ss1.etl_selection_segment_id source_record_id ,
    NULL selection_txn_group_id ,
    ss1.program_type_cd ,
    'State_Facilitated_Enrollment' transaction_type_cd ,
    'State Facilitated' selection_source_cd ,
    NULL ref_source_id ,
    NULL ref_source_type ,
    NULL ref_ext_txn_id ,
    ss1.plan_type_cd ,
    p.plan_id source_plan_id ,
    ss1.plan_id_ext ,
    ss1.contract_id ,
    NULL network_id ,
    NULL source_provider_id ,
    ss1.provider_id_ext ,
    ss1.provider_first_name ,
    ss1.provider_middle_name ,
    ss1.provider_last_name ,
    ss1.selection_start_date start_date ,
    CASE
      WHEN ss1.selection_end_date = TO_DATE('12/31/2099','mm/dd/yyyy')
      THEN NULL
      ELSE ss1.selection_end_date
    END end_date ,
    ss1.choice_reason_cd ,
    ss1.disenroll_reason1_cd disenroll_reason_cd_1 ,
    ss1.disenroll_reason2_cd disenroll_reason_cd_2 ,
    NULL override_reason_cd ,
    NULL followup_reason_cd ,
    NULL followup_call_date ,
    NULL followup_form_rcv_date ,
    NULL followup_by ,
    NULL missing_info_id ,
    NULL missing_signature_ind ,
    NULL outreach_session_id ,
    NULL benefits_package_cd ,
    ss1.etl_selection_segment_id selection_segment_id ,
    st.client_id client_number ,
    NULL current_selection_status_id ,
    j1.start_ts status_date ,    
    cc.cscl_adlk_id client_aid_category_cd ,
    cs.addr_county county ,
    
    ss1.client_res_zipcode zip_code ,
    NULL client_residence_address_id ,
    NULL prior_selection_segment_id ,
    'acceptedByState' status_cd ,
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_lookup.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(j1.start_ts) AND TRUNC(j1.start_ts)
    ) age_in_business_days ,
    'N' newborn_flag ,
    
    est.report_label subprogram ,
    
    (SELECT
      CASE
        WHEN (COUNT(*)-1) < 0
        THEN 0
        ELSE COUNT(*)-1
      END
    FROM maxdat_lookup.d_dates
    WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(j1.start_ts) AND TRUNC(j1.start_ts)
    ) history_age_in_business_days
  FROM (SELECT plan_id_ext
            , etl_selection_segment_id
            , CLIENT_RES_ZIPCODE
            , PROGRAM_TYPE_CD
            , PLAN_TYPE_CD
            , CONTRACT_ID
            , PROVIDER_ID_EXT
            , PROVIDER_FIRST_NAME
            , PROVIDER_MIDDLE_NAME
            , PROVIDER_LAST_NAME
            , SELECTION_END_DATE
            , choice_reason_cd
            , DISENROLL_REASON1_CD
            , disenroll_reason2_cd
            , job_id, matched_plan_id
            , selection_start_date 
            FROM etl_l_selection_segment   
        UNION ALL
        SELECT plan_id_ext
            , etl_selection_segment_id
            , CLIENT_RES_ZIPCODE
            , PROGRAM_TYPE_CD
            , PLAN_TYPE_CD
            , CONTRACT_ID
            , PROVIDER_ID_EXT
            , PROVIDER_FIRST_NAME
            , PROVIDER_MIDDLE_NAME
            , PROVIDER_LAST_NAME
            , SELECTION_END_DATE
            , choice_reason_cd
            , DISENROLL_REASON1_CD
            , disenroll_reason2_cd
            , job_id, matched_plan_id
            , selection_start_date 
             FROM etl_l_selection_segment@eb_etl_link
        )   ss1
  JOIN
    (SELECT MIN( u.etl_selection_segment_id ) etl_id , u.client_id , u.clnt_cin,u.subprogram_type, u.selection_segment_id
     FROM 
     (select ss.etl_selection_segment_id 
              , e.client_id 
              , c.clnt_cin 
              , e.subprogram_type 
              , s.selection_segment_id
           FROM eb.client c 
           JOIN eb.selection_segment s ON s.client_id = c.clnt_client_id 
           JOIN eb.client_elig_status e ON c.clnt_client_id = e.client_id 
            AND ((e.end_date IS NULL AND s.end_date > sysdate) OR (s.end_date  between e.start_date and e.end_date)) 
            AND e.elig_status_cd = 'M' 
           JOIN eb.etl_l_selection_segment ss ON ss.client_cin = c.clnt_cin AND ss.matched_plan_id = s.plan_id 
           JOIN eb.job_run_data j ON j.job_run_data_id = ss.job_id 
            AND TRUNC(j.end_ts) >= TRUNC(e.start_date)
         UNION ALL 
         select ss2.etl_selection_segment_id 
              , e.client_id 
              , c.clnt_cin 
              , e.subprogram_type 
              , s.selection_segment_id
           FROM eb.client c 
           JOIN eb.selection_segment s ON s.client_id = c.clnt_client_id 
           JOIN eb.client_elig_status e ON c.clnt_client_id = e.client_id 
            AND ((e.end_date IS NULL AND s.end_date > sysdate) OR (s.end_date  between e.start_date and e.end_date)) 
            AND e.elig_status_cd = 'M' 
           JOIN etl_l_selection_segment@eb_etl_link ss2 ON ss2.client_cin = c.clnt_cin AND ss2.matched_plan_id = s.plan_id 
           JOIN eb.job_run_data j ON j.job_run_data_id = ss2.job_id 
            AND TRUNC(j.end_ts) >= TRUNC(e.start_date) 
          ) u
    GROUP BY u.client_id ,
      u.clnt_cin,
      u.subprogram_type,
      u.selection_segment_id
    ) st ON ss1.etl_selection_segment_id = st.etl_id
  JOIN eb.job_run_data j1 ON j1.job_run_data_id = ss1.job_id
  LEFT JOIN plans p ON (p.plan_id_ext = ss1.plan_id_ext)  -- (SELECT plan_id FROM plans p WHERE p.plan_id_ext = ss1.plan_id_ext) source_plan_id 
  LEFT JOIN enum_subprogram_type est ON (est.value = st.subprogram_type)
  LEFT JOIN eb.client_supplementary_info cs ON (cs.client_id = st.client_id)
  LEFT JOIN eb.case_client cc ON (cc.cscl_id = cs.case_client_id) 
  
  WHERE j1.start_ts >= add_months(TRUNC(sysdate,'mm'),-2) AND NOT EXISTS
    (SELECT 1
    FROM eb.selection_txn t
    WHERE st.client_id = t.client_id AND ss1.matched_plan_id = t.plan_id AND ss1.selection_start_date = t.start_date)
; 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_D_SELECTION_TRANS_SV TO EB_MAXDAT_REPORTS;  