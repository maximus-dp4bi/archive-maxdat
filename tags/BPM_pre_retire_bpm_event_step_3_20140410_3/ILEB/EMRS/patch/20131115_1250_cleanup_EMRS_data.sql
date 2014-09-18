UPDATE emrs_d_case
SET date_of_validity_start = TRUNC(date_of_validity_start)
    ,date_of_validity_end = TRUNC(date_of_validity_end)
where date_of_validity_start > date_of_validity_end;    
    
UPDATE emrs_d_provider
SET date_of_validity_start = TRUNC(date_of_validity_end,'MM')
where date_of_validity_start > date_of_validity_end;

UPDATE emrs_d_client_plan_eligibility
SET date_of_validity_start = date_of_validity_end
where date_of_validity_start > date_of_validity_end;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_start = date_of_validity_end
where date_of_validity_start > date_of_validity_end;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177079;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177246;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177241;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177533;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177315;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177671;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177191;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24176432;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24176249;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24176551;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177118;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177393;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24176709;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24176956;

UPDATE emrs_d_client_plan_enrl_status
SET current_flag = 'N', date_of_validity_end = to_date('10/19/2013','mm/dd/yyyy')
WHERE client_enroll_status_id = 24177005;

COMMIT;
