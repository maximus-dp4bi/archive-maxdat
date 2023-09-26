CREATE TABLE INCIDENT_STATUS_HISTORY
(INCIDENT_HEADER_STAT_HIST_ID  NUMBER(18,0) NOT NULL ENABLE,     
 INCIDENT_ID                   NUMBER(18,0),     
 STATUS_CD                     VARCHAR2(30),  
 INCIDENT_STATUS               VARCHAR2(50),     
 INCIDENT_STATUS_DT            DATE,
 CREATED_BY                    VARCHAR2(80),     
 CREATED_BY_STAFF_ID           NUMBER(18,0),  
 END_DATE                      DATE,
 AGE_IN_BUSINESS_DAYS          NUMBER,
 AGE_IN_CALENDAR_DAYS          NUMBER,
 AGE_IN_BUSINESS_DAYS_FLOW     NUMBER,
 AGE_IN_CALENDAR_DAYS_FLOW     NUMBER,
 AGE_IN_BUSINESS_DAYS_FLOW_NEW NUMBER,
 AGE_IN_CALENDAR_DAYS_FLOW_NEW NUMBER,
 STAGE_DONE_DT                 DATE,
 STG_EXTRACT_DATE              DATE DEFAULT SYSDATE NOT NULL ENABLE,     
 STG_LAST_UPDATE_DATE          DATE DEFAULT SYSDATE NOT NULL ENABLE  
 ) TABLESPACE "MAXDAT_DATA";
 
 CREATE UNIQUE INDEX "MAXDAT"."INCIDENT_STATUS_HISTORY_NDX1" ON "MAXDAT"."INCIDENT_STATUS_HISTORY" ("INCIDENT_HEADER_STAT_HIST_ID", "INCIDENT_ID") 
  TABLESPACE "MAXDAT_INDX";
 
CREATE OR REPLACE VIEW D_INCIDENT_STATUS_HISTORY_SV
AS select 
INCIDENT_HEADER_STAT_HIST_ID,
INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID,
END_DATE,
AGE_IN_BUSINESS_DAYS,
AGE_IN_CALENDAR_DAYS,
AGE_IN_BUSINESS_DAYS_FLOW,
AGE_IN_CALENDAR_DAYS_FLOW,
AGE_IN_BUSINESS_DAYS_FLOW_NEW,
AGE_IN_CALENDAR_DAYS_FLOW_NEW
 from INCIDENT_STATUS_HISTORY WITH READ ONLY;

GRANT SELECT on D_INCIDENT_STATUS_HISTORY_SV to MAXDAT_READ_ONLY;

CREATE or REPLACE VIEW MAXDAT.D_INCIDENT_STATUS_HISTORY_OLD_SV
AS WITH get_basic AS
(
SELECT distinct
INCIDENT_HEADER_STAT_HIST_ID,
INCIDENT_HEADER_ID AS INCIDENT_ID,
STATUS_CD,
INCIDENT_STATUS,
CREATE_TS INCIDENT_STATUS_DT,
CREATED_BY,
CREATED_BY_STAFF_ID,
lead(create_ts,1) OVER (PARTITION BY incident_header_id ORDER BY create_ts,INCIDENT_HEADER_STAT_HIST_ID) as end_date
from
INCIDENT_HEADER_STAT_HIST_STG
), get_appeal
AS (
SELECT
     a.INCIDENT_HEADER_STAT_HIST_ID
    ,a.incident_id
    ,a.INCIDENT_STATUS
    ,b.appeal_hearing_date
    ,max(b.appeal_hearing_date) OVER (PARTITION BY a.incident_id) max_appeal_hearing_date
FROM get_basic a
JOIN MAXDAT.d_appeals_current b
ON a.INCIDENT_ID = b.incident_id
WHERE b.appeal_hearing_date IS NOT NULL
), get_hearing_list
AS (
SELECT distinct
    INCIDENT_HEADER_STAT_HIST_ID hearing_id,
    max(INCIDENT_HEADER_STAT_HIST_ID) OVER (PARTITION BY incident_id) max_hearing_id,
    lag(INCIDENT_HEADER_STAT_HIST_ID) OVER (PARTITION BY incident_id ORDER BY INCIDENT_HEADER_STAT_HIST_ID) lag_hearing_id,
    min(INCIDENT_HEADER_STAT_HIST_ID) OVER (PARTITION BY incident_id) min_hearing_id,
    INCIDENT_ID
from
get_basic
WHERE incident_status = 'Hearing Set'
), get_dismissed_list
AS (
SELECT DISTINCT
   b.hearing_id,
   CASE WHEN a.incident_status = 'Request to Vacate Dismissal' AND ((a.INCIDENT_HEADER_STAT_HIST_ID < b.hearing_id) AND a.INCIDENT_HEADER_STAT_HIST_ID > nvl(b.lag_hearing_id,1)) THEN a.INCIDENT_HEADER_STAT_HIST_ID ELSE NULL END dismissed_id,
   CASE WHEN a.incident_status = 'Reschedule Hearing' AND ((a.INCIDENT_HEADER_STAT_HIST_ID < b.hearing_id) AND a.INCIDENT_HEADER_STAT_HIST_ID > nvl(b.lag_hearing_id,1)) THEN a.INCIDENT_HEADER_STAT_HIST_ID ELSE NULL END rescheduled_id,
   a.INCIDENT_ID
from
get_basic a
LEFT JOIN get_hearing_list b
ON a.incident_id = b.incident_id
WHERE a.incident_status in ('Request to Vacate Dismissal','Reschedule Hearing')
AND (b.hearing_id IS NOT NULL AND (a.INCIDENT_HEADER_STAT_HIST_ID < b.hearing_id) AND a.INCIDENT_HEADER_STAT_HIST_ID > nvl(b.lag_hearing_id,1))
)
SELECT distinct
b.INCIDENT_HEADER_STAT_HIST_ID,
b.INCIDENT_ID,
b.status_cd,
b.INCIDENT_STATUS,
b.INCIDENT_STATUS_DT,
b.CREATED_BY,
b.CREATED_BY_STAFF_ID,
CASE WHEN b.incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN b.INCIDENT_STATUS_DT ELSE b.END_DATE END end_date,
CASE WHEN b.incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN 0 ELSE bus_days_between(b.INCIDENT_STATUS_DT, nvl(b.end_date,SYSDATE)) end age_in_business_days,
CASE WHEN b.incident_status IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH')) THEN 0 ELSE trunc(nvl(b.end_date,SYSDATE)) - trunc(b.INCIDENT_STATUS_DT) end age_in_calendar_days,
CASE WHEN b.incident_status = 'Hearing Set' AND (nvl(e.hearing_id,999999999) < nvl(e.max_hearing_id,1) AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1)) OR (nvl(f.rescheduled_id,999999999) < nvl(e.lag_hearing_id,1))
          THEN 0 -- UPD1_450
     WHEN b.incident_status = 'Hearing Set' AND (TRUNC(b.incident_status_dt) = TRUNC(b.end_date)) OR (((f.dismissed_id IS NOT NULL OR f.rescheduled_id IS NOT NULL) AND e.hearing_id < e.max_hearing_id) AND e.hearing_id > e.min_hearing_id)
          THEN 0 -- prevent counting when incident_status_dt = end_date
     WHEN b.incident_status = 'Hearing Set' AND d.max_appeal_hearing_date IS NULL AND e.hearing_id = e.max_hearing_id AND e.hearing_id = e.min_hearing_id AND EXISTS (SELECT 'yes' FROM get_basic x WHERE x.incident_status = 'Request to Vacate Dismissal' AND x.incident_id = b.incident_id AND x.INCIDENT_HEADER_STAT_HIST_ID < e.hearing_id)
          THEN 0 -- when only a single hearing set and it has request to vacate prior
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE) AND ((e.hearing_id > nvl(f.dismissed_id,99999999)) OR (e.hearing_id > nvl(f.rescheduled_id,99999999))) AND ((e.hearing_id > nvl(e.lag_hearing_id,99999999)) OR (e.hearing_id = e.min_hearing_id))
          THEN 0 -- UPD1_410
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,1) AND nvl(e.hearing_id,999999999) < nvl(e.max_hearing_id,1)
          THEN 0
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND e.hearing_id = e.max_hearing_id and ((f.dismissed_id IS NULL and f.rescheduled_id IS NOT NULL) OR (f.dismissed_id IS NOT NULL and f.rescheduled_id IS NULL) OR (f.dismissed_id IS NOT NULL and f.rescheduled_id IS NOT NULL)) AND ((f.dismissed_id IS NULL OR (f.dismissed_id < nvl(e.hearing_id,1) AND f.dismissed_id > nvl(e.lag_hearing_id,9999999999)) OR (f.rescheduled_id IS NULL OR (f.rescheduled_id > nvl(e.lag_hearing_id,9999999999) AND f.rescheduled_id < e.hearing_id))))
          THEN bus_days_between(d.max_appeal_hearing_date,nvl(b.end_date,SYSDATE)) -- UPD1_420
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND e.hearing_id = e.max_hearing_id and e.hearing_id = e.min_hearing_id and ((nvl(f.dismissed_id,999999999) < e.hearing_id) or (nvl(f.rescheduled_id,999999999) < e.hearing_id))
          THEN bus_days_between(d.max_appeal_hearing_date,nvl(b.end_date,SYSDATE)) -- UPD1_420
     WHEN b.incident_status = 'Hearing Set' AND nvl(e.hearing_id,999999999) = nvl(e.max_hearing_id,1) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,9999999999)  AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1)  AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE)
          THEN 0 -- UPD1_430
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,9999999999) AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1)
          THEN 0
     WHEN b.incident_status = 'Hearing Set' AND nvl(e.hearing_id,999999999) = nvl(e.max_hearing_id,1) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,9999999999) AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1) AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE)
          THEN bus_days_between(d.max_appeal_hearing_date,nvl(b.end_date,SYSDATE)) -- UPD1_440
     WHEN b.incident_status = 'Hearing Set' AND  (d.max_appeal_hearing_date IS NULL) AND  nvl(e.hearing_id,1) > nvl(e.min_hearing_id,9999999999) AND e.hearing_id < e.max_hearing_id AND EXISTS (SELECT x.incident_status FROM get_basic x WHERE x.incident_status in ('Reschedule Hearing','Request to Vacate Dismissal') AND x.incident_id = b.incident_id AND x.INCIDENT_HEADER_STAT_HIST_ID < e.hearing_id)
          THEN 0 -- UPD4_060, UPD4_070
     WHEN b.incident_status NOT IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP'))
          THEN bus_days_between(b.INCIDENT_STATUS_DT, nvl(b.end_date,SYSDATE))
     ELSE 0 end age_in_business_days_flow ,
CASE WHEN b.incident_status = 'Hearing Set' AND (nvl(e.hearing_id,999999999) < nvl(e.max_hearing_id,1) AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1)) OR (f.rescheduled_id < e.lag_hearing_id)
          THEN 0 -- UPD1_450
     WHEN b.incident_status = 'Hearing Set' AND (TRUNC(b.incident_status_dt) = TRUNC(b.end_date)) OR  (((f.dismissed_id IS NOT NULL OR f.rescheduled_id IS NOT NULL) AND e.hearing_id < e.max_hearing_id) AND e.hearing_id > e.min_hearing_id)
          THEN 0 -- prevent counting when incident_status_dt = end_date
     WHEN b.incident_status = 'Hearing Set' AND d.max_appeal_hearing_date IS NULL AND e.hearing_id = e.max_hearing_id AND e.hearing_id = e.min_hearing_id AND EXISTS (SELECT 'yes' FROM get_basic x WHERE x.incident_status = 'Request to Vacate Dismissal' AND x.incident_id = b.incident_id AND x.INCIDENT_HEADER_STAT_HIST_ID < e.hearing_id)
          THEN 0 -- when only a single hearing set and it has request to vacate prior
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE) AND ((e.hearing_id > nvl(f.dismissed_id,99999999)) OR (e.hearing_id > nvl(f.rescheduled_id,99999999))) AND ((e.hearing_id > nvl(e.lag_hearing_id,99999999)) OR (e.hearing_id = e.min_hearing_id))
          THEN 0 -- UPD1_410
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,1) AND nvl(e.hearing_id,999999999) < nvl(e.max_hearing_id,1)
          THEN 0
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND e.hearing_id = e.max_hearing_id and ((f.dismissed_id IS NULL and f.rescheduled_id IS NOT NULL) OR (f.dismissed_id IS NOT NULL and f.rescheduled_id IS NULL) OR (f.dismissed_id IS NOT NULL and f.rescheduled_id IS NOT NULL)) AND ((f.dismissed_id IS NULL OR (f.dismissed_id < nvl(e.hearing_id,1) AND f.dismissed_id > nvl(e.lag_hearing_id,9999999999)) OR (f.rescheduled_id IS NULL OR (f.rescheduled_id > nvl(e.lag_hearing_id,9999999999) AND f.rescheduled_id < e.hearing_id))))
          THEN CASE WHEN (trunc(nvl(trunc(nvl(b.end_date,SYSDATE)) - d.max_appeal_hearing_date,SYSDATE))) < 0 THEN 0 ELSE trunc(nvl(trunc(nvl(b.end_date,SYSDATE)) - d.max_appeal_hearing_date,SYSDATE)) END  -- UPD1_420
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND e.hearing_id = e.max_hearing_id and e.hearing_id = e.min_hearing_id and ((nvl(f.dismissed_id,999999999) < e.hearing_id) or (nvl(f.rescheduled_id,999999999) < e.hearing_id))
          THEN CASE WHEN (trunc(nvl(trunc(nvl(b.end_date,SYSDATE)) - d.max_appeal_hearing_date,SYSDATE))) < 0 THEN 0 ELSE trunc(nvl(trunc(nvl(b.end_date,SYSDATE)) - d.max_appeal_hearing_date,SYSDATE)) END  -- UPD1_420
     WHEN b.incident_status = 'Hearing Set' AND nvl(e.hearing_id,999999999) = nvl(e.max_hearing_id,1) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,9999999999)  AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1)  AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('1900/01/01','yyyy/mm/dd'))) > TRUNC(SYSDATE)
          THEN 0 -- UPD1_430
     WHEN b.incident_status = 'Hearing Set' AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,9999999999) AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1)
          THEN 0
     WHEN b.incident_status = 'Hearing Set' AND nvl(e.hearing_id,999999999) = nvl(e.max_hearing_id,1) AND nvl(f.dismissed_id,1) > nvl(e.lag_hearing_id,9999999999) AND nvl(f.dismissed_id,9999999999) < nvl(e.hearing_id,1) AND TRUNC(nvl(d.max_appeal_hearing_date,to_date('2099/01/01','yyyy/mm/dd'))) <= TRUNC(SYSDATE)
          THEN trunc(nvl(trunc(nvl(b.end_date,SYSDATE)) - d.max_appeal_hearing_date,SYSDATE)) -- UPD1_440
     WHEN b.incident_status = 'Hearing Set' AND  (d.max_appeal_hearing_date IS NULL) AND  nvl(e.hearing_id,1) > nvl(e.min_hearing_id,9999999999) AND e.hearing_id < e.max_hearing_id AND EXISTS (SELECT x.incident_status FROM get_basic x WHERE x.incident_status in ('Reschedule Hearing','Request to Vacate Dismissal') AND x.incident_id = b.incident_id AND x.INCIDENT_HEADER_STAT_HIST_ID < e.hearing_id)
          THEN 0 -- UPD4_060, UPD4_070
     WHEN b.incident_status NOT IN (SELECT incident_status FROM incident_status_lookup WHERE start_stop IN ('FINISH', 'STOP'))
          THEN trunc(nvl(b.end_date,SYSDATE)) - trunc(b.INCIDENT_STATUS_DT)
    ELSE 0 END age_in_calendar_days_flow
FROM get_basic b
LEFT JOIN get_appeal d
ON b.INCIDENT_HEADER_STAT_HIST_ID = d.INCIDENT_HEADER_STAT_HIST_ID
LEFT JOIN get_hearing_list e
ON b.INCIDENT_HEADER_STAT_HIST_ID = e.hearing_ID
LEFT JOIN get_dismissed_list f
ON b.INCIDENT_HEADER_STAT_HIST_ID = f.hearing_ID WITH READ ONLY;


GRANT SELECT on MAXDAT.D_INCIDENT_STATUS_HISTORY_OLD_SV to MAXDAT_READ_ONLY;
