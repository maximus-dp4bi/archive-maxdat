CREATE OR REPLACE VIEW dceb.dceb_d_ltc_opt_out_consumers_sv
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
clphn AS(SELECT p.*,co.external_ref_type,co.external_ref_id                   
                 FROM marsdb.marsdb_phone_vw p  
                   JOIN marsdb.marsdb_contacts_owner_vw co ON p.phone_id = co.contact_owner_id AND co.project_id = p.project_id 
                   JOIN marsdb.marsdb_project_vw pr ON pr.project_id = p.project_id
                 WHERE pr.project_name = 'DC-EB'
                 AND UPPER(co.external_ref_type) = 'CONSUMER'
                 AND p.phone_type = 'Home'
                 QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY p.effective_end_date DESC NULLS FIRST,phone_id DESC ) =1),
ce AS(
SELECT ce.project_id,ce.core_eligibility_segments_id,ce.consumer_id,ce.coverage_code,cc.report_label coverage_code_label,
 ce.eligibility_end_reason,ce.eligibility_status_code,ce.start_date eligibility_start_date,ce.end_date eligibility_end_date,ce.sub_program_type_cd,
 sp.report_label sub_program_type,CAST(ce.created_on AS DATE) eligibility_created_on,cbvw.population program_population,
 ce.eligibility_end_reason opt_out_code, 
 ervw.report_label opt_out_description,
 CASE WHEN DATE_PART(DAY,current_date()) <= 15 THEN DATEADD(MONTH,1,DATE_TRUNC(MONTH,current_date()))
   ELSE DATEADD(MONTH,2,DATE_TRUNC(MONTH,current_date())) END elig_month
FROM marsdb.marsdb_core_eligibility_vw ce
  JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
  JOIN (SELECT b.project_id,consumer_id,population
        FROM marsdb.marsdb_consumer_benefit_status_vw b
          JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
        WHERE p.project_name = 'DC-EB'
        QUALIFY ROW_NUMBER() OVER(PARTITION BY consumer_id ORDER BY consumer_benefit_status_id DESC) =1 ) cbvw ON ce.consumer_id = cbvw.consumer_id AND ce.project_id = cbvw.project_id
  JOIN marsdb.marsdb_enum_coverage_code_vw cc ON ce.coverage_code = cc.value AND ce.project_id = cc.project_id
  JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON ce.sub_program_type_cd = sp.value AND ce.project_id = sp.project_id 
  JOIN marsdb.marsdb_enum_enrollment_update_reasons_vw ervw ON ce.eligibility_end_reason = ervw.value AND ce.project_id = ervw.project_id
WHERE p.project_name = 'DC-EB'
AND ce.start_date != ce.end_date
AND UPPER(cbvw.population) LIKE '%FEE FOR SERVICE%'
AND ce.eligibility_end_reason IN ('1F','3E','RH','LT')
QUALIFY ROW_NUMBER() OVER(PARTITION BY ce.consumer_id ORDER BY ce.core_eligibility_segments_id DESC) = 1)
SELECT cldtl.consumer_id,
 cldtl.medical_assistance_id,
 cldtl.case_number,
 cldtl.consumer_first_name,
 cldtl.consumer_last_name,
 cldtl.consumer_date_of_birth,
 clphn.phone_number,
 'Fee for Service' current_status,
 ce.opt_out_code,
 ce.opt_out_description,
 ce.coverage_code recipient_program_code,
 ce.eligibility_start_date,
 ce.eligibility_end_date
FROM ce
  JOIN marsdb.marsdb_project_vw p ON ce.project_id = p.project_id
  JOIN cldtl ON ce.consumer_id = cldtl.consumer_id AND ce.project_id = cldtl.project_id
  LEFT JOIN clphn ON cldtl.consumer_id = clphn.external_ref_id AND cldtl.project_id = clphn.project_id
 WHERE p.project_name = 'DC-EB'
 AND ce.elig_month BETWEEN ce.eligibility_start_date AND ce.eligibility_end_date;