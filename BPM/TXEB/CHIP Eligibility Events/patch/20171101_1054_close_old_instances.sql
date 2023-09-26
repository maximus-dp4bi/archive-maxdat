DECLARE  
  CURSOR temp_cur IS
    select * from txeb_etl_chip_elig_events
    WHERE  instance_status = 'Active'
    AND create_dt < to_date('06/01/2017 00:00:00','mm/dd/yyyy hh24:mi:ss');
   
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
        UPDATE txeb_etl_chip_elig_events
SET instance_status = 'Complete'
    ,instance_end_date = sysdate
    ,stage_done_date = sysdate
    ,complete_dt = sysdate
    ,cancel_reason = 'TXEB-10546 - close old instances'
    ,cancel_by = 'TXEB-10546'
        where tecee_id = temp_tab(indx).tecee_id;    
  END;
   COMMIT;
 END LOOP;
 COMMIT;
 CLOSE temp_cur;
END;
/

commit;