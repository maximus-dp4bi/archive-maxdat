DECLARE  
  CURSOR temp_cur IS
     select letter_request_id, new_county_code,county_code
     from(
     select letter_request_id, (select residence_county from letters_stg s where s.letter_id = l.letter_request_id) new_county_code, county_code     
     from corp_etl_proc_letters l
     where instance_status = 'Complete'
     and create_dt >= to_date('10/01/2015 00:00:00','mm/dd/yyyy hh24:mi:ss')
     ) 
     where new_county_code is not null 
     and (new_county_code <> county_code or county_code is null) 
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
         set county_code = temp_tab(indx).new_county_code          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
     select letter_request_id, new_zip_code,zip_code
     from(
     select letter_request_id, zip_code,
     (select residence_zip_code from letters_stg s where s.letter_id = l.letter_request_id) new_zip_code
     from corp_etl_proc_letters l
     where instance_status = 'Complete'
     and create_dt >= to_date('10/01/2015 00:00:00','mm/dd/yyyy hh24:mi:ss')
     ) 
     where new_zip_code is not null 
     and (new_zip_code <> zip_code or zip_code is null)
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
         set zip_code = temp_tab(indx).new_zip_code          
	       where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/