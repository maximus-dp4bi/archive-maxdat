DECLARE  
  CURSOR temp_cur IS
  select letter_request_id, 
         CASE WHEN program = 'CHIP' THEN 'CHIP Letter' 
              WHEN program = 'Medicaid' THEN 'Medicaid Letter'
         ELSE 'Other Letter' END new_sla_category         
  from d_pl_current
  where INSTANCE_STATUS = 'Complete'
  and sla_category = 'Other Letter'
  and trunc(create_date) >= to_date('08/01/2014','mm/dd/yyyy');

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
          UPDATE d_pl_current
            SET sla_category = temp_tab(indx).new_sla_category   
          WHERE letter_request_id = temp_tab(indx).letter_request_id;     
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;