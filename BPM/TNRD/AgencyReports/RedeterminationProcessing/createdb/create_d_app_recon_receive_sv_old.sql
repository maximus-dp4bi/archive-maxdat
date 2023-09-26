CREATE OR REPLACE VIEW d_app_recon_receive_sv
AS
SELECT CASE WHEN app_receipt_date > response_due_date AND app_receipt_date <= response_due_date + 90 THEN 'Y' ELSE 'N' END rcvd_during_recon_period       
       ,application_status     
       ,task_name task_type
       ,curr_task_status task_status
       ,current_owner
       ,staff_type_cd
       ,create_date task_create_date              
       ,business_unit_name
       ,case_id       
       ,task_id 
       ,application_id
       ,application_type
       ,app_receipt_date
       ,cob_indicator
       ,recon_period_end
       ,letter_type_cd      
       ,letter_id
       ,task_priority
       ,app_priority
       ,packet_type
       ,source_reference_type
FROM (
SELECT  cl.case_id
        ,ah.application_id      
       ,TRUNC(COALESCE((SELECT MIN(ds.received_date) FROM document_set_stg ds INNER JOIN document_stg d ON ds.document_set_id = d.document_set_id
          INNER JOIN doc_link_stg dl ON d.document_id = dl.document_id WHERE doc_type_cd = 'APPLICATION' AND link_type_cd = 'APPLICATION'        
        --  AND dl.case_id = cl.case_id
          AND dl.link_ref_id = cl.application_id
          AND TRUNC(ds.received_date) >= pckt.packet_mailed_date
          ),doc_rcvd.app_receipt_date)) app_receipt_date
       ,ast.report_label application_status
       ,apt.report_label application_type       
       ,ltr.letter_mailed_date
       ,response_due_date
       ,response_due_date + 90 recon_period_end       
       ,mw.curr_task_status
       ,mw.create_date
       ,mw.task_id
       ,tt.task_name
       ,bu.business_unit_name
       ,CASE WHEN mw.curr_owner_staff_id IS NULL THEN NULL ELSE CASE WHEN s.last_name IS NULL THEN NULL ELSE s.Last_name||', '||s.First_Name END END current_owner
       ,s.staff_type_cd     
       ,CASE WHEN ah.ref_value_1 = '1' THEN 'Yes' ELSE 'No' END cob_indicator
       ,letter_type_cd
       ,letter_id
       ,mw.task_priority
       ,ah.priority app_priority
       ,pckt.packet_type
       ,COALESCE(mw.source_reference_type,'Application ID') source_reference_type
FROM  app_header_stg ah
 LEFT JOIN app_case_link_stg cl 
   ON ah.application_id = cl.application_id
 LEFT OUTER JOIN (SELECT *
                  FROM (
                   SELECT  reference_id app_id ,letter_type_cd packet_type,lr.letter_mailed_date packet_mailed_date,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY letter_create_ts DESC) rn            
                   FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
                   WHERE lr.letter_type_cd IN('TN 401','TN 401a')
                   AND lr.letter_status_cd = 'MAIL'  )                   
                  WHERE rn = 1 ) pckt
  ON ah.application_id = pckt.app_id                  
 LEFT OUTER JOIN (SELECT *
                  FROM (
                   SELECT letter_id,letter_case_id, letter_mailed_date,response_due_date, reference_id,letter_type_cd,ROW_NUMBER() OVER (PARTITION BY ll.reference_id ORDER BY response_due_date DESC) rn            
                   FROM letters_stg lr INNER JOIN letter_request_link_stg ll ON lr.letter_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
                   WHERE lr.letter_type_cd IN('TN 411', 'TN 408ftp','TN 408') -- 'TN 409', 'TN 409ftp','TN 410msp') 
                   AND lr.letter_status_cd = 'MAIL'
                   AND lr.letter_request_type IN('L','S'))                   
                  WHERE rn = 1 ) ltr  
   -- ON cl.case_id = ltr.letter_case_id
     ON ah.application_id = ltr.reference_id 
  LEFT OUTER JOIN app_status_lkup ast
    ON ah.status_cd = ast.value
  LEFT OUTER JOIN app_type_lkup apt
    ON ah.app_form_cd = apt.value
  LEFT OUTER JOIN d_mw_v2_current mw 
    ON mw.source_reference_id = ah.application_id 
    AND mw.source_reference_type = 'Application ID'
    AND mw.curr_task_status IN('CLAIMED','UNCLAIMED')
  LEFT OUTER JOIN d_task_types tt
    ON mw.task_type_id = tt.task_type_id
  LEFT OUTER JOIN d_business_units bu 
    ON mw.curr_business_unit_id = bu.business_unit_id   
  LEFT OUTER JOIN d_staff s 
    ON mw.curr_owner_staff_id = s.staff_id
  LEFT JOIN (SELECT dl.link_ref_id,MIN(ds.received_date) app_receipt_date
             FROM document_set_stg ds 
               JOIN document_stg d ON ds.document_set_id = d.document_set_id
               JOIN doc_link_stg dl ON d.document_id = dl.document_id 
             WHERE doc_type_cd = 'APPLICATION' AND link_type_cd = 'APPLICATION'        
             GROUP BY dl.link_ref_id
            ) doc_rcvd  
    ON doc_rcvd.link_ref_id = ah.application_id       
  ) app
;


GRANT SELECT ON D_APP_RECON_RECEIVE_SV TO MAXDAT_READ_ONLY;


               
      