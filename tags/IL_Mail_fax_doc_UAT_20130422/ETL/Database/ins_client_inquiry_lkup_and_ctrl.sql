-- 4/8 Global controls
INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_CONTACT_DAYS','N','30','Client Inquiry''s Number of business days to look for call records.');

INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_LAST_CALL_ID','N','0','Client Inquiry''s last processed call record ID.');

INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_LAST_CECI_ID','N','0','Client Inquiry''s last processed BPM table CECI_ID.');

INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_LAST_EVENT_ID','N','0','Client Inquiry''s last processed OLTP call-related events.');



-- 4/4 Client Inquiry lookups

-- Call Types
INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_CONTACT_TYPE','LIST','INBOUND','Inbound','ENUM_CALL_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Contact/Call Types',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_CONTACT_TYPE','LIST','OUTBOUND','Outbound','ENUM_CALL_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Contact/Call Types',SYSDATE,SYSDATE);


-- Event/Call Action (EVENT_TYPE_CD)
INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','EXPIRE_AUTHORIZED_CONTACT','Expire Authorized Contact','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','UNEXPIRE_AUTHORIZED_CONTACT','UnExpire Authorized Contact','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','INVALIDATE_AUTHORIZED_CONTACT','Invalidate Authorized Contact','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','DOCUMENT_LINKED','Document Linked Successfully','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','LINK_TO_CALL','Link Client / Case to call record','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SURVEY_REFUSED','Survey Refused','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SURVEY_QUIT','Survey Quit','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SPOKEN_LANGUAGE_UPDATED','Spoken Language Updated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','WRITTEN_LANGUAGE_UPDATED','Written Language Updated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','LETTER_RESEND','Letter Request Resend','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','FORM_REQUESTED','A Form request was submitted','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','MANUAL_TASK_CREATED','Manual Task Created','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SURVEY_COMPLETED','Survey Completed','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','RECALC_ENROLL_STATUS','re-calculate the enrollment status','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','ELIG_STATUS_UPDATED','Enrollment Eligibility Status (M/V/X) is changed','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','CHANGE_CASE_PHONE','Change Case Phone Number','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','CHANGE_CASE_ADDRESS','Change Case Address','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','MANUAL_ACTION','Manual Action','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','COMPLAINT_INITIATED','Complaint Initiated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','OUTBOUND_CALL','Outbound Call Initiated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','INBOUND_CALL','Inbound Call Received','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','INCOMPLETE_INVALID_CHOICE','Incomplete/Invalid Choice','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','CHOICE_ENROLLMENT','Choice form Enrollment','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PHONE_ENROLLMENT','Phone Enrollment','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','ADDRESS_ADDED','Address Added','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PCCM_DISENROLL_REQ','PCCM Disenrollment Request','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','OPEN_ENROLLMENT_TRANSFER','Open Enrollment Transfer','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PHONE_NUMBER_ADDED','Phone Number Added','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','DISREGARDED_AA','Disregard AA','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PLAN_PCP_DISENROLL_REQ','Plan / Provider Disenrollment Request','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);



-- Manual Actions
INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','AUTHORIZED REP','Auth Rep/ Legal Documentation Pending','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','BILLING','Billing','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PRG EDUCATION','Program Education','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PRG ELIGIBILITY','Program Eligibility','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','ENROLL_STATUS','Enrollment Status','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','COVERED BENEFITS','Covered Benefits','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PCP SEARCH','PCP Search','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PROV VERIFY ENRL','Provider Verifying Enrollment','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','REF TO CASEWORKER','Referred to Caseworker','REFERRAL',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','REF TO IHC','Referred to IHC','REFERRAL',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','REF TO HEALTH PLAN','Referred to Health Plan','REFERRAL',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','SPEC SEARCH','Specialist Search','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','OTHER','Other','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','AUTH REP','Auth Rep/ Legal Documentation Pending','NO ENROLLMENT DONE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','CLIENT WILL CALLBACK','Client Will Call Back','NO ENROLLMENT DONE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','COUNTY DISPUTE','County Dispute','SUPERVISOR ISSUE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','ENROLL FORMS INCOMPLETE','Enrollment Form Incomplete - Callback Required','NO ENROLLMENT DONE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','HOC DOES NOT WANT MAIL','HOC Does Not Want to Receive Mailings','SUPERVISOR ISSUE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','HOC ISSUE','HOC Issue','SUPERVISOR ISSUE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PCP NOT FOUND','PCP Not Found','NO ENROLLMENT DONE',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','ICP_CLIENT_DISENROLL','ICP Disenrollment Request, No Cause','DISENROLL_REQUEST',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PCCM_CLIENT_DISENROLL','PCCM Disenrollment Request, No Cause','DISENROLL_REQUEST',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);


-- In PRD not in QA
INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PLAN_PCP_DIS_REQ','Plan/PCP Disenrollment Request','PLAN_PCP_DIS_REQ',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','WEBSITE','Website Questions','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','CALL_BACK','Call Back','CALL_BACK',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','RECD_ESC_CALL','Received Escalated Call','REC_ESCALATED_CALL',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','TRANSFER_CALL','Transferred Call','TRANSFERRED_CALL',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','PLAN_SEARCH','Plan Search','INQUIRY',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_MANUAL_ACTION','LIST','FAX_TO_CALLER','Faxed Information to Caller','FAX_TO_CALLER',TRUNC(SYSDATE,'MON'),'7-JUL-7777','Client Inquiry ETL - Manual Event Actions',SYSDATE,SYSDATE);




COMMIT;

--
