 DECLARE  
  CURSOR temp_cur IS
   select letter_request_id
     from (
       select letter_request_id, count(1) 
       from CORP_ETL_PROC_LETTERS_CHD cl
       where client_id is null
       group by letter_request_id    )
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
         delete from CORP_ETL_PROC_LETTERS_CHD          
	 where letter_request_id = temp_tab(indx).letter_request_id    ;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/