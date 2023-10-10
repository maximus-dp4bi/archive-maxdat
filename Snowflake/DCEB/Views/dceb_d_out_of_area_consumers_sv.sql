CREATE OR REPLACE VIEW dceb.dceb_d_out_of_area_consumers_sv 
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
claddr AS(
SELECT b.*,co.external_ref_type,co.external_ref_id,
  CASE WHEN zvw.zipcode IS NULL AND b.address_state = 'DC' THEN 'Non-DC Zip Code'
       WHEN b.address_state != 'DC' THEN 'Non-DC State Code'
    ELSE NULL END out_of_area_reason
FROM marsdb.marsdb_address_vw b                      
  JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
  JOIN marsdb.marsdb_contacts_vw ct ON b.contact_type_id = ct.contact_type_id AND b.project_id = ct.project_id
  JOIN marsdb.marsdb_contacts_owner_vw co ON ct.owner_id = co.contact_owner_id AND ct.project_id = co.project_id   
  LEFT JOIN marsdb.marsdb_zipcode_vw zvw ON b.address_zip = zvw.zipcode AND b.project_id = zvw.project_id  
WHERE p.project_name = 'DC-EB'
AND b.address_type = 'Physical'
AND UPPER(co.external_ref_type) = 'CONSUMER'                          
QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY b.effective_end_date DESC NULLS FIRST,address_id DESC ) =1),
enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code,CASE WHEN disenrl.enrollment_id IS NOT NULL THEN 'T' ELSE 'N' END transfer_or_new_enroll
   ,CAST(enrl.created_on AS DATE) created_on_date
FROM marsdb.marsdb_enrollments_vw enrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND disenrl.status LIKE 'DISENR%' AND disenrl.plan_end_date_reason IS NOT NULL
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED')
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
UNION ALL
SELECT disenrl.project_id,disenrl.enrollment_id, disenrl.consumer_id, disenrl.start_date, disenrl.end_date,disenrl.status, CAST(disenrl.txn_status_date AS DATE) txn_status_date
   ,disenrl.plan_code,disenrl.enrollment_type,disenrl.sub_program_type_cd,disenrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,disenrl.service_region_code,'D' transfer_or_new_enroll
   ,CAST(disenrl.created_on AS DATE) created_on_date
FROM marsdb.marsdb_enrollments_vw disenrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = disenrl.project_id
WHERE p.project_name = 'DC-EB'
AND disenrl.status = 'DISENROLLED'
AND NOT EXISTS(SELECT 1 FROM marsdb.marsdb_enrollments_vw enrl WHERE disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND enrl.status IN('ACCEPTED'))
),
ce AS(
SELECT ce.project_id,ce.core_eligibility_segments_id,ce.consumer_id,ce.coverage_code,cc.report_label coverage_code_label,
 ce.eligibility_end_reason,ce.eligibility_status_code,ce.start_date eligibility_start_date,ce.end_date eligibility_end_date,ce.sub_program_type_cd,
 sp.report_label sub_program_type,CAST(ce.created_on AS DATE) eligibility_created_on,cbvw.population program_population
FROM marsdb.marsdb_core_eligibility_vw ce
  JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
  LEFT JOIN (SELECT b.project_id,consumer_id,population
             FROM marsdb.marsdb_consumer_benefit_status_vw b
               JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
             WHERE p.project_name = 'DC-EB'
             QUALIFY ROW_NUMBER() OVER(PARTITION BY consumer_id ORDER BY consumer_benefit_status_id DESC) =1 ) cbvw ON ce.consumer_id = cbvw.consumer_id AND ce.project_id = cbvw.project_id
  LEFT JOIN marsdb.marsdb_enum_coverage_code_vw cc ON ce.coverage_code = cc.value AND ce.project_id = cc.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON ce.sub_program_type_cd = sp.value AND ce.project_id = sp.project_id 
WHERE p.project_name = 'DC-EB'
AND ce.start_date != ce.end_date
QUALIFY ROW_NUMBER() OVER(PARTITION BY ce.consumer_id ORDER BY ce.core_eligibility_segments_id DESC) = 1)
SELECT
  cldtl.medical_assistance_id,
  CASE WHEN UPPER(ce.program_population) LIKE '%FEE FOR SERVICE%' THEN 'Fee For Service'  
       WHEN enrl.enrollment_id IS NOT NULL AND enrl.enroll_status = 'ACCEPTED' THEN 'Enrolled' 
       WHEN enrl.enrollment_id IS NOT NULL AND enrl.enroll_status = 'DISENROLLED' THEN 'Not Enrolled'    
    ELSE 'New' END enrollment_status,
  enrl.plan_name,
  enrl.plan_code,  
  COALESCE(csaddr.address_street_1,claddr.address_street_1) address_street_1,
  COALESCE(csaddr.address_street_2,claddr.address_street_2) address_street_2,
  COALESCE(csaddr.address_city,claddr.address_city) address_city,
  COALESCE(csaddr.address_state,claddr.address_state) address_state,
  COALESCE(csaddr.address_zip,claddr.address_zip) address_zip,
  COALESCE(csaddr.address_zip_four,claddr.address_zip_four) address_zip_four,
  COALESCE(csaddr.address_county,claddr.address_county) address_county, 
  COALESCE(csaddr.out_of_area_reason,claddr.out_of_area_reason) out_of_area_reason
FROM cldtl 
JOIN ce ON cldtl.consumer_id = ce.consumer_id AND cldtl.project_id = ce.project_id  
LEFT JOIN cldtl hoh ON cldtl.case_id = hoh.case_id AND cldtl.project_id = hoh.project_id AND hoh.consumer_role = 'Primary Individual'
LEFT JOIN claddr ON cldtl.consumer_id = claddr.external_ref_id AND cldtl.project_id = claddr.project_id
LEFT JOIN claddr csaddr ON hoh.consumer_id = csaddr.external_ref_id AND hoh.project_id = csaddr.project_id
LEFT JOIN (SELECT enrl.project_id,enrl.enrollment_id,enrl.consumer_id,enrl.start_date,enrl.end_date,enrl.txn_status_date,
               enrl.plan_code,pnvw.report_label plan_name,created_on_date,enrl.status enroll_status   
             FROM enrl 
               LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON enrl.plan_code = pnvw.value AND enrl.project_id = pnvw.project_id               
             QUALIFY ROW_NUMBER() OVER (PARTITION BY consumer_id ORDER BY enrollment_id DESC) = 1) enrl 
  ON cldtl.consumer_id = enrl.consumer_id AND cldtl.project_id = enrl.project_id
WHERE COALESCE(csaddr.out_of_area_reason,claddr.out_of_area_reason) IS NOT NULL
AND (enrl.enroll_status IS NULL OR enrl.enroll_status != 'DISENROLLED')
;