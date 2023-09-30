CREATE TABLE APP_MI_CATEGORY_LKUP
(
  VALUE VARCHAR2(32 BYTE) NOT NULL 
, DESCRIPTION VARCHAR2(256 BYTE) 
, REPORT_LABEL VARCHAR2(64 BYTE) 
, SCOPE VARCHAR2(128 BYTE) 
, CREATED_BY VARCHAR2(50 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(50 BYTE) 
, UPDATE_TS DATE 
, ORDER_BY_DEFAULT NUMBER(10, 0) 
, EFFECTIVE_START_DATE DATE 
, EFFECTIVE_END_DATE DATE 
, APP_MEMBER_LEVEL_IND NUMBER(1, 0) 
, PERMISSION VARCHAR2(256 BYTE) ) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX XPK_APP_MI_CATEGORY ON APP_MI_CATEGORY_LKUP (VALUE ASC) TABLESPACE MAXDAT_INDX;

COMMENT ON TABLE APP_MI_CATEGORY_LKUP IS 'code table to define the missing information categories. Example records include: Expenses, Income - Wages and Salary, Application, etc.';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.VALUE IS 'missing information category code';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.DESCRIPTION IS 'description of the code usage';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.REPORT_LABEL IS 'The default label for the corresponding code';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.SCOPE IS 'This is used to categorize values into subsets when needed. This is often needed when, for example, one needs to display a sub-type valuelist based on the type selected in a type valuelist. Multiple scopes may be comma delimited.';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.CREATED_BY IS 'Contains the staff id (or component) which originally created the record.';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.CREATE_TS IS 'record creation timestamp';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.UPDATED_BY IS 'Contains the staff id which most recently updated the record.';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.UPDATE_TS IS 'timestamp of when the record was last updated';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.ORDER_BY_DEFAULT IS 'order by value';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.EFFECTIVE_START_DATE IS 'Contains the date of when this code value became or will become active. Having the value empty implies the code is always active until the effective end date is set.';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.EFFECTIVE_END_DATE IS 'Contains the date of when this code value will become inactive. Having the value empty implies code will never become inactive in the future.';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.APP_MEMBER_LEVEL_IND IS 'indicates the category is always associated with an application member (i.e. applicant)';
COMMENT ON COLUMN APP_MI_CATEGORY_LKUP.PERMISSION IS 'This Mi type can  have a permission with it for greater control';

CREATE TABLE APP_MI_SATISFY_REASON_LKUP (
  VALUE VARCHAR2(32 BYTE) NOT NULL 
, DESCRIPTION VARCHAR2(256 BYTE) 
, REPORT_LABEL VARCHAR2(64 BYTE) 
, SCOPE VARCHAR2(128 BYTE) 
, CREATED_BY VARCHAR2(50 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(50 BYTE) 
, UPDATE_TS DATE 
, ORDER_BY_DEFAULT NUMBER(10, 0) 
, EFFECTIVE_START_DATE DATE 
, EFFECTIVE_END_DATE DATE 
, VOID_MI_IND NUMBER(1, 0) ) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX XPK_APP_MI_SATISFY_REASON ON APP_MI_SATISFY_REASON_LKUP (VALUE ASC) TABLESPACE MAXDAT_INDX;

COMMENT ON TABLE APP_MI_SATISFY_REASON_LKUP IS 'code table to define the missing information satisfaction reason codes. For example: member sent, state sent, phone, duplicate, error, other.';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.VALUE IS 'MI satisfied reason code';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.DESCRIPTION IS 'description of the code usage';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.REPORT_LABEL IS 'The default label for the corresponding code';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.SCOPE IS 'This is used to categorize values into subsets when needed. This is often needed when, for example, one needs to display a sub-type valuelist based on the type selected in a type valuelist. Multiple scopes may be comma delimited.';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.CREATED_BY IS 'Contains the staff id (or component) which originally created the record.';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.CREATE_TS IS 'record creation timestamp';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.UPDATED_BY IS 'Contains the staff id which most recently updated the record.';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.UPDATE_TS IS 'timestamp of when the record was last updated';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.ORDER_BY_DEFAULT IS 'order by value';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.EFFECTIVE_START_DATE IS 'Contains the date of when this code value became or will become active. Having the value empty implies the code is always active until the effective end date is set.';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.EFFECTIVE_END_DATE IS 'Contains the date of when this code value will become inactive. Having the value empty implies code will never become inactive in the future.';
COMMENT ON COLUMN APP_MI_SATISFY_REASON_LKUP.VOID_MI_IND IS 'indicates that the associated MI entry should be voided (i.e. ignored), if this satisfaction reason code is assigned to the MI.';

CREATE TABLE APP_MI_TYPE_LKUP
(
  VALUE VARCHAR2(32 BYTE) NOT NULL 
, DESCRIPTION VARCHAR2(256 BYTE) 
, REPORT_LABEL VARCHAR2(64 BYTE) 
, SCOPE VARCHAR2(128 BYTE) 
, CREATED_BY VARCHAR2(50 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(50 BYTE) 
, UPDATE_TS DATE 
, ORDER_BY_DEFAULT NUMBER(10, 0) 
, EFFECTIVE_START_DATE DATE 
, EFFECTIVE_END_DATE DATE 
, MI_CATEGORY VARCHAR2(32 BYTE) 
, ENABLE_ENTITY_NAME_IND NUMBER(1, 0) 
, ENTITY_NAME_LABEL_MSG_KEY VARCHAR2(64 BYTE) 
, ALLOW_MULTIPLE_OPEN_MI_IND NUMBER(1, 0) 
, SATISFIED_WITHOUT_TANGIBLE_IND NUMBER(1, 0) 
, PERMISSION VARCHAR2(256 BYTE) 
, SATISFY_PERMISSION VARCHAR2(256 BYTE) 
, DUE_DATE_DAYS NUMBER(18, 0) 
, UPDATE_DUE_DATE_PERMISSION VARCHAR2(256 BYTE) ) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX XPK_APP_MI_TYPE ON APP_MI_TYPE_LKUP (VALUE ASC) TABLESPACE MAXDAT_INDX;

COMMENT ON TABLE APP_MI_TYPE_LKUP IS 'Code table to define the missing information type codes, their categories, and labels. Example type code could be: E001, label: type of expense, category: expenses';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.VALUE IS 'missing information type code';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.MI_CATEGORY IS 'missing information category code';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.ENABLE_ENTITY_NAME_IND IS 'If indicator is set, then allow the entry of a name field for the MI entry. The name would be relevant based on the context of the MI entry.';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.ENTITY_NAME_LABEL_MSG_KEY IS 'Message key of the associated entity''s name field label';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.ALLOW_MULTIPLE_OPEN_MI_IND IS 'If indicator is set, it indicates that the system should allow multiple open MI entries with the same MI type and individual';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.SATISFIED_WITHOUT_TANGIBLE_IND IS 'This Mi type can  be satisfied without tangible evidence (e.g. word of mouth,  not required to see a physical document)';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.PERMISSION IS 'This Mi type can  have a permission with it for greater control';
COMMENT ON COLUMN APP_MI_TYPE_LKUP.SATISFY_PERMISSION IS 'This Mi type can  have a satisfy permission with it for greater control of who can satisfy this kind of MI';


CREATE TABLE CASE_MANUAL_ACTION_LKUP
(
  VALUE VARCHAR2(64 BYTE) NOT NULL 
, DESCRIPTION VARCHAR2(256 BYTE) 
, REPORT_LABEL VARCHAR2(64 BYTE) 
, SCOPE VARCHAR2(128 BYTE) 
, CREATED_BY VARCHAR2(80 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE 
, ORDER_BY_DEFAULT NUMBER(10, 0) 
, EFFECTIVE_START_DATE DATE 
, EFFECTIVE_END_DATE DATE 
, EVENT_TYPE_CD VARCHAR2(32 BYTE) 
, PERMISSION VARCHAR2(256 BYTE) 
, CLIENT_REQUIRED_IND NUMBER(1, 0) 
, PERMISSION1 VARCHAR2(256 BYTE) ) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX XPK_CASE_MANUAL_ACTION ON CASE_MANUAL_ACTION_LKUP (VALUE ASC) TABLESPACE MAXDAT_INDX;

COMMENT ON TABLE CASE_MANUAL_ACTION_LKUP IS 'enumertation table for case manual actions / events';

CREATE TABLE CASE_EVENT_STG
(
  EVENT_ID NUMBER(18, 0) NOT NULL 
, EVENT_TYPE_CD VARCHAR2(32 BYTE) 
, CONTEXT VARCHAR2(1000 BYTE) 
, COMMENTS VARCHAR2(2500 BYTE) 
, CREATE_TS DATE 
, CREATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, REF_TYPE VARCHAR2(32 BYTE) 
, REF_ID NUMBER(18, 0) 
, EVENT_LEVEL NUMBER(8, 0) 
, IMAGE_REPO_REF_ID NUMBER(18, 0) 
, EFFECTIVE_DATE DATE 
, CASE_ID NUMBER(18, 0) 
, CLIENT_ID NUMBER(18, 0) 
, CALL_RECORD_ID NUMBER(18, 0) 
, TASK_INSTANCE_ID NUMBER(18, 0) 
, CSCL_ID NUMBER(18, 0) 
, DISABLED_IND NUMBER 
, GENERIC_FIELD1_DATE DATE 
, GENERIC_FIELD2_DATE DATE 
, GENERIC_FIELD3_NUM NUMBER(18, 0) 
, GENERIC_FIELD4_NUM NUMBER(18, 0) 
, GENERIC_FIELD5_TXT VARCHAR2(256 BYTE) 
, GENERIC_FIELD6_TXT VARCHAR2(256 BYTE) 
, GENERIC_FIELD7_TXT VARCHAR2(256 BYTE) 
, GENERIC_FIELD8_TXT VARCHAR2(256 BYTE) 
, GENERIC_FIELD9_TXT VARCHAR2(256 BYTE) 
, GENERIC_FIELD10_TXT VARCHAR2(256 BYTE) ) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX XPKCASE_EVENT_STG ON CASE_EVENT_STG (EVENT_ID ASC) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX1_EVENT_STG_CASEID ON CASE_EVENT_STG (CASE_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX2_EVENT_STG_CLIENTID ON CASE_EVENT_STG (CLIENT_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX3_EVENT_STG_CONTEXT ON CASE_EVENT_STG (CONTEXT) TABLESPACE MAXDAT_INDX;

COMMENT ON TABLE CASE_EVENT_STG IS 'The Events table holds business events generated by the different application modules as a result of user actions or based on business logic.';
COMMENT ON COLUMN CASE_EVENT_STG.EVENT_ID IS 'PK of the event table';
COMMENT ON COLUMN CASE_EVENT_STG.EVENT_TYPE_CD IS 'Event Type Code Value';
COMMENT ON COLUMN CASE_EVENT_STG.CONTEXT IS 'Any context information related to this event (optional)';
COMMENT ON COLUMN CASE_EVENT_STG.COMMENTS IS 'Any comment related to this event (optional)';
COMMENT ON COLUMN CASE_EVENT_STG.CREATE_TS IS 'event creation timstamp';
COMMENT ON COLUMN CASE_EVENT_STG.CREATED_BY IS 'The id of the user / staff that caused this event to be generated. If this event was generated by an offline process, then this is set to SYSTEM.';
COMMENT ON COLUMN CASE_EVENT_STG.UPDATE_TS IS 'update timestamp if applicable';
COMMENT ON COLUMN CASE_EVENT_STG.UPDATED_BY IS 'the id of the user / staff that updated the record';
COMMENT ON COLUMN CASE_EVENT_STG.REF_TYPE IS 'This is the name of the entity whose PK value is specified by ref_id';
COMMENT ON COLUMN CASE_EVENT_STG.REF_ID IS 'This is the PK value of the record from the entity specified in ref_type that caused this event.';
COMMENT ON COLUMN CASE_EVENT_STG.EVENT_LEVEL IS 'The event level. This is copied from the enum_event_type table for performance reasons (denormalized value).';
COMMENT ON COLUMN CASE_EVENT_STG.IMAGE_REPO_REF_ID IS 'A reference to the image repository record that holds information on the image associated with this event. This is only applicable for certain events that involve images.';
COMMENT ON COLUMN CASE_EVENT_STG.EFFECTIVE_DATE IS 'The effective date of the transaction that generated this event. Usually set the same as the createTs field (but only the date part is set).';
COMMENT ON COLUMN CASE_EVENT_STG.CASE_ID IS 'The id of the case that is associated with this event.';
COMMENT ON COLUMN CASE_EVENT_STG.CLIENT_ID IS 'The id of the client that is associated with this event. May not be applicable.';
COMMENT ON COLUMN CASE_EVENT_STG.CALL_RECORD_ID IS 'The id of the call record that is associated with this event. May not be applicable.';
COMMENT ON COLUMN CASE_EVENT_STG.TASK_INSTANCE_ID IS 'The id of the task instance that is associated with this event. May not be applicable.';
COMMENT ON COLUMN CASE_EVENT_STG.CSCL_ID IS 'The id of the case_client record that is associated with this event. May not be applicable.';
COMMENT ON COLUMN CASE_EVENT_STG.DISABLED_IND IS 'If true, then this event record is considered invalid and should not be included in views / reports.';

CREATE TABLE APP_TRACKER_STG
(
  APP_TRACKER_ID NUMBER(18, 0) NOT NULL 
, APPLICATION_ID NUMBER(18, 0) 
, APP_INDIVIDUAL_ID NUMBER(18, 0) 
, STATUS_DATE DATE 
, NOTE_REF_ID NUMBER(18, 0) 
, CREATE_TS DATE 
, CREATED_BY VARCHAR2(50 BYTE) 
, HISTORY_IND NUMBER(1, 0) 
, RFE_STATUS_CD VARCHAR2(32 BYTE) 
, UPDATE_TS DATE 
, UPDATED_BY VARCHAR2(50 BYTE) 
, REJ_REASON_CD VARCHAR2(32 BYTE) ) TABLESPACE MAXDAT_DATA;

COMMENT ON TABLE APP_TRACKER_STG IS 'Application Tracker, carries application and applicant status history and notes.';
COMMENT ON COLUMN APP_TRACKER_STG.APP_TRACKER_ID IS 'Application Tracker ID (Primary Key)';
COMMENT ON COLUMN APP_TRACKER_STG.APPLICATION_ID IS 'Application ID (Primary Key), uniquely identifies an application.';
COMMENT ON COLUMN APP_TRACKER_STG.APP_INDIVIDUAL_ID IS 'Application member ID (Primary Key)';
COMMENT ON COLUMN APP_TRACKER_STG.STATUS_DATE IS 'Status Date';
COMMENT ON COLUMN APP_TRACKER_STG.NOTE_REF_ID IS 'Notes';
COMMENT ON COLUMN APP_TRACKER_STG.RFE_STATUS_CD IS 'Application Status Code';

CREATE UNIQUE INDEX XPKAPP_TRACKER_STG ON APP_TRACKER_STG (APP_TRACKER_ID ASC) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX1_APP_TRACKER_STG_APPID ON APP_TRACKER_STG (APPLICATION_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX2_APP_TRACKER_STG_APPINDVID ON APP_TRACKER_STG (APP_INDIVIDUAL_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX3_APP_TRACKER_STG_RFESTAT ON APP_TRACKER_STG (RFE_STATUS_CD) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON APP_TRACKER_STG to MAXDAT_READ_ONLY;
GRANT SELECT ON CASE_EVENT_STG to MAXDAT_READ_ONLY;
GRANT SELECT ON CASE_MANUAL_ACTION_LKUP to MAXDAT_READ_ONLY;
GRANT SELECT ON APP_MI_CATEGORY_LKUP to MAXDAT_READ_ONLY;
GRANT SELECT ON APP_MI_SATISFY_REASON_LKUP to MAXDAT_READ_ONLY;
GRANT SELECT ON APP_MI_TYPE_LKUP to MAXDAT_READ_ONLY;

