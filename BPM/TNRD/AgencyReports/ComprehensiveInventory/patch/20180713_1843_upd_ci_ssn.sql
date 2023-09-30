DECLARE  
  CURSOR temp_cur IS
 SELECT  
      clnt_ssn         
      ,ah.application_id
      ,ci.client_id
FROM tn_ci_redetermination ci
 JOIN app_header_stg ah ON ci.application_id = ah.application_id
 JOIN app_individual_stg ai on ah.application_id = ai.application_id and ai.applicant_ind = 1
 JOIN client_stg cl  on ai.client_id = cl.client_id
WHERE ci.ssn <> clnt_ssn
OR (ci.ssn IS NULL AND clnt_ssn IS NOT NULL);

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
        SET ssn = temp_tab(indx).clnt_ssn
        WHERE application_id = temp_tab(indx).application_id
        AND client_id = temp_tab(indx).client_id;         
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/