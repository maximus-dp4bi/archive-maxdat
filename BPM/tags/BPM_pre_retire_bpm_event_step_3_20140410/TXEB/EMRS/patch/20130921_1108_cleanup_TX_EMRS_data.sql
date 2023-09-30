INSERT INTO corp_etl_job_statistics(job_id,job_name,job_status_cd,job_start_date,job_end_date)
VALUES(SEQ_JOB_ID.nextval,'ETL_Enrollment','COMPLETED',TO_DATE('09/20/2013','MM/DD/YYYY'), TO_DATE('09/20/2013','MM/DD/YYYY'));


UPDATE emrs_d_provider
SET date_of_validity_start = TRUNC(date_created)
WHERE date_of_validity_start IS NULL;

UPDATE emrs_d_client c1
SET date_of_validity_end = to_date('12/31/2050','mm/dd/yyyy')
    ,current_flag = 'Y'
WHERE date_of_validity_end < to_date('12/31/2050','mm/dd/yyyy')
AND NOT EXISTS(SELECT 1 
	       FROM emrs_d_client c2 
               WHERE c1.client_number = c2.client_number
               AND trunc(c2.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy'));


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