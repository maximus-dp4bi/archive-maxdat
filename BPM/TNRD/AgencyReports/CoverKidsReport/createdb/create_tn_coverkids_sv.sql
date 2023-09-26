
CREATE OR REPLACE VIEW TN_COVERKIDS_DAILY_SV
AS
SELECT *
FROM (
  SELECT ah.application_id
       ,ai.app_individual_id
       ,ai.client_id      
       ,cls.case_id
       ,CASE WHEN clnt.supplemental_nbr IS NOT NULL THEN clnt.supplemental_nbr ELSE clnt.clnt_cin END household_id           
       ,s.effective_date
       ,s.letter_mailed_date
       ,19 age_19
       ,'START' directive  
       ,'M' gender_m
       ,'Y' in_yes
       ,'N' in_no
       ,'START' in_start_directive
       ,'N' pend_ck_found
       ,s.letter_update_ts       
       ,clnt.clnt_fname first_name
       ,clnt.clnt_lname last_name
       ,clnt.clnt_mi middle_name
       ,clnt.suffix
       ,TO_CHAR(clnt.clnt_dob,'YYYYMMDD') dob
       ,clnt.clnt_ssn ssn
       ,COALESCE(clnt.clnt_gender_cd,'U') gender 
       ,FLOOR(months_between(COALESCE(TO_DATE(s.effective_date,'YYYYMMDD'),TRUNC(sysdate)),clnt.clnt_dob)/12) clnt_age
  FROM app_header_stg ah
   INNER JOIN app_individual_stg ai
     ON ah.application_id = ai.application_id
   INNER JOIN app_case_link_stg cls
     ON ah.application_id = cls.application_id
   INNER JOIN app_elig_outcome_stg ae
    ON ah.application_id = ae.application_id
    AND ai.app_individual_id = ae.app_individual_id
   INNER JOIN client_stg clnt 
    ON ai.client_id = clnt.client_id
   INNER JOIN (SELECT *
               FROM (
                 SELECT l.reference_id,letter_update_ts,letter_mailed_date,
                        ROW_NUMBER() OVER (PARTITION BY l.reference_id,s.letter_type_cd ORDER BY s.letter_mailed_date,s.letter_id DESC) rn,
                        coalesce( TO_CHAR(CASE WHEN letter_type_cd = 'TN 405' THEN 
                                        CASE WHEN TO_CHAR(letter_mailed_date + 20,'D') IN ('1','7') OR EXISTS(SELECT 1 FROM holidays h WHERE h.holiday_date = TRUNC(letter_mailed_date)+20) THEN
                                          get_business_date(TRUNC(letter_mailed_date+20),1) ELSE TRUNC(letter_mailed_date)+20 END +1 
                                     WHEN letter_type_cd IN('TN 405a', 'TN 413a') THEN term_ltr.response_due_date + 1                
                                     WHEN letter_type_cd = 'TN 413' THEN 											 
                                              (SELECT MAX(received_date) app_receipt_date
   										       FROM document_stg d 
 										       INNER JOIN document_set_stg s ON d.document_set_id = s.document_set_id 
									  	       INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id  
										       WHERE doc_type_cd = 'APPLICATION' 
										       AND link_type_cd = 'APPLICATION'
										       AND link_ref_id = l.reference_id ) 
                           ELSE null END,'YYYYMMDD') , to_char(o.EFFECTIVEDATEVALUE, 'YYYYMMDD')) effective_date
                 FROM letters_stg s
                   INNER JOIN letter_request_link_stg l ON s.letter_id = l.lmreq_id   
                   LEFT JOIN (SELECT l.response_due_date,l.reference_id
                              FROM(
                                SELECT l.*,ROW_NUMBER() OVER (PARTITION BY l.reference_id ORDER BY response_due_date DESC) lrn
                                FROM (SELECT l.reference_id,response_due_date,letter_id, 
                                           ROW_NUMBER() OVER (PARTITION BY l.reference_id,s.letter_type_cd ORDER BY s.letter_mailed_date,s.letter_id DESC) rn                                          
                                       FROM letters_stg s
                                         INNER JOIN letter_request_link_stg l ON s.letter_id = l.lmreq_id                   
                                       WHERE l.reference_type = 'APP_HEADER'
                                       AND letter_type_cd IN('TN 411', 'TN 408ftp')
                                       AND s.letter_request_type IN('L','S')
                                       AND s.letter_status_cd = 'MAIL' ) l
                                 WHERE rn = 1 ) l
                               WHERE lrn = 1 ) term_ltr ON term_ltr.reference_id = l.reference_id
                   JOIN corp_etl_control ds ON ds.name = 'COVERKIDS_RPT_START_DATE'
                   LEFT JOIN  LETTER_OUT_DATA_CONTENT_STG o ON s.letter_id = o.LETTER_REQ_ID
                 WHERE l.reference_type = 'APP_HEADER'                 
                 AND s.letter_type_cd IN('TN 405','TN 405a','TN 413', 'TN 413a') 
                 AND s.letter_status_cd = 'MAIL'
				         AND s.letter_request_type IN('L','S')
                 AND s.letter_update_ts >= TO_DATE(ds.value,'YYYY/MM/DD HH24:MI:SS')-5)
               WHERE rn = 1) s ON ah.application_id = s.reference_id

  WHERE 1=1  
UNION
  SELECT application_id
         ,app_individual_id
         ,client_id
         ,case_id
         ,household_id
         ,CASE WHEN directive = 'START' THEN effective_date ELSE TO_CHAR(response_due_date,'YYYYMMDD') END effective_date
         ,letter_mailed_date
         ,age_19
         ,directive
         ,gender_m
         ,in_yes
         ,in_no
         ,in_start_directive
         ,pend_ck_found
         ,letter_update_ts         
         ,first_name
         ,last_name
         ,middle_name
         ,suffix
         ,dob
         ,ssn
         ,gender 
         ,FLOOR(months_between(COALESCE(CASE WHEN directive = 'START' THEN response_due_date + 1 ELSE TRUNC(sysdate) END,TRUNC(sysdate)),clnt_dob)/12) clnt_age
  FROM(SELECT ah.application_id
           ,ai.app_individual_id
           ,ai.client_id      
           ,cls.case_id
           ,clnt.supplemental_nbr household_id              
           ,s.effective_date
           ,s.letter_mailed_date
           ,19 age_19       
           ,CASE WHEN letter_type_cd IN('TN 408ftp', 'TN 411') AND  ah.status_cd != 'DISREGARDED' AND                 
             EXISTS(SELECT 1 
                  FROM app_event_log_stg av
                    JOIN app_individual_stg ai ON av.application_id = ai.application_id AND applicant_ind = 1
                    JOIN doc_link_stg dl ON ai.client_id = dl.client_id
                    JOIN  document_stg d ON dl.document_id = d.document_id
                    JOIN document_set_stg ds ON d.document_set_id = ds.document_set_id    
                  WHERE ah.application_id = av.application_id
                  AND link_type_cd = 'APPLICATION'
                  AND app_event_cd = 'PEND_CK'
                  AND TRUNC(av.create_ts) = TRUNC(dl.create_ts)
                  AND ((TRUNC(ds.received_date) >= s.letter_mailed_date AND TRUNC(ds.received_date) <= response_due_date)
                     OR (TRUNC(ds.received_date) < s.letter_mailed_date AND TRUNC(dl.create_ts) >= s.letter_mailed_date))
                  ) THEN 'START' ELSE 'TERMINATE' END directive 
           ,'M' gender_m
           ,'Y' in_yes
           ,'N' in_no
           ,'START' in_start_directive
           ,CASE WHEN letter_type_cd IN('TN 408ftp', 'TN 411') AND
              EXISTS(SELECT 1 
                     FROM app_event_log_stg av
                       JOIN app_individual_stg ai ON av.application_id = ai.application_id AND applicant_ind = 1
                       JOIN doc_link_stg dl ON ai.client_id = dl.client_id
                       JOIN  document_stg d ON dl.document_id = d.document_id
                       JOIN document_set_stg ds ON d.document_set_id = ds.document_set_id    
                     WHERE ah.application_id = av.application_id
                     AND link_type_cd = 'APPLICATION'
                     AND app_event_cd = 'PEND_CK'
                     AND TRUNC(av.create_ts) = TRUNC(dl.create_ts)
                     AND TRUNC(av.create_ts) >= letter_requested_on AND TRUNC(av.create_ts) <= s.letter_mailed_date) THEN 'Y' ELSE 'N' END pend_ck_found       
           ,s.letter_update_ts      
           ,s.response_due_date
           ,clnt.clnt_fname first_name
           ,clnt.clnt_lname last_name
           ,clnt.clnt_mi middle_name
           ,clnt.suffix
           ,TO_CHAR(clnt.clnt_dob,'YYYYMMDD') dob
           ,clnt.clnt_ssn ssn
           ,COALESCE(clnt.clnt_gender_cd,'U') gender 
           ,clnt.clnt_dob
        FROM app_header_stg ah
          INNER JOIN app_individual_stg ai
            ON ah.application_id = ai.application_id
          INNER JOIN app_case_link_stg cls
            ON ah.application_id = cls.application_id
          LEFT JOIN app_elig_outcome_stg ae
            ON ah.application_id = ae.application_id
            AND ai.app_individual_id = ae.app_individual_id
          INNER JOIN client_stg clnt 
            ON ai.client_id = clnt.client_id
          INNER JOIN (SELECT *
               FROM (
                 SELECT l.reference_id,letter_update_ts,letter_mailed_date,letter_sent_on,letter_requested_on,letter_type_cd,response_due_date,
                        ROW_NUMBER() OVER (PARTITION BY l.reference_id,s.letter_type_cd ORDER BY s.letter_mailed_date,s.letter_id DESC) rn,
                        TO_CHAR(response_due_date + 1 ,'YYYYMMDD' ) effective_date
                 FROM letters_stg s
                   INNER JOIN letter_request_link_stg l ON s.letter_id = l.lmreq_id
                   JOIN corp_etl_control ds ON ds.name = 'COVERKIDS_RPT_START_DATE'
                   WHERE l.reference_type = 'APP_HEADER'
                 AND letter_type_cd IN('TN 411', 'TN 408ftp','TN 408')
                 AND s.letter_request_type IN('L','S')
                 AND s.letter_status_cd = 'MAIL'
                 AND s.letter_update_ts >= TO_DATE(ds.value,'YYYY/MM/DD HH24:MI:SS')-5)
               WHERE rn = 1) s ON ah.application_id = s.reference_id

        WHERE 1=1
        AND clnt.supplemental_nbr IS NOT NULL -- CK members denied for Coverkids but approved for other programs 
        AND (ae.program_cd != 'CHIP' OR ae.program_cd IS NULL)
        AND NOT EXISTS(SELECT 1 FROM etl_e_daily_accent_staging_stg das WHERE das.transaction_cd = 'A' AND das.process_ts IS NOT NULL
                       AND das.application_id = ah.application_id
                       AND TRUNC(das.process_ts) >= TRUNC(s.letter_update_ts) )  
        ) t       
WHERE ( pend_ck_found = 'N' AND NOT EXISTS(SELECT 1 FROM tn_coverkids_exception ae WHERE ae.application_id = t.application_id AND ae.directive = t.directive AND exclude_flag = 'Y')
  AND (directive = 'TERMINATE'  OR
   (directive = 'START' AND NOT EXISTS(SELECT 1 FROM coverkids_approval_stg ae WHERE ae.application_id = t.application_id AND ae.directive = 'TERMINATE' AND ae.cumulative_ind = 'N' AND ae.letter_mailed_date > t.letter_mailed_date))
   ) )   
UNION
  SELECT x.application_id
         ,ai.app_individual_id
         ,x.client_id
         ,x.case_id
         ,CASE WHEN clnt.supplemental_nbr IS NOT NULL THEN clnt.supplemental_nbr ELSE clnt.clnt_cin END household_id
         ,TO_CHAR(x.effective_date,'YYYYMMDD') effective_date
         ,s.letter_mailed_date
         ,19 age_19
         ,x.directive
         ,'M' gender_m
         ,'Y' in_yes
         ,'N' in_no
         ,'START' in_start_directive
         ,'N' pend_ck_found            
         ,s.letter_update_ts
         ,clnt.clnt_fname first_name
         ,clnt.clnt_lname last_name
         ,clnt.clnt_mi middle_name
         ,clnt.suffix
         ,TO_CHAR(clnt.clnt_dob,'YYYYMMDD') dob
         ,clnt.clnt_ssn ssn
         ,COALESCE(clnt.clnt_gender_cd,'U') gender 
         ,FLOOR(months_between(COALESCE(x.effective_date,TRUNC(sysdate)),clnt.clnt_dob)/12) clnt_age
  FROM tn_coverkids_exception x
    JOIN app_individual_stg ai ON x.application_id = ai.application_id
    JOIN client_stg clnt ON x.client_id = clnt.client_id
    JOIN letters_stg s ON x.letter_id = s.letter_id
  WHERE exclude_flag = 'N'  
) appr
WHERE 1=1
AND NOT EXISTS(SELECT 1 FROM coverkids_approval_stg ck WHERE ck.application_id = appr.application_id AND ck.letter_mailed_date = appr.letter_mailed_date AND ck.directive = appr.directive AND cumulative_ind = 'N')  
;

GRANT SELECT ON "TN_COVERKIDS_DAILY_SV" TO "MAXDAT_READ_ONLY";