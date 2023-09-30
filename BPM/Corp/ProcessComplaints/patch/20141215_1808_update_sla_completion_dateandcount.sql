DECLARE  
  CURSOR TEMP_CUR IS
   SELECT incident_id,
         (SELECT min(create_ts) from incident_header_stat_hist_stg s where ci.incident_id = s.incident_header_id
          and (s.incident_status like '%State%' or s.incident_status like '%Close%' or s.incident_status like '%Withdrawn%')) sla_complete_dt
   FROM corp_etl_complaints_incidents ci
   WHERE sla_satisfied = 'Y'
   AND sla_complete_dt is null;

  TYPE T_TAB IS TABLE OF TEMP_CUR%ROWTYPE INDEX BY PLS_INTEGER;
  TEMP_TAB T_TAB;
  V_BULK_LIMIT NUMBER := 500;

BEGIN  
   OPEN TEMP_CUR;
   LOOP
     FETCH TEMP_CUR BULK COLLECT INTO TEMP_TAB LIMIT V_BULK_LIMIT;
     EXIT WHEN TEMP_TAB.COUNT = 0; 
  
     BEGIN
       FORALL INDX IN 1..TEMP_TAB.COUNT
         UPDATE corp_etl_complaints_incidents
         SET sla_complete_dt = temp_tab(indx).sla_complete_dt
         WHERE incident_id = temp_tab(indx).incident_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE TEMP_CUR;
END;
/

update corp_etl_complaints_incidents
set sla_complete_dt = complete_dt
   WHERE sla_satisfied = 'Y'
   AND sla_complete_dt is null;
   
commit;   

DECLARE  
  CURSOR TEMP_CUR IS
   SELECT f.fcmplbd_id,cc.sla_complete_date
   FROM f_complaint_by_date f, d_complaint_current cc
   WHERE f.cmpl_bi_id = cc.cmpl_bi_id
   AND f.sla_complete_date is null
   AND dcmplss_id = 1;

  TYPE T_TAB IS TABLE OF TEMP_CUR%ROWTYPE INDEX BY PLS_INTEGER;
  TEMP_TAB T_TAB;
  V_BULK_LIMIT NUMBER := 500;

BEGIN  
   OPEN TEMP_CUR;
   LOOP
     FETCH TEMP_CUR BULK COLLECT INTO TEMP_TAB LIMIT V_BULK_LIMIT;
     EXIT WHEN TEMP_TAB.COUNT = 0; 
  
     BEGIN
       FORALL INDX IN 1..TEMP_TAB.COUNT
         UPDATE f_complaint_by_date
         SET sla_complete_date = temp_tab(indx).sla_complete_date
         WHERE fcmplbd_id = temp_tab(indx).fcmplbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE TEMP_CUR;
END; 
/