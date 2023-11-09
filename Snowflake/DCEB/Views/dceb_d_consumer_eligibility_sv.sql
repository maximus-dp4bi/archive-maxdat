CREATE OR REPLACE VIEW dceb.dceb_d_consumer_eligibility_sv
AS
WITH cldtl AS(
SELECT cnvw.project_id,cnvw.consumer_id,cnvw.consumer_date_of_birth,   
       cin.external_consumer_id medical_assistance_id,
       civw.external_case_id case_number,
       cnvw.consumer_first_name,
       cnvw.consumer_last_name,
       ccvw.case_id,
       ccvw.consumer_role,
       ccvw.effective_end_date,
       lcvw.report_label consumer_language_preference
FROM marsdb.marsdb_consumer_vw cnvw
  JOIN marsdb.marsdb_project_vw p ON p.project_id = cnvw.project_id
  LEFT JOIN marsdb.marsdb_case_consumer_vw ccvw ON cnvw.consumer_id = ccvw.consumer_id AND cnvw.project_id = ccvw.project_id
  LEFT JOIN marsdb.marsdb_consumer_identification_number_vw cin ON cnvw.consumer_id = cin.consumer_id AND cnvw.project_id = cin.project_id 
      AND cin.identification_number_type = 'MEDICAID'
  LEFT JOIN marsdb.marsdb_case_identification_number_vw civw ON ccvw.case_id = civw.case_id AND ccvw.project_id = civw.project_id 
      AND civw.identification_number_type = 'MEDICAID'  
  LEFT JOIN marsdb.marsdb_consumer_attribute_v2_vw cavw ON cnvw.consumer_id = cavw.profile_id AND cnvw.project_id = cavw.project_id AND cavw.attr_key = 'LANGUAGE_PREFERENCE'  
  LEFT JOIN marsdb.marsdb_enum_language_code_v2_vw lcvw ON cavw.attr_value = lcvw.value AND cavw.project_id = lcvw.project_id
WHERE p.project_name = 'DC-EB'
QUALIFY ROW_NUMBER() OVER (PARTITION BY cnvw.consumer_id ORDER BY ccvw.effective_end_date DESC NULLS FIRST) = 1),
ce AS(
SELECT ce.project_id,ce.core_eligibility_segments_id,ce.consumer_id,ce.coverage_code,cc.report_label coverage_code_label,
 ce.eligibility_end_reason,ce.eligibility_status_code,ce.start_date eligibility_start_date,ce.end_date eligibility_end_date,ce.sub_program_type_cd,
 sp.report_label sub_program_type,CAST(ce.created_on AS DATE) eligibility_created_on,ervw.report_label eligibility_end_reason_label,
 cldtl.consumer_first_name,
 cldtl.consumer_last_name,
 cldtl.consumer_date_of_birth,
 CASE WHEN ce.start_date < cldtl.consumer_date_of_birth THEN 0 
  ELSE FLOOR((CAST(ce.start_date AS DATE) - CAST(cldtl.consumer_date_of_birth AS DATE))/365) END consumer_age,
 cldtl.medical_assistance_id,
 cldtl.case_number,
 cldtl.consumer_language_preference,
 csdtl.consumer_id case_hoh_consumer_id
FROM marsdb.marsdb_core_eligibility_vw ce
  JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
  LEFT JOIN cldtl ON ce.consumer_id = cldtl.consumer_id  AND ce.project_id = cldtl.project_id
  LEFT JOIN cldtl csdtl ON cldtl.case_id = csdtl.case_id AND cldtl.project_id = csdtl.project_id AND csdtl.consumer_role = 'Primary Individual'
  LEFT JOIN marsdb.marsdb_enum_coverage_code_vw cc ON ce.coverage_code = cc.value AND ce.project_id = cc.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON ce.sub_program_type_cd = sp.value AND ce.project_id = sp.project_id 
  LEFT JOIN marsdb.marsdb_enum_enrollment_update_reasons_vw ervw ON ce.eligibility_end_reason = ervw.value AND ce.project_id = ervw.project_id
WHERE p.project_name = 'DC-EB'
AND CAST(ce.start_date AS DATE) != CAST(ce.end_date AS DATE)),
ce_future_elig AS(
SELECT ce.core_eligibility_segments_id,ce.project_id,ce.consumer_id,ce.coverage_code
FROM ce
WHERE LAST_DAY(LAST_DAY(current_date())+1) +1 BETWEEN CAST(eligibility_start_date AS DATE) AND CAST(eligibility_end_date AS DATE)
QUALIFY ROW_NUMBER() OVER (PARTITION BY project_id,consumer_id ORDER BY ce.core_eligibility_segments_id DESC) = 1 ),
ce_dr AS(
SELECT project_id,consumer_id,eligibility_end_reason,eligibility_end_reason_label,MIN(eligibility_created_on) disenrl_dr_min_created_on
FROM ce
WHERE eligibility_end_reason = 'DR'
GROUP BY project_id,consumer_id,eligibility_end_reason,eligibility_end_reason_label),
ce_8x AS(
SELECT project_id,consumer_id,eligibility_end_reason,eligibility_end_reason_label,MIN(eligibility_created_on) disenrl_8x_min_created_on
FROM ce
WHERE eligibility_end_reason = '8X'
GROUP BY project_id,consumer_id,eligibility_end_reason,eligibility_end_reason_label),
ce_current_elig AS(
SELECT ce.core_eligibility_segments_id,ce.project_id,ce.consumer_id,ce.coverage_code
FROM ce
WHERE current_date() BETWEEN CAST(eligibility_start_date AS DATE) AND CAST(eligibility_end_date AS DATE)
QUALIFY ROW_NUMBER() OVER (PARTITION BY project_id,consumer_id ORDER BY ce.core_eligibility_segments_id DESC) = 1 ),
claddr AS(
SELECT b.*,co.external_ref_type,co.external_ref_id  
FROM marsdb.marsdb_address_vw b                      
  JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
  JOIN marsdb.marsdb_contacts_vw ct ON b.contact_type_id = ct.contact_type_id AND b.project_id = ct.project_id
  JOIN marsdb.marsdb_contacts_owner_vw co ON ct.owner_id = co.contact_owner_id AND ct.project_id = co.project_id 
WHERE p.project_name = 'DC-EB'
AND b.address_type = 'Physical'
AND UPPER(co.external_ref_type) = 'CONSUMER'                          
QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY b.effective_end_date DESC NULLS FIRST,address_id DESC ) =1),
clphn AS(SELECT p.*,co.external_ref_type,co.external_ref_id                   
                 FROM marsdb.marsdb_phone_vw p                     
                   JOIN marsdb.marsdb_project_vw pr ON p.project_id = pr.project_id
                   JOIN marsdb.marsdb_contacts_vw ct ON p.contact_type_id = ct.contact_type_id AND p.project_id = ct.project_id
                   JOIN marsdb.marsdb_contacts_owner_vw co ON ct.owner_id = co.contact_owner_id AND ct.project_id = co.project_id 
                 WHERE pr.project_name = 'DC-EB'
                 AND UPPER(co.external_ref_type) = 'CONSUMER'
                 AND p.phone_type = 'Home'
                 QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY p.effective_end_date DESC NULLS FIRST,phone_id DESC ) =1),
enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status enroll_status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code   
   ,CAST(disenrl.created_on AS DATE) disenroll_created_on_date
FROM marsdb.marsdb_enrollments_vw enrl
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date 
    AND disenrl.status = 'DISENROLLED' --AND disenrl.plan_end_date_reason IS NOT NULL
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED')
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
UNION ALL
SELECT disenrl.project_id,disenrl.enrollment_id, disenrl.consumer_id, disenrl.start_date, disenrl.end_date,disenrl.status, CAST(disenrl.txn_status_date AS DATE) txn_status_date
   ,disenrl.plan_code,disenrl.enrollment_type,disenrl.sub_program_type_cd,disenrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,disenrl.service_region_code
   ,CAST(disenrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code
   ,CAST(disenrl.created_on AS DATE) disenroll_created_on_date
FROM marsdb.marsdb_enrollments_vw disenrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = disenrl.project_id
WHERE p.project_name = 'DC-EB'
AND disenrl.status = 'DISENROLLED'
AND NOT EXISTS(SELECT 1 FROM marsdb.marsdb_enrollments_vw enrl WHERE disenrl.project_id = enrl.project_id 
  AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND enrl.status IN('ACCEPTED'))
)
SELECT ce.project_id,
 ce.core_eligibility_segments_id,
 ce.consumer_id,
 ce.coverage_code,
 ce.coverage_code_label,
 ce.eligibility_end_reason,
 ce.eligibility_status_code,
 CAST(ce.eligibility_start_date AS DATE) eligibility_start_date,
 CAST(ce.eligibility_end_date AS DATE) eligibility_end_date,
 ce.sub_program_type_cd,
 ce.sub_program_type,
 ce.eligibility_created_on,
 ce.eligibility_end_reason_label,
 ce.consumer_first_name,
 ce.consumer_last_name,
 ce.consumer_date_of_birth,
 ce.consumer_age,
 ce.medical_assistance_id,
 ce.case_number,
 COALESCE(csaddr.address_street_1,claddr.address_street_1) address_street_1,
 COALESCE(csaddr.address_street_2,claddr.address_street_2) address_street_2,
 COALESCE(csaddr.address_city,claddr.address_city) address_city,
 COALESCE(csaddr.address_state,claddr.address_state) address_state,
 COALESCE(csaddr.address_zip,claddr.address_zip) address_zip,
 COALESCE(csaddr.address_zip_four,claddr.address_zip_four) address_zip_four,
 COALESCE(csaddr.address_county,claddr.address_county) address_county,  
 COALESCE(csphn.phone_number,clphn.phone_number) phone_number,
 CASE WHEN enrl.enrollment_id IS NOT NULL THEN 'Enrolled' ELSE 'Not Enrolled' END enrolled_indicator,  
 ce.consumer_language_preference,
 enrl.start_date enrollment_start_date,
 enrl.end_date enrollment_end_date,  
 enrl.plan_code,
 enrl.plan_name,
 CASE WHEN ( (ce.eligibility_end_reason ='DR' OR ce_dr.disenrl_dr_min_created_on IS NOT NULL) AND ce_future_elig.core_eligibility_segments_id IS NOT NULL)
        OR ((ce.eligibility_end_reason = '8X' OR ce_8x.disenrl_8x_min_created_on IS NOT NULL) AND enrl.enrollment_id IS NULL AND ce_future_elig.core_eligibility_segments_id IS NOT NULL) 
      THEN ce.eligibility_end_reason ELSE NULL END disenroll_reason_code,   
 CASE WHEN ( (ce.eligibility_end_reason ='DR' OR ce_dr.disenrl_dr_min_created_on IS NOT NULL) AND ce_future_elig.core_eligibility_segments_id IS NOT NULL)
        OR ((ce.eligibility_end_reason = '8X' OR ce_8x.disenrl_8x_min_created_on IS NOT NULL) AND enrl.enrollment_id IS NULL AND ce_future_elig.core_eligibility_segments_id IS NOT NULL) 
      THEN COALESCE(ce_dr.disenrl_dr_min_created_on,ce_8x.disenrl_8x_min_created_on,ce.eligibility_created_on) ELSE NULL END disenroll_reason_created_on_date,  
 CASE WHEN (ce.eligibility_end_reason IN('DR') OR ce_dr.disenrl_dr_min_created_on IS NOT NULL) AND ce_future_elig.core_eligibility_segments_id IS NOT NULL THEN 'Member eligible with DR disenrollment code'
      WHEN (ce.eligibility_end_reason IN('8X') OR ce_8x.disenrl_8x_min_created_on IS NOT NULL) AND enrl.enrollment_id IS NULL AND ce_future_elig.core_eligibility_segments_id IS NOT NULL THEN 'Member eligible with 8X disenrollment code'
      WHEN ce.coverage_code IN ('820C','222') AND ce_future_elig.core_eligibility_segments_id IS NOT NULL AND consumer_age >= 19 THEN 'Overage for SCHIP (>=19)'
      WHEN ce.coverage_code IN ('420') AND ce_future_elig.core_eligibility_segments_id IS NOT NULL AND consumer_age >= 21 THEN 'Overage for Immigrant Children (>=21)'      
      WHEN ce.coverage_code IN ('470') AND ce_future_elig.core_eligibility_segments_id IS NOT NULL AND consumer_age < 21 THEN 'Underage for Alliance (<21)'
      WHEN ce.coverage_code IN ('774D','271','774') AND ce_future_elig.core_eligibility_segments_id IS NOT NULL AND consumer_age >= 65 THEN 'Overage for Adult Medicaid (>=65), program codes 271, 774, 774D'
      WHEN ce.coverage_code IN ('221','720','921','120') AND ce_future_elig.core_eligibility_segments_id IS NOT NULL AND consumer_age >= 21 THEN 'Overage for Child Medicaid (>=21)'
      WHEN CAST(ce.eligibility_start_date AS DATE) >= ADD_MONTHS(LAST_DAY(current_date()),3) +1 AND ce_future_elig.core_eligibility_segments_id IS NULL THEN 'Future eligibility w/o current'
   ELSE NULL END esa_reason,
 CASE WHEN coverage_code_label = 'Deemed Newborn' THEN 
   CASE WHEN sub_program_type_cd LIKE '%ALL%' THEN 'Alliance' ELSE 'Medicaid' END 
  ELSE NULL END newborn_elig_type, 
 CASE WHEN coverage_code_label = 'Deemed Newborn' THEN 
   CASE WHEN sub_program_type_cd LIKE '%ALL%' THEN
     CASE WHEN DATE_PART(day,ce.consumer_date_of_birth) > 15 
        THEN ADD_MONTHS(LAST_DAY(ce.consumer_date_of_birth),1) +1
     ELSE LAST_DAY(ce.consumer_date_of_birth) + 1  END                            
   ELSE ce.consumer_date_of_birth END 
 ELSE NULL END newborn_calculated_enroll_start_date,
 CASE WHEN ce_current_elig.core_eligibility_segments_id IS NULL THEN 'N' ELSE 'Y' END current_elig_ind
FROM ce 
  LEFT JOIN claddr csaddr ON ce.case_hoh_consumer_id = csaddr.external_ref_id AND ce.project_id = csaddr.project_id  
  LEFT JOIN claddr ON ce.consumer_id = claddr.external_ref_id AND ce.project_id = claddr.project_id
  LEFT JOIN clphn ON ce.consumer_id = clphn.external_ref_id AND ce.project_id = clphn.project_id
  LEFT JOIN clphn csphn ON ce.case_hoh_consumer_id = csphn.external_ref_id AND ce.project_id = csphn.project_id
 -- LEFT JOIN (SELECT * FROM enrl WHERE enroll_status = 'ACCEPTED') enrl ON ce.consumer_id = enrl.consumer_id AND ce.project_id = enrl.project_id AND enrl.start_date BETWEEN ce.eligibility_start_date AND ce.eligibility_end_date
 LEFT JOIN (SELECT enrl.project_id,enrl.enrollment_id,enrl.consumer_id,enrl.start_date,enrl.end_date,enrl.txn_status_date,
               enrl.plan_code,pnvw.report_label plan_name,created_on_date,enrl.enroll_status ,plan_end_date_reason,disenroll_created_on_date
             FROM enrl 
               LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON enrl.plan_code = pnvw.value AND enrl.project_id = pnvw.project_id               
             QUALIFY ROW_NUMBER() OVER (PARTITION BY consumer_id ORDER BY enrollment_id DESC) = 1) enrl ON ce.consumer_id = enrl.consumer_id AND ce.project_id = enrl.project_id
 LEFT JOIN ce_dr ON ce.consumer_id = ce_dr.consumer_id AND ce.project_id = ce_dr.project_id 
 LEFT JOIN ce_8x ON ce.consumer_id = ce_8x.consumer_id AND ce.project_id = ce_8x.project_id 
 LEFT JOIN ce_future_elig ON ce.consumer_id = ce_future_elig.consumer_id AND ce.project_id = ce_future_elig.project_id
 LEFT JOIN ce_current_elig ON ce.consumer_id = ce_current_elig.consumer_id AND ce.project_id = ce_current_elig.project_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY ce.consumer_id,ce.core_eligibility_segments_id ORDER BY ce.core_eligibility_segments_id, enrl.start_date DESC,enrl.enrollment_id DESC) = 1
;