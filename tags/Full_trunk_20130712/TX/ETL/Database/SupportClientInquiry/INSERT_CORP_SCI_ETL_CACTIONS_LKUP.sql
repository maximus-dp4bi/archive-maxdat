-- Event/Call Action (EVENT_TYPE_CD)
INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','EXPIRE_AUTHORIZED_CONTACT','Expire Authorized Contact','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','UNEXPIRE_AUTHORIZED_CONTACT','UnExpire Authorized Contact','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','INVALIDATE_AUTHORIZED_CONTACT','Invalidate Authorized Contact','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','DOCUMENT_LINKED','Document Linked Successfully','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','LINK_TO_CALL','Link Client / Case to call record','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SURVEY_REFUSED','Survey Refused','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SURVEY_QUIT','Survey Quit','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SPOKEN_LANGUAGE_UPDATED','Spoken Language Updated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','WRITTEN_LANGUAGE_UPDATED','Written Language Updated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','LETTER_RESEND','Letter Request Resend','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','FORM_REQUESTED','A Form request was submitted','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','MANUAL_TASK_CREATED','Manual Task Created','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','SURVEY_COMPLETED','Survey Completed','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','RECALC_ENROLL_STATUS','re-calculate the enrollment status','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','ELIG_STATUS_UPDATED','Enrollment Eligibility Status (M/V/X) is changed','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','CHANGE_CASE_PHONE','Change Case Phone Number','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','CHANGE_CASE_ADDRESS','Change Case Address','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','MANUAL_ACTION','Manual Action','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','COMPLAINT_INITIATED','Complaint Initiated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','OUTBOUND_CALL','Outbound Call Initiated','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','INBOUND_CALL','Inbound Call Received','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','INCOMPLETE_INVALID_CHOICE','Incomplete/Invalid Choice','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','CHOICE_ENROLLMENT','Choice form Enrollment','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PHONE_ENROLLMENT','Phone Enrollment','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','ADDRESS_ADDED','Address Added','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PCCM_DISENROLL_REQ','PCCM Disenrollment Request','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','OPEN_ENROLLMENT_TRANSFER','Open Enrollment Transfer','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PHONE_NUMBER_ADDED','Phone Number Added','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','DISREGARDED_AA','Disregard AA','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

INSERT INTO corp_etl_list_lkup(NAME,list_type,VALUE,out_var,ref_type,start_date,end_date,comments,created_ts,updated_ts)
VALUES('CLIENT_INQUIRY_EVENT_ACTION','LIST','PLAN_PCP_DISENROLL_REQ','Plan / Provider Disenrollment Request','ENUM_BIZ_EVENT_TYPE',TRUNC(SYSDATE,'MON'),TO_DATE('7-JUL-7777','DD-MON-YYYY'),'Client Inquiry ETL - Event Actions for both systematic and manuals. Action points to EVENT_TYPE_CD',SYSDATE,SYSDATE);

COMMIT;