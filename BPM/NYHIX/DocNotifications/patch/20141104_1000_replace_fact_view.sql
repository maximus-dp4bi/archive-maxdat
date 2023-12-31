-- Grant permissions

grant execute on BPM_COMMON to MAXDAT;

--Rename columns in current table
create or replace view D_NYHIX_DOC_NOTIF_CURRENT_SV 
as
SELECT
  NYHIX_DN_BI_ID,
  EDNDB_ID,
  DOC_NOTIFICATION_ID,
  KOFAX_DCN,
  INSTANCE_STATUS,
  INSTANCE_START_DATE,
  INSTANCE_END_DATE,
  COMPLETE_DT,
  CANCEL_DT,
  CANCEL_BY_ID,
  CANCEL_BY,
  CANCEL_REASON,
  CANCEL_METHOD,
  CREATE_DT,
  CREATED_BY_ID,
  CREATED_BY,
  UPDATE_DT,
  UPDATED_BY_ID,
  UPDATED_BY,
  STATUS_CD,
  STATUS,
  HXID,
  HX_ACCOUNT_ID,
  ACCOUNT_ID,
  DESCRIPTION,
  PROCESSED_IND,
  PROCESS_INSTANCE_ID,
  ERROR_CD,
  NOTIFICATION_DT,
  CHANNEL,
  ASSD_PROCESS_DN,
  ASED_PROCESS_DN,
  ASF_VERIFY_DN,
  STG_EXTRACT_DATE,
  STAGE_DONE_DATE,
  STG_LAST_UPDATE_DATE,
  LAST_EVENT_DATE,
  AGE_IN_BUSINESS_DAYS CURR_AGE_IN_BUSINESS_DAYS,
  AGE_IN_CALENDAR_DAYS CURR_AGE_IN_CALENDAR_DAYS,
  TIMELINESS_STATUS,
  TIMELINESS_DAYS,
  TIMELINESS_DAYS_TYPE,
  TIMELINESS_DATE,
  JEOPARDY_FLAG CURR_JEOPARDY_FLAG,
  JEOPARDY_DAYS,
  JEOPARDY_DAYS_TYPE,
  JEOPARDY_DATE,
  TARGET_DAYS
FROM
  MAXDAT.D_NYHIX_DOC_NOTIF_CURRENT ;

--Replace History View
create or replace view D_NYHIX_DOC_NOTIF_HISTORY_SV
as
SELECT
  h.DDNBD_ID,
  b.D_DATE,
  h.NYHIX_DN_BI_ID,
  h.STATUS_CD,
  h.STATUS,
  BPM_COMMON.BUS_DAYS_BETWEEN(d.create_dt, b.d_date) as AGE_IN_BUSINESS_DAYS,
  Case when (ROUND(trunc(b.D_DATE) - trunc(d.create_dt))) > 0 then (ROUND(trunc(b.D_DATE) - trunc(d.create_dt))) else 0 end as AGE_IN_CALENDAR_DAYS,
  case when (d.COMPLETE_DT is not null and b.D_DATE = trunc(d.COMPLETE_DT)) or (d.cancel_dt is not null and b.D_DATE = trunc(d.CANCEL_DT)) then 'N/A'
     when BPM_COMMON.BUS_DAYS_BETWEEN(d.create_dt, b.d_date) >= d.JEOPARDY_DAYS then 'Y'
     else 'N' end as JEOPARDY_FLAG
FROM D_NYHIX_DOC_NOTIF_HISTORY h 
JOIN D_NYHIX_DOC_NOTIF_CURRENT d on (h.NYHIX_DN_BI_ID = d.NYHIX_DN_BI_ID)
JOIN BPM_D_DATES B on (B.D_DATE >= H.BUCKET_START_DATE and B.D_DATE <= H.BUCKET_END_DATE);

--Replace Fact view
Create or replace view F_NYHIX_DOC_NOTIF_BY_DATE_SV
as
Select 
d.NYHIX_DN_BI_ID,
bdd.D_DATE,
CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DT) THEN 1 else 0 END AS CREATION_COUNT,
CASE WHEN (bdd.D_DATE != TRUNC(d.COMPLETE_DT) OR d.COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS INVENTORY_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DT) THEN 1 else 0 END AS COMPLETION_COUNT
FROM 
BPM_D_DATES bdd 
INNER JOIN D_NYHIX_DOC_NOTIF_CURRENT d on (bdd.D_DATE >= TRUNC(D.INSTANCE_START_DATE) and bdd.D_DATE <= nvl(TRUNC(D.INSTANCE_END_DATE),sysdate));