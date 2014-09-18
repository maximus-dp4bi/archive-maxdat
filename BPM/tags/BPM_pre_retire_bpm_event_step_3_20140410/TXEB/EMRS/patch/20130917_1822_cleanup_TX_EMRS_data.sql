DELETE FROM emrs_d_provider p
WHERE EXISTS(SELECT 1 FROM emrs_d_provider p1
             WHERE p.provider_number = p1.provider_number
             AND p.version = p1.version
             AND p.provider_id < p1.provider_id);

UPDATE emrs_d_client
SET date_of_validity_start = TO_DATE('01/01/1995','mm/dd/yyyy')
    ,date_of_validity_end =  TO_DATE('12/31/2050','mm/dd/yyyy')
WHERE client_id = 0;

UPDATE emrs_d_client
SET date_of_validity_start = TRUNC(record_date)
WHERE date_of_validity_start IS NULL;

UPDATE emrs_d_client_plan_enrl_status
SET date_of_validity_end = date_of_validity_start
    ,current_flag = 'N'
WHERE client_enroll_status_id IN(SELECT client_enroll_status_id
                                 FROM emrs_d_client_plan_enrl_status s1
                                 WHERE TRUNC(s1.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy')
                                 AND EXISTS (SELECT 1 FROM emrs_d_client_plan_enrl_status s2 
                                             WHERE s1.client_number = s2.client_number 
                                             AND s1.plan_type_id = s2.plan_type_id 
                                             AND TRUNC(s2.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy')
                                             AND s1.version < s2.version));

COMMIT;