CREATE OR REPLACE VIEW dceb.dceb_d_provider_capacity_sv
AS
WITH etl AS
(SELECT DISTINCT UPPER(COALESCE(x.provider_name,'')) AS provider_name
   ,x.report_label AS plan_name
   ,x.provider_type_cd
   ,x.provider_type
   ,x.pcp_flag
   ,COALESCE(x.dchf,0) + COALESCE(x.alliance,0) cumulative_enrolled            
   ,'2000' AS capacity
   ,x.npi_number
   ,x.scope
   ,x.plan_provider_number
FROM (SELECT p.provider_name
         ,p.npi_number, mco.report_label
         ,COALESCE(p.pcp_flag,'N') AS pcp_flag
         ,p.dchf_active_members AS dchf
         ,p.alliance_active_members AS alliance
         ,etvw.report_label AS provider_type
         ,p.provider_type AS provider_type_cd
         ,mco.scope
         ,p.plan_provider_number
         ,ROW_NUMBER() OVER (PARTITION BY p.provider_name,p.plan_provider_number,mco.report_label ORDER BY p.job_id desc, p.file_seq desc,p.row_num desc) AS rn
      FROM (SELECT CASE WHEN p.provider_first_name IS NULL AND p.provider_last_name IS NOT NULL THEN UPPER(p.provider_last_name)
                    ELSE UPPER(p.provider_first_name)||' '||UPPER(p.provider_last_name) END AS provider_name,p.*      
            FROM marsdb.marsdb_etl_prov_stg_dceb p) p
      LEFT JOIN marsdb.marsdb_enum_plan_name_vw mco ON (mco.project_id = 120 and p.provider_number = LPAD(TO_CHAR(mco.value),10,'0'))
      LEFT JOIN marsdb.marsdb_enum_provider_type_vw etvw ON (p.provider_type = etvw.value and etvw.project_id = 120)
      --WHERE error_text IS NULL
      --AND state_code = 'DC'
     ) x 
WHERE x.rn = 1),
enrlpr AS(
   SELECT project_id,provider_type,provider_npi,plan_code,COUNT(DISTINCT consumer_id) enrolled_count
   FROM(SELECT pr.project_id, provider_type,pr.provider_npi,en.plan_code,en.consumer_id,en.status,en.start_date,en.end_date
        FROM marsdb.marsdb_enrollments_vw en
          JOIN marsdb.marsdb_enrollment_provider_vw pr ON en.enrollment_id = pr.enrollment_id AND en.project_id = pr.project_id
          JOIN marsdb.marsdb_project_vw p ON pr.project_id = p.project_id
        WHERE p.project_name = 'DC-EB'
        AND en.status = 'ACCEPTED'
        AND current_date() BETWEEN CAST(en.start_date AS DATE) AND CAST(en.end_date AS DATE)
        QUALIFY ROW_NUMBER() OVER(PARTITION BY pr.enrollment_id,pr.provider_type ORDER BY pr.enrollment_provider_id DESC) = 1)
   GROUP BY project_id,provider_type,provider_npi,plan_code),
prov AS(
SELECT DISTINCT provider_name, plan_name, provider_type_cd, provider_type, pcp_flag, cumulative_enrolled, capacity
FROM(
SELECT DISTINCT pn.provider_name
      ,mco.report_label plan_name
      ,ptvw.provider_type_cd
      ,etvw.report_label AS provider_type
      ,pn.pcp_flag
      ,COALESCE(etl.cumulative_enrolled,0) + COALESCE(enrlpr.enrolled_count,0) AS cumulative_enrolled
      ,'2000' AS capacity
      ,pn.npi
      ,mco.scope
      ,sp.report_label sub_program_type
      ,pn.state_provider_id
FROM (SELECT CASE WHEN pn.first_name IS NULL AND pn.last_name IS NOT NULL THEN UPPER(pn.last_name)
          ELSE  UPPER(COALESCE(pn.first_name||' '||pn.last_name,'')) END AS provider_name, pn.*
      FROM marsdb.marsdb_provider_network_vw pn) pn
  JOIN marsdb.marsdb_project_vw p ON (p.project_id = pn.project_id)
  LEFT JOIN marsdb.marsdb_provider_panel_limit_vw ppl ON (pn.plan_provider_id = ppl.plan_provider_id and ppl.project_id = p.project_id)
  LEFT JOIN marsdb.marsdb_provider_type_vw ptvw ON (pn.plan_provider_id = ptvw.plan_provider_id and ptvw.project_id = p.project_id)
  LEFT JOIN marsdb.marsdb_enum_provider_type_vw etvw ON (ptvw.provider_type_cd = etvw.value and etvw.project_id = p.project_id)
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw mco ON (mco.value = pn.plan_code and mco.project_id = p.project_id)
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON mco.scope = sp.value AND pn.project_id = sp.project_id 
  LEFT JOIN etl ON (UPPER(etl.provider_name)= pn.provider_name AND etl.plan_name = mco.report_label ) --AND etl.plan_provider_number = pn.state_provider_id)
  LEFT JOIN enrlpr ON enrlpr.provider_npi = pn.npi AND enrlpr.plan_code = mco.value AND enrlpr.project_id = pn.project_id AND enrlpr.provider_type = ptvw.provider_type_cd
WHERE p.project_name = 'DC-EB'
--UNION ALL
--SELECT *
--FROM etl
) ),
penrl AS(
SELECT enrl.sub_program_type_cd, sp.report_label sub_program_type, enrl.start_date, enrl.end_date, enrl.plan_code, pn.report_label plan_name, COUNT(DISTINCT enrl.consumer_id) plan_enrolled_count
FROM (SELECT * FROM marsdb.marsdb_enrollments_vw 
      QUALIFY ROW_NUMBER() OVER (PARTITION BY sub_program_type_cd, start_date, plan_code,status,consumer_id ORDER BY enrollment_id DESC) = 1) enrl  
  JOIN marsdb.marsdb_project_vw p ON (p.project_id = enrl.project_id)
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pn ON (pn.value = enrl.plan_code AND pn.project_id = p.project_id)
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON enrl.sub_program_type_cd = sp.value AND enrl.project_id = sp.project_id
WHERE  p.project_name = 'DC-EB'
AND enrl.status = 'ACCEPTED'
AND current_date() BETWEEN CAST(enrl.start_date AS DATE) AND CAST(enrl.end_date AS DATE)
GROUP BY enrl.sub_program_type_cd, sp.report_label, enrl.start_date, enrl.end_date, enrl.plan_code, pn.report_label)
SELECT provider_name,plan_name,provider_type_cd,provider_type,pcp_flag,SUM(cumulative_enrolled) cumulative_enrolled,capacity
FROM prov
GROUP BY provider_name,plan_name,provider_type_cd,provider_type,pcp_flag,capacity
UNION ALL
SELECT 'No Dentist Assigned' provider_name,penrl.plan_name,'D','Dental','N',SUM(plan_enrolled_count) - COALESCE(prov_enrolled,0) cumulative_enrolled,'2000' capacity
FROM penrl
  LEFT JOIN (SELECT plan_name,SUM(cumulative_enrolled) prov_enrolled
             FROM prov
             WHERE provider_type_cd = 'D'
             GROUP BY plan_name) prov ON penrl.plan_name = prov.plan_name
GROUP BY penrl.plan_name,prov_enrolled
UNION ALL
SELECT 'No PCP Assigned' provider_name,penrl.plan_name,'P','Individual Provider','N',SUM(plan_enrolled_count) - COALESCE(prov_enrolled,0) cumulative_enrolled,'2000' capacity
FROM penrl
  LEFT JOIN (SELECT plan_name,SUM(cumulative_enrolled) prov_enrolled
             FROM prov
             WHERE provider_type_cd = 'P'
             GROUP BY plan_name) prov ON penrl.plan_name = prov.plan_name
GROUP BY penrl.plan_name,prov_enrolled
;

CREATE OR REPLACE VIEW dceb.dceb_f_plan_enrollments_sv
AS
SELECT enrl.sub_program_type_cd, enrl.start_date, enrl.end_date, enrl.plan_code, pn.report_label plan_name, COUNT(DISTINCT enrl.consumer_id) plan_enrolled_count,sp.report_label sub_program_type
FROM (SELECT * FROM marsdb.marsdb_enrollments_vw 
      QUALIFY ROW_NUMBER() OVER (PARTITION BY sub_program_type_cd, start_date, plan_code,status,consumer_id ORDER BY enrollment_id DESC) = 1) enrl  
  JOIN marsdb.marsdb_project_vw p ON (p.project_id = enrl.project_id)
  LEFT JOIN marsdb.marsdb_enum_plan_name_vw pn ON (pn.value = enrl.plan_code AND pn.project_id = p.project_id)
  LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON enrl.sub_program_type_cd = sp.value AND enrl.project_id = sp.project_id
WHERE  p.project_name = 'DC-EB'
AND enrl.status = 'ACCEPTED'
GROUP BY enrl.sub_program_type_cd, sp.report_label,enrl.start_date, enrl.end_date, enrl.plan_code, pn.report_label
 ;
