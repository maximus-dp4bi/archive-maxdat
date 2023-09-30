CREATE OR REPLACE VIEW EMRS_D_AA_CONTRACT_SV
AS
  SELECT aa_contract_id source_record_id ,
    aa_job_id ,
    aa_plan_id ,
    valid_ind ,
    contract_name ,
    contract_id ,
    current_enrollment ,
    program_type_cd managed_care_program ,
    plan_id source_plan_id ,
    status_cd ,
    plan_service_type_cd ,
    all_counties ,
    case_assignment_only ,
    client_count ,
    sanctioned_ind ,
    phsp_plan_ind ,
    qm_plan_ind ,
    total_assigned_clients ,
    total_autoenrolled_clients ,
    exclusion_reason ,
    create_ts record_date ,
    TO_CHAR(create_ts,'HH24MI') record_time ,
    created_by record_name ,
    update_ts modified_date ,
    TO_CHAR(update_ts,'HH24MI') modified_time ,
    updated_by modified_name ,
    order_by_default ,
    aa_contract_id aa_contract_id
  FROM aa_contract ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AA_CONTRACT_SV TO MAXDAT_REPORTS;