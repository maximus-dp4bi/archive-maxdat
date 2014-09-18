DECLARE
 CURSOR client_cur IS
    SELECT * FROM emrs_d_client_plan_enrl_status s1
    WHERE TRUNC(s1.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy')
    AND EXISTS (SELECT 1 FROM emrs_d_client_plan_enrl_status s2 
            WHERE s1.client_number = s2.client_number 
            AND s1.plan_type_id = s2.plan_type_id 
            AND TRUNC(s2.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy')
            AND s1.version < s2.version);
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;     
    v_new_end_date DATE;
BEGIN
   OPEN client_cur;
   LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. clnt_tab.COUNT LOOP     
       v_new_end_date := clnt_tab(indx).date_of_validity_start;
       
       FOR e IN(SELECT TRUNC(date_of_validity_start) date_of_validity_end
                FROM emrs_d_client_plan_enrl_status
                WHERE client_number = clnt_tab(indx).client_number
                AND plan_type_id = clnt_tab(indx).plan_type_id
                AND version = clnt_tab(indx).version + 1)
       LOOP
         v_new_end_date := e.date_of_validity_end;
       END LOOP;  
    
     UPDATE emrs_d_client_plan_enrl_status
     SET date_of_validity_end = v_new_end_date
         ,current_flag = 'N'
     WHERE client_enroll_status_id = clnt_tab(indx).client_enroll_status_id;    
    END LOOP;
    COMMIT;
  END LOOP;
  COMMIT;
END;
/


DECLARE
 CURSOR client_cur IS
   SELECT * FROM emrs_d_client_plan_enrl_status d
   WHERE current_flag = 'Y'
   AND version < (SELECT MAX(version)
                  FROM emrs_d_client_plan_enrl_status d1
                  WHERE d1.client_number = d.client_number
                  AND d1.plan_type_id = d.plan_type_id                  
                  AND current_flag = 'N');
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;     
    v_new_end_date DATE;    
    v_current_cnt NUMBER;
BEGIN
   OPEN client_cur;
   LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. clnt_tab.COUNT LOOP     
       v_new_end_date := clnt_tab(indx).date_of_validity_start;              
       v_current_cnt := 0;
       
       FOR e IN(SELECT TRUNC(date_of_validity_start) date_of_validity_end
                FROM emrs_d_client_plan_enrl_status
                WHERE client_number = clnt_tab(indx).client_number
                AND plan_type_id = clnt_tab(indx).plan_type_id                
                AND version = clnt_tab(indx).version + 1)
       LOOP
         v_new_end_date := e.date_of_validity_end;         
       END LOOP;  
    
       UPDATE emrs_d_client_plan_enrl_status
       SET date_of_validity_end = v_new_end_date
           ,current_flag = 'N'
       WHERE client_enroll_status_id = clnt_tab(indx).client_enroll_status_id;    
     
       SELECT COUNT(1)
       INTO v_current_cnt
       FROM emrs_d_client_plan_enrl_status
       WHERE client_number = clnt_tab(indx).client_number
       AND plan_type_id = clnt_tab(indx).plan_type_id       
       AND current_flag = 'Y';
     
       IF v_current_cnt = 0 THEN     
         UPDATE emrs_d_client_plan_enrl_status el
         SET date_of_validity_end = TO_DATE('12/31/2050','MM/DD/YYYY')
             ,current_flag = 'Y'
         WHERE client_number = clnt_tab(indx).client_number
         AND plan_type_id = clnt_tab(indx).plan_type_id         
         AND version = (SELECT MAX(version)
                        FROM emrs_d_client_plan_enrl_status el1
                        WHERE el1.client_number = el.client_number
                        AND el1.plan_type_id = el.plan_type_id );                      
       END IF;
    END LOOP;
    COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
    SELECT * FROM emrs_d_client_plan_eligibility s1
    WHERE TRUNC(s1.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy')
    AND EXISTS (SELECT 1 FROM emrs_d_client_plan_eligibility s2 
            WHERE s1.client_number = s2.client_number 
            AND s1.plan_type_id = s2.plan_type_id 
            AND s1.sub_program_id = s2.sub_program_id
            AND TRUNC(s2.date_of_validity_end) = to_date('12/31/2050','mm/dd/yyyy')
            AND s1.version < s2.version);
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;     
    v_new_end_date DATE;
BEGIN
   OPEN client_cur;
   LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. clnt_tab.COUNT LOOP     
       v_new_end_date := clnt_tab(indx).date_of_validity_start;
       
       FOR e IN(SELECT TRUNC(date_of_validity_start) date_of_validity_end
                FROM emrs_d_client_plan_eligibility
                WHERE client_number = clnt_tab(indx).client_number
                AND plan_type_id = clnt_tab(indx).plan_type_id
                AND sub_program_id = clnt_tab(indx).sub_program_id
                AND version = clnt_tab(indx).version + 1)
       LOOP
         v_new_end_date := e.date_of_validity_end;
       END LOOP;  
    
     UPDATE emrs_d_client_plan_eligibility
     SET date_of_validity_end = v_new_end_date
         ,current_flag = 'N'
     WHERE client_plan_eligibility_id = clnt_tab(indx).client_plan_eligibility_id;    
    END LOOP;
    COMMIT;
  END LOOP;
  COMMIT;
END;
/

DECLARE
 CURSOR client_cur IS
   SELECT * FROM emrs_d_client_plan_eligibility d
   WHERE current_flag = 'Y'
   AND version < (SELECT MAX(version)
                  FROM emrs_d_client_plan_eligibility d1
                  WHERE d1.client_number = d.client_number
                  AND d1.plan_type_id = d.plan_type_id
                  AND d1.sub_program_id = d.sub_program_id
                  AND current_flag = 'N');
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;     
    v_new_end_date DATE;    
    v_current_cnt NUMBER;
BEGIN
   OPEN client_cur;
   LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. clnt_tab.COUNT LOOP     
       v_new_end_date := clnt_tab(indx).date_of_validity_start;              
       v_current_cnt := 0;
       
       FOR e IN(SELECT TRUNC(date_of_validity_start) date_of_validity_end
                FROM emrs_d_client_plan_eligibility
                WHERE client_number = clnt_tab(indx).client_number
                AND plan_type_id = clnt_tab(indx).plan_type_id
                AND sub_program_id = clnt_tab(indx).sub_program_id
                AND version = clnt_tab(indx).version + 1)
       LOOP
         v_new_end_date := e.date_of_validity_end;         
       END LOOP;  
    
       UPDATE emrs_d_client_plan_eligibility
       SET date_of_validity_end = v_new_end_date
           ,current_flag = 'N'
       WHERE client_plan_eligibility_id = clnt_tab(indx).client_plan_eligibility_id;    
     
       SELECT COUNT(1)
       INTO v_current_cnt
       FROM emrs_d_client_plan_eligibility
       WHERE client_number = clnt_tab(indx).client_number
       AND plan_type_id = clnt_tab(indx).plan_type_id
       AND sub_program_id = clnt_tab(indx).sub_program_id
       AND current_flag = 'Y';
     
       IF v_current_cnt = 0 THEN     
         UPDATE emrs_d_client_plan_eligibility el
         SET date_of_validity_end = TO_DATE('12/31/2050','MM/DD/YYYY')
             ,current_flag = 'Y'
         WHERE client_number = clnt_tab(indx).client_number
         AND plan_type_id = clnt_tab(indx).plan_type_id
         AND sub_program_id = clnt_tab(indx).sub_program_id
         AND version = (SELECT MAX(version)
                        FROM emrs_d_client_plan_eligibility el1
                        WHERE el1.client_number = el.client_number
                        AND el1.plan_type_id = el.plan_type_id
                        AND el1.sub_program_id = el.sub_program_id);                      
       END IF;
    END LOOP;
    COMMIT;
  END LOOP;
  COMMIT;
END;
/

COMMIT;

