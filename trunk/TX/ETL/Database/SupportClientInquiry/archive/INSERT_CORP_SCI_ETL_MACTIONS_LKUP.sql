-- Manual Actions
DECLARE
  c_name    CONSTANT corp_etl_list_lkup.name%TYPE       := 'CLIENT_INQUIRY_MANUAL_ACTION';
  c_type    CONSTANT corp_etl_list_lkup.list_type%TYPE  := 'LIST';
  c_beg     CONSTANT corp_etl_list_lkup.start_date%TYPE := TRUNC(SYSDATE,'MON');
  c_end     CONSTANT corp_etl_list_lkup.end_date%TYPE   := TO_DATE('7-JUL-7777','DD-MON-YYYY');
  v_value            corp_etl_list_lkup.value%TYPE;
  v_desc             corp_etl_list_lkup.out_var%TYPE;
  v_category         corp_etl_list_lkup.ref_type%TYPE;

BEGIN
  FOR c IN 1..76
  LOOP
    CASE c
    WHEN 1 THEN v_value := 'PROVIDER_REF'; v_desc := 'Provider Referral'; v_category := 'REFERRAL';
    WHEN 2 THEN v_value := 'PLAN_REF'; v_desc := 'Plan Referral'; v_category := 'REFERRAL';
    WHEN 3 THEN v_value := 'MTP_REF'; v_desc := 'MTP Referral'; v_category := 'REFERRAL';
    WHEN 4 THEN v_value := 'MTP'; v_desc := 'MTP 3-Way Call Initiated'; v_category := '3_WAY_CALL';
    WHEN 5 THEN v_value := 'PLAN'; v_desc := 'Plan 3-Way Call Initiated'; v_category := '3_WAY_CALL';
    WHEN 6 THEN v_value := 'PROVIDER'; v_desc := 'Provider 3-Way Call Initiated'; v_category := '3_WAY_CALL';
    WHEN 7 THEN v_value := 'HHSC'; v_desc := 'HHSC 3-Way Call Initiated'; v_category := '3_WAY_CALL';
    WHEN 8 THEN v_value := 'GENERAL'; v_desc := 'General Managed Care Info Inquiry'; v_category := 'INQUIRY';
    WHEN 9 THEN v_value := 'DISENROLLMENT'; v_desc := 'Disenrollment Inquiry'; v_category := 'INQUIRY';
    WHEN 10 THEN v_value := 'COST_SHARE'; v_desc := 'Cost Share Inquiry'; v_category := 'INQUIRY';
    WHEN 11 THEN v_value := 'PREMIUM'; v_desc := 'Premium Inquiry'; v_category := 'INQUIRY';
    WHEN 12 THEN v_value := 'CLAIMS_ADMIN'; v_desc := 'Claims Administrator Referral'; v_category := 'REFERRAL';
    WHEN 13 THEN v_value := 'ELIGIBILITY'; v_desc := 'Eligibility Referral'; v_category := 'REFERRAL';
    WHEN 14 THEN v_value := 'OTHER_RESOURCE'; v_desc := 'Non Enrollment/THSteps Call - Referred Out'; v_category := 'REFERRAL';
    WHEN 15 THEN v_value := 'BASIC_SCRIPT'; v_desc := 'Basic Script - THSteps'; v_category := 'THSTEPS';
    WHEN 16 THEN v_value := 'HCO_SCRIPT'; v_desc := 'HCO Script - THSteps'; v_category := 'THSTEPS';
    WHEN 17 THEN v_value := 'PROVIDER_HELP'; v_desc := 'Help Finding Providers - THSteps'; v_category := 'THSTEPS';
    WHEN 18 THEN v_value := 'SCHEDULING'; v_desc := 'Scheduling Assistance - THSteps'; v_category := 'THSTEPS';
    WHEN 19 THEN v_value := '3_WAY_INIT_OTH'; v_desc := 'Other 3-Way Call Initiated'; v_category := '3_WAY_CALL';
    WHEN 20 THEN v_value := 'PLAN_CHG_ISSUE'; v_desc := 'Plan Changed Not Processed-Hospitalized'; v_category := 'INQUIRY';
    WHEN 21 THEN v_value := 'RESEARCH_INQ'; v_desc := 'Research/Review Inquiry'; v_category := 'INQUIRY';
    WHEN 22 THEN v_value := 'MEDICAID_ID_INQ'; v_desc := 'Medicaid ID Inquiry'; v_category := 'INQUIRY';
    WHEN 23 THEN v_value := 'OUTREACH_INQ'; v_desc := 'Outreach Presentation Day/Time Inqury'; v_category := 'INQUIRY';
    WHEN 24 THEN v_value := 'OUTREACH_EVENT'; v_desc := 'Outreach Event Requested'; v_category := 'INQUIRY';
    WHEN 25 THEN v_value := 'HOME_VISIT_REQUEST'; v_desc := 'Home Visit Requested'; v_category := 'INQUIRY';
    WHEN 26 THEN v_value := 'WEB_HELP'; v_desc := 'Website question/help'; v_category := 'INQUIRY';
    WHEN 27 THEN v_value := 'THSTEPS_CASE_MGMT'; v_desc := 'Enhanced Case Management Script'; v_category := 'THSTEPS';
    WHEN 28 THEN v_value := 'THSTEPS_MISS_APPT'; v_desc := 'Missed Appointment Script - THSteps'; v_category := 'THSTEPS';
    WHEN 29 THEN v_value := 'THSTEPS_SP_PROJ'; v_desc := 'Special Project Script - THSteps'; v_category := 'THSTEPS';
    WHEN 30 THEN v_value := 'THSTEPS_1087'; v_desc := '1087/1087C Script - THSteps'; v_category := 'THSTEPS';
    WHEN 31 THEN v_value := 'TRANS_CALL_CLAIMS_ADMIN'; v_desc := 'Claims Administrator Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 32 THEN v_value := 'TRANS_CALL_ELIG'; v_desc := 'Eligibility Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 33 THEN v_value := 'TRANS_CALL_MTP'; v_desc := 'MTP Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 34 THEN v_value := 'TRANS_CALL_PLAN'; v_desc := 'Plan Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 35 THEN v_value := 'TRANS_CALL_PROV'; v_desc := 'Provider Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 36 THEN v_value := 'TRANS_CALL_SPANISH'; v_desc := 'Spanish Queue Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 37 THEN v_value := 'TRANS_CALL_SSU'; v_desc := 'SSU Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 38 THEN v_value := 'TRANS_CALL_SUPER'; v_desc := 'Supervisor Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 39 THEN v_value := 'RETURN_VMAIL'; v_desc := 'Return Voice Mail'; v_category := 'CALL_BACK';
    WHEN 40 THEN v_value := 'THSTEPS_FOLLOWUP'; v_desc := 'THSteps Follow Up'; v_category := 'CALL_BACK';
    WHEN 41 THEN v_value := 'ENROLL_FOLLOWUP'; v_desc := 'Enrollment Follow Up'; v_category := 'CALL_BACK';
    WHEN 42 THEN v_value := '3WAY_RECD_MTP'; v_desc := '3-Way Call Received from MTP'; v_category := '3_WAY_CALL_REC';
    WHEN 43 THEN v_value := '3WAY_RECD_PLAN'; v_desc := '3-Way Call Received from Plan'; v_category := '3_WAY_CALL_REC';
    WHEN 44 THEN v_value := '3WAY_RECD_OTHER'; v_desc := '3-Way Call Received - Other'; v_category := '3_WAY_CALL_REC';
    WHEN 45 THEN v_value := '3WAY_RECD_PROV'; v_desc := '3-Way Call Received from Provider'; v_category := '3_WAY_CALL_REC';
    WHEN 46 THEN v_value := '3WAY_RECD_HHSC'; v_desc := '3-Way Call Received from HHSC'; v_category := '3_WAY_CALL_REC';
    WHEN 47 THEN v_value := 'BUSY_ATTEMPT'; v_desc := 'Busy when Phone Call Attempted'; v_category := 'CALL_ATTEMPT';
    WHEN 48 THEN v_value := 'NO_ANSWER_ATTEMPT'; v_desc := 'No Answer when Phone Call Attempted'; v_category := 'CALL_ATTEMPT';
    WHEN 49 THEN v_value := 'WRONG_NUMBER_ATTEMPT'; v_desc := 'Wrong Number when Phone Call Attempted'; v_category := 'CALL_ATTEMPT';
    WHEN 50 THEN v_value := 'LEFT_MSG_ATTEMPT'; v_desc := 'Left Message when Phone Call Attempted'; v_category := 'CALL_ATTEMPT';
    WHEN 51 THEN v_value := 'NOT_HOME_LEFT_LTR'; v_desc := 'No one home, left letter'; v_category := 'VISIT_ATTEMPT';
    WHEN 52 THEN v_value := 'WRONG_HOUSE'; v_desc := 'Wrong House - Home Visit Attempt'; v_category := 'VISIT_ATTEMPT';
    WHEN 53 THEN v_value := 'SAFETY_ISSUE'; v_desc := 'Safety Issue - Do Not Return'; v_category := 'VISIT_ATTEMPT';
    WHEN 54 THEN v_value := 'CHECKUP_VERIFY_CLAIM'; v_desc := 'Checkup Verified Thru Claims'; v_category := 'THSTEPS';
    WHEN 55 THEN v_value := 'CHECKUP_VERIFY_CLIENT'; v_desc := 'Checkup Verified by Recipient'; v_category := 'THSTEPS';
    WHEN 56 THEN v_value := 'CHECKUP_VERIFY_PROV'; v_desc := 'Checkup Verified Thru Provider'; v_category := 'THSTEPS';
    WHEN 57 THEN v_value := 'CLIENT_LOCATE_FAIL'; v_desc := 'Unable to Locate Recipient'; v_category := 'THSTEPS';
    WHEN 58 THEN v_value := 'INFO_TO_PROV'; v_desc := 'Information Given to Provider'; v_category := 'THSTEPS';
    WHEN 59 THEN v_value := 'OR_HOME_VISIT_SUCCESS'; v_desc := 'Outreach Request Home Visit Successful'; v_category := 'THSTEPS';
    WHEN 60 THEN v_value := 'OR_PRESENTATION_NOT_SCHED'; v_desc := 'Outreach Presentation Not Scheduled'; v_category := 'THSTEPS';
    WHEN 61 THEN v_value := 'OR_PRESENTATION_SCHED'; v_desc := 'Outreach Presentation Scheduled'; v_category := 'THSTEPS';
    WHEN 62 THEN v_value := 'OR_PRESENTATION_WITHDRAWN'; v_desc := 'Outreach Presentation Withdrawn'; v_category := 'THSTEPS';
    WHEN 63 THEN v_value := 'OR_WITHDRAWN'; v_desc := 'Outreach Request Withdrawn by Recipient'; v_category := '';
    WHEN 64 THEN v_value := 'OUTBOUND_CALL_SUCCESS'; v_desc := 'Outbound Call Successful'; v_category := 'THSTEPS';
    WHEN 65 THEN v_value := 'PROV_CONTACT_FAIL'; v_desc := 'Provider Contact Unsuccessful'; v_category := 'THSTEPS';
    WHEN 66 THEN v_value := 'OR_HOME_UNSUCCESS'; v_desc := 'Home Visit Unsuccessful'; v_category := 'THSTEPS';
    WHEN 67 THEN v_value := 'OR_SCRIPT_DECLINED'; v_desc := 'Outreach Request - Script Declined'; v_category := 'THSTEPS';
    WHEN 68 THEN v_value := 'OR_SCRIPT_DELIVERED'; v_desc := 'Outreach Request - Script Delivered'; v_category := 'THSTEPS';
    WHEN 69 THEN v_value := 'START_ORPROC_2_1'; v_desc := 'Start Outreach Process 2.1'; v_category := 'THSTEPS';
    WHEN 70 THEN v_value := 'START_ORPROC_4_1'; v_desc := 'Start Outreach Process 4.1'; v_category := 'THSTEPS';
    WHEN 71 THEN v_value := 'OUTBOUND_CALL_UNSUCCESS'; v_desc := 'Outbound Call Unsuccessful'; v_category := 'THSTEPS';
    WHEN 72 THEN v_value := 'REFER_FOR_ADDITIONAL_OUTREACH'; v_desc := 'Referred for Additional Outreach'; v_category := 'THSTEPS';
    WHEN 73 THEN v_value := 'OTHER_INFO'; v_desc := 'Other Information Provided (THSteps)'; v_category := 'THSTEPS';
    WHEN 74 THEN v_value := 'CHECKUP_VERIFY_FAIL'; v_desc := 'Unable to Verify Checkup (THSteps)'; v_category := 'THSTEPS';
    WHEN 75 THEN v_value := 'VISIT_WITHDRAWN'; v_desc := 'Home Visit Withdrawn'; v_category := 'VISIT_WITHDRAWN';
    WHEN 76 THEN v_value := 'VISIT_SUCCESS'; v_desc := 'Home Visit Successful'; v_category := 'VISIT_SUCCESS';
    ELSE NULL;
    END CASE;
    --
    UPDATE corp_etl_list_lkup
       SET ref_type = v_category, out_var = v_desc
     WHERE name = c_name AND value = v_value;
    --
    IF SQL%ROWCOUNT = 0
    THEN INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
         VALUES (c_name, c_type, v_value, v_desc, v_category, c_beg, c_end, 'Client Inquiry ETL - Manual Event Actions', SYSDATE, SYSDATE);
    END IF;
  END LOOP;
  COMMIT;
END;
/