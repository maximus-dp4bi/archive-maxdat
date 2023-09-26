DECLARE  
CURSOR cmpl_cur IS
   SELECT doc_notification_id new_doc_notification_id
   FROM nyhix_etl_doc_notifications
   WHERE instance_status = 'Complete'
  ;  
   
   TYPE t_cmpl_tab IS TABLE OF cmpl_cur %ROWTYPE INDEX BY PLS_INTEGER;
   cmpl_tab t_cmpl_tab ;
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cmpl_cur;
   LOOP
     FETCH cmpl_cur BULK COLLECT INTO cmpl_tab LIMIT v_bulk_limit;
     EXIT WHEN cmpl_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cmpl_tab.COUNT
                                update nyhix_etl_doc_notifications
                                set INSTANCE_STATUS = 'Active' 
                                ,STAGE_DONE_DATE = null 
                                ,COMPLETE_DT  = null
                                ,CANCEL_DT = null
                                ,CANCEL_BY = null
                                ,CANCEL_REASON = null
                                ,CANCEL_METHOD = null
                                where doc_notification_id = cmpl_tab(indx).new_doc_notification_id;                       
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cmpl_cur ;
END;
/
commit;
