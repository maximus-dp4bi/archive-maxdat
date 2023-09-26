CREATE OR REPLACE VIEW D_APPEALS_CURRENT_SV
AS select 
"APL_BI_ID",
"ABOUT_PLAN_CODE",
"ABOUT_PLAN_NAME",
"ABOUT_PROVIDER_ID",
"ABOUT_PROVIDER_NAME",
"ACTION_TYPE",
"ADVISE_TO_WTHD_IN_WRITING_END",
"ADVISE_TO_WTHD_IN_WRITING_ST",
"ADVISE_TO_WTHD_IN_WRT_PERF_BY",
"AGE_IN_BUSINESS_DAYS",
"AGE_IN_CALENDAR_DAYS",
"APPEAL_HEARING_DATE",
"APPEAL_TIMELINESS_STATUS",
"ASF_ADVISE_WITHDRAW",
"ASF_CANCEL_HEARING",
"ASF_CON_HEARING_PROC",
"ASF_CONDUCT_ST_REV",
"ASF_DETERMINE_VALID",
"ASF_GATHER_MISS_INFO",
"ASF_PROC_VALID_AMEND",
"ASF_REVIEW_APPEAL",
"ASF_SCHEDULE_HEARING",
"ASF_SHOP_REVIEW",
"CANCEL_BY",
"CANCEL_DATE",
"CANCEL_HEARING_END",
"CANCEL_HEARING_PERFORMED_BY",
"CANCEL_HEARING_START",
"CANCEL_METHOD",
"CANCEL_REASON",
"CASE_ID",
"CHANNEL",
"CONDUCT_HEARING_PROCESS_END",
"CONDUCT_HEARING_PROCESS_START",
"CONDUCT_STATE_REVIEW_END",
"CONDUCT_STATE_REVIEW_START",
"CREATE_DATE",
"CREATED_BY_GROUP",
"CREATED_BY_NAME",
"CUR_ACTION_COMMENTS",
"CUR_CONDUCT_VALIDITY_END",
"CUR_CONDUCT_VALIDITY_START",
"CUR_CURRENT_TASK_ID",
"CUR_INCIDENT_ABOUT",
"CUR_INCIDENT_DESCRIPTION",
"CUR_INCIDENT_STATUS",
"CUR_INCIDENT_STATUS_DATE",
"CUR_INSTANCE_STATUS",
"CUR_VALIDITY_PERFORMED_BY",
"GATHER_MISSING_INFO_PERFORM_BY",
"GATHER_MISSING_INFO_START",
"GATHER_MISSING_INFORMATION_END",
"GWF_APPEAL_INVALID",
"GWF_CHANGE_ELIGIBILITY",
"GWF_CHANNEL",
"GWF_RESOLVED",
"GWF_SHOP_REVIEW",
"GWF_VALID",
"GWF_WITHDRAWN_IN_WRITING",
"HEARING_PROCESS_PERFORMED_BY",
"INCIDENT_ID",
"INCIDENT_TRACKING_NUMBER",
"INCIDENT_TYPE",
"JEOPARDY_DAYS_TYPE",
"JEOPARDY_FLAG",
"LAST_UPDATE_BY_NAME",
"LAST_UPDATE_DATE",
"LINKED_CLIENT",
"OTHER_PARTY_NAME",
"PRIORITY",
"RECEIPT_DATE",
"REPORTED_BY",
"REPORTER_RELATIONSHIP",
"RESOLUTION_DESCRIPTION",
"RESOLUTION_TYPE",
"REVIEW_APPEAL_END",
"REVIEW_APPEAL_START",
"REVIEW_APPEALPERFORMED_BY",
"SCHEDULE_HEARING_END",
"SCHEDULE_HEARING_PERFORMED_BY",
"SCHEDULE_HEARING_START",
"SHOP_DESK_REVIEW_INFO_END",
"SHOP_DESK_REVIEW_INFO_PRFRM_BY",
"SHOP_DESK_REVIEW_INFO_START",
"SLA_JEOPARDY_DATE",
"SLA_JEOPARDY_DAYS",
"SLA_TARGET_DAYS",
"STATE_REVIEW_PERFORMED_BY",
"VALIDITY_AMENDMENT_END",
"VALIDITY_AMENDMENT_PERFORM_BY",
"VALIDITY_AMENDMENT_START",
"APPEAL_DATE",
"APPELLANT_TYPE",
"APPELLANT_TYPE_DESCRIPTION",
"REQUESTED_HEARING_DAY",
"REQUESTED_HEARING_TIME",
"APPEAL_HEARING_TIME",
"APPEAL_HEARING_LOCATION",
"AID_TO_CONTINUE",
"EXPECTED_APPEAL_REQUEST",
"CUR_COMPLETE_DATE",
"INSTANCE_COMPLETE_DATE",
"CURRENT_STEP",
"RECEIVED_DATE",
"FAIR_HEARING_TRACKING_NBR",
"APL_PRIMARY_MEMBER_ID",
"ACCOUNT_ID",
"NYHIX_ID",
"PREF_LANGUAGE",
"DECISION_DETAILS",
"SPECIALIZED_FLAG", 
"APL_OUTRCH_IND",
"APL_OUTRCH_DATE",
"APL_OUTRCH_OUTCM",
"OUTRCH_OUTCM_DATE", 
"APL_RSN_FR_WTHDRWL",
"UNBL_CNTCT_START_DATE" from D_APPEALS_CURRENT WITH READ ONLY;

GRANT SELECT on D_APPEALS_CURRENT_SV to MAXDAT_READ_ONLY;

  
	 
	 
	 
	 
	
	