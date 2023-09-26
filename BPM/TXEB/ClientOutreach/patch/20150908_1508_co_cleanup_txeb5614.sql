DECLARE  
  CURSOR temp_cur IS
    select outreach_id,outreach_status_dt, last_update_by 
    from corp_etl_clnt_outreach
    where outreach_req_type IN('THSteps Checkup OverDue Dental Letters','THSteps Checkup OverDue Medical Letters','THSteps Checkup Due Medical Letters','THSteps Checkup Due Dental Letters')
            AND outreach_status = 'Outreach Successful'
    and instance_status = 'Active'   ;
   

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
           set ASED_OUTREACH_STEP1 =	temp_tab(indx).outreach_status_dt
                ,ASPB_OUTREACH_STEP1	= temp_tab(indx).last_update_by
                ,ASF_OUTREACH_STEP1 = 'Y'                  
                ,GWF_STEP2_REQUIRED = 'N'
                ,GWF_UNSUCCESSFUL = 'N'
                ,ASED_PERFORM_OUTREACH = temp_tab(indx).outreach_status_dt
                ,ASF_PERFORM_OUTREACH = 'Y'
                ,ASPB_PERFORM_OUTREACH = temp_tab(indx).last_update_by
                ,instance_status = 'Complete'
                ,complete_dt = temp_tab(indx).outreach_status_dt
                ,stage_done_date = sysdate
		     where outreach_id = temp_tab(indx).outreach_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
delete from bpm_update_event_queue
where bsl_id = 15
and identifier in(
'53991377',
'53991378',
'53991379',
'53991382',
'53991381',
'53991394',
'53991395',
'53991392',
'53991396',
'53991388',
'53991397',
'53991386',
'53991387',
'53991385');

update corp_etl_clnt_outreach
set generic_field2 = 'OUTREACH_REQUEST_5'
where outreach_id in(
53991377,
53991378,
53991379,
53991382,
53991381,
53991394,
53991395,
53991392,
53991396,
53991388,
53991397,
53991386,
53991387,
53991385);

commit;