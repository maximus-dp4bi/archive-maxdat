ALTER TABLE d_complaint_current
ADD(GWF_RESOLVED_EES_CSS             varchar2(30),
    GWF_RESOLVED_SUP                 varchar2(1),
    GWF_FOLLOWUP_REQ                 varchar2(1),
    GWF_RETURN_TO_STATE              varchar2(1));


CREATE OR REPLACE FORCE VIEW "MAXDAT"."D_COMPLAINT_CURRENT_SV" ("CMPL_BI_ID", "CHANNEL", "CREATED_BY_GROUP", "CREATED_BY_NAME", "INCIDENT_ID", "INCIDENT_TRACKING_NUMBER", "CREATE_DATE", "ATMPT_TO_RES_INCIDENT_END", "ATMPT_TO_RES_INCIDENT_START", "ATMPT_TO_RES_INCIDENT_SUPV_END", "ATMPT_TO_RES_INCIDENT_SUPV_ST", "RESOLVE_INCIDENT_END", "RESOLVE_INCIDENT_START", "WITHDRAW_INCIDENT_END", "WITHDRAW_INCIDENT_START", "PERFORM_FOLLOWUP_ACTIONS_END", "PERFORM_FOLLOWUP_ACTIONS_START", "ABOUT_PLAN_CODE", "ABOUT_PROVIDER_ID", "CUR_ACTION_COMMENTS", "ACTION_TYPE", "CANCEL_BY", "CANCEL_DATE", "CANCEL_METHOD", "CANCEL_REASON", "CUR_CURRENT_TASK_ID", "DATA_ENTRY_TASK_ID", "CUR_INCIDENT_ABOUT", "CUR_INCIDENT_DESCRIPTION", "CUR_INCIDENT_REASON", "CUR_INCIDENT_STATUS", "CUR_INCIDENT_STATUS_DATE", "INSTANCE_COMPLETE_DATE", "CUR_INSTANCE_STATUS", "CUR_LAST_UPDATE_BY_NAME", "CUR_LAST_UPDATE_DATE", "LAST_UPDATED_BY", "CLIENT_ID", "OTHER_PARTY_NAME", "PRIORITY", "REPORTED_BY", "REPORTER_RELATIONSHIP", "CUR_RESOLUTION_DESCRIPTION", "RESOLUTION_TYPE", "CASE_ID", "FORWARDED_FLAG", "INCIDENT_TYPE", "FORWARDED_TO", "SLA_DAYS_TYPE", "SLA_JEOPARDY_DATE", "SLA_JEOPARDY_DAYS", "SLA_TARGET_DAYS", "AGE_IN_BUSINESS_DAYS", "AGE_IN_CALENDAR_DAYS", "JEOPARDY_DAYS_TYPE", "JEOPARDY_FLAG", "TIMELINESS_STATUS", "INCIDENT_FWD_TIMELINESS_STATUS", "INCIDENT_FORWARDING_TARGET", "COMPLETE_DT", "FORWARD_DT", "CURRENT_STEP", "RECEIVED_DT", "PLAN_NAME", "REPORTER_NAME", "REPORTER_PHONE", "SLA_SATISFIED", "CREATED_BY_SUP", "CREATED_BY_EID", "CREATED_BY_SUP_NAME", "PROJECT_NAME", "GWF_ESCALATE_TO_STATE", "GWF_RESOLVED_EES_CSS", "GWF_RESOLVED_SUP", "GWF_FOLLOWUP_REQ", "GWF_RETURN_TO_STATE" ) AS 
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
    , CAST('NYHBE' AS VARCHAR2(10)) AS PROJECT_NAME
    , "GWF_ESCALATE_TO_STATE"
    , "GWF_RESOLVED_EES_CSS"
    , "GWF_RESOLVED_SUP"   
    , "GWF_FOLLOWUP_REQ"   
    , "GWF_RETURN_TO_STATE"    
FROM D_COMPLAINT_CURRENT WITH read only;

create or replace public synonym D_COMPLAINT_CURRENT_SV for D_COMPLAINT_CURRENT_SV;
grant select on D_COMPLAINT_CURRENT_SV to MAXDAT_READ_ONLY;