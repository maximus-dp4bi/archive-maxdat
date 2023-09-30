-- TXEB-3622


DECLARE  
  v_invalid_status VARCHAR2(30)   := 'Outreach Invalid Request';
  v_not_req_status VARCHAR2(30)   := 'Outreach No Longer Required';
  v_withdrawn_status VARCHAR2(30) := 'Withdrawn';

  v_invalid_method VARCHAR2(30) := 'Exception';
  v_invalid_reason VARCHAR2(30) := 'Invalid';

  v_not_req_method VARCHAR2(30) := 'Normal';
  v_not_req_reason VARCHAR2(30) := v_not_req_status;

  v_withdrawn_method VARCHAR2(30) := 'Normal';
  v_withdrawn_reason VARCHAR2(30) := v_withdrawn_status;

  CURSOR cancel_cur IS
  SELECT outreach_id, last_update_by, last_update_dt
       , CASE outreach_status
         WHEN v_invalid_status THEN v_invalid_method
         WHEN v_not_req_status THEN v_not_req_method
         ELSE v_withdrawn_method
         END cancel_method
       , CASE outreach_status
         WHEN v_invalid_status THEN v_invalid_reason
         WHEN v_not_req_status THEN v_not_req_reason
         ELSE v_withdrawn_reason
         END cancel_reason
  FROM corp_etl_clnt_outreach
 WHERE outreach_status IN (v_withdrawn_status,v_not_req_status, v_invalid_status)
   AND instance_status = 'Complete'
--and outreach_id = 26064121
   AND (cancel_by IS NULL OR cancel_dt IS NULL OR complete_dt IS NULL OR stage_done_date IS NULL);

  TYPE t_tab IS TABLE OF cancel_cur%ROWTYPE INDEX BY PLS_INTEGER;
  cancel_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN cancel_cur;
   LOOP
     FETCH cancel_cur BULK COLLECT INTO cancel_tab LIMIT v_bulk_limit;
     EXIT WHEN cancel_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..cancel_tab.COUNT
         UPDATE corp_etl_clnt_outreach
            SET cancel_method = NVL(cancel_method, cancel_tab(indx).cancel_method)
              , cancel_reason = NVL(cancel_reason, cancel_tab(indx).cancel_reason)
              , cancel_by     = NVL(cancel_by,     cancel_tab(indx).last_update_by)
              , cancel_dt     = NVL(cancel_dt,     cancel_tab(indx).last_update_dt)
              , complete_dt   = NVL(complete_dt,   cancel_tab(indx).last_update_dt)
              , stage_done_date = NVL(stage_done_date,cancel_tab(indx).last_update_dt)
         WHERE outreach_id = cancel_tab(indx).outreach_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cancel_cur;
END;
/