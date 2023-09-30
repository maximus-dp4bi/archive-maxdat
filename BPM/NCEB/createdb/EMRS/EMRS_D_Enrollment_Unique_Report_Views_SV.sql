DROP VIEW MAXDAT_SUPPORT.EMRS_D_ENROLL_MED_TXN_CNT_SV;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_ENROLL_MED_TXN_CNT_SV" AS 
-- Total Medicaid and Transaction numbers for weekly Unique Enrollment Report
-- -- Neither number has been validated by the project
WITH clnt AS (
SELECT client_id, addr_county, max(update_ts) begin_date
FROM EB.CLIENT_SUPPLEMENTARY_INFO
WHERE ADDR_COUNTY IS NOT null
GROUP BY CLIENT_ID, addr_county
)
, max_seq AS (
SELECT esd.client_id, max(esd.start_date) start_dte
FROM EB.ELIG_SEGMENT_AND_DETAILS esd
JOIN clnt csi ON csi.CLIENT_ID = esd.CLIENT_ID 
WHERE esd.segment_type_cd = 'ME'
AND esd.end_Date >= SYSDATE
AND esd.start_date <= add_months(TRUNC(SYSDATE,'MM'),1)
AND esd.segment_detail_value_2  in ('MCS001','MCS005','MCS026','MCS027','MCS034','MCS035','MCS042')
 OR (esd.segment_detail_value_2 IN ('MCS025','MCS028','MCS029','MCS030','MCS031','MCS032','MCS033','MCS036','MCS037'
                               ,'MCS038','MCS039','MCS040','MCS041','MCS044','MCS045','MCS046','MCS047','MCS048','MCS049','MCS050')
 AND csi.addr_county IN ('011','020','022','038','044','045','050','056','057','087','088'))
GROUP BY esd.client_id
)
, med_cnt AS (
SELECT sum(count(*)) med_count
FROM EB.ELIG_SEGMENT_AND_DETAILS esd
JOIN max_seq ON esd.client_id = max_seq.client_id
  AND esd.start_date = max_seq.start_dte
WHERE esd.segment_type_cd = 'ME'
AND esd.end_Date >= SYSDATE
AND esd.start_date <= add_months(TRUNC(SYSDATE,'MM'),1)
GROUP BY esd.client_id
)
SELECT med_cnt.med_count Medicaid_Population
, 0 Enrollment_Transaction_Count
FROM med_cnt
;
/

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_MED_TXN_CNT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_MED_TXN_CNT_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_MED_TXN_CNT_SV TO MAXDAT_REPORTS;

DROP VIEW MAXDAT_SUPPORT.EMRS_D_ENROLL_UNIQUE_CNT_SV;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_ENROLL_UNIQUE_CNT_SV" AS 
-- Weekly Unique Enrollment Report
select plan_name, sum(active_flag) Unique_enrollment_count, sum(future_flag) future_enrollment_count
from (
select client_id, plan_id_ext, plan_name, max(active_flag) active_flag , max(future_flag) future_flag, count(1) count_of_Selections
from
(select client_id, plan_id_ext, plan_name, active_flag, future_flag
from (
SELECT ss.client_id
       , (case when ss.START_DATE <= last_day(TRUNC(sysdate)) and (ss.end_date) >= trunc(sysdate) THEN 1
--       , (case when ss.START_DATE <= last_day(TRUNC(sysdate)) and trunc(ss.end_date,'MM') >= trunc(sysdate,'MM') THEN 1
            ELSE 0
       END) active_flag
      , (CASE WHEN ss.START_DATE >= add_months(TRUNC(SYSDATE,'MM'),1) and not exists 
        (select 'x' from eb.selection_segment sel where sel.client_id = ss.client_id
                    and sel.start_nd < sel.end_nd
                    and sel.ss_generic_field3_num is null
                    and sel.plan_id <> 601
                    and sel.START_DATE <= last_day(TRUNC(sysdate)) and trunc(sel.end_date,'MM') >= trunc(sysdate,'MM')
                    and sel.plan_type_cd = ss.plan_type_Cd
                    )
                    THEN  1-- count for future enrollments
            ELSE 0
       END) future_flag
      ,pl.plan_name
      , pl.plan_id_ext
   FROM EB.SELECTION_SEGMENT ss
--   JOIN EB.CLIENT_SUPPLEMENTARY_INFO csi ON csi.CLIENT_ID = ss.CLIENT_ID
   JOIN EB.PLANS pl ON pl.PLAN_ID = ss.PLAN_ID
WHERE (ss.START_DATE <= add_months(TRUNC(SYSDATE,'MM'),1))
   AND ss.plan_id <> 601
   AND ss.SS_GENERIC_FIELD3_NUM IS NULL -- exclude Bene 834 records
-- 04022021 commented out per Carols request
--   AND csi.CASE_CLIENT_STATUS <> 'C'
   and ss.start_nd < ss.end_nd
   and ss.plan_type_cd = 'MEDICAL'
--and client_id = 12755249
)
where active_flag > 0 or future_flag > 0
)
group by client_id, plan_id_ext, plan_name
)
group by plan_name
;
/

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_UNIQUE_CNT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_UNIQUE_CNT_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLL_UNIQUE_CNT_SV TO MAXDAT_REPORTS;
commit;
