CREATE OR REPLACE VIEW F_SURVEY_COUNT_SV
 AS
  SELECT D.D_MONTH_START RECORD_DATE,
  'MEDICAID' PROGRAM_CODE,
  pl.PLAN_TYPE,
  pl.plan_Service_type_Cd,
  pl.PLAN_ID
  , COUNT(SURVEY_ID) SURVEY_CNT
  , sum(NVL(completed_phone,0)) completed_phone_cnt
  , round(nvl(sum(completed_phone)/SUM(NVL(SURVEY_TAKEN,0)) * 100,0),0) completed_phone_per
  , round(nvl(sum(completed_phone)/count(survey_id) * 100,0),0) completedtot_phone_per
  , sum(NVL(completed_web,0)) completed_web_cnt
  , round(nvl(sum(completed_web)/SUM(NVL(SURVEY_TAKEN,0)) * 100,0),0) completed_web_per
  , round(nvl(sum(completed_web)/count(survey_id) * 100,0),0) completedtot_web_per
  , SUM(NVL(SURVEY_TAKEN,0)) COMPLETED_CNT
  , sum(NVL(survey_optout,0)) optout_cnt
  , round(nvl(sum(survey_optout)/count(survey_id)*100,0),0) optout_per
  , sum(NVL(abandon_answered,0)) abandon_answered_cnt
  , sum(NVL(abandon_notime,0)) abandon_notime_cnt
  , sum(NVL(abandon_private,0)) abandon_private_cnt
  , sum(NVL(abandon_other,0)) abandon_other_cnt
  , sum(nvl(survey_abandon,0)) abandon_cnt
  , round(nvl(sum(survey_abandon)/count(survey_id)*100,0),0) abandon_per
  , NVL(ROUND(sum(completed_survey_duration)/ sum(survey_taken),0),0) avg_completed_min
FROM (SELECT D_MONTH_START, D_MONTH_END FROM MAXDAT_SUPPORT.D_MONTHS D1 WHERE d1.D_MONTH_END BETWEEN GREATEST(ADD_MONTHS(TRUNC(sysdate, 'mm'),-24),TO_DATE('8/1/2018','MM/DD/YYYY')) AND TRUNC(LAST_DAY(sysdate))) d
JOIN MAXDAT_SUPPORT.EMRS_D_PLAN_SV PL ON 1=1
LEFT JOIN (
SELECT
 SURVEY_ID
, plan_id
, plan_id_ext
, plan_service_type_cd
, PROVIDER_ORG_TYPE
, PROVIDER_ORG_CD
, SURVEY_TITLE
, status_cd
, CASE WHEN RECEIVED_VIA_CD = 'PHONE' AND S.STATUS_CD IN ('COMPLETED') THEN 1 ELSE 0 END COMPLETED_PHONE
, CASE WHEN RECEIVED_VIA_CD = 'WEB' AND S.STATUS_CD IN ('COMPLETED') THEN 1 ELSE 0 END COMPLETED_WEB
, case when s.status_cd in ('COMPLETED') then 1 else 0 end survey_taken
, case when s.status_cd in ('COMPLETED') then SURVEY_DURATION else 0 end completed_survey_duration
, case when s.status_cd in ('REFUSED') then 1 else 0 end survey_optout
, case when s.status_cd in ('QUIT') then 1 else 0 end survey_abandon
, case when s.status_cd in ('QUIT') AND refuse_reason_cd in ('ANSWERED_QUIT') then 1 else 0 end abandon_answered
, case when s.status_cd in ('QUIT') AND refuse_reason_cd in ('NOTIME_QUIT') then 1 else 0 end abandon_notime
, case when s.status_cd in ('QUIT') AND refuse_reason_cd in ('PRIVATEINFO_QUIT') then 1 else 0 end abandon_private
, case when s.status_cd in ('QUIT') AND (refuse_reason_cd is null or refuse_reason_cd not in ('ANSWERED_QUIT','PRIVATEINFO_QUIT','NOTIME_QUIT')) then 1 else 0 end abandon_other
, refuse_reason_cd
, received_via_cd
, received_date
, TRUNC(ca_date,'MM') RECORD_DATE
, staff_name
, created_by
, create_ts
, SURVEY_DURATION
FROM MAXDAT_SUPPORT.D_SURVEY_SV S
  ) f ON (d.D_MONTH_START = f.RECORD_DATE --AND F.MANAGED_CARE_END_DATE
          AND F.PLAN_ID = PL.PLAN_ID) 
WHERE 1=1
AND PL.PLAN_ID > 1
AND PL.PLAN_SERVICE_TYPE_CD = 'ACC'
GROUP BY d.d_month_start,
  pl.PLAN_TYPE,
  pl.plan_Service_type_Cd,
  pl.PLAN_ID
ORDER BY RECORD_DATE, PLAN_SERVICE_TYPE_CD; 

GRANT SELECT ON MAXDAT_SUPPORT.F_SURVEY_COUNT_SV TO MAXDAT_REPORTS;    
