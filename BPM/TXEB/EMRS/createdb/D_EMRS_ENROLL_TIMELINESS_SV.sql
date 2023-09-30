CREATE OR REPLACE VIEW d_emrs_enroll_timeliness_sv
AS 
SELECT client_number
 ,managed_care_program
 ,plan_type
 ,enrollment_status_code
 ,term
 ,enrollment_status_desc
 ,date_of_validity_start
 ,date_of_validity_end
 ,version
 ,current_flag
 ,date_created
 ,CASE WHEN date_of_validity_end > sysdate THEN CASE WHEN term = 'Y' THEN 0 ELSE TRUNC(sysdate) - TRUNC(date_of_validity_start) END
ELSE TRUNC(date_of_validity_end) - TRUNC(date_of_validity_start) END duration_days_cal
 ,CASE WHEN date_of_validity_end > sysdate THEN CASE WHEN term = 'Y' THEN 0 ELSE ETL_COMMON.bus_days_between(TRUNC(date_of_validity_start),TRUNC(sysdate)) END
   ELSE ETL_COMMON.bus_days_between(TRUNC(date_of_validity_start),TRUNC(date_of_validity_end)) END duration_days_bus
 ,MAX(rn) OVER (PARTITION BY managed_care_program,plan_type,client_number ORDER BY managed_care_program,plan_type,client_number,version) groupnum
 FROM ( 
SELECT tt.*, 
CASE WHEN term = 'Y' AND (prev_status_is_term IS NULL OR prev_status_is_term = 'Y') THEN source_record_id
 WHEN term = 'N' AND (prev_status_is_term IS NULL OR prev_status_is_term = 'Y') THEN source_record_id
 ELSE NULL END rn
 FROM ( 
SELECT t.*, LAG(term,1) OVER (PARTITION BY managed_care_program,plan_type,client_number ORDER BY managed_care_program,plan_type,client_number,version) prev_status_is_term
 FROM(
 SELECT cpe.*, s.enrollment_status_code, s.enrollment_status_desc,p.plan_type,p.managed_care_program
 ,CASE WHEN s.enrollment_status_code IN('K','G','G+','G^','L*','G*','O*','X','A*') THEN 'Y' ELSE 'N' END term
 FROM emrs_d_client_plan_enrl_status cpe 
INNER JOIN emrs_d_enrollment_status s
 ON cpe.enrollment_status_id = s.enrollment_status_id
 INNER JOIN emrs_d_plan_type p
 ON cpe.plan_type_id = p.plan_type_id
 --WHERE client_number IN(14826031,14828176) 
WHERE date_created >= ADD_MONTHS(TRUNC(sysdate),-2) -- 2 months worth of data 
) t 
) tt
 );
 
 GRANT SELECT ON d_emrs_enroll_timeliness_sv TO MAXDAT_READ_ONLY;