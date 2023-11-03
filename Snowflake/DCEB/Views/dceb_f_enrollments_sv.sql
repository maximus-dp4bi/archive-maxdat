CREATE OR REPLACE VIEW dceb.dceb_f_enrollments_sv AS
WITH enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code,CASE WHEN disenrl.enrollment_id IS NOT NULL THEN 'T' ELSE 'N' END transfer_or_new_enroll
   ,CAST(enrl.created_on AS DATE) created_on_date   
   ,CASE WHEN enrl.channel = 'SYSTEM_INTEGRATION' AND disenrl.channel = 'SYSTEM_INTEGRATION' THEN 'MMIS_TRANSFER'  ELSE enrl.channel END channel   
FROM marsdb.marsdb_enrollments_vw enrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date 
    AND disenrl.status = 'DISENROLLED' --AND (disenrl.plan_end_date_reason IS NOT NULL OR (enrl.channel = 'SYSTEM_INTEGRATION' AND disenrl.channel = 'SYSTEM_INTEGRATION' ) )
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED')
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
UNION ALL
SELECT disenrl.project_id,disenrl.enrollment_id, disenrl.consumer_id, disenrl.start_date, disenrl.end_date,disenrl.status, CAST(disenrl.txn_status_date AS DATE) txn_status_date
   ,disenrl.plan_code,disenrl.enrollment_type,disenrl.sub_program_type_cd,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,disenrl.service_region_code,'D' transfer_or_new_enroll
   ,CAST(disenrl.created_on AS DATE) created_on_date
   ,channel 
FROM marsdb.marsdb_enrollments_vw disenrl
  JOIN marsdb.marsdb_project_vw p ON p.project_id = disenrl.project_id
WHERE p.project_name = 'DC-EB'
AND disenrl.status = 'DISENROLLED'
AND NOT EXISTS(SELECT 1 FROM marsdb.marsdb_enrollments_vw enrl WHERE disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND enrl.status IN('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE'))
)
SELECT evw.project_id,
evw.sub_program_type_cd,
stvw.report_label sub_program_type,
evw.start_date,
evw.end_date,
evw.txn_status_date,
evw.enrollment_type,
evw.plan_code,
pnvw.report_label plan_name,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' THEN evw.consumer_id ELSE NULL END) new_enrollment_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' THEN evw.consumer_id ELSE NULL END) transfer_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION') THEN evw.consumer_id ELSE NULL END) transfer_auto_assign_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION') THEN evw.consumer_id ELSE NULL END) new_enroll_auto_assign_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') THEN evw.consumer_id ELSE NULL END) transfer_voluntary_choice_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION') THEN evw.consumer_id ELSE NULL END) new_enroll_voluntary_choice_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel IN('MMIS_TRANSFER') THEN evw.consumer_id ELSE NULL END) transfer_mmis_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel = 'AUTO_ASSIGNMENT' AND baddr.address_id IS NOT NULL THEN evw.consumer_id ELSE NULL END ) transfer_bad_address_exclusion,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel = 'AUTO_ASSIGNMENT' AND baddr.address_id IS NOT NULL THEN evw.consumer_id ELSE NULL END ) new_enroll_bad_address_exclusion,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel = 'AUTO_ASSIGNMENT' AND bp.phone_id IS NOT NULL THEN evw.consumer_id ELSE NULL END ) transfer_bad_phone_exclusion,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel = 'AUTO_ASSIGNMENT' AND bp.phone_id IS NOT NULL THEN evw.consumer_id ELSE NULL END ) new_enroll_bad_phone_exclusion,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel = 'AUTO_ASSIGNMENT' AND ccvw.core_eligibility_segments_id IS NOT NULL THEN evw.consumer_id ELSE NULL END ) transfer_newborn_exclusion,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel = 'AUTO_ASSIGNMENT' AND ccvw.core_eligibility_segments_id IS NOT NULL THEN evw.consumer_id ELSE NULL END ) new_enroll_newborn_exclusion,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel = 'PHONE' THEN evw.consumer_id ELSE NULL END) transfer_phone_enrollment_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel = 'PHONE' THEN evw.consumer_id ELSE NULL END) new_enroll_phone_enrollment_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel = 'WEB' THEN evw.consumer_id ELSE NULL END) transfer_web_enrollment_count,  
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel = 'WEB' THEN evw.consumer_id ELSE NULL END) new_enroll_web_enrollment_count,  
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel = 'SELECTION_FROM_IN_MAIL' THEN evw.consumer_id ELSE NULL END) transfer_mail_enrollment_count,  
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel = 'SELECTION_FROM_IN_MAIL' THEN evw.consumer_id ELSE NULL END) new_enroll_mail_enrollment_count,  
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel = 'OUTREACH' THEN evw.consumer_id ELSE NULL END) transfer_outreach_enrollment_count,    
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel = 'OUTREACH' THEN evw.consumer_id ELSE NULL END) new_enroll_outreach_enrollment_count,   
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel NOT IN('PHONE','WEB','SELECTION_FROM_IN_MAIL','OUTREACH','AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  THEN evw.consumer_id ELSE NULL END) transfer_other_enrollment_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel NOT IN('PHONE','WEB','SELECTION_FROM_IN_MAIL','OUTREACH','AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  THEN evw.consumer_id ELSE NULL END) new_enroll_other_enrollment_count,          
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  AND UPPER(service_region_code) = 'NORTHWEST' THEN evw.consumer_id ELSE NULL END) qnorthwest_voluntary_transfer_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  AND UPPER(service_region_code) = 'NORTHEAST' THEN evw.consumer_id ELSE NULL END) qnortheast_voluntary_transfer_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  AND UPPER(service_region_code) = 'SOUTHWEST' THEN evw.consumer_id ELSE NULL END) qsouthwest_voluntary_transfer_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'T' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  AND UPPER(service_region_code) = 'SOUTHEAST' THEN  evw.consumer_id ELSE NULL END)  qsoutheast_voluntary_transfer_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER')
  AND UPPER(service_region_code) = 'NORTHWEST' THEN evw.consumer_id ELSE NULL END) qnorthwest_voluntary_newenroll_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  AND UPPER(service_region_code) = 'NORTHEAST' THEN evw.consumer_id ELSE NULL END) qnortheast_voluntary_newenroll_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER')
  AND UPPER(service_region_code) = 'SOUTHWEST' THEN evw.consumer_id ELSE NULL END) qsouthwest_voluntary_newenroll_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'N' AND evw.channel NOT IN('AUTO_ASSIGNMENT','SYSTEM_INTEGRATION','MMIS_TRANSFER') 
  AND UPPER(service_region_code) = 'SOUTHEAST' THEN evw.consumer_id ELSE NULL END)  qsoutheast_voluntary_newenroll_count,
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'D' AND evw.channel IN('SYSTEM_INTEGRATION') THEN evw.consumer_id ELSE NULL END) disenrollment_mmis_count,  
COUNT (DISTINCT CASE WHEN evw.transfer_or_new_enroll = 'D' THEN evw.consumer_id ELSE NULL END) disenrollment_count,
created_on_date
FROM enrl evw     
  LEFT JOIN marsdb.marsdb_consumer_vw cnvw ON evw.consumer_id = cnvw.consumer_id AND evw.project_id = cnvw.project_id
  LEFT JOIN marsdb.marsdb_enum_sub_program_type_vw stvw ON evw.sub_program_type_cd = stvw.value AND evw.project_id = stvw.project_id
  LEFT JOIN marsdb.marsdb_enum_enrollment_update_reasons_vw uvw ON evw.plan_end_date_reason = uvw.value AND evw.project_id = uvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_selection_channels_vw cvw ON evw.channel = cvw.value AND evw.project_id = cvw.project_id
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON evw.plan_code = pnvw.value AND evw.project_id = pnvw.project_id  
  LEFT JOIN (SELECT ce.consumer_id,enr.enrollment_id,enr.project_id, ce.core_eligibility_segments_id,ce.coverage_code
             FROM marsdb.marsdb_core_eligibility_vw ce
                JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
               JOIN marsdb.marsdb_enrollments_vw enr ON ce.consumer_id = enr.consumer_id AND ce.project_id = enr.project_id AND enr.txn_status_date BETWEEN ce.start_date AND ce.end_date
             WHERE p.project_name = 'DC-EB'
             AND coverage_code = '221B'
             QUALIFY ROW_NUMBER() OVER(PARTITION BY ce.consumer_id,enr.enrollment_id ORDER BY ce.end_date DESC NULLS FIRST,ce.core_eligibility_segments_id DESC) = 1) ccvw ON ccvw.enrollment_id = evw.enrollment_id AND ccvw.project_id = evw.project_id
  LEFT JOIN (SELECT b.address_id,b.external_ref_type,b.external_ref_id,b.project_id
             FROM  (SELECT *
                    FROM (SELECT b.*,co.external_ref_type,co.external_ref_id  
                          FROM marsdb.marsdb_address_vw b  
                            JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
                            JOIN marsdb.marsdb_contacts_owner_vw co ON b.address_id = co.contact_owner_id AND co.project_id = b.project_id 
                          WHERE p.project_name = 'DC-EB'
                          AND b.address_type = 'Mailing'
                          AND UPPER(co.external_ref_type) = 'CONSUMER'
                          QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY b.effective_end_date DESC NULLS FIRST,address_id DESC ) =1) b
             WHERE (b.address_street_1 = ('                      0')
              OR b.address_street_1 like '899 N%Capitol%' 
              OR b.address_street_1 like '3851 ALABAMA%'
              OR replace(b.address_street_1,'.',' ') like '645 H %'
              OR b.address_street_1 like '1207 Taylor%'
              OR b.address_street_1 like '2100%M%L%K%'
              OR b.address_street_1 like '4001 S%Capitol%'
              OR b.address_street_1 like '425 Mitch%Snyder%'
              OR b.address_street_1 like '1900 Mass%'
              OR b.address_street_1 like '1234 Mass%'
              OR b.address_street_1 like '425 2nd%'
              OR b.address_street_1 like '425 Second%'
              OR b.address_street_1 like '1355 N%Y%'
              OR b.address_street_1 like '1448 Park%'
              OR b.address_street_1 like '1200 N%Capitol%' 
			  OR replace(b.address_street_1,'.',' ') like '1430 G %'
			  OR b.address_street_1 like '2840 Langston%'
			  OR b.address_street_1 like '2844 Langston%'
			  OR b.address_street_1 like '2850 Langston%'
			  OR b.address_street_1 like '2700 N%Y%'
			  OR b.address_street_1 like '2700 M%L%K%'
			  OR b.address_street_1 like '1910 Mass%'
			  OR b.address_street_1 like '1600 N%Y%'
              OR replace(b.address_street_1,'.',' ') like '609 H%'
			  OR b.address_street_1 like '4049 S%Cap%' ) ) b ) baddr ON evw.consumer_id = baddr.external_ref_id AND evw.project_id = baddr.project_id
  LEFT JOIN(SELECT *
            FROM(SELECT p.*,co.external_ref_type,co.external_ref_id  
                 FROM marsdb.marsdb_phone_vw p  
                   JOIN marsdb.marsdb_project_vw pr ON p.project_id = p.project_id
                   JOIN marsdb.marsdb_contacts_owner_vw co ON p.phone_id = co.contact_owner_id AND co.project_id = p.project_id 
                 WHERE pr.project_name = 'DC-EB'
                 AND UPPER(co.external_ref_type) = 'CONSUMER'
                 QUALIFY ROW_NUMBER() OVER(PARTITION BY co.external_ref_id ORDER BY p.effective_end_date DESC NULLS FIRST,phone_id DESC ) =1) p
             WHERE (SUBSTR(p.phone_number,1,1) = '0' OR LENGTH(RTRIM(LTRIM(p.phone_number))) < 10)) bp ON evw.consumer_id = bp.external_ref_id AND evw.project_id = bp.project_id
GROUP BY evw.project_id,
evw.sub_program_type_cd,
stvw.report_label,
evw.start_date,
evw.end_date,
evw.txn_status_date,
evw.enrollment_type,
evw.plan_code,
pnvw.report_label,
evw.created_on_date
UNION ALL
SELECT stvw.project_id,
stvw.value sub_program_type_cd,
stvw.report_label sub_program_type,
NULL start_date,
NULL end_date,
d_date txn_status_date,
'MEDICAL' enrollment_type,
pnvw.value plan_code,
pnvw.report_label plan_name,
0 new_enrollment_count,
0 transfer_count,
0 transfer_auto_assign_count,
0 new_enroll_auto_assign_count,
0 transfer_voluntary_choice_count,
0 new_enroll_voluntary_choice_count,
0 transfer_mmis_count,
0 transfer_bad_address_exclusion,
0 new_enroll_bad_address_exclusion,
0 transfer_bad_phone_exclusion,
0 new_enroll_bad_phone_exclusion,
0 transfer_newborn_exclusion,
0 new_enroll_newborn_exclusion,
0 transfer_phone_enrollment_count,
0 new_enroll_phone_enrollment_count,
0 transfer_web_enrollment_count,  
0 new_enroll_web_enrollment_count,  
0 transfer_mail_enrollment_count,  
0 new_enroll_mail_enrollment_count,  
0 transfer_outreach_enrollment_count,    
0 new_enroll_outreach_enrollment_count,   
0 transfer_other_enrollment_count,
0 new_enroll_other_enrollment_count,          
0 qnorthwest_voluntary_transfer_count,
0 qnortheast_voluntary_transfer_count,
0 qsouthwest_voluntary_transfer_count,
0 qsoutheast_voluntary_transfer_count,
0 qnorthwest_voluntary_newenroll_count,
0 qnortheast_voluntary_newenroll_count,
0 qsouthwest_voluntary_newenroll_count,
0 qsoutheast_voluntary_newenroll_count,
0 disenrollment_mmis_count,  
0 disenrollment_count,
d_date created_on_date
FROM public.d_dates d
   JOIN marsdb.marsdb_project_vw p ON p.project_id = d.project_id
   JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) stvw ON d.project_id = stvw.project_id
   JOIN marsdb.marsdb_enum_plan_name_vw pnvw ON d.project_id = pnvw.project_id AND stvw.value = pnvw.scope
   --JOIN marsdb.marsdb_enum_enrollment_type_vw etvw ON d.project_id = etvw.project_id 
WHERE p.project_name = 'DC-EB'
AND d_date >= current_date() - 365
AND d_date <= current_date()
AND plan_code != 'Dummy';