CREATE OR REPLACE VIEW dceb.dceb_f_contacts_by_disposition_sv
AS
WITH stf AS(
SELECT p.project_id,u.user_id, s.staff_id,s.maximus_id,CONCAT(s.first_name, ' ',s.last_name) as staff_name,tvw.team_name
FROM marsdb.marsdb_user_vw u 
 JOIN marsdb.marsdb_project_vw p ON p.project_id = u.project_id
 JOIN marsdb.marsdb_staff_vw s ON s.staff_id = u.staff_id
 LEFT JOIN marsdb.marsdb_team_user_vw tuvw ON tuvw.user_id = u.user_id AND tuvw.project_id = u.project_id
 LEFT JOIN marsdb.marsdb_team_vw tvw ON tuvw.team_id = tvw.team_id AND tuvw.project_id = tvw.project_id
WHERE p.project_name = 'DC-EB'
QUALIFY ROW_NUMBER() OVER (PARTITION BY p.project_id,u.user_id ORDER BY tuvw.effective_end_date DESC NULLS FIRST, tuvw.team_user_id) = 1 ),    
ccext as (
SELECT DISTINCT
    project_id,
    internal_id,
    external_ref_id,
    external_ref_type
FROM
    marsdb.marsdb_external_links_vw
WHERE internal_ref_type = 'CONTACT_RECORD'
AND external_ref_type = 'CONSUMER'
AND effective_end_date IS NULL),
ccrec AS(
  SELECT cr.project_id,
        cr.contact_record_id,
        cr.created_by,
        CAST(cr.created_on AS DATE) cr_create_date,
        COALESCE(ccext.external_ref_id,CASE WHEN link_ref_type = 'CONSUMER' THEN link_ref_id ELSE NULL END) consumer_id,
        link_ref_type,
        stf.maximus_id,
        stf.team_name,
        COALESCE(sp.report_label,ptvw.program_type) sub_program_type,
        cr.consumer_type 
  FROM marsdb.marsdb_contact_record_vw cr
    JOIN marsdb.marsdb_project_vw p ON cr.project_id = p.project_id
    LEFT JOIN marsdb.marsdb_contact_record_program_type_vw ptvw ON cr.contact_record_id = ptvw.contact_record_id AND cr.project_id = ptvw.project_id
    LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_program_type_vw) sp ON ptvw.program_type = sp.value AND ptvw.project_id = sp.project_id 
    LEFT JOIN stf ON cr.created_by = stf.user_id AND cr.project_id = stf.project_id
    LEFT JOIN ccext ON cr.contact_record_id = ccext.internal_id AND cr.project_id = ccext.project_id
  WHERE p.project_name = 'DC-EB' ),
ccaction AS(
  SELECT rsn.project_id,
        rsn.contact_record_id,
        COALESCE(rsn.contact_record_reason_type,'No Reason') contact_reason,
        COALESCE(eccr.report_label,'No Reason') contact_reason_label,
        COALESCE(actn.contact_record_action_type,'No Action') contact_action,
        COALESCE(eccra.report_label,'No Action') contact_action_label
  FROM marsdb.marsdb_contact_record_reason_vw rsn
    JOIN marsdb.marsdb_project_vw p ON rsn.project_id = p.project_id
    LEFT JOIN marsdb.marsdb_enum_contact_record_action_reason_vw eccr ON rsn.contact_record_reason_type = eccr.value AND rsn.project_id = eccr.project_id
    LEFT JOIN marsdb.marsdb_contact_record_action_vw actn ON rsn.contact_record_reason_id = actn.contact_record_reason_id AND actn.effective_end_date IS NULL
    LEFT JOIN marsdb.marsdb_enum_contact_record_action_type_vw eccra ON actn.contact_record_action_type = eccra.value AND actn.project_id = eccra.project_id
  WHERE p.project_name = 'DC-EB' )
SELECT ccrec.cr_create_date,
  COALESCE(ccrec.sub_program_type,'Unknown') sub_program_type,
  COALESCE(ccaction.contact_action_label,'No Action') contact_action_label,  
  COALESCE(ccrec.maximus_id,0) maximus_id,  
  COALESCE(ccrec.consumer_type,'Unknown') customer_type,
  COALESCE(ccrec.team_name, 'Unknown') team_name,
  COUNT(DISTINCT ccrec.contact_record_id) count_calls,
  COALESCE(ccaction.contact_reason_label,'No Action') contact_reason_label
FROM ccrec
  JOIN marsdb.marsdb_project_vw p ON ccrec.project_id = p.project_id
  LEFT JOIN ccaction ON ccrec.contact_record_id = ccaction.contact_record_id AND ccrec.project_id = ccaction.project_id  
WHERE p.project_name = 'DC-EB'  
GROUP BY ccrec.cr_create_date,COALESCE(ccrec.sub_program_type,'Unknown'),COALESCE(ccaction.contact_action_label,'No Action'),ccrec.maximus_id,ccrec.consumer_type,ccrec.team_name,COALESCE(ccaction.contact_reason_label,'No Action')
;