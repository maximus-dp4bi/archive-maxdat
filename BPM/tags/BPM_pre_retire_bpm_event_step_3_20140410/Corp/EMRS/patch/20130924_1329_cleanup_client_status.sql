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

UPDATE corp_etl_job_statistics
SET job_end_date = SYSDATE,job_status_cd = 'ERROR'
WHERE job_status_cd = 'STARTED';

COMMIT;