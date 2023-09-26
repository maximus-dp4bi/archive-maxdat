/*
Created on 09/30/2016 by Raj A.
Description: Process Complaints ETL errored out on 09/30/2016 because of a complaint incident having created_by=25963.

This issue is explained in NYHIX-25620. 
*/
insert into MAXDAT.CORP_ETL_COMPLAINTS_INCIDENTS (CHANNEL, CREATED_BY_GROUP, CREATED_BY_NAME, INCIDENT_ID, TRACKING_NUMBER, CREATE_DT, ASED_RESOLVE_INCIDENT_EES_CSS, ASSD_RESOLVE_INCIDENT_EES_CSS, ASED_RESOLVE_INCIDENT_SUP, ASSD_RESOLVE_INCIDENT_SUP, ASED_RESOLVE_INCIDENT_DOH, ASSD_RESOLVE_INCIDENT_DOH, ASED_WITHDRAW_INCIDENT, ASSD_WITHDRAW_INCIDENT, ASED_PERFORM_FOLLOWUP, ASSD_PERFORM_FOLLOWUP, ABOUT_PLAN_CODE, ABOUT_PROVIDER_ID, ACTION_TYPE, CANCEL_BY, CANCEL_DT, CANCEL_METHOD, CANCEL_REASON, CURRENT_TASK_ID, DE_TASK_ID, INCIDENT_ABOUT, INCIDENT_DESCRIPTION, INCIDENT_REASON, INCIDENT_STATUS, INCIDENT_STATUS_DT, INSTANCE_COMPLETE_DT, INSTANCE_STATUS, LAST_UPDATE_BY_NAME, LAST_UPDATE_BY_DT, UPDATED_BY, CLIENT_ID, OTHER_PARTY_NAME, PRIORITY, REPORTED_BY, REPORTER_RELATIONSHIP, RESOLUTION_DESCRIPTION, RESOLUTION_TYPE, CASE_ID, FORWARDED, INCIDENT_TYPE, FORWARDED_TO, GWF_RESOLVED_EES_CSS, GWF_RESOLVED_SUP, GWF_FOLLOWUP_REQ, GWF_RETURN_TO_STATE, ASF_RESOLVE_INCIDENT_EES_CSS, ASF_RESOLVE_INCIDENT_SUP, ASF_RESOLVE_INCIDENT_DOH, ASF_PERFORM_FOLLOWUP, ASF_WITHDRAW_INCIDENT, STG_EXTRACT_DATE, STG_LAST_UPDATE_DATE, MAX_INCI_STAT_HIST_ID, STAFF_TYPE_CD, STAGE_DONE_DT, COMPLETE_DT, FORWARD_DT, CURRENT_STEP, RECEIVED_DT, PLAN_NAME, REPORTER_NAME, REPORTER_PHONE, SLA_SATISFIED, ACTION_COMMENTS, CREATED_BY_SUP, GWF_ESCALATE_TO_STATE, CREATED_BY_EID, CREATED_BY_SUP_NAME, SLA_COMPLETE_DT, CASE_CIN)
values ('PHONE', 'Call Center Team 1', '25963', 26777781, '27534722', to_date('30-09-2016 14:53:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('30-09-2016 14:53:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'Referral Open', to_date('30-09-2016 14:53:19', 'dd-mm-yyyy hh24:mi:ss'), null, 'Active', '19379', to_date('30-09-2016 15:39:47', 'dd-mm-yyyy hh24:mi:ss'), null, 16769185, null, null, 'Consumer', null, null, null, null, 'N', 'REFERRAL', null, null, null, null, null, 'N', 'N', 'N', 'N', 'N', to_date('30-09-2016 17:28:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-09-2016 14:28:19', 'dd-mm-yyyy hh24:mi:ss'), 2920702, null, null, null, null, null, to_date('30-09-2016 14:51:29', 'dd-mm-yyyy hh24:mi:ss'), null, 'ZAKYRA ALLEN', '3472282857', 'N', null, 'N', null, '25963', 'Tirado,Nicole ', null, null);
commit;