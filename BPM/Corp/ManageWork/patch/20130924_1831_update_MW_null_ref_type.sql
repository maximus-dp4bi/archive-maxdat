-- NYHIX-1572 fix 
DECLARE
  v_min_task_id  corp_etl_manage_work.task_id%TYPE;
  v_tot          INTEGER := 0;
  v_cnt          INTEGER := 1;
BEGIN
  SELECT NVL(MIN(task_id),0) INTO v_min_task_id
    FROM corp_etl_manage_work
   WHERE source_reference_type IS NULL;
  --
  IF v_min_task_id > 0
  THEN
    FOR a IN (SELECT task_id
                   ,decode(upper(s.ref_type) 
                                     , 'APP_HEADER'         ,'Application ID'
                                      , 'APPLICATION_ID'     ,'Application ID'
                                      , 'DOCUMENT_ID'        ,'Document ID'
                                      , 'DOCUMENT'           ,'Document ID'
                                      , 'DOCUMENT_SET_ID'    ,'Document Set ID'
                                      , 'DOCUMENT_SET'       ,'Document Set ID'
                                      , 'IMAGING'            ,'Image ID'
                                      , 'CASES'              ,'Case ID'
                                      , 'CASE_ID'            ,'Case ID'
                                      , 'CLIENT'             ,'Client ID'
                                      , 'CLNT_CLIENT_ID'     ,'Client ID'
                                      , 'CALL_RECORD'        ,'Call ID'
                                      , 'CALL_RECORD_ID'     ,'Call ID'
                                      , 'INCIDENT_HEADER'    ,'Incident ID'
                                      , 'INCIDENT_HEADER_ID' ,'Incident ID'
                                      , 'APP_DOC_TRACKER_ID', 'App Doc Tracker'
                                      ,                      s.ref_type) new_source_ref_type
                FROM corp_etl_manage_work m, step_instance_stg s
               WHERE m.task_id = s.step_instance_id
                 AND source_reference_type IS NULL
                 AND m.task_id >= v_min_task_id)
    LOOP
      v_tot := v_tot + 1;
      UPDATE corp_etl_manage_work
         SET source_reference_type = a.new_source_ref_type
      WHERE task_id = a.task_id;
      --
      IF v_cnt = 500
      THEN COMMIT; v_cnt := 1;
      ELSE v_cnt := v_cnt + 1;
      END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Records updated: '||v_tot);
    COMMIT;
  END IF;
END;
/
