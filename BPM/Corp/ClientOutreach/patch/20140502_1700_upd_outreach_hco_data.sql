UPDATE CORP_CLNT_OUTREACH_NOTIFY_LKUP
SET process = 2
WHERE outreach_type = 'HEALTHCAREORIENTATION';

COMMIT;

alter trigger TRG_BIU_CORP_ETL_CLNT_OUTREACH disable;
alter trigger TRG_AI_CORP_ETL_CLNT_OUTRCH_Q disable;
alter trigger TRG_AU_CORP_ETL_CLNT_OUTRCH_Q disable;

DECLARE  
CURSOR co_cur IS

   SELECT outreach_id
   FROM corp_etl_clnt_outreach
   WHERE outreach_req_type = 'Health Care Orientation'
   AND instance_status = 'Complete';
   
   TYPE t_co_tab IS TABLE OF co_cur%ROWTYPE INDEX BY PLS_INTEGER;
   co_tab t_co_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN co_cur;
   LOOP
     FETCH co_cur BULK COLLECT INTO co_tab LIMIT v_bulk_limit;
     EXIT WHEN co_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..co_tab.COUNT
        UPDATE corp_etl_clnt_outreach
        SET instance_status = 'Active', complete_dt = null, stage_done_date = null, cancel_dt = null, cancel_by = null, cancel_reason = null, cancel_method = null
        WHERE outreach_id = co_tab(indx).outreach_id;       
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE co_cur;
END;
/

alter table f_cor_by_date enable row movement;

DECLARE  
CURSOR dco_cur IS

   SELECT outreach_request_id, cor_bi_id
   FROM d_cor_current
   WHERE outreach_request_type = 'Health Care Orientation'
   AND instance_status = 'Complete';
   
   TYPE t_dco_tab IS TABLE OF dco_cur%ROWTYPE INDEX BY PLS_INTEGER;
   dco_tab t_dco_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN dco_cur;
   LOOP
     FETCH dco_cur BULK COLLECT INTO dco_tab LIMIT v_bulk_limit;
     EXIT WHEN dco_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..dco_tab.COUNT
        UPDATE d_cor_current
        SET instance_status = 'Active', complete_date = null,  cancel_date = null, cancel_by = null, cancel_reason = null, cancel_method = null
        WHERE outreach_request_id = dco_tab(indx).outreach_request_id;     
                    
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE dco_cur;
END;
/

DECLARE  
CURSOR dco_cur IS

   SELECT f.fcorbd_id
   FROM d_cor_current dc, f_cor_by_date f
   where dc.cor_bi_id = f.cor_bi_id
   and outreach_request_type = 'Health Care Orientation'
   and instance_status = 'Active'
   and completion_count = 1;
   
   TYPE t_dco_tab IS TABLE OF dco_cur%ROWTYPE INDEX BY PLS_INTEGER;
   dco_tab t_dco_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN dco_cur;
   LOOP
     FETCH dco_cur BULK COLLECT INTO dco_tab LIMIT v_bulk_limit;
     EXIT WHEN dco_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
        
       FORALL indx IN 1..dco_tab.COUNT
        UPDATE f_cor_by_date
        SET completion_count = 0, inventory_count = 1,  bucket_end_date = TO_DATE('07/07/2077','mm/dd/yyyy')
        WHERE fcorbd_id = dco_tab(indx).fcorbd_id;
                           
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE dco_cur;
END;

COMMIT;

alter table f_cor_by_date disable row movement;

alter trigger TRG_BIU_CORP_ETL_CLNT_OUTREACH enable;
alter trigger TRG_AI_CORP_ETL_CLNT_OUTRCH_Q enable;
alter trigger TRG_AU_CORP_ETL_CLNT_OUTRCH_Q enable;


DECLARE
  CURSOR coqa_cur IS
   SELECT *
   FROM(
     SELECT bueq_id,identifier, extractValue(new_data,'/ROWSET/ROW/COMPLETE_DT') complete_dt,
            extractValue(new_data,'/ROWSET/ROW/OUTREACH_REQ_TYPE') outreach_req_type
     FROM bpm_update_event_queue_archive qa
     WHERE  bsl_id = 15) qa
   WHERE complete_dt IS NOT NULL  
   AND outreach_req_type = 'Health Care Orientation';
   
   TYPE t_coqa_tab IS TABLE OF coqa_cur%ROWTYPE INDEX BY PLS_INTEGER;
   coqa_tab t_coqa_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN coqa_cur;
   LOOP
     FETCH coqa_cur BULK COLLECT INTO coqa_tab LIMIT v_bulk_limit;
     EXIT WHEN coqa_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/COMPLETE_DT'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/COMPLETE_DT')
         WHERE bueq_id = coqa_tab(indx).bueq_id ;

       FORALL indx2 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/CANCEL_DT'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/CANCEL_DT')
          WHERE bueq_id = coqa_tab(indx2).bueq_id ;
         
       FORALL indx3 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/CANCEL_BY'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/CANCEL_BY')
         WHERE bueq_id = coqa_tab(indx3).bueq_id ;        
       
       FORALL indx4 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/CANCEL_REASON'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/CANCEL_REASON')
          WHERE bueq_id = coqa_tab(indx4).bueq_id ;          

     FORALL indx5 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/CANCEL_METHOD'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/CANCEL_METHOD')
          WHERE bueq_id = coqa_tab(indx5).bueq_id ;           
       
       FORALL indx6 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<COMPLETE_DT></COMPLETE_DT>'))                                               
            ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<COMPLETE_DT></COMPLETE_DT>'))                                               
          WHERE bueq_id = coqa_tab(indx6).bueq_id ;

       FORALL indx7 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_DT></CANCEL_DT>'))                                               
            ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_DT></CANCEL_DT>'))                                               
          WHERE bueq_id = coqa_tab(indx7).bueq_id ;
    
       FORALL indx8 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_BY></CANCEL_BY>'))                                               
            ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_BY></CANCEL_BY>'))                                               
          WHERE bueq_id = coqa_tab(indx8).bueq_id ;

       FORALL indx9 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_REASON></CANCEL_REASON>'))                                               
            ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_REASON></CANCEL_REASON>'))                                               
          WHERE bueq_id = coqa_tab(indx9).bueq_id ;

       FORALL indx10 IN 1..coqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_METHOD></CANCEL_METHOD>'))                                               
            ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<CANCEL_METHOD></CANCEL_METHOD>'))                                               
          WHERE bueq_id = coqa_tab(indx10).bueq_id ;      
    
      END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE coqa_cur;
END;
/

COMMIT;




