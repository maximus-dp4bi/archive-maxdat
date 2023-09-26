
DECLARE  
  CURSOR temp_cur IS
  select outreach_id,outreach_status_dt, last_update_by, 'N' gwf_unsuccessful
  from corp_etl_clnt_outreach
where instance_status = 'Active'
and outreach_req_type in('THSteps Checkup Due Medical Letters','THSteps Checkup OverDue Dental Letters','THSteps Checkup Due Dental Letters','THSteps Checkup OverDue Medical Letters')
and outreach_status = 'Outreach Successful'--in ('Outreach Successful','Outreach Unsuccessful')
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
           set ased_outreach_step1 =  temp_tab(indx).outreach_status_dt  
               ,aspb_outreach_step1 = temp_tab(indx).last_update_by                 
               ,asf_outreach_step1 = 'Y'
               ,ased_perform_outreach =  temp_tab(indx).outreach_status_dt  
               ,aspb_perform_outreach = temp_tab(indx).last_update_by                 
               ,gwf_unsuccessful = temp_tab(indx).gwf_unsuccessful
               ,instance_status = 'Complete'
               ,stage_done_date = sysdate
               ,complete_dt = temp_tab(indx).outreach_status_dt  
               ,stg_last_update_date = sysdate
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
