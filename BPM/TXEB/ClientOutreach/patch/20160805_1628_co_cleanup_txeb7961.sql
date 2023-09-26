DECLARE  
  CURSOR temp_cur IS
    select outreach_id,outreach_status_dt, last_update_by 
    from corp_etl_clnt_outreach
    where create_dt < to_date('07/01/2016 00:00:00','mm/dd/yyyy hh24:mi:ss')
    and outreach_status = 'Outreach Unsuccessful'
    and instance_status = 'Active';
   

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
         update corp_etl_clnt_outreach
           set GWF_UNSUCCESSFUL = 'Y'                
                ,instance_status = 'Complete'
                ,complete_dt = temp_tab(indx).outreach_status_dt
                ,stage_done_date = sysdate
                ,cancel_reason = 'TXEB-7961 - Closing old instances'
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/