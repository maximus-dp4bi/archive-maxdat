   CREATE OR REPLACE FORCE VIEW "D_MEMBER_ELIGIBILITY_SV" ("ME_ID",
 "COV_RQST_ID",
 "CREATE_DATE",
 "ELIG_STATUS",
 "ELIG_STATUS_DATE",
 "PENDING_REASON",
 "PENDING_REASON_DATE",
 "NOT_ELIG_REASON",
 "NOT_APPLYING_REASON",
 "PROGRAM",
 "APPLICATION_ID",
 "ACCOUNT_ID",
 "MEMBER_ID",
 "LAST_UPDATE_DATE",
 "LAST_UPDATE_BY_NAME",
 "MEDICAID_REFERRAL",
 "MEDICAID_REFERRAL_SENT_DATE",
 "MEDICAID_REFERRAL_REC_DATE",
 "ALL_MI_SATISFIED",
 "SSN_APPLY_DATE",
 "RACE_1",
 "RACE_2",
 "ETHNICITY",
 "MEMBER_ZIP_CODE",
 "COUNTY",
 "MEMBER_STATE",
 "TOTAL_MEMBER_INCOME_AMT",
 "INCOME_VERIF_STATUS",
 "INCOME_VERIF_STATUS_DATE",
 "CHILDCARE_EXPENSE",
 "RELATIONSHIP_PARENT1",
 "RELATIONSHIP_PARENT2",
 "UNBORN_CHILD_DUE_DATE",
 "OTHER_INSURANCE_ANSWER",
 "VOLUNTARY_CANCEL_ANSWER",
 "LIMITED_IN_ANY_WAY",
 "NEEDS_SPECIAL_THERAPY",
 "USES_MORE_MED_CARE",
 "CMSN_OPT_ANSWER",
 "DENTAL_COVERAGE_FLAG",
 "CITIZENSHIP_VERIFIED",
 "CITIZENSHIP_VERIF_DATE",
 "CITIZENSHIP_VERIF_SOURCE_DOC",
 "CITIZENSHIP_INSUFF_REASON",
 "IDENTITY_VERIFIED",
 "IDENTITY_VERIF_DATE",
 "IDENTITY_VERIF_SOURCE_DOC",
 "IDENTITY_INSUFF_REASON",
 "TRIBAL_MBRSHIP_VERIFIED",
 "TRIBAL_MBRSHIP_INSUFF_REASON",
 "ELIG_RESULT_ID",
 "ELIG_RESULT_DATE",
 "PRE_ELIG_RUN_DATE",
 "AGENCY_MATCH",
 "AGENCY_MATCH_DATE",
 "IVIC_WRK_REQ_ID",
 "PENDING_ELIG_NTFY_RQST_ID",
 "APP_EXPIRED_NTFY_RQST_ID",
 "APP_EXPIRED_NTFY_RQST_DATE",
 "ELIG_OUTCOME_NTFY_RQST_ID",
 "COMPLETE_DATE",
 "ASSD_RVW_ELIG",
 "ASED_RVW_ELIG",
 "ASF_RVW_ELIG",
 "ASSD_COV_REQ",
 "ASED_COV_REQ",
 "ASF_COV_REQ",
 "ASSD_NTFY_OUTCOME",
 "ASED_NTFY_OUTCOME",
 "ASF_NTFY_OUTCOME",
 "ASSD_RECEIVE_PROCESS_MI",
 "ASED_RECEIVE_PROCESS_MI",
 "ASF_RECEIVE_PROCESS_MI",
 "ASSD_NTFY_PENDING_ELIG",
 "ASED_NTFY_PENDING_ELIG",
 "ASF_NTFY_PENDING_ELIG",
 "ASSD_NTFY_TIMEOUT",
 "ASED_NTFY_TIMEOUT",
 "ASF_NTFY_TIMEOUT",
 "ASED_CANCEL_REQUEST",
 "GWF_AUTO_DETERMINED",
 "GWF_ELIG_DETERMINED",
 "GWF_MISSING_INFO",
 "GWF_ELIG_TIMEOUT",
 "GWF_TIMEOUT_REV",
 "INSTANCE_STATUS",
 "CANCEL_DATE",
 "IVIC_WRK_REQ_DATE",
 "IVIC_COMPLETE_DATE",
 "AGE_IN_BUSINESS_DAYS",
 "AGE_IN_CALENDAR_DAYS",
 "STATUS_AGE_IN_BUS_DAYS",
 "STATUS_AGE_IN_CAL_DAYS",
 "ACCOUNT_NUMBER",
 "PERSON_NUMBER" ,
 "COVERAGE_REQUEST_STATUS" ,
 "COVERAGE_REQUEST_STATUS_DATE",
 "ELIG_OUTCOME_NTFY_RQST_DATE",
 "PENDING_ELIG_NTFY_RQST_DATE", 
 "GWF_ELIG_PEND_NOTIFY")
 AS SELECT "ME_ID",
"COV_RQST_ID",
"CREATE_DATE",
"ELIG_STATUS",
"ELIG_STATUS_DATE",
"PENDING_REASON",
"PENDING_REASON_DATE",
"NOT_ELIG_REASON",
"NOT_APPLYING_REASON",
"PROGRAM",
"APPLICATION_ID",
"ACCOUNT_ID",
"MEMBER_ID",
"LAST_UPDATE_DATE",
"LAST_UPDATE_BY_NAME",
"MEDICAID_REFERRAL",
"MEDICAID_REFERRAL_SENT_DATE",
"MEDICAID_REFERRAL_REC_DATE",
"ALL_MI_SATISFIED",
"SSN_APPLY_DATE",
"RACE_1",
"RACE_2",
"ETHNICITY",
"MEMBER_ZIP_CODE",
"COUNTY",
"MEMBER_STATE",
"TOTAL_MEMBER_INCOME_AMT",
"INCOME_VERIF_STATUS",
"INCOME_VERIF_STATUS_DATE",
"CHILDCARE_EXPENSE",
"RELATIONSHIP_PARENT1",
"RELATIONSHIP_PARENT2",
"UNBORN_CHILD_DUE_DATE",
"OTHER_INSURANCE_ANSWER",
"VOLUNTARY_CANCEL_ANSWER",
"LIMITED_IN_ANY_WAY",
"NEEDS_SPECIAL_THERAPY",
"USES_MORE_MED_CARE",
"CMSN_OPT_ANSWER",
"DENTAL_COVERAGE_FLAG",
"CITIZENSHIP_VERIFIED",
"CITIZENSHIP_VERIF_DATE",
"CITIZENSHIP_VERIF_SOURCE_DOC",
"CITIZENSHIP_INSUFF_REASON",
"IDENTITY_VERIFIED",
"IDENTITY_VERIF_DATE",
"IDENTITY_VERIF_SOURCE_DOC",
"IDENTITY_INSUFF_REASON",
"TRIBAL_MBRSHIP_VERIFIED",
"TRIBAL_MBRSHIP_INSUFF_REASON",
"ELIG_RESULT_ID",
"ELIG_RESULT_DATE",
"PRE_ELIG_RUN_DATE",
"AGENCY_MATCH",
"AGENCY_MATCH_DATE",
"IVIC_WRK_REQ_ID",
"PENDING_ELIG_NTFY_RQST_ID",
"APP_EXPIRED_NTFY_RQST_ID",
"APP_EXPIRED_NTFY_RQST_DATE",
"ELIG_OUTCOME_NTFY_RQST_ID",
"COMPLETE_DATE",
"ASSD_RVW_ELIG",
"ASED_RVW_ELIG",
"ASF_RVW_ELIG",
"ASSD_COV_REQ",
"ASED_COV_REQ",
"ASF_COV_REQ",
"ASSD_NTFY_OUTCOME",
"ASED_NTFY_OUTCOME",
"ASF_NTFY_OUTCOME",
"ASSD_RECEIVE_PROCESS_MI",
"ASED_RECEIVE_PROCESS_MI",
"ASF_RECEIVE_PROCESS_MI",
"ASSD_NTFY_PENDING_ELIG",
"ASED_NTFY_PENDING_ELIG",
"ASF_NTFY_PENDING_ELIG",
"ASSD_NTFY_TIMEOUT",
"ASED_NTFY_TIMEOUT",
"ASF_NTFY_TIMEOUT",
"ASED_CANCEL_REQUEST",
"GWF_AUTO_DETERMINED",
"GWF_ELIG_DETERMINED",
"GWF_MISSING_INFO",
"GWF_ELIG_TIMEOUT",
"GWF_TIMEOUT_REV",
"INSTANCE_STATUS",
"CANCEL_DATE",
"IVIC_WRK_REQ_DATE",
"IVIC_COMPLETE_DATE",
business_days_between(CREATE_DATE, sysdate)    as "AGE_IN_BUSINESS_DAYS",
round(sysdate - create_date,0) as "AGE_IN_CALENDAR_DAYS",
business_days_between(ELIG_STATUS_DATE, sysdate) as "STATUS_AGE_IN_BUS_DAYS", 
round(sysdate - ELIG_STATUS_DATE,0 ) as "STATUS_AGE_IN_CAL_DAYS",
"ACCOUNT_NUMBER",
"PERSON_NUMBER" ,
"COVERAGE_REQUEST_STATUS" ,
"COVERAGE_REQUEST_STATUS_DATE",
"ELIG_OUTCOME_NTFY_RQST_DATE",
"PENDING_ELIG_NTFY_RQST_DATE", 
"GWF_ELIG_PEND_NOTIFY"
FROM FLHK_ETL_MEMBER_ELIGIBILITY;
/