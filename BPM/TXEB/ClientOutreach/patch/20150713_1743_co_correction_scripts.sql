DECLARE  
  CURSOR temp_cur IS
   select outreach_id,STEP1,
STEP2,
STEP3,
STEP4,
STEP5,
STEP6
   from corp_etl_clnt_outreach o, CORP_CLNT_OUTREACH_PROC_LKUP l
   where o.generic_field2 = l.process
   and instance_status = 'Active'
   and generic_field2 in('OUTREACH_REQUEST_12','OUTREACH_REQUEST_13')
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
   select outreach_id,STEP1,
STEP2,
STEP3,
STEP4,
STEP5,
STEP6
   from corp_etl_clnt_outreach o, CORP_CLNT_OUTREACH_PROC_LKUP l
   where o.generic_field2 = l.process
   and instance_status = 'Complete'
   and generic_field2 in('OUTREACH_REQUEST_12','OUTREACH_REQUEST_13')
   and outreach_status not in('Outreach No Longer Required','Outreach Invalid Request');
       

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT
       LOOP
         update corp_etl_clnt_outreach
           set outreach_step1_type = temp_tab(indx).step1
               ,outreach_step2_type = temp_tab(indx).step2
               ,outreach_step3_type = temp_tab(indx).step3
               ,outreach_step4_type = temp_tab(indx).step4
               ,outreach_step5_type = temp_tab(indx).step5
               ,outreach_step6_type = temp_tab(indx).step6
               ,instance_status = 'Active'
               ,stage_done_date = null
               ,complete_dt = null
               ,max_inci_header_stat_hist_id = 0
               ,gwf_notify_source = null
               ,ased_perform_outreach = null
               ,aspb_perform_outreach = null
               ,asf_perform_outreach= 'N'               
		     where outreach_id = temp_tab(indx).outreach_id;		   
         
         delete from f_cor_by_date
         where cor_bi_id = (select cor_bi_id from d_cor_current cc where cc.outreach_request_id = temp_tab(indx).outreach_id)
         and completion_count = 1;
         
         update f_cor_by_date
         set bucket_end_date = to_date('07/07/2077','mm/dd/yyyy')
         where cor_bi_id = (select cor_bi_id from d_cor_current cc where cc.outreach_request_id = temp_tab(indx).outreach_id)
         and fcorbd_id = (select max(fcorbd_id) from f_cor_by_date fc, d_cor_current cc where fc.cor_bi_id = cc.cor_bi_id and cc.outreach_request_id = temp_tab(indx).outreach_id);
       END LOOP;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   select outreach_id,STEP1,
STEP2,
STEP3,
STEP4,
STEP5,
STEP6
   from corp_etl_clnt_outreach o, CORP_CLNT_OUTREACH_PROC_LKUP l
   where o.generic_field2 = l.process
   and instance_status = 'Complete'
   and generic_field2 in('OUTREACH_REQUEST_12','OUTREACH_REQUEST_13')
   and outreach_status in('Outreach No Longer Required','Outreach Invalid Request');
   

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


--fix queue rows

 insert into F_COR_BY_DATE
        (FCORBD_ID,
         D_DATE,
         BUCKET_START_DATE,
         BUCKET_END_DATE,
         COR_BI_ID,
         DCORCI_ID,
         DCORRS_ID,
         DCORSI_ID,
         CREATION_COUNT,
         INVENTORY_COUNT,
         COMPLETION_COUNT,
         OUTREACH_REQUEST_STATUS_DATE)
      select SEQ_FCORBD_ID.nextval
         ,create_date
         ,trunc(create_date)
         ,to_date('07/07/2077','mm/dd/yyyy')
         ,cor_bi_id
         ,( select DCORCI_ID from D_COR_COUNTY  where  COUNTY = cc.county)
         ,(select DCORRS_ID from D_COR_REQUEST_STATUS where  OUTREACH_REQUEST_STATUS = cc.outreach_request_status)
         ,265
         ,1
         ,0
         ,0
         ,outreach_request_status_date
       FROM d_cor_current cc
       WHERE outreach_request_id in(select identifier from bpm_logging
       where log_date >= trunc(sysdate-1)
       and bsl_id = 15);

commit;

execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(15);