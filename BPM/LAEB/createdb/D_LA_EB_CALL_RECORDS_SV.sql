DROP VIEW MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV
AS
SELECT
  c.call_record_id call_record_id
, c.create_ts call_creation_date
, c.call_type_cd call_call_type_cd
, E.event_type_cd call_event_type_cd
, E.context call_action_cd
, e.comments call_action_desc
FROM EB.CALL_RECORD c
JOIN EB.EVENT e ON E.CALL_RECORD_ID = c.CALL_RECORD_ID
AND E.CONTEXT IN ('RENEWAL_COMPLETED',
                               'RENEWAL_INCOMPLETE_CALL_DISCONNECTED',
                               'RENEWAL_INCOMPLETE_MISSING_INFO',
                               'RENEWAL_INCOMPLETE_WILL_CALL_BACK',
                               'RENEWAL_INCOMPLETE_PROBLEM_WITH_STATE_SYSTEM',
                               'APPLICATION_COMPLETE_PLAN_SELECTED',
                               'APPLICATION_COMPLETE_NO_PLAN_SELECTED',
                               'APPLICATION_INCOMPLETE_CALL_DISCONNECTED',
                               'APPLICATION_INCOMPLETE_MISSING_INFO',
                               'APPLICATION_INCOMPLETE_WILL_CALL_BACK',
                               'APPLICATION_INCOMPLETE_PROBLEM_WITH_STATE_SYSTEM',
                               'UNABLE_TO_VERIFY_IDENTITY',
                               'GENERAL_INFORMATION',
                               'MAILING_ADDRESS_AND_OR_PHONE_NUMBER_CHANGE',
                               'MEMBER_REQUESTED_FORM_TO_BE_MAILED',
                               'NON_DEMOGRAPHIC_CHANGE_OR_CONCERN_REFERRED_TO_DHH',
                               'INQUERY_PLAN_INFO',
                               'INQUERY_PROVIDER_INFO',
                               'INQUERY_RENEWAL_INFO',
                               'INQUERY_CSCL_STATUS',
                               'INQUERY_GENERAL_INFO',
                               'INQUERY_MEDICAID_INFO',
                               'INQUERY_OTHER_PROGRAM_INFO',
                               'INQUERY_PLAN_AND_CUSTOMER_SERVICE_INFO',
                               'REFERRAL_TO_DHH',
                               'REFERRAL_TO_PLAN',
                              'REFERRAL_TO_HEALTHY_LOUISIANA',
                               'REFERRAL_TO_PROVIDER',
                               'LA_TRANSFER_CALL_BYH');

GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO GT83345;
GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_LA_EB_CALL_RECORDS_SV TO MAXDAT_SUPPORT_READ_ONLY;
