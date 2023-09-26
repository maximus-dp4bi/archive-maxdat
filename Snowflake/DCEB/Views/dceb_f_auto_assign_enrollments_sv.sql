CREATE OR REPLACE VIEW dceb.dceb_f_auto_assign_enrollments_sv
AS	
WITH ce AS(
SELECT ce.project_id,ce.core_eligibility_segments_id,ce.consumer_id,ce.coverage_code,cc.report_label coverage_code_label,
 ce.eligibility_end_reason,ce.eligibility_status_code,ce.start_date eligibility_start_date,ce.end_date eligibility_end_date,ce.sub_program_type_cd,
 sp.report_label sub_program_type,CAST(ce.created_on AS DATE) eligibility_created_on,cbvw.population program_population,enrollment_scenario
FROM marsdb.marsdb_core_eligibility_vw ce
  JOIN marsdb.marsdb_project_vw p ON p.project_id = ce.project_id
  LEFT JOIN (SELECT b.project_id,consumer_id,population,enrollment_scenario
             FROM marsdb.marsdb_consumer_benefit_status_vw b
               JOIN marsdb.marsdb_project_vw p ON p.project_id = b.project_id
             WHERE p.project_name = 'DC-EB'
             QUALIFY ROW_NUMBER() OVER(PARTITION BY consumer_id ORDER BY consumer_benefit_status_id DESC) =1 ) cbvw ON ce.consumer_id = cbvw.consumer_id AND ce.project_id = cbvw.project_id
  LEFT JOIN marsdb.marsdb_enum_coverage_code_vw cc ON ce.coverage_code = cc.value AND ce.project_id = cc.project_id
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON ce.sub_program_type_cd = sp.value AND ce.project_id = sp.project_id 
WHERE p.project_name = 'DC-EB'
AND ce.start_date != ce.end_date
QUALIFY ROW_NUMBER() OVER(PARTITION BY ce.consumer_id ORDER BY ce.core_eligibility_segments_id DESC) = 1),
enrl AS(
SELECT enrl.project_id,enrl.enrollment_id, enrl.consumer_id, enrl.start_date, enrl.end_date,enrl.status, CAST(enrl.txn_status_date AS DATE) txn_status_date
   ,enrl.plan_code,enrl.enrollment_type,enrl.sub_program_type_cd,enrl.channel,disenrl.enrollment_id disenrl_enrollment_id,disenrl.plan_end_date_reason
   ,enrl.service_region_code
   ,CASE WHEN enrl.status IN('SELECTION_MADE','SUBMITTED_TO_STATE') THEN 'Pending_AA'
         ELSE 'Confirmed_AA' END assignment_status
   ,CAST(enrl.created_on AS DATE) created_on_date
   ,disenrl.plan_code transfer_from_plan_code   
   ,CASE WHEN UPPER(ce.program_population) IN ('DCHF-CHILD','ALLIANCE-CHILD') AND enrl.selection_reason = 'NEWBORN_DEFAULT' 
           AND FLOOR(MONTHS_BETWEEN(CAST(enrl.created_on AS DATE), CAST(cnvw.consumer_date_of_birth AS DATE))) < 12 THEN 'Newborn'
         WHEN enrl.selection_reason IN('Round Robin','ROUND_ROBIN') THEN 'Random'
         WHEN enrl.selection_reason IN('Family Plan','FAMILY_PLAN') THEN 'Assigned to same plan as family members'         
      ELSE enrl.selection_reason END assignment_type,
      enrl.selection_reason    
FROM marsdb.marsdb_enrollments_vw enrl
  LEFT JOIN marsdb.marsdb_enrollments_vw disenrl ON disenrl.project_id = enrl.project_id AND disenrl.consumer_id = enrl.consumer_id AND disenrl.end_date + 1 = enrl.start_date AND disenrl.status LIKE 'DISENR%' AND disenrl.plan_end_date_reason IS NOT NULL
  LEFT JOIN ce ON enrl.consumer_id = ce.consumer_id AND enrl.project_id = ce.project_id 
  LEFT JOIN marsdb.marsdb_consumer_vw cnvw ON enrl.consumer_id = cnvw.consumer_id AND enrl.project_id = cnvw.project_id
  JOIN marsdb.marsdb_project_vw p ON p.project_id = enrl.project_id  
WHERE p.project_name = 'DC-EB'
AND enrl.status IN('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE')
AND enrl.channel = 'AUTO_ASSIGNMENT'
QUALIFY ROW_NUMBER() OVER(PARTITION BY enrl.project_id, enrl.enrollment_id,enrl.start_date,enrl.end_date ORDER BY enrl.enrollment_id,disenrl.enrollment_id) = 1
),
aapp AS(
SELECT aa.project_id,sub_program_type_code, spvw.report_label sub_program_type, plan_code,pvw.report_label plan_name,plan_percentage,
  CASE WHEN tsvw.value IN('SELECTION_MADE','SUBMITTED_TO_STATE') THEN 'Pending_AA'
                   ELSE 'Confirmed_AA' END assignment_status,
                CASE WHEN srvw.value IN('ROUND_ROBIN') THEN 'Random'
                     WHEN srvw.value IN('FAMILY_PLAN') THEN 'Assigned to same plan as family members'
                     WHEN srvw.value IN('NEWBORN_DEFAULT') THEN 'Newborn' ELSE NULL END assignment_type
FROM marsdb.marsdb_auto_assignment_plan_percentage_configuration_vw aa
  JOIN marsdb.marsdb_enum_sub_program_type_vw spvw ON aa.sub_program_type_code = spvw.value
  JOIN marsdb.marsdb_project_vw p ON p.project_id = aa.project_id  
  JOIN marsdb.marsdb_enum_plan_name_vw pvw ON aa.plan_code = pvw.value
  JOIN (SELECT value,report_label,project_id
        FROM marsdb.marsdb_enum_plan_selection_reasons_vw srvw 
        WHERE srvw.value IN('ROUND_ROBIN','FAMILY_PLAN')
        UNION ALL
        SELECT 'NEWBORN_DEFAULT','Newborn',project_id
        FROM marsdb.marsdb_project_vw p
        WHERE p.project_name = 'DC-EB') srvw ON srvw.project_id = aa.project_id
  JOIN marsdb.marsdb_enum_transaction_status_vw tsvw ON tsvw.project_id = aa.project_id AND tsvw.value IN('SELECTION_MADE','SUBMITTED_TO_STATE','ACCEPTED')
WHERE p.project_name = 'DC-EB'    
),
aa AS(
SELECT d_date,aapp.project_id,aapp.sub_program_type_code,aapp.sub_program_type, aapp.plan_code,aapp.plan_name,aapp.plan_percentage,
  aapp.assignment_type,
  aapp.assignment_status,
  COUNT(DISTINCT CASE WHEN created_on_date >= DATE_TRUNC(MONTH,d_date) AND created_on_date <= d_date THEN consumer_id ELSE NULL END) enrollment_count,
  COUNT(DISTINCT CASE WHEN created_on_date = d_date THEN consumer_id ELSE NULL END) ddate_enrollment_count
FROM public.d_dates d
  JOIN aapp ON d.project_id = aapp.project_id 
  LEFT JOIN enrl ON enrl.sub_program_type_cd = aapp.sub_program_type_code AND enrl.project_id = aapp.project_id AND enrl.plan_code = aapp.plan_code 
    AND enrl.assignment_status = aapp.assignment_status AND enrl.assignment_type = aapp.assignment_type  
WHERE d_date >= current_date() - 190
AND d_date <= current_date()  
GROUP BY d_date,aapp.project_id,aapp.sub_program_type_code, aapp.sub_program_type,aapp.plan_code,aapp.plan_name,aapp.plan_percentage,aapp.assignment_type,aapp.assignment_status )
SELECT d_date,project_id,sub_program_type_code,sub_program_type,plan_code,plan_name,plan_percentage,
    assignment_status,assignment_type,
    SUM (enrollment_count) enrollment_count,
    SUM(ddate_enrollment_count) ddate_enrollment_count
FROM aa  
GROUP BY d_date,project_id,sub_program_type_code,sub_program_type,plan_code,plan_name,plan_percentage,
    assignment_status,assignment_type
;