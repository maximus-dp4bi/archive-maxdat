
CREATE OR REPLACE VIEW D_SURVEY_CURRENT_SV 
AS
SELECT case_id case_number,
       client_id client_number,
       survey_id,
       survey_create_ts,
       plan_name,
       plan_id_ext,
       medallion,
       provider_id_ext,
       provider_first_name,
       provider_last_name,
       effective_date,
       incomplete_refuse_answer,
       reason_for_hsa,
       MAX(q_primary_physician) q_primary_physician,
       MAX(q_primary_physician_name) q_primary_physician_name,
       MAX(q_seeing_specialist) q_seeing_specialist,
       MAX(q_specialist_name) q_specialist_name,
       MAX(q_medications) q_medications,
       MAX(q_medication_name) q_medication_name,
       MAX(q_medical_equipment) q_medical_equipment,
       MAX(q_doctor_prescribed) q_doctor_prescribed,
       MAX(q_pregnant) q_pregnant,
       MAX(q_baby_due_date) q_baby_due_date,
       MAX(q_high_risk_preg) q_high_risk_preg,
       MAX(q_scheduled_surgery) q_scheduled_surgery,
       MAX(q_surgery_date) q_surgery_date,
       MAX(q_home_health_care) q_home_health_care,
       MAX(q_explain_care_rcvd) q_explain_care_rcvd,
       MAX(q_organ_transplant_list) q_organ_transplant_list,
       MAX(q_explain_transplant) q_explain_transplant,
       MAX(q_diabetes) q_diabetes,
       MAX(q_smoke) q_smoke,
       MAX(q_heart_condition) q_heart_condition,
       MAX(q_high_blood_pressure) q_high_blood_pressure,
       MAX(q_living_hiv_aids) q_living_hiv_aids,
       MAX(q_lung_disorder) q_lung_disorder,
       MAX(q_asthma) q_asthma,
       MAX(q_kidney_disease) q_kidney_disease,
       MAX(q_blood_disease) q_blood_disease,
       MAX(q_cancer) q_cancer,
       MAX(q_tuberculosis) q_tuberculosis,
       MAX(q_seeing_psychiatrist) q_seeing_psychiatrist,       
       MAX(q_child_rcvd_services) q_child_rcvd_services,
       MAX(q_rcvd_case_manager) q_rcvd_case_manager,
       MAX(q_other_med_needs) q_other_med_needs,
       MAX(q_hospitalized) q_hospitalized,
       MAX(q_regular_doctor) q_regular_doctor,
       MAX(q_regular_dr_name1) q_regular_dr_name1,
       MAX(q_regular_dr_name2) q_regular_dr_name2,
       MAX(q_regular_dr_name3) q_regular_dr_name3,       
       MAX(q_desc_hospice_care) q_desc_hospice_care,
       MAX(q_desc_transplant) q_desc_transplant,
       MAX(q_height_feet) q_height_feet,
       MAX(q_height_inches) q_height_inches,
       MAX(q_weight) q_weight,
       MAX(q_native_language) q_native_language,
       MAX(q_specialist_name1) q_specialist_name1,
       MAX(q_specialist_name2) q_specialist_name2,
       MAX(q_specialist_name3) q_specialist_name3,
       MAX(q_other_health_programs) q_other_health_programs,
       MAX(q_health_program_name1) q_health_program_name1,
       MAX(q_health_program_name2) q_health_program_name2,
       MAX(q_health_program_name3) q_health_program_name3,
       MAX(q_therapy) q_therapy,
       MAX(q_desc_other_need1) q_desc_other_need1,
       MAX(q_desc_other_need2) q_desc_other_need2,
       MAX(q_desc_other_need3) q_desc_other_need3,
       MAX(q_why_admitted) q_why_admitted,
       MAX(q_medication_name1) q_medication_name1,
       MAX(q_medication_name2) q_medication_name2,
       MAX(q_medication_name3) q_medication_name3,
       MAX(q_med_equipment1) q_med_equipment1,
       MAX(q_equipment_prescribed1) q_equipment_prescribed1,
       MAX(q_med_equipment2) q_med_equipment2,
       MAX(q_equipment_prescribed2) q_equipment_prescribed2,
       MAX(q_med_equipment3) q_med_equipment3,
       MAX(q_equipment_prescribed3) q_equipment_prescribed3,
       MAX(q_provider_fname) q_provider_fname,
       MAX(q_provider_lname) q_provider_lname,
       MAX(q_provider_code) q_provider_code,
       medicaid_expansion_indicator
FROM (       
SELECT qt.svey_tmpl_question_text_id
       ,qt.question_text
       ,sa.answer_text
       ,sv.case_id
       ,sv.client_id
       ,TRUNC(sv.create_ts) survey_create_ts
       ,sv.survey_id
       ,t.plan_name
       ,t.plan_id_ext
       ,CASE WHEN t.plan_id_ext in ('0047003170', '0047003253', '0047000820', '1790768380', '0047001042', '1730254681') THEN 'M3'
              WHEN t.plan_id_ext in ('0562425543', '0562425972', '0575325995', '0562427754', '0575326118', '0562425717') THEN 'M4'
              ELSE NULL
        END AS medallion
       ,t.provider_id_ext
       ,t.provider_first_name
       ,t.provider_last_name
       ,t.effective_date 
       ,COALESCE(t.medicaid_expansion_indicator,0) medicaid_expansion_indicator
       ,CASE WHEN t.transaction_type_cd = 'Transfer' THEN 'Changed' ELSE 'New Enrollee' END reason_for_hsa
       ,CASE WHEN sv.status_cd = 'COMPLETED' THEN 'NO' ELSE 'YES' END incomplete_refuse_answer
       ,CASE WHEN qt.question_text LIKE 'Do you have a PRIMARY CARE PHYSICIAN%' THEN sa.answer_text ELSE NULL END q_primary_physician
       ,CASE WHEN qt.question_text LIKE 'What is the PCP name%' THEN sr.answer_text ELSE null END q_primary_physician_name
       ,CASE WHEN qt.question_text LIKE 'Are you seeing any SPECIALISTS%' THEN sa.answer_text ELSE null END q_seeing_specialist
       ,CASE WHEN qt.question_text LIKE 'If so what are the names%' THEN sr.answer_text ELSE null END q_specialist_name
       ,CASE WHEN qt.question_text LIKE 'Are you taking MEDICATIONS%' THEN sa.answer_text ELSE null END q_medications
       ,CASE WHEN qt.question_text LIKE 'What are the names of the medications%' THEN sr.answer_text ELSE null END q_medication_name
       ,CASE WHEN qt.question_text LIKE 'Are you using any DURABLE MEDICAL EQUIPMENT%' THEN sa.answer_text ELSE null END q_medical_equipment
       ,CASE WHEN qt.question_text LIKE 'Was it prescribed by a doctor%' THEN sa.answer_text ELSE null END q_doctor_prescribed
       ,CASE WHEN qt.question_text LIKE 'Are you PREGNANT%' THEN sa.answer_text ELSE null END q_pregnant
       ,CASE WHEN qt.question_text LIKE 'PREGNANCY DUE DATE%' THEN sr.answer_text ELSE null END q_baby_due_date
       ,CASE WHEN qt.question_text LIKE 'Is your pregnancy considered high risk or any concerns%' THEN sa.answer_text ELSE null END q_high_risk_preg
       ,CASE WHEN qt.question_text LIKE 'Are you  scheduled for any SURGERY%' THEN sa.answer_text ELSE null END q_scheduled_surgery
       ,CASE WHEN qt.question_text LIKE 'SURGERY DATE%' THEN sr.answer_text ELSE null END q_surgery_date
       ,CASE WHEN qt.question_text LIKE 'Are you receiving HOME HEALTH CARE or HOSPICE CARE%' THEN sa.answer_text ELSE null END q_home_health_care
       ,CASE WHEN qt.question_text LIKE 'Please explain the care you are receiving%' THEN sr.answer_text ELSE null END q_explain_care_rcvd
       ,CASE WHEN qt.question_text LIKE 'Are you on an ORGAN TRANSPLANT list%'  THEN sa.answer_text ELSE null END q_organ_transplant_list
       ,CASE WHEN qt.question_text LIKE 'If Yes, Please Explain%' THEN sr.answer_text ELSE null END q_explain_transplant
       ,CASE WHEN qt.question_text LIKE 'Do you have DIABETES%' THEN sa.answer_text ELSE null END q_diabetes
       ,CASE WHEN qt.question_text LIKE 'Do you SMOKE%' THEN sa.answer_text ELSE null END q_smoke
       ,CASE WHEN qt.question_text LIKE 'Do you have a HEART CONDITION%' THEN sa.answer_text ELSE null END q_heart_condition
       ,CASE WHEN qt.question_text LIKE 'Do you have HIGH BLOOD PRESSURE%' THEN sa.answer_text ELSE null END q_high_blood_pressure
       ,CASE WHEN qt.question_text LIKE 'Are you living with HIV or AIDS%' THEN sa.answer_text ELSE null END q_living_hiv_aids
       ,CASE WHEN qt.question_text LIKE 'Do you have a LUNG DISORDER%' THEN sa.answer_text ELSE null END q_lung_disorder
       ,CASE WHEN qt.question_text LIKE 'Do you have ASTHMA%' THEN sa.answer_text ELSE null END q_asthma
       ,CASE WHEN qt.question_text LIKE 'Do you have KIDNEY DISEASE OR ON DIALYSIS%' THEN sa.answer_text ELSE null END q_kidney_disease
       ,CASE WHEN qt.question_text LIKE 'Do you have a BLOOD DISEASE%' THEN sa.answer_text ELSE null END q_blood_disease
       ,CASE WHEN qt.question_text LIKE 'Do you have CANCER%' THEN sa.answer_text ELSE null END q_cancer
       ,CASE WHEN qt.question_text LIKE 'Do you have TUBERCULOSIS%' THEN sa.answer_text ELSE null END q_tuberculosis
       ,CASE WHEN qt.question_text LIKE 'Are you seeing a PSYCHIATRIST or PSYCHOLOGIST%' THEN sa.answer_text ELSE null END q_seeing_psychiatrist
       ,CASE WHEN qt.question_text LIKE 'Does your child receive services through any of these programs: PART C or EARLY INTERVENTION%' THEN sa.answer_text ELSE null END q_child_rcvd_services
       ,CASE WHEN qt.question_text LIKE 'Do you receive CASE MANAGER OR CASE COORDINATOR SERVICES%' THEN sa.answer_text ELSE null END q_rcvd_case_manager
       ,CASE WHEN qt.question_text LIKE 'Are there any OTHER MEDICAL or MENTAL NEEDS that you would like the MCO to know about%' THEN sa.answer_text ELSE null END q_other_med_needs
       ,CASE WHEN qt.question_text LIKE 'Have you been HOSPITALIZED for over 24 hours in the past 12 months%' THEN sa.answer_text ELSE null END q_hospitalized
       ,CASE WHEN qt.question_text LIKE 'Do you have a REGULAR DOCTOR%' THEN sa.answer_text ELSE NULL END q_regular_doctor
       ,CASE WHEN qt.question_text LIKE 'Regular Doctor''s NAME?(1)%' THEN sr.answer_text ELSE NULL END q_regular_dr_name1
       ,CASE WHEN qt.question_text LIKE 'Regular Doctor''s NAME?(2)%' THEN sr.answer_text ELSE NULL END q_regular_dr_name2
       ,CASE WHEN qt.question_text LIKE 'Regular Doctor''s NAME?(3)%' THEN sr.answer_text ELSE NULL END q_regular_dr_name3       
       ,CASE WHEN qt.question_text LIKE 'DESCRIBE HEALTH OR HOSPICE CARE%' THEN sr.answer_text ELSE NULL END q_desc_hospice_care
       ,CASE WHEN qt.question_text LIKE 'DESCRIBE TRANSPLANT ORGAN%' THEN sr.answer_text ELSE NULL END q_desc_transplant
       ,CASE WHEN qt.question_text LIKE 'HEIGHT Feet%' THEN sr.answer_text ELSE NULL END q_height_feet
       ,CASE WHEN qt.question_text LIKE 'HEIGHT inches%' THEN sr.answer_text ELSE NULL END q_height_inches
       ,CASE WHEN qt.question_text LIKE 'WEIGHT%' THEN sr.answer_text ELSE NULL END q_weight
       ,CASE WHEN qt.question_text LIKE 'NATIVE LANGUAGE%' THEN sr.answer_text ELSE NULL END q_native_language
       ,CASE WHEN qt.question_text LIKE 'SPECIALIST NAME (1)%' THEN sr.answer_text ELSE NULL END q_specialist_name1
       ,CASE WHEN qt.question_text LIKE 'SPECIALIST NAME (2)%' THEN sr.answer_text ELSE NULL END q_specialist_name2
       ,CASE WHEN qt.question_text LIKE 'SPECIALIST NAME (3)%' THEN sr.answer_text ELSE NULL END q_specialist_name3
       ,CASE WHEN qt.question_text LIKE 'Do you participate in any other HEALTH DEPARTMENT PROGRAMS%' THEN sa.answer_text ELSE NULL END q_other_health_programs
       ,CASE WHEN qt.question_text LIKE 'Name of HEALTH DEPARTMENT PROGRAM (1)%' THEN sr.answer_text ELSE NULL END q_health_program_name1
       ,CASE WHEN qt.question_text LIKE 'Name of HEALTH DEPARTMENT PROGRAM (2)%' THEN sr.answer_text ELSE NULL END q_health_program_name2
       ,CASE WHEN qt.question_text LIKE 'Name of HEALTH DEPARTMENT PROGRAM (3)%' THEN sr.answer_text ELSE NULL END q_health_program_name3
       ,CASE WHEN qt.question_text LIKE 'Are you receiving Occupational, Physical or Speech Therapy%' THEN sa.answer_text ELSE NULL END q_therapy
       ,CASE WHEN qt.question_text LIKE 'DESCRIBE OTHER NEED (1)%' THEN sr.answer_text ELSE NULL END q_desc_other_need1
       ,CASE WHEN qt.question_text LIKE 'DESCRIBE OTHER NEED (2)%' THEN sr.answer_text ELSE NULL END q_desc_other_need2
       ,CASE WHEN qt.question_text LIKE 'DESCRIBE OTHER NEED (3)%' THEN sr.answer_text ELSE NULL END q_desc_other_need3
       ,CASE WHEN qt.question_text LIKE 'Why were you ADMITTED%' THEN sr.answer_text ELSE NULL END q_why_admitted
       ,CASE WHEN qt.question_text LIKE 'MEDICATION NAME (1)%' THEN sr.answer_text ELSE NULL END q_medication_name1
       ,CASE WHEN qt.question_text LIKE 'MEDICATION NAME (2)%' THEN sr.answer_text ELSE NULL END q_medication_name2
       ,CASE WHEN qt.question_text LIKE 'MEDICATION NAME (3)%' THEN sr.answer_text ELSE NULL END q_medication_name3
       ,CASE WHEN qt.question_text LIKE 'DURABLE MEDICAL EQUIPMENT NAME (1)%' THEN sr.answer_text ELSE NULL END q_med_equipment1
       ,CASE WHEN qt.question_text LIKE 'DURABLE MEDICAL EQUIPMENT PRESCRIBED (1)%' THEN sr.answer_text ELSE NULL END q_equipment_prescribed1
       ,CASE WHEN qt.question_text LIKE 'DURABLE MEDICAL EQUIPMENT NAME (2)%' THEN sr.answer_text ELSE NULL END q_med_equipment2
       ,CASE WHEN qt.question_text LIKE 'DURABLE MEDICAL EQUIPMENT PRESCRIBED (2)%' THEN sr.answer_text ELSE NULL END q_equipment_prescribed2
       ,CASE WHEN qt.question_text LIKE 'DURABLE MEDICAL EQUIPMENT NAME (3)%' THEN sr.answer_text ELSE NULL END q_med_equipment3
       ,CASE WHEN qt.question_text LIKE 'DURABLE MEDICAL EQUIPMENT PRESCRIBED (3)%' THEN sr.answer_text ELSE NULL END q_equipment_prescribed3
       ,CASE WHEN qt.question_text LIKE 'PROVIDER FIRST NAME%' THEN sr.answer_text ELSE NULL END q_provider_fname
       ,CASE WHEN qt.question_text LIKE 'PROVIDER LAST NAME%' THEN sr.answer_text ELSE NULL END q_provider_lname
       ,CASE WHEN qt.question_text LIKE 'PROVIDER CODE%' THEN sr.answer_text ELSE NULL END q_provider_code       
FROM survey sv   
 INNER JOIN survey_template st   ON sv.survey_template_id = st.survey_template_id
 INNER JOIN survey_template_group sg   ON st.survey_template_id = sg.survey_template_id
 INNER JOIN survey_template_question sq   ON sg.survey_template_group_id = sq.survey_template_group_id
   AND sg.survey_template_id = sq.survey_template_id   
 LEFT OUTER JOIN svey_tmpl_question_text qt   ON sq.survey_template_question_id = qt.survey_template_question_id
 LEFT OUTER JOIN survey_response sr   ON sv.survey_id = sr.survey_id   
   AND sr.template_question_id = qt.survey_template_question_id
 LEFT OUTER JOIN  svey_tmpl_answer_text sa   ON sa.survey_template_answer_id = sr.survey_template_answer_id  
 LEFT OUTER JOIN (SELECT p.plan_name,p.plan_id_ext, t.client_id, t.provider_id_ext, t.provider_first_name, t.provider_last_name,t.start_date effective_date,t.transaction_type_cd
                         ,CASE WHEN t.client_aid_category_cd IN('100', '101', '102', '103', '106','108') THEN 1 ELSE 0 END medicaid_expansion_indicator
            FROM eb.selection_txn t
              INNER JOIN eb.plans p
                ON t.plan_id = p.plan_id
            WHERE t.status_cd = 'acceptedByState'
            AND status_date = (SELECT MAX(status_date)
                               FROM selection_txn st
                               WHERE t.client_id = st.client_id
                               AND t.status_cd = st.status_cd)) t          
  ON sv.client_id = t.client_id   
)
GROUP BY case_id,client_id,survey_id,survey_create_ts,plan_name,plan_id_ext,medallion,provider_id_ext, provider_first_name,provider_last_name, effective_date,incomplete_refuse_answer,reason_for_hsa,medicaid_expansion_indicator
;

GRANT SELECT ON maxdat_support.D_SURVEY_CURRENT_SV TO MAXDAT_REPORTS;