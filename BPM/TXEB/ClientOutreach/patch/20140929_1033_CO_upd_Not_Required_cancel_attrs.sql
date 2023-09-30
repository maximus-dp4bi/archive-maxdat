-- TXEB-3622


DECLARE  
  v_not_req_status VARCHAR2(30) := 'Outreach No Longer Required';

  CURSOR cancel_cur IS
  SELECT outreach_id
  FROM corp_etl_clnt_outreach
 WHERE outreach_status = v_not_req_status
   AND instance_status = 'Complete'
   AND outreach_id >= 26064678
   AND cancel_reason = 'Deleted' AND cancel_method = v_not_req_status;

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
            SET cancel_method = 'Normal'
              , cancel_reason = v_not_req_status
         WHERE outreach_id = cancel_tab(indx).outreach_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cancel_cur;
END;
/