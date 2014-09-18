CREATE SEQUENCE "EMRS_SEQ_AA_CLIENT_ID" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 86401 CACHE 5 NOORDER  NOCYCLE ; 
GRANT SELECT ON "EMRS_SEQ_AA_CLIENT_ID" TO "MAXDAT_READ_ONLY"; 
CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_AA_CLIENT FOR EMRS_D_AA_CLIENT; 
GRANT SELECT ON "EMRS_D_AA_CLIENT" TO "MAXDAT_READ_ONLY"; 

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

CREATE OR REPLACE VIEW EMRS_CASE_FPIL_SV 
AS
SELECT *
FROM(
SELECT  r.case_number       
       ,(SELECT case_cin FROM emrs_d_case cs WHERE cs.case_number = r.case_number AND cs.current_flag = 'Y') case_cin
       ,(SELECT managed_care_program FROM emrs_d_case cs WHERE cs.case_number = r.case_number AND cs.current_flag = 'Y') managed_care_program
       ,(SELECT MIN(managed_via_gen_rev_flag) FROM emrs_d_client dc,emrs_f_enrollment f WHERE dc.client_number = f.client_number AND current_flag = 'Y' AND f.case_number = r.case_number) managed_via_gen_rev_flag
       ,(SELECT MIN(f.plan_id)
         FROM emrs_f_enrollment f           
             INNER JOIN emrs_d_plan_type pt
               ON f.plan_type_id = pt.plan_type_id
           WHERE f.case_number = r.case_number
           AND pt.plan_type = 'MEDICAL'
           AND (NOT EXISTS(SELECT 1 FROM emrs_f_enrollment f1 
                           WHERE f.client_number = f1.client_number 
                           AND f.plan_type_id = f1.plan_type_id
                           AND f.managed_care_start_date >= f1.managed_care_end_date +1)
            OR eligibility_receipt_date BETWEEN managed_care_start_date AND COALESCE(managed_care_end_date,sysdate) )
           ) eligibility_hp_plan_id       
       ,(SELECT MIN(f.plan_id)
         FROM emrs_f_enrollment f
             INNER JOIN emrs_d_plan_type pt
               ON f.plan_type_id = pt.plan_type_id
           WHERE f.case_number = r.case_number
           AND pt.plan_type = 'DENTAL'
           AND (NOT EXISTS(SELECT 1 FROM emrs_f_enrollment f1 
                           WHERE f.client_number = f1.client_number 
                           AND f.plan_type_id = f1.plan_type_id
                           AND f.managed_care_start_date >= f1.managed_care_end_date +1)
            OR eligibility_receipt_date BETWEEN managed_care_start_date AND COALESCE(managed_care_end_date,sysdate) )
           ) eligibility_dental_plan_id              
        ,(SELECT MAX(f.plan_id)
          FROM emrs_f_enrollment f
            INNER JOIN emrs_d_plan_type pt
            ON f.plan_type_id = pt.plan_type_id
          WHERE f.case_number = r.case_number
          AND f.chip_annual_enroll_date = cs.enrollment_end_date + 1
          AND pt.plan_type = 'MEDICAL'
          AND (managed_care_end_date IS NULL OR managed_care_end_date > LAST_DAY(TRUNC(sysdate))))  current_hp_plan_id
        ,(SELECT MAX(f.plan_id)
          FROM emrs_f_enrollment f
            INNER JOIN emrs_d_plan_type pt
            ON f.plan_type_id = pt.plan_type_id
          WHERE f.case_number = r.case_number
          AND f.chip_annual_enroll_date = cs.enrollment_end_date + 1
          AND pt.plan_type = 'DENTAL'          
          AND (managed_care_end_date IS NULL OR managed_care_end_date > LAST_DAY(TRUNC(sysdate)))) current_dental_plan_id             
        , cs.fpil 
        ,(SELECT MAX(cs1.fpil)
          FROM cost_share_details_stg cs1
          WHERE cs1.case_id = cs.case_id
          AND cs_period_start_date = (SELECT MAX(cs_period_start_date)
                                      FROM cost_share_details_stg cs2
                                      WHERE cs1.case_id = cs2.case_id
                                      AND cs1.enrollment_end_date = cs2.enrollment_end_date)
          --cs1.enrollment_end_date = cs.enrollment_end_date
          ) current_fpil
        ,cs.enrollment_start_date
        ,cs.enrollment_end_date
        ,cs.cs_period_start_date
        ,cs.cs_period_end_date
        ,cs.enrollment_end_date + 1 chip_annual_enroll_date
        ,cs.enrollment_fee
        ,cs.date_fee_paid
        ,cs.fee_paid_flag
FROM emrs_d_case_ref r
INNER JOIN cost_share_details_stg cs
ON r.case_number = cs.case_id)
WHERE managed_care_program = 'CHIP';

CREATE OR REPLACE PUBLIC SYNONYM EMRS_CASE_FPIL_SV FOR EMRS_CASE_FPIL_SV;
GRANT SELECT ON EMRS_CASE_FPIL_SV TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW EMRS_D_AA_CLIENT_SV 
AS
SELECT aa_client_id
 ,source_record_id
 ,aa_job_id
 ,client_number
 ,cin
 ,source_plan_id
 ,aa_action_cd
 ,program_type
 ,subprogram_type
 ,source_provider_id
 ,record_date
 ,record_time
 ,record_name
 ,order_by_default
 ,modified_date
 ,modified_time
 ,modified_name
FROM emrs_d_aa_client; 
 
CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_AA_CLIENT_SV FOR EMRS_D_AA_CLIENT_SV; 
GRANT SELECT ON "EMRS_D_AA_CLIENT_SV" TO "MAXDAT_READ_ONLY";