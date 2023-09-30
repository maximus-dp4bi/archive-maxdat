/* The app_priority_ind and app_in_process can then be reset to their previous values */
DECLARE
  CURSOR cur IS
    SELECT t.app_id
         , t.app_priority_ind
         , t.app_in_process
      FROM process_app_stg_tmp_0913 t
     WHERE EXISTS
         ( SELECT 1
             FROM process_app_stg a
            WHERE a.app_id = t.app_id
              AND ( a.app_priority_ind <> t.app_priority_ind
                 OR a.app_in_process <> t.app_in_process ));
  v_proc_ct PLS_INTEGER := 0;
  v_save_ct PLS_INTEGER := 0;
  v_upd_ct PLS_INTEGER := 0;
BEGIN
  FOR i IN cur LOOP
    v_proc_ct := v_proc_ct + 1;
    UPDATE process_app_stg
       SET app_priority_ind = i.app_priority_ind
         , app_in_process = i.app_in_process
     WHERE app_id = i.app_id;
    v_upd_ct := v_upd_ct + 1;
    v_save_ct := v_save_ct + 1;
    IF v_save_ct >= 1000 THEN
      COMMIT;
      v_save_ct := 0;
    END IF;
  END LOOP;
  COMMIT;
dbms_output.put_line( '-- Reset results of PROCESS_APP_STG: '||TO_CHAR(SYSDATE,'MM/DD/YYYY  HH:MI AM'));
dbms_output.put_line( '-- Processed: '||TO_CHAR(v_proc_ct,'999,999,990'));
dbms_output.put_line( '-- Updated  : '||TO_CHAR(v_upd_ct,'999,999,990'));
END;
/ 