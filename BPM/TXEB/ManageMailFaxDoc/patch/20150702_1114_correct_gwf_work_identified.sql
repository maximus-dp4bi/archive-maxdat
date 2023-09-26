DECLARE  
CURSOR doc_cur IS
   select m.document_id, gwf_work_identified,COALESCE((SELECT 'Y' FROM corp_etl_list_lkup WHERE name  = 'ProcessMail_work_expected' AND list_type LIKE 'DOC_TYPE%'
                AND value = m.document_type AND out_var = m.work_task_type_created),'N') new_gwf_work_identified  
   from corp_etl_mailfaxdoc m
   WHERE instance_status = 'Active'
   and gwf_work_identified <> COALESCE((SELECT 'Y' FROM corp_etl_list_lkup WHERE name  = 'ProcessMail_work_expected' AND list_type LIKE 'DOC_TYPE%'
                AND value = m.document_type AND out_var = m.work_task_type_created),'N')  ;
  
   TYPE t_doc_tab IS TABLE OF doc_cur %ROWTYPE INDEX BY PLS_INTEGER;
   doc_tab t_doc_tab ;
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN doc_cur;
   LOOP
     FETCH doc_cur BULK COLLECT INTO doc_tab LIMIT v_bulk_limit;
     EXIT WHEN doc_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..doc_tab.COUNT
        UPDATE corp_etl_mailfaxdoc
        SET gwf_work_identified = doc_tab(indx).new_gwf_work_identified
        WHERE document_id = doc_tab(indx).document_id;       
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE doc_cur ;
END;
/
commit; 

DECLARE  
CURSOR doc_cur IS
   select document_id
   from corp_etl_mailfaxdoc m
   where instance_status = 'Active'
   and gwf_autolink_outcome = 'Autolink Successful'
   and gwf_document_barcoded = 'Y'
   and gwf_work_identified = 'N';
  
   TYPE t_doc_tab IS TABLE OF doc_cur %ROWTYPE INDEX BY PLS_INTEGER;
   doc_tab t_doc_tab ;
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN doc_cur;
   LOOP
     FETCH doc_cur BULK COLLECT INTO doc_tab LIMIT v_bulk_limit;
     EXIT WHEN doc_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..doc_tab.COUNT
       UPDATE corp_etl_mailfaxdoc
       SET assd_create_ia_task = null
           ,ased_create_ia_task = null
           ,asf_create_ia_task = 'N'
           ,assd_classify_form_doc_manual = null
           ,ased_classify_form_doc_manual = null
           ,asf_classify_form_doc_manual = 'N'
           ,assd_create_and_route_work = null
           ,ased_create_and_route_work = null
           ,asf_create_and_route_work = 'N'
        WHERE document_id = doc_tab(indx).document_id;     
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE doc_cur ;
END;
/
commit;