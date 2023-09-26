update CORP_CLNT_OUTREACH_PROC_LKUP
set step2 = 'Phone Call'
    ,step3 = 'Home Visit'
    ,step4 = null
    ,step5 = null
    ,step6 = null
where process = 'OUTREACH_REQUEST_9';    

commit;

DECLARE  
  CURSOR temp_cur IS
      select outreach_id from corp_etl_clnt_outreach
      where GENERIC_FIELD2 = 'OUTREACH_REQUEST_9'
      and instance_status = 'Active' ;
   

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
         set outreach_step2_type = 'Phone Call'
             ,outreach_step3_type = 'Home Visit'
             ,outreach_step4_type = null
             ,outreach_step5_type = null
             ,outreach_step6_type = null
 	       where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/