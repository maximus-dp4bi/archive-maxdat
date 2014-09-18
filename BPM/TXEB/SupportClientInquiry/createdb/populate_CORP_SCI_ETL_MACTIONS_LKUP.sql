/* Manual Actions
   7/30/13  B.Thai Creation
   11/18/13 B.Thai Original list of 76 manual actions in TX is actually 67. Some of different name than originally provided.
*/
DECLARE
  c_name    CONSTANT corp_etl_list_lkup.name%TYPE       := 'CLIENT_INQUIRY_MANUAL_ACTION';
  c_type    CONSTANT corp_etl_list_lkup.list_type%TYPE  := 'LIST';
  c_beg     CONSTANT corp_etl_list_lkup.start_date%TYPE := TRUNC(SYSDATE,'MON');
  c_end     CONSTANT corp_etl_list_lkup.end_date%TYPE   := TO_DATE('7-JUL-7777','DD-MON-YYYY');
  v_value            corp_etl_list_lkup.value%TYPE;
  v_desc             corp_etl_list_lkup.out_var%TYPE;
  v_category         corp_etl_list_lkup.ref_type%TYPE;

BEGIN
  -- Remove corporate records. TX has own values.
  DELETE FROM corp_etl_list_lkup
   WHERE name  = 'CLIENT_INQUIRY_MANUAL_ACTION';
  COMMIT;
  --
  FOR c IN 1..67
  LOOP
    CASE c
    WHEN 1 THEN v_value := '211_REFERRAL'; v_desc := '211 option 1'; v_category := 'INQUIRY';
    WHEN 2 THEN v_value := 'BASIC_SCRIPT'; v_desc := 'Basic Script'; v_category := 'INQUIRY';
    WHEN 3 THEN v_value := 'BENEFIT_REF'; v_desc := 'Your Texas Benefits (YTB)/ Medicaid ID'; v_category := 'REFERRAL';
    WHEN 4 THEN v_value := 'BUSY_ATTEMPT'; v_desc := 'Phone Call - Busy'; v_category := 'OUTREACH';
    WHEN 5 THEN v_value := 'CALL_FAIL_RETRY'; v_desc := 'Phone Call Unsuccessful Try Again'; v_category := 'OUTREACH';
    WHEN 6 THEN v_value := 'CHECKUP_VERIFY_CLAIM'; v_desc := 'Checkup Verified Thru Claims'; v_category := 'CHECKUP_VERIFICATION';
    WHEN 7 THEN v_value := 'CHECKUP_VERIFY_FAIL'; v_desc := 'Unable to Verify Checkup'; v_category := 'CHECKUP_VERIFICATION';
    WHEN 8 THEN v_value := 'CHECKUP_VERIFY_PROV'; v_desc := 'Checkup Verified Thru Provider'; v_category := 'CHECKUP_VERIFICATION';
    WHEN 9 THEN v_value := 'CHIP_EDUCATION'; v_desc := 'Education Only - CHIP'; v_category := 'INQUIRY';
    WHEN 10 THEN v_value := 'CLAIMS_ADMIN'; v_desc := 'Medicaid Hotline / Claims Administrator (TMHP)'; v_category := 'REFERRAL';
    WHEN 11 THEN v_value := 'CLIENT_LOCATE_FAIL'; v_desc := 'Unable to Locate Recipient'; v_category := 'INQUIRY';
    WHEN 12 THEN v_value := 'CM_PROV_MAIL'; v_desc := 'Gave Case Management Providers by Mail'; v_category := 'INQUIRY';
    WHEN 13 THEN v_value := 'CM_PROV_PHONE'; v_desc := 'Gave Case Management Providers by Phone'; v_category := 'INQUIRY';
    WHEN 14 THEN v_value := 'CMI_REF'; v_desc := 'CMI'; v_category := 'REFERRAL';
    WHEN 15 THEN v_value := 'COMMUNITY_EVENT'; v_desc := 'Community Event Inquiry'; v_category := 'INQUIRY';
    WHEN 16 THEN v_value := 'COST_SHARE'; v_desc := 'Cost Share / Copay'; v_category := 'INQUIRY';
    WHEN 17 THEN v_value := 'DEFAULT_EDUCATION'; v_desc := 'MMC Default Education'; v_category := 'INQUIRY';
    WHEN 18 THEN v_value := 'DISENROLL_REQ'; v_desc := 'MMC Mandatory Disenrollment Request'; v_category := 'DISENROLL_REQUEST';
    WHEN 19 THEN v_value := 'DISENROLLMENT'; v_desc := 'Disenrollment Inquiry'; v_category := 'DISENROLL_REQUEST';
    WHEN 20 THEN v_value := 'ELIGIBILITY'; v_desc := 'Eligibility-211 option 2'; v_category := 'INQUIRY';
    WHEN 21 THEN v_value := 'ELIGIBILITY1'; v_desc := 'Eligibility - SSA/SSI'; v_category := 'INQUIRY';
    WHEN 22 THEN v_value := 'ELIGIBILITY2'; v_desc := 'Eligibility - MEPD'; v_category := 'INQUIRY';
    WHEN 23 THEN v_value := 'ELIGIBILITY3'; v_desc := 'Eligibility - DADS'; v_category := 'INQUIRY';
    WHEN 24 THEN v_value := 'ELIGIBILITY4'; v_desc := 'Eligibility - DPFS'; v_category := 'INQUIRY';
    WHEN 25 THEN v_value := 'ELIGIBILITY5'; v_desc := 'Eligibility - STAR+PLUS Support Unit'; v_category := 'INQUIRY';
    WHEN 26 THEN v_value := 'ENROLL_DISCONNECT'; v_desc := 'Call Disconnected During Enrollment Script'; v_category := 'NO ENROLLMENT DONE';
    WHEN 27 THEN v_value := 'ENROLL_FEE'; v_desc := 'Enrollment Fee'; v_category := 'INQUIRY';
    WHEN 28 THEN v_value := 'HCO_SCRIPT'; v_desc := 'HCO Script'; v_category := 'INQUIRY';
    WHEN 29 THEN v_value := 'HEALTH_MARKETPLACE_EXCHANGE'; v_desc := 'Health Marketplace Exchange'; v_category := 'INQUIRY';
    WHEN 30 THEN v_value := 'INFO_TO_PROV'; v_desc := 'Information Given to Provider'; v_category := 'INQUIRY';
    WHEN 31 THEN v_value := 'LEFT_MSG_ATTEMPT'; v_desc := 'Phone Call - Left Message'; v_category := 'OUTREACH';
    WHEN 32 THEN v_value := 'MEDICARE_REF'; v_desc := 'Medicare'; v_category := 'REFERRAL';
    WHEN 33 THEN v_value := 'MMC_EDUCATION'; v_desc := 'Education Only - MMC'; v_category := 'INQUIRY';
    WHEN 34 THEN v_value := 'MTP_REF'; v_desc := 'MTP'; v_category := 'REFERRAL';
    WHEN 35 THEN v_value := 'NO_ANSWER_ATTEMPT'; v_desc := 'Phone Call - No Answer'; v_category := 'OUTREACH';
    WHEN 36 THEN v_value := 'NONMED_REF'; v_desc := 'Non Medicaid/CHIP Call - Referred Out'; v_category := 'REFERRAL';
    WHEN 37 THEN v_value := 'OR_RETURN_VMAIL'; v_desc := 'Return Voice Mail'; v_category := 'OUTREACH';
    WHEN 38 THEN v_value := 'OR_SCRIPT_DECLINED'; v_desc := 'Script Declined, Other Program Info Provided'; v_category := 'OUTREACH';
    WHEN 39 THEN v_value := 'OTHER_INFO'; v_desc := 'Assistance Declined, Other Program Info Provided'; v_category := 'OUTREACH';
    WHEN 40 THEN v_value := 'OTHER_REF'; v_desc := 'Other'; v_category := 'REFERRAL';
    WHEN 41 THEN v_value := 'OTHER_RESOURCE'; v_desc := 'Referred for Additional Outreach - 1087'; v_category := 'OUTREACH';
    WHEN 42 THEN v_value := 'OTHER_RESOURCE2'; v_desc := 'Referred for Additional Outreach - EER'; v_category := 'OUTREACH';
    WHEN 43 THEN v_value := 'OUTBOUND_DIALER_FAIL'; v_desc := 'Phone - Dialer Unsuccessful'; v_category := 'OUTREACH';
    WHEN 44 THEN v_value := 'PLAN_CHG_ISSUE'; v_desc := 'Plan Change Not Processed - Hospitalized'; v_category := 'NO PLAN CHANGE DONE';
    WHEN 45 THEN v_value := 'PLAN_CHG_ISSUE2'; v_desc := 'Plan Change Not Processed - Nursing Home'; v_category := 'NO PLAN CHANGE DONE';
    WHEN 46 THEN v_value := 'PLAN_INFO'; v_desc := 'Provided Plan Information'; v_category := 'INQUIRY';
    WHEN 47 THEN v_value := 'PLAN_REF'; v_desc := 'Plan'; v_category := 'REFERRAL';
    WHEN 48 THEN v_value := 'PROV_COST_SHARE'; v_desc := 'Provider Cost Share / Copay information'; v_category := 'INQUIRY';
    WHEN 49 THEN v_value := 'PROV_NOT_IN_PLAN'; v_desc := 'Not in Plan System'; v_category := 'INQUIRY';
    WHEN 50 THEN v_value := 'PROVIDER_HELP'; v_desc := 'Help Finding Providers'; v_category := 'INQUIRY';
    WHEN 51 THEN v_value := 'PROVIDER_REF'; v_desc := 'Provider'; v_category := 'INQUIRY';
    WHEN 52 THEN v_value := 'REFER_TO_MEM_SERVICE'; v_desc := 'Referred to Member Services'; v_category := 'REFERRAL';
    WHEN 53 THEN v_value := 'REFER_TO_PLAN'; v_desc := 'Referred to Plan'; v_category := 'REFERRAL';
    WHEN 54 THEN v_value := 'REFER_TO_TMHP'; v_desc := 'Referred to Claims Administrator (TMHP)'; v_category := 'REFERRAL';
    WHEN 55 THEN v_value := 'SAFETY_ISSUE'; v_desc := 'Home Visit Safety Issue - Do Not Return'; v_category := 'OUTREACH';
    WHEN 56 THEN v_value := 'SCHEDULING'; v_desc := 'Scheduling Assistance'; v_category := 'INQUIRY';
    WHEN 57 THEN v_value := 'SEU_REF'; v_desc := 'SEU'; v_category := 'REFERRAL';
    WHEN 58 THEN v_value := 'THS_DISCONNECT'; v_desc := 'Call Disconnected During THS Script'; v_category := 'THS SCRIPT';
    WHEN 59 THEN v_value := 'THSTEPS_1087'; v_desc := '1087/1087C Script'; v_category := 'THS SCRIPT';
    WHEN 60 THEN v_value := 'THSTEPS_CASE_MGMT'; v_desc := 'Enhanced Case Management Script'; v_category := 'THS SCRIPT';
    WHEN 61 THEN v_value := 'THSTEPS_INFO'; v_desc := 'THSteps Program Information'; v_category := 'THS SCRIPT';
    WHEN 62 THEN v_value := 'THSTEPS_MISS_APPT'; v_desc := 'Missed Appointment Script'; v_category := 'THS SCRIPT';
    WHEN 63 THEN v_value := 'TPR_REF'; v_desc := 'TPR Hotline'; v_category := 'REFERRAL';
    WHEN 64 THEN v_value := 'VERIFY_ENROLL_STATUS'; v_desc := 'Verified Enrollment Status'; v_category := 'INQUIRY';
    WHEN 65 THEN v_value := 'VERIFY_ENROLLMENT'; v_desc := 'Verified Client Enrollment'; v_category := 'INQUIRY';
    WHEN 66 THEN v_value := 'WEB_HELP'; v_desc := 'Website Info'; v_category := 'INQUIRY';
    WHEN 67 THEN v_value := 'WRONG_NUMBER_ATTEMPT'; v_desc := 'Phone Call - Wrong Number'; v_category := 'OUTREACH';
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