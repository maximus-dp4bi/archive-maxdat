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
       ,cap_met_amount
       ,fee_status_date
       ,fee_status
       ,last_payment_date
       ,plan_notified_date
       ,total_expense_amount
FROM emrs_f_enrollment;

GRANT SELECT ON EMRS_F_ENROLLMENT_SV TO MAXDAT_READ_ONLY;