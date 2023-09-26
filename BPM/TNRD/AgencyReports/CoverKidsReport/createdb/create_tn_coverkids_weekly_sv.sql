CREATE OR REPLACE VIEW TN_COVERKIDS_WEEKLY_SV AS
SELECT *
FROM (
  SELECT cas.application_id
       ,cas.app_individual_id
       ,cas.client_id      
       ,cas.case_id
       ,CASE WHEN clnt.supplemental_nbr IS NOT NULL THEN clnt.supplemental_nbr ELSE clnt.clnt_cin END household_id
       ,cas.effective_date_str effective_date
       ,cas.letter_mailed_date  
       ,19 age_19    
       ,cas.directive
       ,'M' gender_m
       ,'Y' in_yes
       ,'N' in_no
       ,'START' in_start_directive
       ,clnt.clnt_fname first_name
       ,clnt.clnt_lname last_name
       ,clnt.clnt_mi middle_name
       ,clnt.suffix
       ,TO_CHAR(clnt.clnt_dob,'YYYYMMDD') dob
       ,clnt.clnt_ssn ssn
       ,COALESCE(clnt.clnt_gender_cd,'U') gender 
       ,FLOOR(months_between(COALESCE(CASE WHEN directive = 'START' THEN TO_DATE(cas.effective_date_str,'YYYYMMDD') ELSE TRUNC(sysdate) END,TRUNC(sysdate)),clnt_dob)/12) clnt_age
       ,cas.home_phone_number
       ,cas.home_phone_type_cd
       ,cas.st_reported_phone
       ,cas.st_phone_type_cd
       ,cas.other_phone_number
       ,cas.other_phone_type
       ,cas.pregnancy
       ,cas.income_amount
       ,cas.income_frequency
       ,cas.household_size       
  FROM  coverkids_approval_stg cas
   JOIN client_stg clnt  ON cas.client_id = clnt.client_id   
   JOIN corp_etl_control ws ON ws.name = 'COVERKIDS_WKLY_RPT_START_DATE' 
   JOIN corp_etl_control we ON we.name = 'COVERKIDS_WKLY_RPT_END_DATE' 
  WHERE 1=1 
  AND cas.cumulative_ind = 'N'
  AND cas.create_date >= TO_DATE(ws.value,'YYYY/MM/DD HH24:MI:SS')
  AND cas.create_date <= TO_DATE(we.value,'YYYY/MM/DD HH24:MI:SS')
  ) appr
  WHERE NOT EXISTS(SELECT 1 FROM coverkids_approval_stg ck WHERE ck.application_id = appr.application_id AND ck.letter_mailed_date = appr.letter_mailed_date AND ck.directive = appr.directive AND cumulative_ind = 'W')  
;

GRANT SELECT ON "TN_COVERKIDS_WEEKLY_SV" TO "MAXDAT_READ_ONLY";
