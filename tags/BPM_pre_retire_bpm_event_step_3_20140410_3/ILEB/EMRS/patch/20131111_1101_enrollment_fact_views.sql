CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_SV
AS
SELECT enrollment_id       
       ,change_reason_id       
       ,communication_type_id
       ,county_id
       ,coverage_category_id
       ,csda_id
       ,date_period_id
       ,enrollment_action_status_id
       ,fpl_id
       ,language_code_id
       ,plan_id
       ,program_id       
       ,provider_type_id
       ,race_id
       ,rejection_error_reason_id
       ,risk_group_id
       ,stat_in_grp_id
       ,sub_program_id
       ,term_reason_code_id
       ,time_period_id
       ,certification_date
       ,csda_change_date
       ,enrollment_status_change_date
       ,jyear_of_last_enrollment_form
       ,managed_care_end_date
       ,managed_care_start_date
       ,medicaid_buy_in_fee
       ,medicaid_buy_in_fee_date
       ,medicaid_recertification_date
       ,number_count
       ,date_created
       ,created_by
       ,updated_by
       ,date_updated
       ,met_cost_share_cap_date
       ,cost_share_start_date
       ,cost_share_end_date
       ,enrollment_fee_frequency
       ,chip_annual_enroll_date
       ,selection_source_id
       ,selection_reason_id
       ,aid_category_id
       ,citizenship_id
       ,enrollment_group_id
       ,source_record_id
       ,people_in_family
       ,enrollment_fee_assessed
       ,enrollment_fee_assessed_date
       ,enrollment_fee_paid
       ,enrollment_fee_paid_date
       ,co_pay_amount
       ,source_table_name
       ,eligibility_receipt_date
       ,case_number
       ,client_number
       ,provider_number
       ,plan_type_id
       ,fpl_percentage
FROM emrs_f_enrollment;

CREATE OR REPLACE PUBLIC SYNONYM EMRS_F_ENROLLMENT_SV FOR EMRS_F_ENROLLMENT_SV;

CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
SELECT plan_id
       ,managed_care_program
       ,csda
       ,plan_code
       ,plan_name
       ,plan_abbreviation
       ,plan_effective_date
       ,address1
       ,address2
       ,city
       ,state
       ,zip
       ,active
       ,contact_first_name
       ,contact_initial
       ,contact_last_name
       ,contact_full_name
       ,contact_phone
       ,contact_extension
       ,member_contact_phone
       ,enrollok
       ,plan_assign
       ,record_date
       ,record_time
       ,record_name
       ,source_record_id
       ,plan_type_id
       ,plan_service_type
FROM emrs_d_plan;

CREATE OR REPLACE VIEW EMRS_D_SUB_PROGRAM_SV
AS
SELECT sub_program_id
      ,sub_program_name
      ,sub_program_code
      ,parent_program_id
      ,parent_program_name
      ,start_date
      ,end_date
      ,source_record_id
      ,managed_care_program
      ,plan_service_type
FROM emrs_d_sub_program
WHERE end_date IS NULL;

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_PLAN_SV FOR EMRS_D_PLAN_SV;
CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_SUB_PROGRAM_SV FOR EMRS_D_SUB_PROGRAM_SV;

GRANT SELECT ON EMRS_D_SUB_PROGRAM_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON EMRS_D_PLAN_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON EMRS_F_ENROLLMENT_SV TO MAXDAT_READ_ONLY;
