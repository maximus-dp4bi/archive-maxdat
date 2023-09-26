 DECLARE  
  CURSOR temp_cur IS
  select cepl.letter_request_id
	from corp_etl_proc_letters cepl
  where instance_status = 'Active'
  and TRUNC(create_dt) < TO_DATE('02/01/2017','mm/dd/yyyy');    

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
         update corp_etl_proc_letters
           set cancel_reason = 'TXEB-9529 - old letters with non-terminal status not active in MAXeb'
               ,instance_status = 'Complete'
               ,complete_dt = sysdate
               ,stage_done_date = sysdate
               ,cancel_dt = sysdate
               ,cancel_by = 'TXEB-9529'
               ,cancel_method = 'Exception'
         where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

commit;