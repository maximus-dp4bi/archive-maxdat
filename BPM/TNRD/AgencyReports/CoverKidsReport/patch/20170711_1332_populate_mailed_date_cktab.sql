BEGIN
FOR x IN (
select application_id,cumulative_ind,s.letter_mailed_date
FROM coverkids_approval_stg ck
--where cumulative_ind = 'Y'
 INNER JOIN (SELECT *
             FROM (
               SELECT l.reference_id,letter_update_ts, letter_mailed_date,
                      ROW_NUMBER() OVER (PARTITION BY l.reference_id ORDER BY s.letter_id DESC) rn,
                 TO_CHAR(CASE WHEN letter_type_cd = 'TN 405' THEN 
                    CASE WHEN TO_CHAR(letter_mailed_date + 20,'D') IN ('1','7') OR EXISTS(SELECT 1 FROM holidays h WHERE h.holiday_date = TRUNC(letter_mailed_date)+20) THEN
                          get_business_date(TRUNC(letter_mailed_date+20),1) ELSE TRUNC(letter_mailed_date)+20 END +1 
                         WHEN letter_type_cd = 'TN 405a' THEN (SELECT MAX(response_due_date) termination_date
                                                               FROM letters_stg lr 
                                                                  INNER JOIN letter_request_link_stg ls ON lr.letter_id = ls.lmreq_id  
                                                               WHERE lr.letter_type_cd IN('TN 411', 'TN 408ftp', 'TN 409ftp') 
                                                               AND lr.letter_status_cd = 'MAIL'
                                                               AND ls.reference_id  = l.reference_id
                                                               AND ls.reference_type = 'APP_HEADER' ) + 1                
                           ELSE null END,'YYYYMMDD') effective_date
               FROM letters_stg s
                 INNER JOIN letter_request_link_stg l ON s.letter_id = l.lmreq_id              
               WHERE l.reference_type = 'APP_HEADER'
               AND s.letter_type_cd LIKE 'TN 405%'
               AND s.letter_status_cd = 'MAIL')
             WHERE rn = 1) s ON ck.application_id = s.reference_id
--where cumulative_ind = 'N'  
where ck.letter_mailed_date is null    
) LOOP

  UPDATE coverkids_approval_stg
  SET letter_mailed_date = x.letter_mailed_date
  WHERE application_id = x.application_id
  AND cumulative_ind = x.cumulative_ind
  AND letter_mailed_date IS NULL;
END LOOP;
END;
/
commit;