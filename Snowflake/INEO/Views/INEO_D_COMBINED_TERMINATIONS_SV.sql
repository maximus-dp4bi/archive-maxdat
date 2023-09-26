CREATE OR REPLACE VIEW INEO_D_COMBINED_TERMINATIONS_SV
AS
SELECT ha.agency_hire_date,
ha.days_active,
ha.employee_id,
ha.employee_type,
ha.first_name,
ha.incumbent_transition,
ha.last_name,
ha.left_for_state_position,
ha.left_to_stateother_vendor_on_ineo_project,
ha.manager,
ha.maximus_email,
ha.maximus_hire_date,
ha.months_active,
ha.position_title,
ha.previous_stateconduent_employee,
ha.region,
ha.region_supporting,
ha.rehire_status,
ha.rehired_archive_term,
ha.supervisor,
ha.term_date,
ha.termination_reason,
ha.training_class_id,
ha.training_status,
ha.voluntary_involuntary,
ha.weeks_active
FROM ineo_hr_archived_terminations_history ha
QUALIFY ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY hr_archived_terminations_id desc) = 1
UNION
SELECT th.agency_hire_date,
th.days_active,
th.employee_id,
th.employee_type,
th.first_name,
th.incumbent_transition,
th.last_name,
ha.left_for_state_position,
th.left_to_stateother_vendor_on_ineo_project,
th.manager,
th.maximus_email,
th.maximus_hire_date,
th.months_active,
th.position_title,
th.previous_stateconduent_employee,
th.region,
th.region_supporting,
th.rehire_status,
COALESCE(th.rehired_archive_term,ha.rehired_archive_term) rehired_archive_term,
th.supervisor,
th.term_date,
th.termination_reason,
th.training_class_id,
th.training_status,
th.voluntary_involuntary,
th.weeks_active
FROM ineo_hr_terminations_tracker_history th
  LEFT JOIN (SELECT * 
             FROM ineo_hr_archived_terminations_history
             QUALIFY ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY hr_archived_terminations_id desc) = 1) ha ON th.employee_id = ha.employee_id 
QUALIFY ROW_NUMBER() OVER(PARTITION BY th.employee_id ORDER BY hr_terminations_tracker_id desc) = 1;