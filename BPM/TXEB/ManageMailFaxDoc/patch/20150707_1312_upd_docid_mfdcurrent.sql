
DECLARE  
CURSOR doc_cur IS
   select document_id, dcn
   from corp_etl_mailfaxdoc m
   where exists(select 1 from d_mfdoc_current d where m.dcn = d.dcn and "Document ID" is null);
  
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
        UPDATE d_mfdoc_current
        SET "Document ID" = doc_tab(indx).document_id
        WHERE dcn = doc_tab(indx).dcn;       
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE doc_cur ;
END;
/
commit; 