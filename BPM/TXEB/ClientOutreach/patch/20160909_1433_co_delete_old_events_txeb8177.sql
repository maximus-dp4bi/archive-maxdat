DECLARE  
  CURSOR temp_cur IS
    select event_id
    from corp_etl_clnt_outreach_events
    where event_create_dt between to_date('01/01/2013 00:00:00','mm/dd/yyyy hh24:mi:ss')
    and to_date('08/31/2015 23:59:59','mm/dd/yyyy hh24:mi:ss');
   

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
         delete from corp_etl_clnt_outreach_events
	 where event_id = temp_tab(indx).event_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/