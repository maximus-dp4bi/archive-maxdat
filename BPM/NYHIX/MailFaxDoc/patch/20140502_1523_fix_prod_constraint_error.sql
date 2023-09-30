DECLARE  
CURSOR mfdqa_cur IS
  SELECT dcn, instance_start_date, instance_end_date
  FROM NYHIX_ETL_MAIL_FAX_DOC mfd
  WHERE EXISTS(SELECT 1 FROM bpm_update_event_queue_archive q WHERE mfd.dcn = q.identifier AND bsl_id = 18)
  and dcn ='10262489' 
  ;
   
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
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/INSTANCE_START_DATE'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/INSTANCE_START_DATE')
         WHERE identifier = mfdqa_tab(indx).dcn
         AND bsl_id = 18;
        
       FORALL indx1 IN 1..mfdqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
         SET OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/INSTANCE_END_DATE'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/INSTANCE_END_DATE')
         WHERE identifier = mfdqa_tab(indx1).dcn
         AND bsl_id = 18;
       
       
       FORALL indx2 IN 1..mfdqa_tab.COUNT
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_START_DATE>' || to_char(mfdqa_tab(indx2).instance_start_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_START_DATE>'))                                               
             ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_START_DATE>' || to_char(mfdqa_tab(indx2).instance_start_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_START_DATE>'))                                               
         WHERE identifier = mfdqa_tab(indx2).dcn
         AND bsl_id = 18;
      
      FORALL indx3 IN 1..mfdqa_tab.COUNT   
         UPDATE BPM_UPDATE_EVENT_QUEUE_ARCHIVE
         SET old_data = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_END_DATE>'|| to_char(mfdqa_tab(indx3).instance_end_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_END_DATE>'))
             ,new_data = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<INSTANCE_END_DATE>'|| to_char(mfdqa_tab(indx3).instance_end_date,'YYYY-MM-DD HH24:MI:SS') || '</INSTANCE_END_DATE>'))
         WHERE identifier = mfdqa_tab(indx3).dcn
         AND bsl_id = 18;
      END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mfdqa_cur;
END;
/

DELETE
FROM f_nyhix_mfd_by_date
WHERE nyhix_mfd_bi_id IN (2656188);

DELETE
FROM d_nyhix_mfd_current
WHERE nyhix_mfd_bi_id IN (2656188);
COMMIT;

INSERT
INTO bpm_update_event_queue
  (
    BUEQ_ID,
    BSL_ID,
    BIL_ID,
    IDENTIFIER,
    EVENT_DATE,
    QUEUE_DATE,
    PROCESS_BUEQ_ID,
  --  WROTE_BPM_EVENT_DATE,
    WROTE_BPM_SEMANTIC_DATE,
    DATA_VERSION,
    OLD_DATA,
    NEW_DATA
  )
SELECT BUEQ_ID,
  BSL_ID,
  BIL_ID,
  IDENTIFIER,
  EVENT_DATE,
  QUEUE_DATE,
  NULL,
 -- WROTE_BPM_EVENT_DATE,
  NULL,
  DATA_VERSION,
  OLD_DATA,
  NEW_DATA
FROM bpm_update_event_queue_archive
WHERE BSL_ID    = 18
AND identifier  ='10262489' ;

DELETE FROM bpm_update_event_queue_archive
WHERE BSL_ID    = 18
AND identifier ='10262489' ;

COMMIT;

alter table f_nyhix_mfd_by_date enable row movement;

DECLARE  
CURSOR cfmfd_cur IS

  SELECT f.fnmfdbd_id, cmfd.instance_start_date instance_start_date 
  FROM F_NYHIX_MFD_BY_DATE f,D_NYHIX_MFD_CURRENT cmfd
  WHERE f.nyhix_mfd_bi_id = cmfd.nyhix_mfd_bi_id
  AND creation_count = 1
  AND cmfd.instance_start_date <> f.d_date
  AND NOT EXISTS(SELECT 1 FROM F_NYHIX_MFD_BY_DATE f2 WHERE f.nyhix_mfd_bi_id = f2.nyhix_mfd_bi_id AND f2.bucket_start_date = trunc(instance_start_date) AND f.fnmfdbd_id != f2.fnmfdbd_id);
  
   TYPE t_cfmfd_tab IS TABLE OF cfmfd_cur%ROWTYPE INDEX BY PLS_INTEGER;
   cfmfd_tab t_cfmfd_tab; 
   v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN cfmfd_cur;
   LOOP
     FETCH cfmfd_cur BULK COLLECT INTO cfmfd_tab LIMIT v_bulk_limit;
     EXIT WHEN cfmfd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cfmfd_tab.COUNT
         UPDATE F_NYHIX_MFD_BY_DATE
         SET bucket_start_date =  TRUNC(cfmfd_tab(indx).instance_start_date),
             d_date =  cfmfd_tab(indx).instance_start_date
         WHERE fnmfdbd_id = cfmfd_tab(indx).fnmfdbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cfmfd_cur;
END;
/
COMMIT;

alter table f_nyhix_mfd_by_date disable row movement;