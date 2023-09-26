CREATE OR REPLACE VIEW EMRS_D_CLIENT_PLAN_ELIG_SV
AS
SELECT client_plan_eligibility_id
       ,client_number
       ,plan_type_id
       ,sub_program_id
       ,eligibility_status_code
       ,current_eligibility_status_cd
       ,created_by
       ,date_created
       ,date_of_validity_start
       ,date_of_validity_end
       ,date_updated
       ,updated_by
       ,current_flag
       ,version
       ,source_record_id
       ,reasons
       ,mvx_core_reason
       ,sub_status_codes
       ,disposition_cd
FROM emrs_d_client_plan_eligibility
WHERE current_flag = 'Y';

GRANT SELECT ON EMRS_D_CLIENT_PLAN_ELIG_SV TO "MAXDAT_READ_ONLY";