-- Manual Actions
DECLARE
  c_name    CONSTANT corp_etl_list_lkup.name%TYPE       := 'CLIENT_INQUIRY_MANUAL_ACTION';
  c_type    CONSTANT corp_etl_list_lkup.list_type%TYPE  := 'LIST';
  c_comment CONSTANT corp_etl_list_lkup.comments%TYPE   := 'Client Inquiry ETL - Manual Event Actions';
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
  FOR c IN 1..29
  LOOP
    CASE c
    WHEN 1 THEN v_value := 'AUTHORIZED REP'; v_desc := 'Auth Rep/ Legal Documentation Pending'; v_category := 'INQUIRY';
    WHEN 2 THEN v_value := 'BILLING'; v_desc := 'Billing'; v_category := 'INQUIRY';
    WHEN 3 THEN v_value := 'PRG EDUCATION'; v_desc := 'Program Education'; v_category := 'INQUIRY';
    WHEN 4 THEN v_value := 'PRG ELIGIBILITY'; v_desc := 'Program Eligibility'; v_category := 'INQUIRY';
    WHEN 5 THEN v_value := 'ENROLL_STATUS'; v_desc := 'Enrollment Status'; v_category := 'INQUIRY';
    WHEN 6 THEN v_value := 'COVERED BENEFITS'; v_desc := 'Covered Benefits'; v_category := 'INQUIRY';
    WHEN 7 THEN v_value := 'PCP SEARCH'; v_desc := 'PCP Search'; v_category := 'INQUIRY';
    WHEN 8 THEN v_value := 'PROV VERIFY ENRL'; v_desc := 'Provider Verifying Enrollment'; v_category := 'INQUIRY';
    WHEN 9 THEN v_value := 'REF TO CASEWORKER'; v_desc := 'Referred to Caseworker'; v_category := 'REFERRAL';
    WHEN 10 THEN v_value := 'REF TO IHC'; v_desc := 'Referred to IHC'; v_category := 'REFERRAL';
    WHEN 11 THEN v_value := 'REF TO HEALTH PLAN'; v_desc := 'Referred to Health Plan'; v_category := 'REFERRAL';
    WHEN 12 THEN v_value := 'SPEC SEARCH'; v_desc := 'Specialist Search'; v_category := 'INQUIRY';
    WHEN 13 THEN v_value := 'OTHER'; v_desc := 'Other'; v_category := 'INQUIRY';
    WHEN 14 THEN v_value := 'AUTH REP'; v_desc := 'Auth Rep/ Legal Documentation Pending'; v_category := 'NO ENROLLMENT DONE';
    WHEN 15 THEN v_value := 'CLIENT WILL CALLBACK'; v_desc := 'Client Will Call Back'; v_category := 'NO ENROLLMENT DONE';
    WHEN 16 THEN v_value := 'COUNTY DISPUTE'; v_desc := 'County Dispute'; v_category := 'SUPERVISOR ISSUE';
    WHEN 17 THEN v_value := 'ENROLL FORMS INCOMPLETE'; v_desc := 'Enrollment Form Incomplete - Callback Required'; v_category := 'NO ENROLLMENT DONE';
    WHEN 18 THEN v_value := 'HOC DOES NOT WANT MAIL'; v_desc := 'HOC Does Not Want to Receive Mailings'; v_category := 'SUPERVISOR ISSUE';
    WHEN 19 THEN v_value := 'HOC ISSUE'; v_desc := 'HOC Issue'; v_category := 'SUPERVISOR ISSUE';
    WHEN 20 THEN v_value := 'PCP NOT FOUND'; v_desc := 'PCP Not Found'; v_category := 'NO ENROLLMENT DONE';
    WHEN 21 THEN v_value := 'ICP_CLIENT_DISENROLL'; v_desc := 'ICP Disenrollment Request, No Cause'; v_category := 'DISENROLL_REQUEST';
    WHEN 22 THEN v_value := 'PCCM_CLIENT_DISENROLL'; v_desc := 'PCCM Disenrollment Request, No Cause'; v_category := 'DISENROLL_REQUEST';
    WHEN 23 THEN v_value := 'PLAN_PCP_DIS_REQ'; v_desc := 'Plan/PCP Disenrollment Request'; v_category := 'PLAN_PCP_DIS_REQ';
    WHEN 24 THEN v_value := 'WEBSITE'; v_desc := 'Website Questions'; v_category := 'INQUIRY';
    WHEN 25 THEN v_value := 'CALL_BACK'; v_desc := 'Call Back'; v_category := 'CALL_BACK';
    WHEN 26 THEN v_value := 'RECD_ESC_CALL'; v_desc := 'Received Escalated Call'; v_category := 'REC_ESCALATED_CALL';
    WHEN 27 THEN v_value := 'TRANSFER_CALL'; v_desc := 'Transferred Call'; v_category := 'TRANSFERRED_CALL';
    WHEN 28 THEN v_value := 'PLAN_SEARCH'; v_desc := 'Plan Search'; v_category := 'INQUIRY';
    WHEN 29 THEN v_value := 'FAX_TO_CALLER'; v_desc := 'Faxed Information to Caller'; v_category := 'FAX_TO_CALLER';
    ELSE v_value := NULL;
    END CASE;
    --
    UPDATE corp_etl_list_lkup
       SET ref_type = v_category, out_var = v_desc
     WHERE name = c_name AND value = v_value;
    --
    IF SQL%ROWCOUNT = 0
    THEN INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
         VALUES (c_name, c_type, v_value, v_desc, v_category, c_beg, c_end, c_comment, SYSDATE, SYSDATE);
    END IF;
  END LOOP;
  COMMIT;
END;
/