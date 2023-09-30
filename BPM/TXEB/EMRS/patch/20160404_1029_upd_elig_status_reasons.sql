DECLARE  
  CURSOR temp_cur IS
  select client_elig_status_id, reasons,mvx_core_reason,sub_status_codes,disposition_cd
  FROM client_elig_Status_stg s
  WHERE reasons is not null
  and exists(select 1 from emrs_d_client_plan_eligibility e where e.source_record_id = s.client_elig_status_id and e.reasons is null)
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
        UPDATE emrs_d_client_plan_eligibility
        SET reasons = temp_tab(indx).reasons
            ,mvx_core_reason = temp_tab(indx).mvx_core_reason
            ,sub_status_codes = temp_tab(indx).sub_status_codes
            ,disposition_cd = temp_tab(indx).disposition_cd
        WHERE source_record_id = temp_tab(indx).client_elig_Status_id;        
     END;
          
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/