SELECT count(1) FROM corp_etl_clnt_outreach --470994
where trunc(create_dt) < to_date('05/01/2018','mm/dd/yyyy')
and trunc(outreach_status_dt) <= to_date('06/30/2018','mm/dd/yyyy')
and instance_status = 'Active';


 DECLARE  
  CURSOR temp_cur IS
   select outreach_id, outreach_status_dt
   FROM corp_etl_clnt_outreach
   WHERE trunc(create_dt) < to_date('05/01/2018','mm/dd/yyyy')
   AND trunc(outreach_status_dt) <= to_date('06/30/2018','mm/dd/yyyy')
   AND instance_status = 'Active';     

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
               ,cancel_dt = sysdate
               ,cancel_by = 'MAXDAT'
               ,cancel_reason = 'TXEB-12641 - old instance complete in source'
               ,stage_done_date = sysdate
               ,stg_last_update_date = sysdate              
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/