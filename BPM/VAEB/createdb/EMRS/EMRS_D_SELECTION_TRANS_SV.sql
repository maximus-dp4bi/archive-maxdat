DROP VIEW EMRS_D_SELECTION_TRANS_SV;
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
  WHERE (s.create_ts >= add_months(TRUNC(sysdate,'mm'),-6) OR s.status_date >= add_months(TRUNC(sysdate,'mm'),-6) );
  
GRANT SELECT ON maxdat_support.EMRS_D_SELECTION_TRANS_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.EMRS_D_SELECTION_TRANS_SV TO MAXDATSUPPORT_READ_ONLY;