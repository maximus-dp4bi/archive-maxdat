CREATE OR REPLACE VIEW EMRS_D_AA_COUNTYCONTRACT_SV
AS
  SELECT updated_by ,
    aa_countycontract_id ,
    created_by ,
    create_ts date_created ,
    updated_by modified_name ,
    TO_CHAR(update_ts,'HH24MI') modified_time ,
    update_ts modified_date ,
    created_by record_name ,
    TO_CHAR(create_ts,'HH24MI') record_time ,
    create_ts record_date ,
    claim_add ,
    pcp_add ,
    mother_child_add ,
    order_by_default ,
    random_num ,
    prior_plan_num ,
    case_add_num ,
    target_num ,
    assigned_num ,
    contract_amendment_id ,
    aa_contract_id ,
    aa_job_id ,
    aa_countycontract_id source_record_id ,
    update_ts date_updated
  FROM aa_countycontract ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AA_COUNTYCONTRACT_SV TO EB_MAXDAT_REPORTS;