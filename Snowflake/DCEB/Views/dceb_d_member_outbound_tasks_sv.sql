CREATE OR REPLACE VIEW dceb.dceb_d_member_outbound_tasks_sv 
AS
WITH stf AS(
SELECT u.user_id, p.project_id, CONCAT(s.first_name, ' ',s.last_name) as staff_name
FROM marsdb.marsdb_user_vw u
 JOIN marsdb.marsdb_project_vw p ON p.project_id = u.project_id
 JOIN marsdb.marsdb_staff_vw s ON s.staff_id = u.staff_id
WHERE p.project_name = 'DC-EB'),
tskinfo AS(SELECT tvw.task_id,
 tvw.project_id,
 tvw.task_type_id,
 tt.task_name,
 tvw.task_status, 
 tvw.created_on,
 tvw.updated_on,
 tvw.default_due_date,
 tvw.staff_assigned_to,
 stf_at.staff_name staff_assigned_to_name,
 tvw.created_by,
 stf.staff_name staff_created_by_name,
 tvw.task_info,
 tvw.task_notes,
 xvw.external_ref_id consumer_id,
 csxvw.external_ref_id case_id
FROM marsdb.marsdb_tasks_vw tvw 
  JOIN marsdb.marsdb_project_vw p ON p.project_id = tvw.project_id
  JOIN marsdb.cfg_task_type tt ON tvw.task_type_id = tt.task_type_id AND tvw.project_id = tt.project_id    
  LEFT JOIN stf ON tvw.created_by = stf.user_id AND tvw.project_id = stf.project_id 
  LEFT JOIN stf stf_at ON tvw.staff_assigned_to = stf_at.user_id AND tvw.project_id = stf_at.project_id 
  LEFT JOIN marsdb.marsdb_external_links_vw xvw ON tvw.task_id = xvw.internal_id AND tvw.project_id = xvw.project_id 
    AND xvw.internal_ref_type = 'TASK' AND xvw.external_ref_type = 'CONSUMER'
    LEFT JOIN marsdb.marsdb_external_links_vw csxvw ON tvw.task_id = csxvw.internal_id AND tvw.project_id = csxvw.project_id 
    AND csxvw.internal_ref_type = 'TASK' AND csxvw.external_ref_type = 'CASE'  
WHERE tt.task_name IN('Member Outbound Call')
AND p.project_name = 'DC-EB'),
tskdtl AS(SELECT x.project_id,
 x.task_id,
 x."13" AS preferred_phone,
 x."42" AS action_taken,
 x."49" AS preferred_callback_date,
 x."50" AS preferred_callback_time
FROM (SELECT td.project_id, td.task_id, 
            CASE WHEN td.task_field_id IN(49) THEN TO_CHAR(td.selection_date,'MM/DD/YYYY')                            
               ELSE COALESCE(selection_varchar, CAST(selection_date AS VARCHAR()),            
              CAST(selection_boolean AS VARCHAR()), CAST(selection_numeric AS VARCHAR())) END selection,
             task_field_id
              FROM  marsdb.marsdb_task_detail_vw td 
                JOIN marsdb.marsdb_project_vw p ON p.project_id = td.project_id
              WHERE td.task_field_id in (13,42,49,50)
              AND p.project_name = 'DC-EB') PIVOT (MAX(selection) FOR task_field_id IN (13,42,49,50)) x
),
cldtl AS(
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
clemail AS(SELECT covw.external_ref_id,ctvw.project_id,evw.email_address
FROM marsdb.marsdb_contacts_vw ctvw
  JOIN marsdb.marsdb_project_vw p ON ctvw.project_id = p.project_id
  JOIN marsdb.marsdb_contacts_owner_vw covw ON ctvw.owner_id = covw.contact_owner_id AND ctvw.project_id= covw.project_id
  JOIN marsdb.marsdb_email_vw evw ON ctvw.contact_type_id = evw.contact_type_id AND ctvw.project_id = evw.project_id
WHERE p.project_name = 'DC-EB'  
AND evw.primary_indicator = 1
AND covw.external_ref_type = 'CONSUMER'
QUALIFY ROW_NUMBER() OVER(PARTITION BY covw.external_ref_id ORDER BY evw.effective_end_date DESC NULLS FIRST,evw.email_id DESC) = 1)                 
SELECT tskinfo.*,  
  COALESCE(tskdtl.preferred_phone,clphn.phone_number) phone_number,
  tskdtl.preferred_callback_date,
  tskdtl.preferred_callback_time,
  CONCAT(TO_CHAR(tskdtl.preferred_callback_date),' ',tskdtl.preferred_callback_time) preferred_callback_datetime,
  tskdtl.action_taken,
  atvw.report_label action_taken_label,  
  cldtl.case_number,
  cldtl.consumer_first_name,
  cldtl.consumer_last_name,
  cldtl.medical_assistance_id,
  clemail.email_address
FROM tskinfo  
  JOIN marsdb.marsdb_project_vw p ON tskinfo.project_id = p.project_id
  LEFT JOIN tskdtl ON tskinfo.task_id = tskdtl.task_id AND tskinfo.project_id = tskdtl.project_id
  LEFT JOIN marsdb.marsdb_enum_action_taken_vw atvw ON tskdtl.action_taken = atvw.value AND tskdtl.project_id = atvw.project_id
  LEFT JOIN cldtl ON tskinfo.consumer_id = cldtl.consumer_id AND tskinfo.project_id = cldtl.project_id
  LEFT JOIN clphn ON cldtl.consumer_id = clphn.external_ref_id AND cldtl.project_id = clphn.project_id
  LEFT JOIN clemail ON cldtl.consumer_id = clemail.external_ref_id AND cldtl.project_id = clemail.project_id
WHERE p.project_name = 'DC-EB';
