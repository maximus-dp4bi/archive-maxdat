UPDATE corp_etl_proc_letters
SET cancel_reason = 'Not valid, however status still REQ in source'
   ,instance_status = 'Complete'
   ,complete_dt = sysdate
   ,stage_done_date = sysdate
   ,cancel_dt = sysdate
   ,cancel_by = 'TXEB-5052'
   ,cancel_method = 'Exception'
   ,status = 'Canceled'
WHERE letter_request_id IN (10681906,
10681907,
10678072,
10678981,
10678143,
10678144,
10678152,
10682088,
10678253,
10680053,
10680993,
10681019,
10681218,
10681225,
10681229)
;
 
 UPDATE corp_etl_proc_letters
SET cancel_reason = 'Voided or Canceled in Source'
   ,instance_status = 'Complete'
   ,complete_dt = sysdate
   ,stage_done_date = sysdate
   ,cancel_dt = sysdate
   ,cancel_by = 'TXEB-5052'
   ,cancel_method = 'Exception'
   ,status = 'Canceled'
WHERE create_by = 'CSP_SCRPT'   
AND instance_status = 'Active';
 
commit;
 
 DECLARE  
  CURSOR temp_cur IS
  select cepl.letter_request_id
	from corp_etl_proc_letters cepl
  where instance_status = 'Active'
  and create_dt < '01-Oct-2014'
  and status = 'Sent';    

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
           set cancel_reason = 'Voided or Canceled in Source'
               ,instance_status = 'Complete'
               ,complete_dt = sysdate
               ,stage_done_date = sysdate
               ,cancel_dt = sysdate
               ,cancel_by = 'TXEB-5052'
               ,cancel_method = 'Exception'
               ,status = 'Canceled'
		     where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/