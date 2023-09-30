
 DECLARE  
  CURSOR temp_cur IS
   select outreach_id, outreach_status_dt
   from corp_etl_clnt_outreach o
   where instance_status = 'Active'
   and outreach_status in ('Outreach Invalid Request','Outreach Successful', 'Outreach Unsuccessful', 'Outreach No Longer Required')
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
           set instance_status = 'Complete'
               ,complete_dt = temp_tab(indx).outreach_status_dt
               ,stage_done_date = sysdate
               ,cancel_by = 'TXEB-5100' -- to mark those that were updated by this script
               ,stg_last_update_date = sysdate
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/


 DECLARE  
  CURSOR temp_cur IS
    select o.outreach_id, o.curr_task_id, w.task_status
    from corp_etl_clnt_outreach o, corp_etl_manage_work w
    where o.curr_task_id = w.task_id
    and o.curr_task_status != w.task_status   ;    

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
           set curr_Task_status = temp_tab(indx).task_status              
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/