CREATE OR REPLACE VIEW D_APPLICATION_MISSING_INFO_SV
AS
SELECT *
FROM (
SELECT ah.application_id
       ,ai.client_cin recipient_id
       ,st.report_label application_status
       ,CASE WHEN EXISTS(SELECT 1 FROM app_missing_info_stg am WHERE am.application_id = ah.application_id AND am.app_individual_id IS NULL AND am.satisfied_date IS NULL) THEN 'Has MI' ELSE 'No MI' END application_mi
       ,CASE WHEN EXISTS(SELECT 1 FROM app_missing_info_stg am WHERE am.application_id = ah.application_id AND am.app_individual_id IS NOT NULL AND am.satisfied_date IS NULL) THEN 'Has MI' ELSE 'No MI' END recipient_mi       
       ,(SELECT first_name||' '||last_name FROM d_staff s WHERE TO_CHAR(s.staff_id) = al.created_by) mi_created_by
       ,al.create_ts mi_create_ts
       ,al.report_label mi_event      
       ,mi.mi_type       
FROM app_header_stg ah
  INNER JOIN app_individual_stg ai
    ON ah.application_id = ai.application_id
  INNER JOIN app_status_lkup st
    ON ah.status_cd = st.value  
  LEFT OUTER JOIN (SELECT al.application_id, al.create_ts, et.report_label, al.created_by
                   FROM app_event_log_stg al
                   INNER JOIN app_event_type_lkup et
                      ON al.app_event_cd = et.value    
                   WHERE al.app_event_cd = 'APP_MI_ADDED'
                   AND al.create_ts = (SELECT MAX(create_ts)
                                       FROM app_event_log_stg al2
                                       WHERE al.application_id = al2.application_id
                                       AND al.app_event_cd = al2.app_event_cd)) al
    ON ah.application_id = al.application_id     
  LEFT OUTER JOIN (SELECT application_id,LISTAGG(mi_category||'-'||mi_type, ', ') WITHIN GROUP (ORDER BY application_id) mi_type
                   FROM (SELECT DISTINCT application_id, mi_type_cd,t.report_label mi_type, ic.report_label mi_category                            
                         FROM app_missing_info_stg i
                            INNER JOIN app_mi_type_lkup t
                              ON i.mi_type_cd = t.value 
                            INNER JOIN app_mi_category_lkup ic
                              ON t.mi_category = ic.value
                          WHERE i.satisfied_date IS NULL  )
                          GROUP BY application_id ) mi
    ON ah.application_id = mi.application_id      
  )
WHERE application_mi = 'Has MI'
 OR recipient_mi = 'Has MI';