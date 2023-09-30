-- TXEB-2649 One-time job populates OLTP event temp table.
-- This script updated the ETL event staging.


DECLARE  
  CURSOR temp_cur IS
  SELECT t.event_id, call_record_id
    FROM txeb2649_co_oltp_event_temp t
         INNER JOIN corp_etl_clnt_outreach_events e ON event_event_id = t.event_id
   WHERE event_call_rec_id IS NULL;

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
         UPDATE corp_etl_clnt_outreach_events
            SET event_call_rec_id = temp_tab(indx).call_record_id
         WHERE event_event_id = temp_tab(indx).event_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/