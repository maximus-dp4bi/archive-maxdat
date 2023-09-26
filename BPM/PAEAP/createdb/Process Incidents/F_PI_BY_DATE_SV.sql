CREATE OR REPLACE VIEW F_PI_BY_DATE_SV
AS
  SELECT i.incident_header_id PI_BI_ID ,
    d.d_date ,
    i.create_ts CREATE_DATE ,
    CASE
      WHEN status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
      THEN i.status_ts
      ELSE NULL
    END COMPLETE_DATE ,
    (
    CASE
      WHEN i.create_ts IS NOT NULL AND (
        CASE
          WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
          THEN i.status_ts
          ELSE d.d_date
        END) IS NOT NULL
      THEN
        (SELECT
          CASE
            WHEN (COUNT(*)-1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM MAXDAT_SUPPORT.D_DATES
        WHERE business_day_flag = 'Y' AND d_date BETWEEN i.CREATE_TS AND (
          CASE
            WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
            THEN
              CASE
                WHEN i.status_ts < d.d_date
                THEN i.status_ts
                ELSE d.d_date
              END
            ELSE d.d_date
          END)
        )
      ELSE 0
    END ) INV_AGE_IN_BUSINESS_DAYS ,
    TRUNC(
    CASE
      WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN')
      THEN
        CASE
          WHEN i.status_ts < d.d_date
          THEN i.status_ts
          ELSE d.d_date
        END
      ELSE d.d_date
    END) - TRUNC(i.create_ts) INV_AGE_IN_CALENDAR_DAYS ,
    CASE
      WHEN I.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN') AND D.D_DATE = TRUNC(i.status_ts)
      THEN 0
      ELSE 1
    END AS INVENTORY_COUNT ,
    CASE
      WHEN d_date = TRUNC(i.create_ts)
      THEN 1
      ELSE 0
    END CREATION_COUNT ,
    CASE
      WHEN i.status_cd IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN') AND D.D_DATE = TRUNC(i.status_ts)
      THEN 1
      ELSE 0
    END AS COMPLETION_COUNT ,
    i.update_ts LAST_UPDATE_DATE ,
    i.status_ts INCIDENT_STATUS_DATE
  FROM MAXDAT_SUPPORT.D_DATES D
  JOIN eb.incident_header i ON (D.D_DATE BETWEEN TRUNC(I.CREATE_TS) AND COALESCE(TRUNC(I.STATUS_TS),TRUNC(sysdate)))
  WHERE i.incident_header_type_cd = 'COMPLAINT'
       and (i.received_ts >=(ADD_MONTHS(TRUNC(sysdate,'mm'),-2))
          or i.status_cd not IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN'))
    ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.F_PI_BY_DATE_SV TO EB_MAXDAT_REPORTS ;
