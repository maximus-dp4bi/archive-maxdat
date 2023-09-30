DECLARE  
  CURSOR temp_cur IS
    select letter_request_id 
    from corp_etl_proc_letters 
    where instance_status = 'Active'
    and status = 'Sent'
    and create_dt < to_date('06/01/2016','mm/dd/yyyy') 
    and letter_type in ('Checkup Due Dental Letter', 'Checkup Due Medical Letter', 'Checkup Reminder Dental Letter', 'Checkup Reminder Medical Letter');
   

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
           set instance_status = 'Complete'
                ,complete_dt = sysdate
                ,stage_done_date = sysdate
                ,cancel_reason = 'TXEB-8033 - Letters were triggered in error'
                ,cancel_dt = sysdate
                ,cancel_method = 'Exception'
                ,cancel_by = 'TXEB-8033'
		     where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/