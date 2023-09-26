DECLARE  
CURSOR cmpl_cur IS
   SELECT cmpl_bi_id, PROCESS_COMPLAINTS_INCIDENTS.GET_SLA_JEOPARDY_DATE(CREATE_DATE,INCIDENT_TYPE) new_sla_jeopardy_date
   FROM d_complaint_current
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
        UPDATE d_complaint_current
        SET sla_jeopardy_date = cmpl_tab(indx).new_sla_jeopardy_date
        WHERE cmpl_bi_id = cmpl_tab(indx).cmpl_bi_id;       
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cmpl_cur ;
END;
/
commit;