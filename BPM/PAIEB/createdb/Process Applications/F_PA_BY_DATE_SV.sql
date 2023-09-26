--alter session set current_schema=maxdat_support
CREATE OR REPLACE VIEW F_PA_BY_DATE_SV
AS
SELECT /*+ parallel(5) */ ah.application_id app_id
   ,d_date
   ,COALESCE(ah.status_cd,'UD') app_status_code
   ,COALESCE(he.reason_delay_cd,'UD') reason_delay_code
   ,COALESCE(he.enroll_delayed_reason_cd,'UD') enroll_delayed_reason_cd                  
   ,COALESCE(he.enroll_delayed_ind, 0) nf_flag
   ,TRUNC(he.app_start_date) app_start_dt
   ,sh.end_date complete_dt
   ,ah.create_ts create_dt       
   ,COALESCE(mi_dates.lcd_date,oc.locadatereceived) loca_date_received
   ,COALESCE(mi_dates.pc_date,oc.pcdatereceived) pc_date_received  
   ,CASE  
    WHEN TRUNC(COALESCE(sh.end_date, bdd.d_date)) < bdd.d_date
    THEN TRUNC(sh.end_date)
    ELSE bdd.d_date END - TRUNC(ah.create_ts) age_in_caldays_from_creation      
   ,CASE WHEN ah.created_by = 'DATA_CONVERSION' AND 
                CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END NOT IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED') AND TRUNC(oc.opendate) < bdd.d_date 
         THEN bdd.d_date - TRUNC(oc.opendate)  
         WHEN ah.created_by <> 'DATA_CONVERSION' AND 
                CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED') 
         THEN TRUNC(sh.end_date) - TRUNC(he.app_start_date) 
         WHEN TRUNC(he.app_start_date) < bdd.d_date THEN bdd.d_date - TRUNC(he.app_start_date)
         ELSE 0 
     END age_in_caldays_from_open
   ,CASE
      WHEN bdd.d_date >= TRUNC(ah.create_ts) AND 
           bdd.d_date <  
          CASE WHEN 
                CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED') 
          THEN TRUNC(sh.end_date) ELSE bdd.d_date + 1 END
      THEN 1
      ELSE 0
    END AS inventory_count 
   ,CASE
      WHEN bdd.d_date >= TRUNC(sh.pending_end_dt) AND 
           bdd.d_date < 
          CASE WHEN 
                CASE WHEN bdd.d_date < TRUNC(sh.end_date) THEN sh.start_cd ELSE sh.end_cd END IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED') 
          THEN TRUNC(sh.end_date) ELSE bdd.d_date + 1 END
      THEN 1
      ELSE 0
    END AS inventory_no_pending_count 
    ,CASE
      WHEN bdd.d_date = TRUNC(ah.create_ts)
      THEN 1
      ELSE 0
    END creation_count 
    ,CASE
      WHEN sh.end_date IS NOT NULL AND bdd.d_date >= TRUNC(sh.end_date)
      THEN 1
      ELSE 0
    END AS completion_count
     ,CASE
      WHEN he.enroll_delayed_ind = 1 
      THEN 1
      ELSE 0
    END AS delayed_enroll_count
FROM app_header ah 
JOIN app_header_ext he ON ah.application_id = he.application_id 
LEFT JOIN harmony_conv.openclose oc ON oc.openid = ah.application_id 
--This is getting the first and last app_history_status records for each application and then uses a maxdat_support table to determine if that status is an inventory status. 
LEFT JOIN (SELECT COALESCE(a.application_id, b.application_id) as application_id, a.start_date, b.end_date, a.start_cd, b.end_cd, c.pending_start_dt, c.pending_end_dt
            FROM (SELECT l.last, l.app_status_history_id, l.application_id, l.status_date as start_date, l.status_cd as start_cd 
                  FROM (SELECT FIRST_VALUE(app_status_history_id) OVER(PARTITION BY sh.application_id, aps.inventory_indicator ORDER BY app_status_history_id) last
                    ,sh.app_status_history_id
                    ,sh.application_id
                    ,sh.status_cd
                    ,sh.status_date
                    ,aps.inventory_indicator
                    FROM app_status_history sh
                    JOIN d_app_status aps ON (sh.status_cd = aps.app_status_code)
                    WHERE sh.app_status_history_id >= 1530000) l 
                  WHERE l.last = l.app_status_history_id
                  AND l.inventory_indicator = 1) a
            --I used first_value but I am ordering desc      
            FULL OUTER JOIN (SELECT f.first, f.app_status_history_id, f.application_id, f.status_date as end_date, f.status_cd as end_cd 
                  FROM  (SELECT FIRST_VALUE(app_status_history_id) OVER(PARTITION BY sh.application_id, aps.inventory_indicator ORDER BY app_status_history_id DESC) first
                    ,sh.app_status_history_id
                    ,sh.application_id
                    ,sh.status_cd
                    ,sh.status_date
                    ,aps.inventory_indicator
                    FROM app_status_history sh
                    JOIN d_app_status aps ON (sh.status_cd = aps.app_status_code)
                    WHERE sh.app_status_history_id >= 1530000
                    ) f 
                  WHERE f.first = f.app_status_history_id
                  AND f.inventory_indicator = 0) b ON (a.application_id = b.application_id) 
            FULL OUTER JOIN (SELECT a.application_id
                              , a.pending_start_dt
                              , a.pending_end_dt
                              FROM (SELECT sh.application_id
                                    , sh.status_cd
                                    , sh.status_date AS pending_start_dt
                                    , ROW_NUMBER() OVER(PARTITION BY sh.application_id, sh.status_cd ORDER BY sh.app_status_history_id ASC) rn
                                    , LEAD(sh.status_date, 1) OVER (PARTITION BY sh.application_id ORDER BY sh.app_status_history_id ASC) pending_end_dt
                                    FROM app_status_history sh
                                    WHERE sh.app_status_history_id >= 1530000
                                    ) a
                              WHERE a.status_cd = 'PENDING'
                              AND a.rn = 1) c ON (a.application_id = c.application_id) ) sh ON ah.application_id = sh.application_id   
  LEFT JOIN (SELECT application_id
              ,MAX(lcd_date) as lcd_date
              ,MAX(pc_date) as pc_date
              FROM
              (SELECT  mi.application_id
              ,mi.mi_type_cd
              ,CASE WHEN mi.mi_type_cd = 'lcd' THEN mi.satisfied_date ELSE NULL END AS lcd_date
              ,CASE WHEN mi.mi_type_cd = 'pc' THEN mi.satisfied_date ELSE NULL END AS pc_date
              ,RANK() OVER(PARTITION BY mi.application_id, mi.mi_type_cd ORDER BY mi.missing_info_id DESC) AS rnk
              FROM app_missing_info mi
              WHERE mi.mi_type_cd IN ('lcd','pc')
              and mi.application_id >= 343555)
              WHERE rnk = 1
              GROUP BY application_id ) mi_dates ON ah.application_id = mi_dates.application_id
JOIN d_dates bdd  ON bdd.d_date >= TRUNC(ah.create_ts) 
AND bdd.d_date <= CASE WHEN CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END IN ('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED') THEN TRUNC(sh.end_date) ELSE TRUNC(sysdate) END
and ah.application_id >= 343555
and ah.create_ts >= ADD_MONTHS(TRUNC(sysdate, 'mm'), -13)
;

    
GRANT SELECT ON F_PA_BY_DATE_SV TO MAXDAT_REPORTS;
GRANT SELECT ON F_PA_BY_DATE_SV TO MAXDAT_SUPPORT_READ_ONLY;
            
