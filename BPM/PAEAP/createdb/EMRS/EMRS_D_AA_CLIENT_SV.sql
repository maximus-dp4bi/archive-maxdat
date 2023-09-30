CREATE OR REPLACE VIEW EMRS_D_AA_CLIENT_SV
AS
  SELECT aa_client_id source_record_id ,
    aa_job_id ,
    client_id client_number ,
    cin ,
    plan_id source_plan_id ,
    aa_action_cd ,
    program_type ,
    subprogram_type ,
    order_by_default ,
    provider_id source_provider_id ,
    TRUNC(create_ts) record_date ,
    TO_CHAR(create_ts,'HH24MI') record_time ,
    created_by record_name ,
    TRUNC(update_ts) modified_date ,
    updated_by modified_name ,
    TO_CHAR(update_ts,'HH24MI') modified_time ,
    aa_client_id aa_client_id
  FROM aa_client ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_AA_CLIENT_SV TO EB_MAXDAT_REPORTS;