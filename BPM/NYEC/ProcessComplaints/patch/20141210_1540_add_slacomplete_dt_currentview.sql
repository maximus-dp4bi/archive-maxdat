CREATE OR REPLACE FORCE VIEW "MAXDAT"."D_COMPLAINT_CURRENT_SV" ("CMPL_BI_ID", "CHANNEL", "CREATED_BY_GROUP", "CREATED_BY_NAME", "INCIDENT_ID", "INCIDENT_TRACKING_NUMBER", "CREATE_DATE", "ATMPT_TO_RES_INCIDENT_END", "ATMPT_TO_RES_INCIDENT_START", "ATMPT_TO_RES_INCIDENT_SUPV_END", "ATMPT_TO_RES_INCIDENT_SUPV_ST", "RESOLVE_INCIDENT_END", "RESOLVE_INCIDENT_START", "WITHDRAW_INCIDENT_END", "WITHDRAW_INCIDENT_START", "PERFORM_FOLLOWUP_ACTIONS_END", "PERFORM_FOLLOWUP_ACTIONS_START", "ABOUT_PLAN_CODE", "ABOUT_PROVIDER_ID", "CUR_ACTION_COMMENTS", "ACTION_TYPE", "CANCEL_BY", "CANCEL_DATE", "CANCEL_METHOD", "CANCEL_REASON", "CUR_CURRENT_TASK_ID", "DATA_ENTRY_TASK_ID", "CUR_INCIDENT_ABOUT", "CUR_INCIDENT_DESCRIPTION", "CUR_INCIDENT_REASON", "CUR_INCIDENT_STATUS", "CUR_INCIDENT_STATUS_DATE", "INSTANCE_COMPLETE_DATE", "CUR_INSTANCE_STATUS", "CUR_LAST_UPDATE_BY_NAME", "CUR_LAST_UPDATE_DATE", "LAST_UPDATED_BY", "CLIENT_ID", "OTHER_PARTY_NAME", "PRIORITY", "REPORTED_BY", "REPORTER_RELATIONSHIP", "CUR_RESOLUTION_DESCRIPTION", "RESOLUTION_TYPE", "CASE_ID", "FORWARDED_FLAG", "INCIDENT_TYPE", "FORWARDED_TO", "SLA_DAYS_TYPE", "SLA_JEOPARDY_DATE", "SLA_JEOPARDY_DAYS", "SLA_TARGET_DAYS", "AGE_IN_BUSINESS_DAYS", "AGE_IN_CALENDAR_DAYS", "JEOPARDY_DAYS_TYPE", "JEOPARDY_FLAG", "TIMELINESS_STATUS", "INCIDENT_FWD_TIMELINESS_STATUS", "INCIDENT_FORWARDING_TARGET", "COMPLETE_DT", "FORWARD_DT", "CURRENT_STEP", "RECEIVED_DT", "PLAN_NAME", "REPORTER_NAME", "REPORTER_PHONE", "SLA_SATISFIED", "CREATED_BY_SUP", "CREATED_BY_EID", "CREATED_BY_SUP_NAME", "PROJECT_NAME", "GWF_ESCALATE_TO_STATE", "GWF_RESOLVED_EES_CSS", "GWF_RESOLVED_SUP", "GWF_FOLLOWUP_REQ", "GWF_RETURN_TO_STATE" ,"CUR_SLA_COMPLETE_DATE") AS 
  SELECT "CMPL_BI_ID"
    , "CHANNEL"
    , "CREATED_BY_GROUP"
    , "CREATED_BY_NAME"
    , "INCIDENT_ID"
    , "INCIDENT_TRACKING_NUMBER"
    , "CREATE_DATE"
    , "ATMPT_TO_RES_INCIDENT_END"
    , "ATMPT_TO_RES_INCIDENT_START"
    , "ATMPT_TO_RES_INCIDENT_SUPV_END"
    , "ATMPT_TO_RES_INCIDENT_SUPV_ST"
    , "RESOLVE_INCIDENT_END"
    , "RESOLVE_INCIDENT_START"
    , "WITHDRAW_INCIDENT_END"
    , "WITHDRAW_INCIDENT_START"
    , "PERFORM_FOLLOWUP_ACTIONS_END"
    , "PERFORM_FOLLOWUP_ACTIONS_START"
    , "ABOUT_PLAN_CODE"
    , "ABOUT_PROVIDER_ID"
    , "CUR_ACTION_COMMENTS"
    , "ACTION_TYPE"
    , "CANCEL_BY"
    , "CANCEL_DATE"
    , "CANCEL_METHOD"
    , "CANCEL_REASON"
    , "CUR_CURRENT_TASK_ID"
    , "DATA_ENTRY_TASK_ID"    
    , "CUR_INCIDENT_ABOUT"
    , "CUR_INCIDENT_DESCRIPTION"
    , "CUR_INCIDENT_REASON"
    , "CUR_INCIDENT_STATUS"
    , "CUR_INCIDENT_STATUS_DATE"
    , "INSTANCE_COMPLETE_DATE"
    , "CUR_INSTANCE_STATUS"
    , "CUR_LAST_UPDATE_BY_NAME"
    , "CUR_LAST_UPDATE_DATE"
    , "LAST_UPDATED_BY"
    , "CLIENT_ID"
    , "OTHER_PARTY_NAME"
    , "PRIORITY"
    , "REPORTED_BY"
    , "REPORTER_RELATIONSHIP"
    , "CUR_RESOLUTION_DESCRIPTION"
    , "RESOLUTION_TYPE"
    , "CASE_ID"
    , "FORWARDED_FLAG"
    , "INCIDENT_TYPE"
    , "FORWARDED_TO"
    , "SLA_DAYS_TYPE"
    , "SLA_JEOPARDY_DATE"
    , "SLA_JEOPARDY_DAYS"
    , "SLA_TARGET_DAYS"
    , "AGE_IN_BUSINESS_DAYS"
    , "AGE_IN_CALENDAR_DAYS"
    , "JEOPARDY_DAYS_TYPE"
    , "JEOPARDY_FLAG"
    , "TIMELINESS_STATUS"
    , "INCIDENT_FWD_TIMELINESS_STATUS"
    , "INCIDENT_FORWARDING_TARGET"
    , "COMPLETE_DT"
    , "FORWARD_DT"
    , "CURRENT_STEP"
    , "RECEIVED_DT"
    , "PLAN_NAME"
    , "REPORTER_NAME"
    , "REPORTER_PHONE"
    , "SLA_SATISFIED"
    , "CREATED_BY_SUP"
    , "CREATED_BY_EID"
    , "CREATED_BY_SUP_NAME"    
    , CAST('NYEC' AS VARCHAR2(10)) AS PROJECT_NAME
    , "GWF_ESCALATE_TO_STATE"
    , "GWF_RESOLVED_EES_CSS"
    , "GWF_RESOLVED_SUP"   
    , "GWF_FOLLOWUP_REQ"   
    , "GWF_RETURN_TO_STATE" 
    , "SLA_COMPLETE_DATE" AS "CUR_SLA_COMPLETE_DATE"
FROM D_COMPLAINT_CURRENT WITH read only;

create or replace public synonym D_COMPLAINT_CURRENT_SV for D_COMPLAINT_CURRENT_SV;
grant select on D_COMPLAINT_CURRENT_SV to MAXDAT_READ_ONLY;


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
  cc.sla_complete_date sla_complete_date
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
  cc.sla_complete_date sla_complete_date
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
  cc.sla_complete_date sla_complete_date
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
  cc.sla_complete_date sla_complete_date
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