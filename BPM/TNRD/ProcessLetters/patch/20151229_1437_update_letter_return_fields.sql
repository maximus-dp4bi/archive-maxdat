DECLARE  
  CURSOR temp_cur IS
     SELECT letter_request_id, s.return_reason, s.letter_return_date return_date
     FROM d_pl_current pl
       INNER JOIN letters_stg s
         ON s.letter_id = pl.letter_request_id
     WHERE pl.return_reason IS NULL AND pl.return_date IS NULL
     AND (s.return_reason IS NOT NULL OR s.letter_return_date IS NOT NULL)     
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
         update corp_etl_proc_letters nf
         set return_reason = temp_tab(indx).return_reason
             ,return_date = temp_tab(indx).return_date
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

COMMIT;