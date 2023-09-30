DECLARE  
  CURSOR temp_cur IS
     select letter_request_id, county_code
     from(
     select letter_request_id, (select residence_county from letters_stg s where s.letter_id = l.letter_request_id) county_code
     from corp_etl_proc_letters l
     where county_code is null
     and instance_status = 'Complete'
     and create_dt >= to_date('07/01/2015','mm/dd/yyyy')
     ) where county_code is not null
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
         set county_code = temp_tab(indx).county_code       
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/