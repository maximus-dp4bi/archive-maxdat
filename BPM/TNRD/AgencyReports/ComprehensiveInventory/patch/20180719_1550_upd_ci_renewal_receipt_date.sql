alter session set current_schema = MAXDAT;


--pop app receipt
DECLARE  
  CURSOR temp_cur IS 
  
 SELECT ap.received_date,
       ap.scan_date,    
       ap.method_of_receipt,
       ci.application_id
FROM tn_ci_redetermination ci
 join (       
SELECT s.received_date,ds.report_label method_of_receipt, case_id,link_ref_id application_id,d.scan_date,ROW_NUMBER() OVER (PARTITION BY case_id ORDER BY s.received_date) rn
FROM document_stg d 
 INNER JOIN document_set_stg s 
   ON d.document_set_id = s.document_set_id 
 INNER JOIN doc_link_stg dl 
   ON d.document_id = dl.document_id  
 INNER JOIN document_source_lkup ds
   ON s.doc_source_cd = ds.value 
WHERE doc_type_cd = 'APPLICATION' 
AND link_type_cd = 'APPLICATION' 
--AND NOT EXISTS(SELECT 1 FROM app_event_log_stg ae WHERE dl.link_ref_id = ae.application_id AND ae.app_event_cd ='APPLICANT_RELINKED' AND ae.create_ts >= dl.create_ts)
) ap on ci.case_id = ap.case_id 
WHERE rn = 1
and (ci.renewal_receipt_date IS NULL OR ap.received_date < ci.renewal_receipt_date)
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
         UPDATE tn_ci_redetermination
         SET method_of_receipt = temp_tab(indx).method_of_receipt
             ,scan_date = temp_tab(indx).scan_date
             ,RENEWAL_RECEIPT_DATE = temp_tab(indx).received_date
         WHERE application_id = temp_tab(indx).application_id;

     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/