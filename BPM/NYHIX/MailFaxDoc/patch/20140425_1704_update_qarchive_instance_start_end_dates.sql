DECLARE  
CURSOR mfdqa_cur IS
  SELECT bueq_id, extractValue(new_data,'/ROWSET/ROW/COMPLETE_DT') complete_dt,event_date,
    (SELECT instance_start_date FROM NYHIX_ETL_MAIL_FAX_DOC WHERE dcn = qa.identifier) instance_start_date,
     CASE WHEN  extractValue(new_data,'/ROWSET/ROW/COMPLETE_DT') IS NULL THEN NULL
       ELSE (SELECT instance_end_date FROM NYHIX_ETL_MAIL_FAX_DOC WHERE dcn = qa.identifier) END instance_end_date
   FROM bpm_update_event_queue_archive qa
   WHERE bsl_id = 18
   AND existsnode(old_data,'ROWSET/ROW/INSTANCE_START_DATE') = 0
   AND existsnode(new_data,'ROWSET/ROW/INSTANCE_START_DATE') = 0;
   
   TYPE t_mfdqa_tab IS TABLE OF mfdqa_cur %ROWTYPE INDEX BY PLS_INTEGER;
   mfdqa_tab t_mfdqa_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mfdqa_cur;
   LOOP
     FETCH mfdqa_cur BULK COLLECT INTO mfdqa_tab LIMIT v_bulk_limit;
     EXIT WHEN mfdqa_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
     /*  FORALL indx IN 1..mfdqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/INSTANCE_START_DATE'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/INSTANCE_START_DATE')
         WHERE bueq_id = mfdqa_tab(indx).bueq_id;      
        
       FORALL indx1 IN 1..mfdqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/INSTANCE_END_DATE'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/INSTANCE_END_DATE')
         WHERE bueq_id = mfdqa_tab(indx1).bueq_id;      
       */  
       FORALL indx2 IN 1..mfdqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_START_DATE>' || to_char(mfdqa_tab(indx2).instance_start_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_START_DATE>'))                                               
             ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_START_DATE>' || to_char(mfdqa_tab(indx2).instance_start_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_START_DATE>'))                                               
         WHERE bueq_id = mfdqa_tab(indx2).bueq_id;      
      
      FORALL indx3 IN 1..mfdqa_tab.COUNT   
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_END_DATE>'|| to_char(mfdqa_tab(indx3).instance_end_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_END_DATE>'))
             ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_END_DATE>'|| to_char(mfdqa_tab(indx3).instance_end_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_END_DATE>'))
         WHERE bueq_id = mfdqa_tab(indx3).bueq_id;      
      END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfdqa_cur;
END;
/

--fix the create_dt for previously updated records
DECLARE  
CURSOR mfdqa_cur IS
   SELECT bueq_id,dcn, (SELECT create_dt FROM NYHIX_ETL_MAIL_FAX_DOC WHERE dcn = qa.dcn) create_dt
   FROM (
      SELECT bueq_id,extractValue(new_data,'/ROWSET/ROW/DCN') dcn
      FROM bpm_update_event_queue_archive qa
      WHERE bsl_id = 18 
      AND identifier in ('10004236','10009683','10009684','10009685','10009686','10009687','10009688','10009692','10009693','10009694','10009695','10009698','10009699',
'10009701','10009706','10009707','10009708','10009709','10009710','10009721','10009731','10009732','10009733','10009734','10032330','10044506','10060938','10101141',
'10101142','10101486','10138360','10138361','10138362','10138363','10138364','10138365','10138366','10138367','10138368','10138369','10138370','10138371','10138372',
'10138373','10138374','10138375','10138376','10138377','10138378','10138379','10138380','10138381','10138382','10138383','10138384','10138385','10138386','10138387',
'10138388','10138389','10138390','10138391','10138392','10138393','10138394','10138395','10138396','10138397','10145154'))qa;
 
   
   TYPE t_mfdqa_tab IS TABLE OF mfdqa_cur %ROWTYPE INDEX BY PLS_INTEGER;
   mfdqa_tab t_mfdqa_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mfdqa_cur;
   LOOP
     FETCH mfdqa_cur BULK COLLECT INTO mfdqa_tab LIMIT v_bulk_limit;
     EXIT WHEN mfdqa_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mfdqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/CREATE_DT'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/CREATE_DT')
         WHERE bueq_id = mfdqa_tab(indx).bueq_id;
        
       
       FORALL indx2 IN 1..mfdqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<CREATE_DT>' || to_char(mfdqa_tab(indx2).create_dt,'YYYY-MM-DD HH24:MI:SS') || '</CREATE_DT>'))                                               
            ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<CREATE_DT>' || to_char(mfdqa_tab(indx2).create_dt,'YYYY-MM-DD HH24:MI:SS') || '</CREATE_DT>'))                                               
         WHERE bueq_id = mfdqa_tab(indx2).bueq_id;
    
      END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfdqa_cur;
END;
/

COMMIT;