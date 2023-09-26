CREATE OR REPLACE VIEW dceb.dceb_d_provider_capacity_sv
AS
SELECT pn.first_name||' '||pn.last_name as provider_name
      ,pn.plan_name
      ,ptvw.provider_type_cd
      ,etvw.report_label provider_type
      ,pn.pcp_flag
      ,ppl.enrolled_count as cumulative_enrolled -- this needs to be a numeric in the view
      ,2000 as capacity -- this needs to be a numeric value in the view
FROM marsdb.marsdb_provider_network_vw pn
  LEFT JOIN marsdb.marsdb_provider_panel_limit_vw ppl ON (pn.plan_provider_id = ppl.plan_provider_id and pn.project_id = ppl.project_id)
  LEFT JOIN  marsdb.marsdb_provider_type_vw ptvw ON pn.plan_provider_id = ptvw.plan_provider_id
  LEFT JOIN marsdb.marsdb_enum_provider_type_vw etvw ON ptvw.provider_type_cd = etvw.value
  JOIN marsdb.marsdb_project_vw p ON (p.project_id = pn.project_id)
WHERE p.project_name = 'DC-EB';

CREATE OR REPLACE VIEW dceb.dceb_f_plan_enrollments_sv
AS
SELECT enrl.sub_program_type_cd, enrl.start_date, enrl.end_date, enrl.plan_code, pn.report_label plan_name, COUNT(DISTINCT enrl.consumer_id) plan_enrolled_count
FROM (SELECT * FROM marsdb.marsdb_enrollments_vw 
      QUALIFY ROW_NUMBER() OVER (PARTITION BY sub_program_type_cd, start_date, plan_code,status,consumer_id ORDER BY enrollment_id DESC) = 1) enrl  
  JOIN marsdb.marsdb_project_vw p ON (p.project_id = enrl.project_id)
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pn ON (pn.value = enrl.plan_code AND pn.project_id = p.project_id)
WHERE  p.project_name = 'DC-EB'
AND enrl.status = 'ACCEPTED'
GROUP BY enrl.sub_program_type_cd, enrl.start_date, enrl.end_date, enrl.plan_code, pn.report_label
 ;
