 DECLARE  
  CURSOR temp_cur IS
    SELECT task_id,COALESCE(SI.CLIENT_ID,ai.client_id,dl.client_id,dls.client_id) client_id
           , COALESCE(SI.CASE_ID,al.case_id,dl.case_id,dls.case_id) CASE_ID
    FROM corp_etl_mw_v2 si
    LEFT JOIN app_individual_stg ai ON ai.application_id = SI.source_reference_id AND SI.source_reference_type = 'Application ID' AND ai.applicant_ind = 1
     LEFT JOIN app_case_link_stg al ON al.application_id = SI.source_reference_id AND SI.source_reference_type = 'Application ID'     
     LEFT JOIN document_set_stg ds ON ds.document_set_id = si.source_reference_id AND si.source_reference_type = 'Document Set ID'
     LEFT JOIN document_stg d ON d.document_set_id = ds.document_set_id
     LEFT JOIN doc_link_stg dl ON d.document_id = dl.document_id 
     LEFT JOIN app_doc_data_stg ad ON ad.app_doc_data_id = si.source_reference_id AND si.source_reference_type = 'APP_DOC_DATA'
     LEFT JOIN doc_link_stg dls ON ad.document_id = dls.document_id
   WHERE si.client_id IS NULL
   AND COALESCE(SI.CLIENT_ID,ai.client_id,dl.client_id,dls.client_id) IS NOT NULL
   ;
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT         
        update corp_etl_mw_v2
        set client_id = temp_tab(indx).client_id
            ,case_id  = temp_tab(indx).case_id
        where task_id = temp_tab(indx).task_id;    
  END;
   COMMIT;
 END LOOP;
 COMMIT;
 CLOSE temp_cur;
END;
/ 

COMMIT;