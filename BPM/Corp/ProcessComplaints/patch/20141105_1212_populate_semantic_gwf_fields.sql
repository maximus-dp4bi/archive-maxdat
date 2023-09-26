DECLARE  
  CURSOR temp_cur IS
   SELECT incident_id, gwf_followup_req
   FROM corp_etl_complaints_incidents
   WHERE gwf_followup_req is not null;

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
         UPDATE d_complaint_current
            SET gwf_followup_req = temp_tab(indx).gwf_followup_req
         WHERE incident_id = temp_tab(indx).incident_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

BEGIN
  FOR ci IN(SELECT incident_id, gwf_return_to_state
            FROM corp_etl_complaints_incidents
            WHERE gwf_return_to_state is not null)
  LOOP
    UPDATE d_complaint_current
    SET gwf_return_to_state = ci.gwf_return_to_state
    WHERE incident_id = ci.incident_id;
  END LOOP;
  COMMIT;
END;
/

DECLARE  
  CURSOR temp_cur IS
   SELECT incident_id, gwf_resolved_sup
   FROM corp_etl_complaints_incidents
   WHERE gwf_resolved_sup is not null;

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
         UPDATE d_complaint_current
            SET gwf_resolved_sup = temp_tab(indx).gwf_resolved_sup
         WHERE incident_id = temp_tab(indx).incident_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

DECLARE  
  CURSOR temp_cur IS
   SELECT incident_id, gwf_resolved_ees_css
   FROM corp_etl_complaints_incidents
   WHERE gwf_resolved_ees_css is not null;

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
         UPDATE d_complaint_current
            SET gwf_resolved_ees_css = temp_tab(indx).gwf_resolved_ees_css
         WHERE incident_id = temp_tab(indx).incident_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/