DECLARE  
  CURSOR temp_cur IS
   select outreach_id,complete_dt
     ,case when outreach_status = 'Outreach No Longer Required' then 'Normal' else 'Exception' end cancel_method
     ,case when outreach_status = 'Outreach No Longer Required' then 'Outreach no longer required' else 'Invalid' end cancel_reason
   from corp_etl_clnt_outreach o
   where outreach_status in('Outreach No Longer Required','Outreach Invalid Request')
   and cancel_dt is null
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
         update corp_etl_clnt_outreach
           set cancel_reason = temp_tab(indx).cancel_reason
               ,cancel_method = temp_tab(indx).cancel_method
               ,cancel_by = 'TXEB-5347'
               ,cancel_dt = temp_tab(indx).complete_dt
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;