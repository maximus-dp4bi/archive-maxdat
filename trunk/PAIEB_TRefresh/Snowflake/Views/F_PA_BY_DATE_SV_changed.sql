create or replace view MAXDAT_SUPPORT.F_PA_BY_DATE_SV(
  APP_ID,
  D_DATE,
  APP_STATUS_CODE,
  REASON_DELAY_CODE,
  ENROLL_DELAYED_REASON_CD,
  NF_FLAG,
  APP_START_DT,
  COMPLETE_DT,
  CREATE_DT,
  LOCA_DATE_RECEIVED,
  PC_DATE_RECEIVED,
  AGE_IN_CALDAYS_FROM_CREATION,
  AGE_IN_CALDAYS_FROM_OPEN,
  INVENTORY_COUNT,
  INVENTORY_NO_PENDING_COUNT,
  CREATION_COUNT,
  COMPLETION_COUNT,
  DELAYED_ENROLL_COUNT
) as
SELECT /*+ parallel(5) */ ah.application_id app_id
   ,d_date
   ,COALESCE(ah.status_cd,'UD') app_status_code
   ,COALESCE(he.reason_delay_cd,'UD') reason_delay_code
   ,COALESCE(he.enroll_delayed_reason_cd,'UD') enroll_delayed_reason_cd
   ,COALESCE(he.enroll_delayed_ind, 0) nf_flag
   ,CAST(he.app_start_date AS DATE) app_start_dt
   ,sh.end_date complete_dt
   ,ah.create_ts create_dt
   ,mi_dates.lcd_date as  loca_date_received
   ,mi_dates.pc_date as  pc_date_received
   ,(CASE
    WHEN CAST(COALESCE(sh.end_date, bdd.d_date) AS DATE) < bdd.d_date
    THEN CAST(sh.end_date AS DATE)
    ELSE CAST(bdd.d_date as DATE) END) - cast(ah.create_ts as date) age_in_caldays_from_creation
  ,CASE WHEN date_TRUNC('day', he.app_start_date) < bdd.d_date THEN date_trunc('day',bdd.d_date) - cast(date_TRUNC('day',he.app_start_date) as date)
         ELSE 0
     END as age_in_caldays_from_open
   ,CASE
      WHEN bdd.d_date >= CAST(ah.create_ts AS DATE) AND
           bdd.d_date <
          CASE WHEN
                CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED')
          THEN CAST(sh.end_date AS DATE) ELSE cast(bdd.d_date as DATE) + 1 END
      THEN 1
      ELSE 0
    END AS inventory_count
   ,CASE
      WHEN bdd.d_date >= CAST(sh.pending_end_dt AS DATE) AND
           bdd.d_date <
          CASE WHEN
                CASE WHEN bdd.d_date < CAST(sh.end_date AS DATE) THEN sh.start_cd ELSE sh.end_cd END IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED')
          THEN CAST(sh.end_date AS DATE) ELSE CAST(bdd.d_date as DATE) + 1 END
      THEN 1
      ELSE 0
    END AS inventory_no_pending_count
    ,CASE
      WHEN bdd.d_date = CAST(ah.create_ts AS DATE)
      THEN 1
      ELSE 0
    END creation_count
    ,CASE
      WHEN sh.end_date IS NOT NULL AND bdd.d_date >= CAST(sh.end_date AS DATE)
      THEN 1
      ELSE 0
    END AS completion_count
     ,CASE
      WHEN he.enroll_delayed_ind = 1
      THEN 1
      ELSE 0
    END AS delayed_enroll_count
FROM PAIEB_PRD.app_header ah
JOIN PAIEB_PRD.app_header_ext he ON ah.application_id = he.application_id
--LEFT JOIN harmony_conv.openclose oc ON oc.openid = ah.application_id
--This is getting the first and last app_history_status records for each application and then uses a maxdat_support table to determine if that status is an inventory status.
LEFT JOIN (SELECT COALESCE(a.application_id, b.application_id) as application_id, a.start_date, b.end_date, a.start_cd, b.end_cd, c.pending_start_dt, c.pending_end_dt
            FROM (SELECT l.last, l.app_status_history_id, l.application_id, l.status_dt as start_date, l.status_cd as start_cd
                  FROM (SELECT FIRST_VALUE(app_status_history_id) OVER(PARTITION BY sh.application_id, aps.inventory_indicator ORDER BY app_status_history_id) last
                    ,sh.app_status_history_id
                    ,sh.application_id
                    ,sh.status_cd
                    ,sh.status_date status_dt
                    ,aps.inventory_indicator
                    FROM PAIEB_PRD.app_status_history sh
                    JOIN PAIEB_PRD.app_status aps ON (sh.status_cd = aps.app_status_code)
                    WHERE sh.app_status_history_id >= 1530000) l
                  WHERE l.last = l.app_status_history_id
                  AND l.inventory_indicator = 1) a
            --I used first_value but I am ordering desc
            FULL OUTER JOIN (SELECT f.first, f.app_status_history_id, f.application_id, f.status_dt as end_date, f.status_cd as end_cd
                  FROM  (SELECT FIRST_VALUE(app_status_history_id) OVER(PARTITION BY sh.application_id, aps.inventory_indicator ORDER BY app_status_history_id DESC) first
                    ,sh.app_status_history_id
                    ,sh.application_id
                    ,sh.status_cd
                    ,sh.status_date status_dt
                    ,aps.inventory_indicator
                    FROM PAIEB_PRD.app_status_history sh
                    JOIN PAIEB_PRD.app_status aps ON (sh.status_cd = aps.app_status_code)
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
                                    FROM PAIEB_PRD.app_status_history sh
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
              FROM PAIEB_PRD.app_missing_info mi
              WHERE mi.mi_type_cd IN ('lcd','pc')
              and mi.application_id >= 343555)
              WHERE rnk = 1
              GROUP BY application_id ) mi_dates ON ah.application_id = mi_dates.application_id
JOIN (select cast(d_date as DATE) d_date from PAIEB_PRD.d_dates) bdd ON bdd.d_date >= cast(ah.create_ts as date) 
and ah.application_id >= 343555 
and bdd.d_date <=  CASE WHEN CASE WHEN bdd.d_date < sh.end_date THEN sh.start_cd ELSE sh.end_cd END IN ('CLOSED','COMPLETED','TIMEOUT','DISREGARDED','ENROLLED') THEN CAST(sh.end_date AS DATE) ELSE CAST(CURRENT_DATE AS DATE) END
and ah.create_ts >= ADD_MONTHS(CURRENT_DATE::DATE, -13);

select DDATE, CHANNEL
,sum(MTD) as "Month To Date"
      ,sum(WTD) as "Week To Date"
      ,sum(PD)  as "Prior Day"
from
(
  select ddate, channel, week, selections_processed, mtd, wtd, pd from maxdat_support.F_CHC_DAILY_ENRL_CNTS_SV
)
group by DDATE, CHANNEL
;
