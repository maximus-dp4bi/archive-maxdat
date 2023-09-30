UPDATE CORP_CLNT_OUTREACH_PROC_LKUP
SET step1 = 'Phone Call5'
   ,step2 = 'Phone Call5'
   ,step3 = 'Phone Call5'
   ,step4 = null
   ,step5 = null
   ,step6 = null
WHERE process = 'OUTREACH_REQUEST_14';  



DECLARE  
  CURSOR temp_cur IS
   select outreach_id, p.step1, p.step2, p.step3,p.step4, p.step5, p.step6
    from corp_etl_clnt_outreach o inner join corp_clnt_outreach_proc_lkup p on o.generic_field2 = p.process
    where instance_status = 'Active'
    and generic_field2 = 'OUTREACH_REQUEST_14';
   

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
        set outreach_step1_type = temp_tab(indx).step1
            ,outreach_step2_type = temp_tab(indx).step2
            ,outreach_step3_type = temp_tab(indx).step3
            ,outreach_step4_type = temp_tab(indx).step4
            ,outreach_step5_type = temp_tab(indx).step5
            ,outreach_step6_type = temp_tab(indx).step6
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
    select outreach_id, assd_outreach_step1,last_update_by 
    from corp_etl_clnt_outreach
    where instance_status = 'Active'
    and outreach_status in('Outreach Successful','Outreach Unsuccessful')
    and generic_field2 = 'OUTREACH_REQUEST_14';
   

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
        set ased_outreach_step1 = null
          ,aspb_outreach_step1 = null
          ,asf_outreach_step1 = 'N'
          ,assd_outreach_step2 = null
          ,ased_outreach_step2 = null
          ,aspb_outreach_step2 = null
          ,asf_outreach_step2 = 'N'
          ,assd_outreach_step3 = null
          ,ased_outreach_step3 = null
          ,aspb_outreach_step3 = null
          ,asf_outreach_step3 = 'N'
          ,assd_outreach_step4 = null
          ,ased_outreach_step4 = null
          ,aspb_outreach_step4 = null
          ,asf_outreach_step4 = 'N'
          ,assd_outreach_step5 = null
          ,ased_outreach_step5 = null
          ,aspb_outreach_step5 = null
          ,asf_outreach_step5 = 'N'
          ,assd_outreach_step6 = null
          ,ased_outreach_step6 = null
          ,aspb_outreach_step6 = null
          ,asf_outreach_step6 = 'N'
          ,ased_perform_outreach = null
          ,aspb_perform_outreach = null
          ,asf_perform_outreach = 'N'
          ,gwf_invalid = 'N'
          ,gwf_unsuccessful = null
          ,gwf_notify_client = null
          ,gwf_notify_source = null          
          ,gwf_step2_required = null
          ,gwf_step3_required = null
          ,gwf_step4_required = null
          ,gwf_step5_required = null
          ,gwf_step6_required = null
          ,gwf_final_wait = null
          ,assd_termination_timer = null
          ,ased_termination_timer = null
          ,asf_termination_timer = 'N'
          ,assd_perform_home_visit = null
          ,aspb_perform_home_visit  = null
          ,ased_perform_home_visit = null
          ,asf_perform_home_visit  = 'N'          
    where outreach_id = temp_tab(indx).outreach_id;		   
  END;
   COMMIT;
 END LOOP;
 COMMIT;
 CLOSE temp_cur;
END;
/

commit;