use role MAXEB_DP4BI_PAIEB_DEV_ADMIN;
use warehouse MAXEB_DP4BI_PAIEB_DEV_LOAD_WH;
use database MAXEB_DP4BI_PAIEB_DEV;

## APP_STATUS_HISTORY ##

create table paieb_dev.app_status_history ( APP_STATUS_HISTORY_ID number (18) not null, 
                                application_id number (18),
                                status_cd varchar(32),
                                 status_dt date );
                                 
ALTER TABLE "ATS"."APP_STATUS_HISTORY" ADD CONSTRAINT "XPKAPP_STATUS_HISTORY_ID" PRIMARY KEY ("APP_STATUS_HISTORY_ID")
                                 
## APP_MISSING_INFO ##

CREATE TABLE "PAIEB_DEV"."APP_HEADER"

   (    "APPLICATION_ID" NUMBER(18,0),
        "RECEIPT_DATE" TIMESTAMP_NTZ,
        "STATUS_DATE" TIMESTAMP_NTZ,
        "RENEWAL_DUE_DATE" TIMESTAMP_NTZ,
        "CREATE_TS" TIMESTAMP_NTZ,
        "CREATED_BY" VARCHAR2(50),
        "UPDATE_TS" TIMESTAMP_NTZ,
        "UPDATED_BY" VARCHAR2(50),
        "APP_MEDIA_CD" VARCHAR2(32),
        "CALL_RECORD_ID" NUMBER(18,0),
        "APP_FORM_CD" VARCHAR2(32),
        "APP_FORM_VERSION" VARCHAR2(32),
        "EXPEDITED_IND" NUMBER(1,0),
        "PRIORITY" NUMBER(2,0),
        "VERSION_ID" NUMBER(18,0),
        "PENDING_CONFIRMATION_IND" NUMBER(1,0),
        "DOCUMENT_ID" NUMBER(18,0),
        "STATUS_CD" VARCHAR2(32),
        "MI_IND" NUMBER(1,0),
        "NOTE_REF_ID" NUMBER(18,0),
        "REF_TYPE_1" VARCHAR2(80),
        "REF_VALUE_1" VARCHAR2(80),
        "REF_TYPE_2" VARCHAR2(80),
        "REF_VALUE_2" VARCHAR2(80),
        "FIRST_MI_ADDED_DATE" TIMESTAMP_NTZ,
        "OVERALL_MI_IND" NUMBER(1,0),
        "REACTIVATION_IND" NUMBER(1,0),
        "REACTIVATION_TS" TIMESTAMP_NTZ,
        "REACTIVATION_REASON_CD" VARCHAR2(32),
        "REACTIVATED_BY" VARCHAR2(50),
        "PRIMARY_PROGRAM_TYPE_CD" VARCHAR2(32)
   ) ;

ALTER TABLE "PAIEB_DEV"."APP_HEADER" ADD CONSTRAINT "XPKAPP_HEADER" PRIMARY KEY ("APPLICATION_ID");


## APP_HEADER ##

CREATE TABLE "PAIEB_DEV"."APP_MISSING_INFO"
   (    "MISSING_INFO_ID" NUMBER(18,0),
        "APPLICATION_ID" NUMBER(18,0),
        "APP_INDIVIDUAL_ID" NUMBER(18,0),
        "REPORTED_DATE" TIMESTAMP_NTZ,
        "NOTIFICATION_DATE" TIMESTAMP_NTZ,
        "SATISFIED_DATE" TIMESTAMP_NTZ,
        "CALL_RECORD_ID" NUMBER(18,0),
        "CREATE_TS" TIMESTAMP_NTZ,
        "CREATED_BY" VARCHAR2(50),
        "UPDATE_TS" TIMESTAMP_NTZ,
        "UPDATED_BY" VARCHAR2(50),
        "MI_SOURCE_CD" VARCHAR2(32),
        "SATISFIED_MEDIA_CD" VARCHAR2(32),
        "MI_TYPE_CD" VARCHAR2(32),
        "NOTE_REF_ID" NUMBER(18,0),
        "ENTITY_NAME" VARCHAR2(50),
        "CLIENT_ID" NUMBER(18,0),
        "SATISFIED_REASON_CD" VARCHAR2(32),
        "STATUS_CD" VARCHAR2(32),
        "SATISFIED_BY" VARCHAR2(50),
        "VOIDED_BY" VARCHAR2(50),
        "VOIDED_DATE" TIMESTAMP_NTZ,
        "EXT_REF_ID" VARCHAR2(256),
        "DUE_DATE" TIMESTAMP_NTZ
   ) ;

ALTER TABLE "PAIEB_DEV"."APP_MISSING_INFO" ADD CONSTRAINT "XPKAPP_MISSING_INFO" PRIMARY KEY ("MISSING_INFO_ID");


## APP_CASE_LINK ##

CREATE TABLE "PAIEB_DEV"."APP_CASE_LINK"
   (    "APP_CASE_LINK_ID" NUMBER(18,0),
        "APPLICATION_ID" NUMBER(18,0),
        "CASE_ID" NUMBER(18,0),
        "CREATE_TS" TIMESTAMP_NTZ,
        "CREATED_BY" VARCHAR2(50),
        "CASE_CIN" VARCHAR2(30),
        "UPDATE_TS" TIMESTAMP_NTZ,
        "UPDATED_BY" VARCHAR2(50)
   ) ;

ALTER TABLE "PAIEB_DEV"."APP_CASE_LINK" ADD CONSTRAINT "XPKAPP_CASE_LINK" PRIMARY KEY ("APP_CASE_LINK_ID");


## ADDRESS ##


CREATE TABLE "PAIEB_DEV"."ADDRESS"

   (    "ADDR_ID" NUMBER(18,0),
        "ADDR_STREET_1" VARCHAR2(55),
        "ADDR_STREET_2" VARCHAR2(55),
        "ADDR_CITY" VARCHAR2(30),
        "ADDR_STATE_CD" VARCHAR2(20),
        "ADDR_ZIP" VARCHAR2(32),
        "ADDR_ZIP_FOUR" VARCHAR2(4),
        "ADDR_TYPE_CD" VARCHAR2(32),
        "ADDR_BEGIN_DATE" TIMESTAMP_NTZ,
        "ADDR_END_DATE" TIMESTAMP_NTZ,
        "ADDR_COUNTRY" VARCHAR2(20) DEFAULT NULL,
        "CLNT_CLIENT_ID" NUMBER(18,0),
        "ADDR_ATTN" VARCHAR2(55),
        "ADDR_HOUSE_CODE" VARCHAR2(10),
        "ADDR_BAR_CODE" VARCHAR2(50),
        "ADDR_ORIGIN_CD" VARCHAR2(2),
        "ADDR_STAFF_ID" NUMBER(38,0),
        "ADDR_CTLK_ID" VARCHAR2(32),
        "ADDR_DOLK_ID" VARCHAR2(32),
        "ADDR_PROV_ID" NUMBER(38,0),
        "ADDR_PAYC_ID" NUMBER(38,0),
        "ADDR_VERIFIED" VARCHAR2(1) DEFAULT 'N',
        "ADDR_VERIFIED_DATE" TIMESTAMP_NTZ,
        "ADVY_ID" NUMBER(38,0),
        "ADDR_BAD_DATE" TIMESTAMP_NTZ,
        "ADDR_BAD_DATE_SATISFIED" TIMESTAMP_NTZ,
        "CREATED_BY" VARCHAR2(30),
        "CREATION_DATE" TIMESTAMP_NTZ,
        "LAST_UPDATED_BY" VARCHAR2(30),
        "LAST_UPDATE_DATE" TIMESTAMP_NTZ,
        "ADDR_CASE_ID" NUMBER(18,0),
        "START_NDT" NUMBER(18,0),
        "END_NDT" NUMBER(18,0),
        "COMPARABLE_KEY" VARCHAR2(2000)
   ) ;

ALTER TABLE "PAIEB_DEV"."ADDRESS" ADD CONSTRAINT "PK_ADDRESS" PRIMARY KEY ("ADDR_ID") ;


### CLIENT ###

CREATE TABLE "PAIEB_DEV"."CLIENT"
   (    "CLNT_CLIENT_ID" NUMBER(18,0),
        "CLNT_CLNT_CLIENT_ID" NUMBER(18,0),
        "CLNT_FNAME" VARCHAR2(25),
        "FIRST_NAME_CANON" VARCHAR2(25),
        "FIRST_NAME_SOUNDLIKE" VARCHAR2(64),
        "CLNT_LNAME" VARCHAR2(40),
        "LAST_NAME_CANON" VARCHAR2(40),
        "LAST_NAME_SOUNDLIKE" VARCHAR2(64),
        "CLNT_MI" VARCHAR2(25),
        "CLNT_GENDER_CD" VARCHAR2(32),
        "CLNT_CITIZEN" VARCHAR2(32),
        "CLNT_ETHNICITY" VARCHAR2(32),
        "CLNT_RACE" VARCHAR2(32),
        "CLNT_DOB" TIMESTAMP_NTZ,
        "CLNT_DOD" TIMESTAMP_NTZ,
        "CLNT_TPL_PRESENT" VARCHAR2(1),
        "CLNT_SSN" VARCHAR2(30),
        "CLNT_NATIONAL_ID" VARCHAR2(15),
        "CLNT_FROM_PACMIS" VARCHAR2(1),
        "CLNT_SHARE_PREMIUM" VARCHAR2(1),
        "CLNT_NOT_BORN" VARCHAR2(1),
        "CLNT_HIPAA_PRIVACY_IND" VARCHAR2(1),
        "CLNT_FINET_VENDOR_NBR" VARCHAR2(10),
        "CLNT_ENROLL_STATUS" VARCHAR2(32),
        "CLNT_ENROLL_STATUS_DATE" TIMESTAMP_NTZ,
        "SCHED_AUTO_ASSIGN_DATE" TIMESTAMP_NTZ,
        "CLNT_CIN" VARCHAR2(30),
        "CLNT_COMMENT" VARCHAR2(4000),
        "CREATED_BY" VARCHAR2(80),
        "CREATION_DATE" TIMESTAMP_NTZ,
        "LAST_UPDATED_BY" VARCHAR2(80),
        "LAST_UPDATE_DATE" TIMESTAMP_NTZ,
        "CLNT_PSEUDO_ID" VARCHAR2(10),
        "CLNT_DISPLAY_NAME" VARCHAR2(80),
        "SSNVL_ID" NUMBER(38,0),
        "NOTE_REF_ID" NUMBER(18,0),
        "CLNT_MARITAL_CD" VARCHAR2(32),
        "CLNT_STATUS_CD" VARCHAR2(32),
        "CLNT_EXPECTED_DOB" TIMESTAMP_NTZ,
        "CLNT_PREG_TERM_DATE" TIMESTAMP_NTZ,
        "CLNT_PREG_TERM_REAS_CD" VARCHAR2(32),
        "CLIENT_TYPE_CD" VARCHAR2(10) DEFAULT 'G',
        "SUPPLEMENTAL_NBR" VARCHAR2(32),
        "CLIENT_LANGUAGE" VARCHAR2(32),
        "STATE_LANGUAGE" VARCHAR2(32),
        "DO_NOT_CALL_IND" NUMBER(1,0),
        "WRITTEN_LANGUAGE" VARCHAR2(32),
        "SUFFIX" VARCHAR2(32),
        "SALUTATION_CD" VARCHAR2(32),
        "DOMESTIC_VIOLENCE_IND" NUMBER(1,0),
        "ENGLISH_FLUENCY_CD" VARCHAR2(32),
        "ENGLISH_LITERACY_CD" VARCHAR2(32),
        "TRIBE_CD" VARCHAR2(32),
        "CLNT_GENERIC_FIELD1_DATE" TIMESTAMP_NTZ,
        "CLNT_GENERIC_FIELD2_DATE" TIMESTAMP_NTZ,
        "CLNT_GENERIC_FIELD3_NUM" NUMBER(18,0),
        "CLNT_GENERIC_FIELD4_NUM" NUMBER(18,0),
        "CLNT_GENERIC_FIELD5_TXT" VARCHAR2(256),
        "CLNT_GENERIC_FIELD6_TXT" VARCHAR2(256),
        "CLNT_GENERIC_FIELD7_TXT" VARCHAR2(256),
        "CLNT_GENERIC_FIELD8_TXT" VARCHAR2(256),
        "CLNT_GENERIC_FIELD9_TXT" VARCHAR2(256),
        "CLNT_GENERIC_FIELD10_TXT" VARCHAR2(256),
        "CLNT_GENERIC_REF11_ID" NUMBER(18,0),
        "CLNT_GENERIC_REF12_ID" NUMBER(18,0),
        "DOD_SOURCE_CD" VARCHAR2(32),
        "DO_NOT_TEXT_IND" NUMBER(1,0),
        "DO_NOT_EMAIL_IND" NUMBER(1,0),
        "LAST_STATE_UPDATE_TS" TIMESTAMP_NTZ,
        "LAST_STATE_UPDATED_BY" NUMBER(18,0),
        "COMPARABLE_KEY" VARCHAR2(2000)
   ) ;

ALTER TABLE "PAIEB_DEV"."CLIENT" ADD CONSTRAINT "PK_CLIENT" PRIMARY KEY ("CLNT_CLIENT_ID");


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE TABLE "PAIEB_DEV"."APP_DOC_DATA"
   (	
    "APP_DOC_DATA_ID" NUMBER(18,0),
	"RECEIVED_DATE" TIMESTAMP_NTZ,
	"ECN" VARCHAR2(32),
	"DCN" VARCHAR2(32),
	"DOCUMENT_TYPE_CD" VARCHAR2(32),
	"VERSION_ID" NUMBER(18,0),
	"APPLICATION_ID" NUMBER(18,0),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATE_TS" TIMESTAMP_NTZ,
	"CURRENT_TASK_QUEUE" VARCHAR2(32),
	"PRIORITY" NUMBER(2,0),
	"BARCODE_DATA" VARCHAR2(64),
	"DOCUMENT_SET_ID" NUMBER(18,0),
	"DOCUMENT_ID" NUMBER(18,0),
	"STATUS_CD" VARCHAR2(32),
	"STATUS_TS" TIMESTAMP_NTZ,
	"MEDIA_CD" VARCHAR2(32),
	"LETTER_REQUEST_ID" NUMBER(18,0),
	"DOCUMENT_SUB_TYPE" VARCHAR2(32),
	"CREATED_BY" VARCHAR2(50),
	"UPDATED_BY" VARCHAR2(50),
	"RENEWAL_IND" NUMBER(1,0),
	"PRIMARY_APP_IND" NUMBER(1,0),
	"HOW_HEARD_CD" VARCHAR2(32),
	"HOW_HEARD_OTHER" VARCHAR2(32),
	"EXT_APPLICATION_ID" VARCHAR2(32),
	"EXT_PROCESSED_IND" NUMBER(1,0)
   )   ;
ALTER TABLE "PAIEB_DEV"."APP_DOC_DATA" ADD CONSTRAINT "XPKAPP_DOC_DATA" PRIMARY KEY ("APP_DOC_DATA_ID");  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."APP_ELIG_OUTCOME"
   (	
    "APP_ELIG_OUTCOME_ID" NUMBER(18,0),
	"APPLICATION_ID" NUMBER(18,0),
	"APP_INDIVIDUAL_ID" NUMBER(18,0),
	"ELIG_OUTCOME_CD" VARCHAR2(32),
	"ELIG_OUTCOME_REASON_CD" VARCHAR2(32),
	"PROGRAM_CD" VARCHAR2(32),
	"CREATE_TS" TIMESTAMP_NTZ,
	"CREATED_BY" VARCHAR2(50),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(50),
	"PROGRAM_SUBTYPE_CD" VARCHAR2(32)
   ) ;
ALTER TABLE "PAIEB_DEV"."APP_ELIG_OUTCOME" ADD CONSTRAINT "XPKAPP_ELIG_OUTCOME" PRIMARY KEY ("APP_ELIG_OUTCOME_ID");  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."APP_HEADER_EXT"
   (	
    "APP_HEADER_EXT_ID" NUMBER(18,0),
	"APPLICATION_ID" NUMBER(18,0),
	"APPLICANT_MED_ASSISTANCE_IND" NUMBER(1,0),
	"APPLICANT_RECEIVE_WAIVER_IND" NUMBER(1,0),
	"WAIVER_CD" VARCHAR2(32),
	"OTH_WAIVER_CD" VARCHAR2(80),
	"WAIVER_END_DATE" TIMESTAMP_NTZ,
	"ACT150_ELIG_IND" NUMBER(1,0),
	"ENROLL_DELAYED_IND" NUMBER(1,0),
	"MFP_CD" VARCHAR2(32),
	"POTENTIAL_DISCHARGE_DATE" TIMESTAMP_NTZ,
	"COMMUNITY_ADDRESS" VARCHAR2(80),
	"ACTUAL_DISCHARGE_DATE" TIMESTAMP_NTZ,
	"CMI_ASSESSMENT_SCHEDULE_DATE" TIMESTAMP_NTZ,
	"CMI_ASSESSMENT_COMPLETE_DATE" TIMESTAMP_NTZ,
	"CMI_WAIVER_CHOICE" VARCHAR2(32),
	"CMI_SC_AGENCY_1" NUMBER(18,0),
	"CMI_SC_AGENCY_2" NUMBER(18,0),
	"CMI_SC_AGENCY_3" NUMBER(18,0),
	"CMI_NH_TRAN_COORDINATOR_1" NUMBER(18,0),
	"CMI_NH_TRAN_COORDINATOR_2" NUMBER(18,0),
	"CMI_NH_TRAN_COORDINATOR_3" NUMBER(18,0),
	"PHY_LEVEL_CARE" VARCHAR2(32),
	"PHY_LEN_CARE" VARCHAR2(32),
	"PHY_SIGN_DATE" TIMESTAMP_NTZ,
	"PHY_COMPLETE_ICD10_IND" NUMBER(1,0),
	"PHY_COMPLETE_DIAGNOSIS_IND" NUMBER(1,0),
	"PHY_CERT_STATUS" VARCHAR2(80),
	"LCD_LEVEL_CARE" VARCHAR2(32),
	"LCD_SUPERVISOR_SIGN_DATE" TIMESTAMP_NTZ,
	"LCD_STATUS" VARCHAR2(80),
	"CLOSE_APP_REASON_CD" VARCHAR2(32),
	"CLOSE_APP_TS" TIMESTAMP_NTZ,
	"CLOSE_APP_IND" NUMBER(1,0),
	"CREATED_BY" VARCHAR2(80),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(80),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"PLAN_DATA_ENTRY" NUMBER(1,0),
	"APPROVAL_DATE" TIMESTAMP_NTZ,
	"LIFE_PLAN_CD" VARCHAR2(32),
	"REASON_DELAY_CD" VARCHAR2(32),
	"APP_START_DATE" TIMESTAMP_NTZ,
	"LCD_LEN_CARE" VARCHAR2(32),
	"ENROLL_DELAYED_REASON_CD" VARCHAR2(32),
	"DATE_OF_DEATH" TIMESTAMP_NTZ,
	"APPROVAL_DENIAL_1768_COMMENT" VARBINARY,   --This was a CLOB before
	"OPTIONS" NUMBER(1,0),
	"PERMISSION_TO_SHARE_IND" NUMBER(1,0),
	"CMI_MANAGE_DIRECT" NUMBER(1,0),
	"CHC_ZONE_IND" NUMBER(1,0),
	"MD_REVIEW_IND" NUMBER(1,0),
	"FIN_ELIG_STATUS_CD" VARCHAR2(32),
	"FIN_ELIG_WAIVER_CD" VARCHAR2(32),
	"FIN_ELIG_DENIAL_RSN_CD" VARCHAR2(32),
	"FIN_ELIG_EFFECTIVE_START_DATE" TIMESTAMP_NTZ,
	"FIN_ELIG_APPROVAL_DATE" TIMESTAMP_NTZ,
	"FIN_ELIG_DENIAL_DATE" TIMESTAMP_NTZ,
	"FIN_ELIG_NOTES" VARCHAR2(4000),
	"PART1_1768_COMMENTS" VARBINARY,   --This was a CLOB before
	"CREATE_FED_COMMENT" VARCHAR2(4000),
	"FED_OVERDUE_REASON_CODE" VARCHAR2(4000),
	"LAST_IVA_CONTACT_DATE" TIMESTAMP_NTZ,
	"FIRST_CONTACT_DATE" TIMESTAMP_NTZ,
	"SEND_1768_IND" NUMBER(1,0),
	"LEGACY_IND" NUMBER(1,0),
	"MD_DETERMINATION" VARCHAR2(32),
	"REASON_DELAYED_SCHEDULE" VARCHAR2(32)
   ) ;
ALTER TABLE "PAIEB_DEV"."APP_HEADER_EXT" ADD CONSTRAINT "XPKAPP_HEADER_EXT_ID" PRIMARY KEY ("APP_HEADER_EXT_ID");
ALTER TABLE "PAIEB_DEV"."APP_HEADER_EXT" ADD CONSTRAINT "UCAPP_EXT_APP_ID" UNIQUE ("APPLICATION_ID");  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."APP_INDIVIDUAL"
   (	
    "APP_INDIVIDUAL_ID" NUMBER(18,0),
	"CLIENT_CIN" VARCHAR2(32),
	"APPLICANT_IND" NUMBER(1,0),
	"HOH_IND" NUMBER(1,0),
	"APPLICATION_ID" NUMBER(18,0),
	"CREATE_TS" TIMESTAMP_NTZ,
	"CREATED_BY" VARCHAR2(50),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(50),
	"CLIENT_ID" NUMBER(18,0),
	"CUT_OFF_DATE" TIMESTAMP_NTZ,
	"LOAD_CONFLICT_IND" NUMBER(1,0),
	"MI_IND" NUMBER(1,0),
	"ROLE_CD" VARCHAR2(32),
	"REMOVED_FROM_APP_IND" NUMBER(1,0),
	"SUFFIX" VARCHAR2(32),
	"REF_TYPE_1" VARCHAR2(80),
	"REF_VALUE_1" VARCHAR2(80),
	"REF_TYPE_2" VARCHAR2(80),
	"REF_VALUE_2" VARCHAR2(80),
	"REF_TYPE_3" VARCHAR2(80),
	"REF_VALUE_3" VARCHAR2(80)
   ) ;
ALTER TABLE "PAIEB_DEV"."APP_INDIVIDUAL" ADD CONSTRAINT "XPKAPP_INDIVIDUAL" PRIMARY KEY ("APP_INDIVIDUAL_ID"); 

 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."DOC_FLEX_FIELD"
   (	
    "DOCUMENT_SET_ID" NUMBER(18,0),
	"DOCUMENT_ID" NUMBER(18,0),
	"GROUP_TYPE" VARCHAR2(256),
	"GROUP_ID" VARCHAR2(256),
	"NAME" VARCHAR2(256),
	"VALUE" VARCHAR2(256),
	"TYPE" VARCHAR2(256),
	"CREATED_BY" VARCHAR2(80),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(80),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"DOC_FLEX_FIELD_ID" NUMBER(18,0)
   ) ;
ALTER TABLE "PAIEB_DEV"."DOC_FLEX_FIELD" ADD CONSTRAINT "DOC_FLEX_FIELD_PK" PRIMARY KEY ("DOC_FLEX_FIELD_ID");
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."DOC_LINK"
   (	
    "DOC_LINK_ID" NUMBER(18,0),
	"DOCUMENT_ID" NUMBER(18,0),
	"LINK_TYPE_CD" VARCHAR2(32),
	"AUTO_LINKED_IND" NUMBER(1,0),
	"CREATED_BY" VARCHAR2(80),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(80),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"CASE_ID" NUMBER(18,0),
	"CLIENT_ID" NUMBER(18,0),
	"LINK_REF_ID" NUMBER(18,0)
   ) ;
ALTER TABLE "PAIEB_DEV"."DOC_LINK" ADD CONSTRAINT "DOC_LINK_PK" PRIMARY KEY ("DOC_LINK_ID");
ALTER TABLE "PAIEB_DEV"."DOC_LINK" ADD CONSTRAINT "DOC_LINK_UNIQUE_ID" UNIQUE ("DOCUMENT_ID", "LINK_TYPE_CD", "CASE_ID", "CLIENT_ID", "LINK_REF_ID");
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."DOCUMENT"
   (	
    "DOCUMENT_ID" NUMBER(18,0),
	"DCN" VARCHAR2(256),
	"DOC_TYPE_CD" VARCHAR2(32),
	"DOC_STATUS_CD" VARCHAR2(32),
	"DOCUMENT_SET_ID" NUMBER(18,0),
	"LETTER_REQUEST_ID" NUMBER(18,0),
	"SCAN_DATE" TIMESTAMP_NTZ,
	"RELEASE_DATE" TIMESTAMP_NTZ,
	"LANGUAGE_CD" VARCHAR2(32),
	"PAGE_COUNT" NUMBER(18,0),
	"IMAGE_ONLY_IND" NUMBER(1,0),
	"BATCH_UPLOAD_IND" NUMBER(1,0),
	"RESCAN_IND" NUMBER(1,0),
	"RETURN_MAIL_IND" NUMBER(1,0),
	"RETURN_MAIL_REASON_CD" VARCHAR2(32),
	"XML_META_DATA" VARCHAR2(4000),
	"RESCAN_COUNT" NUMBER(18,0),
	"CREATED_BY" VARCHAR2(80),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(80),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"NOTE_REF_ID" VARCHAR2(32),
	"TRASHED_DOC_IND" NUMBER(1,0),
	"EXPEDITED_IND" NUMBER(1,0),
	"RESEARCH_REQUESTED_IND" NUMBER(1,0),
	"DOC_FORM_TYPE" VARCHAR2(70),
	"ORIG_DOC_TYPE_CD" VARCHAR2(32),
	"ORIG_DOC_FORM_TYPE" VARCHAR2(32),
	"LAST_TRASHED_BY" VARCHAR2(80),
	"LAST_TRASHED_TS" TIMESTAMP_NTZ,
	"ACCESS_PERMISSION" VARCHAR2(512)
   ) ;
ALTER TABLE "PAIEB_DEV"."DOCUMENT" ADD CONSTRAINT "DOCUMENT_PK" PRIMARY KEY ("DOCUMENT_ID");  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."DOCUMENT_SET"
   (	
    "DOCUMENT_SET_ID" NUMBER(18,0),
	"ECN" VARCHAR2(256),
	"DOCUMENT_COUNT" NUMBER(18,0),
	"DOC_SOURCE_CD" VARCHAR2(32),
	"OPERATOR_ID" VARCHAR2(32),
	"RECEIVED_DATE" TIMESTAMP_NTZ,
	"CREATED_BY" VARCHAR2(80),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(80),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"LANGUAGE_CD" VARCHAR2(32),
	"SCAN_STATION" VARCHAR2(32),
	"XML_META_DATA" VARBINARY  --This was a CLOB before
   ) ;
ALTER TABLE "PAIEB_DEV"."DOCUMENT_SET" ADD CONSTRAINT "DOCUMENT_SET_PK" PRIMARY KEY ("DOCUMENT_SET_ID");
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."LETTER_REQUEST"
   (	
    "LMREQ_ID" NUMBER(18,0),
	"REQUESTED_ON" TIMESTAMP_NTZ,
	"REQUEST_TYPE" VARCHAR2(2),
	"PRODUCED_BY" VARCHAR2(2),
	"LANGUAGE_CD" VARCHAR2(32),
	"DRIVER_TYPE" VARCHAR2(4),
	"STATUS_CD" VARCHAR2(32),
	"REP_LMREQ_ID" NUMBER(18,0),
	"SENT_ON" TIMESTAMP_NTZ,
	"CREATED_BY" VARCHAR2(80),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(80),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"PRINTED_ON" TIMESTAMP_NTZ,
	"STAFF_ID_PRINTED_BY" NUMBER(18,0),
	"NOTE_REFID" NUMBER(18,0),
	"RETURN_DATE" TIMESTAMP_NTZ,
	"RETURN_REASON_CD" VARCHAR2(32),
	"LMDEF_ID" NUMBER(18,0),
	"PARENT_LMREQ_ID" NUMBER(18,0),
	"REPRINT_PARENT_LMREQ_ID" NUMBER(18,0),
	"LMACT_CD" VARCHAR2(32),
	"LDIS_CD" VARCHAR2(32),
	"CASE_ID" NUMBER(18,0),
	"AUTHORIZED_LMREQ_ID" NUMBER(18,0),
	"ERROR_CODES" VARCHAR2(4000),
	"NMBR_REQUESTED" NUMBER(18,0),
	"PROGRAM_TYPE_CD" VARCHAR2(32),
	"MATERIAL_REQUEST_ID" NUMBER(18,0),
	"MAILING_ADDRESS_ID" NUMBER(18,0),
	"RESPONSE_DUE_DATE" TIMESTAMP_NTZ,
	"MAILED_DATE" TIMESTAMP_NTZ,
	"REJECT_REASON_CD" VARCHAR2(32),
	"STATUS_ERR_SRC" VARCHAR2(32),
	"LETTER_OUT_GENERATION_NUM" NUMBER(*,0)
   ) ;
ALTER TABLE "PAIEB_DEV"."LETTER_REQUEST" ADD CONSTRAINT "LETTER_REQUESTS_PK" PRIMARY KEY ("LMREQ_ID");
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."LETTER_REQUEST_LINK"
   (	
    "LMLINK_ID" NUMBER(18,0),
	"REFERENCE_TYPE" VARCHAR2(40),
	"REFERENCE_ID" NUMBER(18,0),
	"CREATED_BY" VARCHAR2(80),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(80),
	"LMREQ_ID" NUMBER(18,0),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"ADDITIONAL_REFERENCE_TYPE" VARCHAR2(30),
	"ADDITIONAL_REFERENCE_ID" NUMBER(18,0),
	"CLIENT_ID" NUMBER(18,0),
	"CLIENT_ENROLL_STATUS_ID" NUMBER(18,0)
   ) ;
ALTER TABLE "PAIEB_DEV"."LETTER_REQUEST_LINK" ADD CONSTRAINT "LETTER_REQUEST_LINK_PK" PRIMARY KEY ("LMLINK_ID");
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE TABLE "PAIEB_DEV"."NOTIFICATION_REQUEST"
   (	
    "NOTIFICATION_REQUEST_ID" NUMBER(18,0),
	"NOTIFICATION_DEFINITION_ID" NUMBER(18,0),
	"STATUS_CD" VARCHAR2(32),
	"TYPE_CD" VARCHAR2(32),
	"CHANNEL_CD" VARCHAR2(32),
	"MESSAGE" VARCHAR2(4000),
	"DOC_LOCATOR" VARCHAR2(255),
	"REQUEST_DATE" TIMESTAMP_NTZ,
	"REQUEST_DATA" VARCHAR2(4000),
	"PROCESSED_DATE" TIMESTAMP_NTZ,
	"SENT_DATE" TIMESTAMP_NTZ,
	"DELIVERED_DATE" TIMESTAMP_NTZ,
	"RETURN_DATE" TIMESTAMP_NTZ,
	"ACCESSED_DATE" TIMESTAMP_NTZ,
	"DUE_DATE" TIMESTAMP_NTZ,
	"ERROR_MSG" VARCHAR2(4000),
	"DELIVERY_CONFIMATION" VARCHAR2(4000),
	"RETURN_REASON_CD" VARCHAR2(32),
	"DOC_CONTENT_TYPE" VARCHAR2(1000),
	"REF_TYPE1" VARCHAR2(100),
	"REF_TYPE2" VARCHAR2(100),
	"REF_TYPE3" VARCHAR2(100),
	"REF_TYPE4" VARCHAR2(100),
	"REF_TYPE5" VARCHAR2(100),
	"REF_TYPE6" VARCHAR2(100),
	"REF_TYPE1_VALUE" VARCHAR2(20),
	"REF_TYPE2_VALUE" VARCHAR2(20),
	"REF_TYPE3_VALUE" VARCHAR2(20),
	"REF_TYPE4_VALUE" VARCHAR2(20),
	"REF_TYPE5_VALUE" VARCHAR2(20),
	"REF_TYPE6_VALUE" VARCHAR2(20),
	"CREATED_BY" VARCHAR2(20),
	"CREATE_TS" TIMESTAMP_NTZ,
	"UPDATED_BY" VARCHAR2(20),
	"UPDATE_TS" TIMESTAMP_NTZ,
	"BATCH_ID" NUMBER(18,0),
	"LANGUAGE_CD" VARCHAR2(32)
   ) ;
ALTER TABLE "PAIEB_DEV"."NOTIFICATION_REQUEST" ADD CONSTRAINT "XPKNOTIFICATION_REQUEST" PRIMARY KEY ("NOTIFICATION_REQUEST_ID");
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  CREATE TABLE "PAIEB_DEV"."STEP_INSTANCE"
   (	
    "STEP_INSTANCE_ID" NUMBER(18,0),
	"STATUS" VARCHAR2(32),
	"CREATE_TS" TIMESTAMP_NTZ,
	"COMPLETED_TS" TIMESTAMP_NTZ,
	"ESCALATED_IND" NUMBER(1,0),
	"STEP_DUE_TS" TIMESTAMP_NTZ,
	"FORWARDED_IND" NUMBER(1,0),
	"ESCALATE_TO" VARCHAR2(80),
	"FORWARDED_BY" VARCHAR2(80),
	"OWNER" VARCHAR2(80),
	--"INPUT_DATA" VARBINARY,  --This was a CLOB before
	--"OUTPUT_DATA" VARBINARY, --This was a CLOB before
	"LOCKED_ID" NUMBER(18,0),
	"GROUP_STEP_DEFINITION_ID" NUMBER(18,0),
	"GROUP_ID" NUMBER(18,0),
	"TEAM_ID" NUMBER(18,0),
	"PROCESS_ID" NUMBER(18,0),
	"PRIORITY_CD" VARCHAR2(32),
	"PROCESS_ROUTER_ID" NUMBER(18,0),
	"PROCESS_INSTANCE_ID" NUMBER(18,0),
	"CASE_ID" NUMBER(18,0),
	"CLIENT_ID" NUMBER(18,0),
	"REF_ID" NUMBER(18,0),
	"REF_TYPE" VARCHAR2(64),
	"STEP_DEFINITION_ID" NUMBER(18,0),
	"CREATED_BY" VARCHAR2(80),
	"SUSPENDED_TS" TIMESTAMP_NTZ,
	"COMMENTS" VARCHAR2(4000),
	"CREATE_NDT" NUMBER(18,0),
	"STEP_DUE_NDT" NUMBER(18,0)
   ) ;
   
ALTER TABLE "PAIEB_DEV"."STEP_INSTANCE" ADD CONSTRAINT "XPKSTEP_INSTANCE" PRIMARY KEY ("STEP_INSTANCE_ID");






