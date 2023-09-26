CREATE OR REPLACE VIEW D_PA_COMPASS_SV
AS
SELECT DISTINCT 
      ah.app_header_id AS app_hdr_id --table key --Compass App Hdr ID
      ,cl.clnt_client_id AS client_id --can be null if join to SSN fails
      ,ai.individual_number AS individual_number --compass ind id -Compass Ind Number
      ,acl.application_id AS application_id --can be null if join to app_header fails
      ,ah.application_number AS application_number --compass app id - Compass App Num
      ,TRUNC(ah.compass_submit_dt) AS submit_date 
      ,ah.process_ts AS process_dt 
      ,ah.error_message AS error_message
      ,ah.error_count as error_count 
      ,cscl.cscl_case_id AS case_id 
      ,ahr.status_cd AS app_status --MAXe App Status
      ,CASE WHEN cl.clnt_ssn IS NOT NULL THEN 'CLIENT SSN FOUND' else 'CLNT SSN NOT FOUND' END AS match_client 
      ,ah.address_line_1 AS address_1 
      ,ah.address_line_2 AS address_2 
      ,ah.city AS city 
      ,ah.state_cd AS state 
      ,ah.zip AS zip  
      ,ai.first_nm AS first_name 
      ,ai.last_nm AS last_name 
      ,ai.ssn AS ssn 
      ,TRUNC(ai.dob) AS dob 
FROM ats.etl_l_comp_app_header ah 
JOIN ats.etl_l_comp_app_indv ai ON ah.app_header_id = ai.app_header_id 
LEFT JOIN ats.client cl ON ai.ssn = cl.clnt_ssn 
LEFT JOIN ats.case_client cscl ON cl.clnt_client_id = cscl.cscl_clnt_client_id 
LEFT JOIN ats.app_case_link acl ON cscl.cscl_case_id = acl.case_id 
LEFT JOIN ats.app_header ahr ON ahr.application_id = acl.application_id 
WHERE ah.error_message IS NOT NULL 
AND ah.error_count > 0 
AND ah.error_code IS NOT NULL;

GRANT SELECT ON D_PA_COMPASS_SV TO MAXDAT_REPORTS;