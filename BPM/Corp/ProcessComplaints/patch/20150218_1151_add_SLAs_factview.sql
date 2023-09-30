create or replace view F_COMPLAINT_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FCMPLBD_ID,
  BUCKET_START_DATE D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,  
  CASE WHEN TRUNC(cc.sla_complete_date) = bucket_start_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
  CASE WHEN cc.sla_complete_date IS NULL OR bucket_start_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bucket_start_date)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness
from F_COMPLAINT_BY_DATE f, d_complaint_current cc
where f.cmpl_bi_id = cc.cmpl_bi_id
and  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,
 CASE WHEN TRUNC(cc.sla_complete_date) = bdd.d_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
 CASE WHEN cc.sla_complete_date IS NULL OR bdd.d_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bdd.D_DATE)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness  
 from F_COMPLAINT_BY_DATE f, d_complaint_current cc,
  BPM_D_DATES bdd
where f.cmpl_bi_id = cc.cmpl_bi_id
and  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  0 CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,
 CASE WHEN TRUNC(cc.sla_complete_date) = bdd.d_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
 CASE WHEN cc.sla_complete_date IS NULL OR bdd.d_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bdd.D_DATE)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness
 from F_COMPLAINT_BY_DATE f, d_complaint_current cc,
  BPM_D_DATES bdd
where f.cmpl_bi_id = cc.cmpl_bi_id
and  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FCMPLBD_ID,
  bdd.D_DATE,
  f.CMPL_BI_ID,
  DCMPLAC_ID, 
  DCMPLIA_ID, 
  DCMPLID_ID, 
  DCMPLIR_ID, 
  DCMPLIS_ID,
  DCMPLIN_ID,
  DCMPLRD_ID,
  f.INCIDENT_STATUS_DATE,
  f.LAST_UPDATE_DATE,
  CREATION_COUNT, 
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  f.COMPLETE_DT,
  DCMPLSS_ID,
 CASE WHEN TRUNC(cc.sla_complete_date) = bdd.d_date THEN 1 ELSE 0 END sla_completion_count,  
  cc.sla_complete_date sla_complete_date,
 CASE WHEN cc.sla_complete_date IS NULL OR bdd.d_date < cc.sla_complete_date THEN BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,bdd.D_DATE)
   ELSE BPM_COMMON.BUS_DAYS_BETWEEN(cc.create_date,cc.sla_complete_date) END sla_age_in_business_days,
 CASE WHEN cc.sla_complete_date IS NULL THEN 'Not Processed' ELSE 
    CASE WHEN cc.sla_complete_date <= cc.sla_jeopardy_date THEN 'Processed Timely' ELSE 'Processed Untimely' END END sla_timeliness  
 from F_COMPLAINT_BY_DATE f, d_complaint_current cc,
  BPM_D_DATES bdd
where f.cmpl_bi_id = cc.cmpl_bi_id
and bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_COMPLAINT_BY_DATE_SV for F_COMPLAINT_BY_DATE_SV;
grant select on F_COMPLAINT_BY_DATE_SV to MAXDAT_READ_ONLY;  