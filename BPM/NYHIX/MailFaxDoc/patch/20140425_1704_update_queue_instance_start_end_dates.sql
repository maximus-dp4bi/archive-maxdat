DECLARE  
CURSOR mfdq_cur IS
  SELECT dcn, instance_start_date, instance_end_date
  FROM NYHIX_ETL_MAIL_FAX_DOC mfd
  WHERE EXISTS(SELECT 1 FROM bpm_update_event_queue q WHERE mfd.dcn = q.identifier AND bsl_id = 18)
  --and dcn ='10005001' 
  ;
   
   TYPE t_mfdq_tab IS TABLE OF mfdq_cur %ROWTYPE INDEX BY PLS_INTEGER;
   mfdq_tab t_mfdq_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mfdq_cur;
   LOOP
     FETCH mfdq_cur BULK COLLECT INTO mfdq_tab LIMIT v_bulk_limit;
     EXIT WHEN mfdq_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mfdq_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE 
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/INSTANCE_START_DATE'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/INSTANCE_START_DATE')
         WHERE identifier = mfdq_tab(indx).dcn
         AND bsl_id = 18;
        
       FORALL indx1 IN 1..mfdq_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE 
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/INSTANCE_END_DATE'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/INSTANCE_END_DATE')
         WHERE identifier = mfdq_tab(indx1).dcn
         AND bsl_id = 18;
              
       FORALL indx2 IN 1..mfdq_tab.COUNT
         UPDATE bpm_update_event_queue
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_START_DATE>' || to_char(mfdq_tab(indx2).instance_start_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_START_DATE>'))                                               
             ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_START_DATE>' || to_char(mfdq_tab(indx2).instance_start_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_START_DATE>'))                                               
         WHERE identifier = mfdq_tab(indx2).dcn
         AND bsl_id = 18;
      
      FORALL indx3 IN 1..mfdq_tab.COUNT   
         UPDATE bpm_update_event_queue
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_END_DATE>'|| to_char(mfdq_tab(indx3).instance_end_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_END_DATE>'))
             ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_END_DATE>'|| to_char(mfdq_tab(indx3).instance_end_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_END_DATE>'))
         WHERE identifier = mfdq_tab(indx3).dcn
         AND bsl_id = 18;
      END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfdq_cur;
END;
/

--fix the create date for previously updated records
DECLARE  
CURSOR mfdq_cur IS
   SELECT dcn, create_dt
  FROM NYHIX_ETL_MAIL_FAX_DOC mfd
  WHERE dcn in('10004236','10009683','10009684','10009685','10009686','10009687','10009688','10009692','10009693','10009694','10009695','10009698','10009699',
'10009701','10009706','10009707','10009708','10009709','10009710','10009721','10009731','10009732','10009733','10009734','10032330','10044506','10060938','10101141',
'10101142','10101486','10138360','10138361','10138362','10138363','10138364','10138365','10138366','10138367','10138368','10138369','10138370','10138371','10138372',
'10138373','10138374','10138375','10138376','10138377','10138378','10138379','10138380','10138381','10138382','10138383','10138384','10138385','10138386','10138387',
'10138388','10138389','10138390','10138391','10138392','10138393','10138394','10138395','10138396','10138397','10145154')
  AND EXISTS(SELECT 1 FROM bpm_update_event_queue q WHERE mfd.dcn = q.identifier AND bsl_id = 18);
  
   TYPE t_mfdq_tab IS TABLE OF mfdq_cur %ROWTYPE INDEX BY PLS_INTEGER;
   mfdq_tab t_mfdq_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mfdq_cur;
   LOOP
     FETCH mfdq_cur BULK COLLECT INTO mfdq_tab LIMIT v_bulk_limit;
     EXIT WHEN mfdq_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mfdq_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/CREATE_DT'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/CREATE_DT')
         WHERE identifier = mfdq_tab(indx).dcn
         AND bsl_id = 18;
        
       
       FORALL indx2 IN 1..mfdq_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<CREATE_DT>' || to_char(mfdq_tab(indx2).create_dt,'YYYY-MM-DD HH24:MI:SS') || '</CREATE_DT>'))                                               
            ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<CREATE_DT>' || to_char(mfdq_tab(indx2).create_dt,'YYYY-MM-DD HH24:MI:SS') || '</CREATE_DT>'))                                               
         WHERE identifier = mfdq_tab(indx2).dcn
         AND bsl_id = 18;    
      END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfdq_cur;
END;
/

COMMIT;