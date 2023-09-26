CREATE OR REPLACE VIEW dceb.dceb_d_provider_continuity_sv AS
WITH dis AS (
SELECT * FROM
(SELECT eh.consumer_id
        ,cc.case_id as case_id
        ,ccin.external_case_id as case_number
        ,cin.external_consumer_id as medical_assistance_id
        ,eh.sub_program_type_cd
        ,eh.plan_code
        ,pn.report_label
        ,eh.txn_status_date
        ,p1.project_id
        ,sp.report_label sub_program_type
        ,ROW_NUMBER() OVER(PARTITION BY eh.consumer_id ORDER BY eh.enrollment_history_id DESC, eh.txn_status_date DESC) rn
 FROM marsdb.marsdb_enrollments_history_vw eh
    JOIN marsdb.marsdb_project_vw p1 ON (eh.project_id = p1.project_id)
    LEFT JOIN marsdb.marsdb_enum_plan_name_vw pn ON (eh.plan_code = pn.value AND pn.project_id = eh.project_id)
    LEFT JOIN marsdb.marsdb_consumer_identification_number_vw cin ON (eh.consumer_id = cin.consumer_id AND p1.project_id = cin.project_id)
    LEFT JOIN marsdb.marsdb_case_consumer_vw cc ON (eh.consumer_id = cc.consumer_id AND cc.project_id = p1.project_id)
    LEFT JOIN marsdb.marsdb_case_identification_number_vw ccin ON (cc.case_id = ccin.case_id AND ccin.project_id = p1.project_id AND ccin.identification_number_type = 'MEDICAID')
    LEFT JOIN (SELECT DISTINCT value,report_label,project_id FROM marsdb.marsdb_enum_sub_program_type_vw) sp ON eh.sub_program_type_cd = sp.value AND eh.project_id = sp.project_id 
 WHERE p1.project_name = 'DC-EB'
 AND eh.txn_status IN ('DISENROLL_REQUESTED','DISENROLL_SUBMITTED','DISENROLLED'))
WHERE rn = 1),
reen AS (
SELECT * FROM
(SELECT eh.consumer_id
       ,eh.sub_program_type_cd
       ,eh.plan_code
       ,pn.report_label
       ,eh.txn_status_date
       ,p1.project_id
       ,ROW_NUMBER() OVER(PARTITION BY eh.consumer_id ORDER BY eh.enrollment_id DESC, eh.txn_status_date DESC) rn
 FROM MARSDB.MARSDB_ENROLLMENTS_VW eh
   JOIN  MARSDB.MARSDB_PROJECT_VW p1 ON (eh.project_id = p1.project_id)
   LEFT JOIN MARSDB.MARSDB_ENUM_PLAN_NAME_VW pn ON (eh.plan_code = pn.value and pn.project_id = eh.project_id)
 WHERE p1.project_name = 'DC-EB'
 AND eh.txn_status IN ('ACCEPTED','SELECTION_MADE','SUBMITTED_TO_STATE') )
WHERE rn = 1 )
SELECT dis.consumer_id, dis.case_id, dis.case_number,dis.medical_assistance_id, dis.sub_program_type,dis.report_label as mco, date(dis.txn_status_date) as elig_term_date, date(reen.txn_status_date) as reenroll_date
FROM dis
  JOIN reen ON (dis.consumer_id = reen.consumer_id AND dis.plan_code = reen.plan_code AND dis.txn_status_date <= reen.txn_status_date)
;