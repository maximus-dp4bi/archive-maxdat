CREATE OR REPLACE VIEW EMRS_D_CASE_FPIL_SV 
AS
SELECT *
FROM(
SELECT  r.case_number       
       ,(SELECT case_cin FROM emrs_d_case cs WHERE cs.case_number = r.case_number AND cs.current_flag = 'Y') case_cin
       ,(SELECT managed_care_program FROM emrs_d_case cs WHERE cs.case_number = r.case_number AND cs.current_flag = 'Y') managed_care_program
       ,(SELECT MIN(managed_via_gen_rev_flag) FROM emrs_d_client dc,emrs_f_enrollment f WHERE dc.client_number = f.client_number AND current_flag = 'Y' AND f.case_number = r.case_number) managed_via_gen_rev_flag
       ,COALESCE((SELECT MIN(f.plan_id)
         FROM emrs_f_enrollment f           
             INNER JOIN emrs_d_plan_type pt
               ON f.plan_type_id = pt.plan_type_id
           WHERE f.case_number = r.case_number
           AND pt.plan_type = 'MEDICAL'
           AND (NOT EXISTS(SELECT 1 FROM emrs_f_enrollment f1 
                           WHERE f.client_number = f1.client_number 
                           AND f.plan_type_id = f1.plan_type_id
                           AND f.managed_care_start_date >= f1.managed_care_end_date +1)
             OR ((eligibility_receipt_date BETWEEN managed_care_start_date AND COALESCE(managed_care_end_date,sysdate))   
              OR (eligibility_receipt_date < managed_care_start_date)) )
           ),0) eligibility_hp_plan_id       
       ,COALESCE((SELECT MIN(f.plan_id)
         FROM emrs_f_enrollment f
             INNER JOIN emrs_d_plan_type pt
               ON f.plan_type_id = pt.plan_type_id
           WHERE f.case_number = r.case_number
           AND pt.plan_type = 'DENTAL'
           AND (NOT EXISTS(SELECT 1 FROM emrs_f_enrollment f1 
                           WHERE f.client_number = f1.client_number 
                           AND f.plan_type_id = f1.plan_type_id
                           AND f.managed_care_start_date >= f1.managed_care_end_date +1)
            OR ((eligibility_receipt_date BETWEEN managed_care_start_date AND COALESCE(managed_care_end_date,sysdate))   
              OR (eligibility_receipt_date < managed_care_start_date)) )
           ),0) eligibility_dental_plan_id              
        ,COALESCE((SELECT MAX(f.plan_id)
          FROM emrs_f_enrollment f
            INNER JOIN emrs_d_plan_type pt
            ON f.plan_type_id = pt.plan_type_id
          WHERE f.case_number = r.case_number
          --AND f.chip_annual_enroll_date = cs.enrollment_end_date + 1
          AND pt.plan_type = 'MEDICAL'
          AND (managed_care_end_date IS NULL OR managed_care_end_date > LAST_DAY(TRUNC(sysdate)))),0)  current_hp_plan_id
        ,COALESCE((SELECT MAX(f.plan_id)
          FROM emrs_f_enrollment f
            INNER JOIN emrs_d_plan_type pt
            ON f.plan_type_id = pt.plan_type_id
          WHERE f.case_number = r.case_number
          --AND f.chip_annual_enroll_date = cs.enrollment_end_date + 1
          AND pt.plan_type = 'DENTAL'          
          AND (managed_care_end_date IS NULL OR managed_care_end_date > LAST_DAY(TRUNC(sysdate)))),0) current_dental_plan_id                     
        ,(SELECT MAX(cs1.fpil)
          FROM cost_share_details_stg cs1
          WHERE cs1.case_id = r.case_number
          AND cs_period_start_date = (SELECT MAX(cs_period_start_date)
                                      FROM cost_share_details_stg cs2
                                      WHERE cs1.case_id = cs2.case_id
                                      AND cs1.enrollment_end_date = cs2.enrollment_end_date)          
          ) current_fpil
        ,(SELECT MIN(cs1.fpil)
          FROM cost_share_details_stg cs1
          WHERE cs1.case_id = r.case_number
          AND cs_period_start_date = (SELECT MIN(cs_period_start_date)
                                      FROM cost_share_details_stg cs2
                                      WHERE cs1.case_id = cs2.case_id
                                      AND cs1.enrollment_end_date = cs2.enrollment_end_date)) eligibility_fpil 
       ,(SELECT MAX(cs1.family_size)
          FROM cost_share_details_stg cs1
          WHERE cs1.case_id = r.case_number
          AND cs_period_start_date = (SELECT MAX(cs_period_start_date)
                                      FROM cost_share_details_stg cs2
                                      WHERE cs1.case_id = cs2.case_id
                                      AND cs1.enrollment_end_date = cs2.enrollment_end_date)) family_size
FROM emrs_d_case_ref r)
WHERE managed_care_program = 'CHIP';

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_CASE_FPIL_SV FOR EMRS_D_CASE_FPIL_SV;
