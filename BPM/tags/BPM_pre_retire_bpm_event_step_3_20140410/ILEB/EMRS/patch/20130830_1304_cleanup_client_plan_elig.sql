DECLARE
 CURSOR client_cur IS
   SELECT DISTINCT client_number
   FROM emrs_d_client_plan_eligibility s1
   WHERE EXISTS(SELECT 1 FROM emrs_d_client_plan_eligibility s2 WHERE s1.client_number = s2.client_number
             AND s1.source_record_id = s2.source_record_id
             AND s1.client_plan_eligibility_id > s2.client_plan_eligibility_id );
   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;    
BEGIN
   OPEN client_cur;
   LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. clnt_tab.COUNT LOOP
      DELETE FROM emrs_d_client_plan_eligibility s1
      WHERE  EXISTS(SELECT 1 FROM emrs_d_client_plan_eligibility s2 WHERE s1.client_number = s2.client_number
             AND s1.source_record_id = s2.source_record_id
             AND s1.client_plan_eligibility_id > s2.client_plan_eligibility_id)
      AND client_number = clnt_tab(indx).client_number;
      
      FOR e IN(SELECT client_plan_eligibility_id, rownum row_num
               FROM(
               SELECT client_plan_eligibility_id       
               FROM emrs_d_client_plan_eligibility
               WHERE client_number = clnt_tab(indx).client_number
               ORDER BY version))
      LOOP
        UPDATE emrs_d_client_plan_eligibility
        SET version = e.row_num
        WHERE client_plan_eligibility_id = e.client_plan_eligibility_id;
      END LOOP;
      
      UPDATE emrs_d_client_plan_eligibility
      SET current_flag = 'Y'
          ,date_of_validity_end = TO_DATE('12/31/2050','mm/dd/yyyy')
      WHERE client_number = clnt_tab(indx).client_number
      AND version = (SELECT MAX(version)
                      FROM emrs_d_client_plan_eligibility
                      WHERE client_number = clnt_tab(indx).client_number);
      
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/
COMMIT;