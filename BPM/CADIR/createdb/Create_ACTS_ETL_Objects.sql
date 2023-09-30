/*
-- ACTS Look up tables 

Farook 07/10/2015 Created. Backfilling comments for Farook.
Raj A. 07/20/2015 Added two lookup tables, ACTS_SPECIALITY & ACTS_REFUSAL_REASON. Removed public synonyms.
*/
CREATE TABLE ACTS_REVIEW_DECISION
(
  REVIEW_DECISION_ID             NUMBER(24) not null,
  CONTENT_LIBRARY_ID             NUMBER(24),
  REVIEW_DESCRIPTION             VARCHAR2(1000 CHAR),
  REVIEW_NUMBER                  VARCHAR2(32 CHAR),
  REVIEW_DECISION_KEY            VARCHAR2(45 CHAR),
  NEXT_LEVEL_REVIEW_FLAG         CHAR(1 CHAR),
  ADDITIONAL_INFO_FLAG           CHAR(1 CHAR),
  UNFAVORABLE_DECISION_FLAG      CHAR(1 CHAR),
  ORDER_BY                       NUMBER(24),
  DELETED_FLAG                   CHAR(1 CHAR),
  CREATED_DATE                   DATE ,
  CREATED_BY                     VARCHAR2(80 CHAR),
  UPDATED_DATE                   DATE,
  UPDATED_BY                     VARCHAR2(80 CHAR)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create unique index ACTS_REVIEW_DECISION_IX1 on ACTS_REVIEW_DECISION (REVIEW_DECISION_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
grant select, insert, update, delete on ACTS_REVIEW_DECISION to MAXDAT_OLTP_SIUD;
grant select on ACTS_REVIEW_DECISION to MAXDAT_READ_ONLY;  
  

CREATE TABLE ACTS_CASE_QUEUE
(
  QUEUE_CODE                VARCHAR2(32 CHAR) NOT NULL,
  QUEUE_DESCRIPTION         VARCHAR2(256 CHAR),
  ORDER_BY                  NUMBER(10),
  EFFECTIVE_START_DATE      DATE,
  EFFECTIVE_END_DATE        DATE,
  PARENT_VALUE              VARCHAR2(32 CHAR),
  CREATED_DATE              DATE,
  CREATED_BY                VARCHAR2(80 CHAR),
  UPDATED_DATE              DATE, 
  UPDATED_BY                VARCHAR2(80 CHAR)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
create unique index ACTS_CASE_QUEUE_IX1 on ACTS_CASE_QUEUE (QUEUE_CODE)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
grant select, insert, update, delete on ACTS_CASE_QUEUE to MAXDAT_OLTP_SIUD;
grant select on ACTS_CASE_QUEUE to MAXDAT_READ_ONLY;   
  
  
CREATE TABLE ACTS_PROGRAM
(
  PROGRAM_ID                   NUMBER(24) NOT NULL,
  PROGRAM_CODE                 VARCHAR2(15 CHAR),
  PROGRAM_NAME                 VARCHAR2(50 CHAR),
  ACK_LETTER_REQUIRED_FLAG     CHAR(1 CHAR),
  ACTIVE_FLAG                  CHAR(1 CHAR),
  ADDITIONAL_INFO_ALLOWED_FLAG CHAR(1 CHAR),
  CONTRACT_PARTY               VARCHAR2(255 CHAR),
  INITIAL_CASE_DOCUMENTATION   VARCHAR2(512 CHAR),
  EMAILBOX                     VARCHAR2(50 CHAR),
  DETERMINATION_PREAPROVED_FLAG CHAR(1 CHAR),
  DOC_URI                      VARCHAR2(50 CHAR),
  HEARING_ALLOWED              CHAR(1 CHAR),
  PR_ALLOWED_FLAG              CHAR(1 CHAR),
  ELIGIBILITY_VERIFICATION_FLAG CHAR(1 CHAR),
  INITIAL_COMPLETENESS_FLAG    CHAR(1 CHAR),
  PREACCEPTANCE_REVIEW_FLAG    CHAR(1 CHAR),
  WEIGHTAGES_SECOND_REVIEW     FLOAT,
  PRR_TF_CALBUSTYPE            NUMBER(10),
  PRR_TF_NOTES                 VARCHAR2(255 CHAR),
  PRR_TF_TYPE                  NUMBER(10),
  PRR_TF_UNIT                  FLOAT,
  ORG_NUMBER                   VARCHAR2(100 CHAR),
  PROJECT_ACCOUNT_GROUP        VARCHAR2(100 CHAR),
  PROJECT_MANAGER              VARCHAR2(100 CHAR),
  PROJECT_NUMBER               VARCHAR2(100 CHAR),
  INVOCE_PREFIX                VARCHAR2(100 CHAR),
  REPORT_TITLE                 VARCHAR2(25 CHAR),
  MD_REVIEW_APPROACH           VARCHAR2(255 CHAR),
  CLIENT_ENTITY_ID             NUMBER(24),
  PROGRAM_LOCATION_VALUE       VARCHAR2(255 CHAR),
  PROJECT_TYPE_VALUE           VARCHAR2(255 CHAR),
  REPORT_FREQUENCY_VALUE       VARCHAR2(255 CHAR),
  CASE_NUMBER_PREFIX           VARCHAR2(15 CHAR),
  RI_TF_CA_LBUS_TYPE           NUMBER(10),
  RI_TF_NOTES                  VARCHAR2(255 CHAR),
  RI_TF_TYPE                   NUMBER(10),
  RI_TF_UNIT                   FLOAT,
  WEIGHTAGE_THIRD_REVIEW       FLOAT,
  SELFASSIGNABLE_FLAG          CHAR(1 CHAR),
  SELFASSIGNED_EMAIL_BOX       VARCHAR2(50 CHAR),
  SELFASSIGN_REVIEWER_TYPE     VARCHAR2(15 CHAR),
  SELFASSIGN_THROSHOLD_DAYS    NUMBER(10),
  CREATED_DATE                 DATE,  
  CREATED_BY                   VARCHAR2(30 CHAR),  
  UPDATED_DATE                 DATE,  
  UPDATED_BY                   VARCHAR2(30 CHAR) 
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    
  
create unique index ACTS_PROGRAM_IX1 on ACTS_PROGRAM (PROGRAM_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    
  
grant select, insert, update, delete on ACTS_PROGRAM to MAXDAT_OLTP_SIUD;
grant select on ACTS_PROGRAM to MAXDAT_READ_ONLY;  
  

CREATE TABLE ACTS_USERS
(
  USER_ID               NUMBER(24) NOT NULL,
  LOGIN_NAME            VARCHAR2(255 CHAR) NOT NULL,
  ENABLED_FLAG          CHAR(1),
  FIRST_NAME            VARCHAR2(50 CHAR),
  MIDDLE_NAME           VARCHAR2(30 CHAR),
  LAST_NAME             VARCHAR2(50 CHAR),
  PHONE_NUMBER          VARCHAR2(14 CHAR),
  FAX_NUMBER            VARCHAR2(14 CHAR),
  EMAIL                 VARCHAR2(80 CHAR),
  EMPLOYEE_NUMBER       VARCHAR2(80 CHAR),
  PASSWORD_CHANGED_DATE DATE,
  OFFICE_CODE           VARCHAR2(32 CHAR),
  MAS_ID                VARCHAR2(50 CHAR),
  LAST_LOGIN_DATE       DATE,
  CREATED_DATE          DATE ,
  CREATED_BY            VARCHAR2(80 CHAR),
  UPDATED_DATE          DATE, 
  UPDATED_BY            VARCHAR2(80 CHAR)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    

create unique index ACTS_USERS_IX1 on ACTS_USERS (USER_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   

grant select, insert, update, delete on ACTS_USERS to MAXDAT_OLTP_SIUD;
grant select on ACTS_USERS to MAXDAT_READ_ONLY;  


CREATE TABLE ACTS_CRED_CONSULTANT
(
  MD_ID                       NUMBER(10) NOT NULL,
  FIRST_NAME                  VARCHAR2(50 CHAR),
  MIDDLE_NAME                 VARCHAR2(25 CHAR),
  LAST_NAME                   VARCHAR2(50 CHAR),
  VENDOR_ID                   VARCHAR2(45 CHAR),
  CCR_ACTION                  VARCHAR2(45 CHAR),
  PA_STATUS                   VARCHAR2(8 CHAR),
  EMPLOYMENT_INDICATOR        CHAR(1 CHAR),
  EFFECTIVE_DATE              DATE,
  NP_NUMBER                   VARCHAR2(25 CHAR),
  STATE_OF_RESIDENCE          VARCHAR2(50 CHAR),
  PROFESSIONAL_GROUP_NAME     VARCHAR2(50 CHAR),
  EXPERTISE_FOR_REVIEW        VARCHAR2(500 CHAR),
  EXPERTISE_FOR_REVIEW2       VARCHAR2(500 CHAR),
  EXPERTISE_FOR_REVIEW3       VARCHAR2(500 CHAR),
  TIME_IN_CLINICAL_PRACTICE   NUMBER(10),
  SPECIALITY                  VARCHAR2(150 CHAR),
  SUB_SPECIALITY              VARCHAR2(500 CHAR),
  DATE_LIMIT                  DATE,
  CONFLICT_1                  VARCHAR2(150 CHAR),
  CONFLICT_2                  VARCHAR2(150 CHAR),
  CONFLICT_3                  VARCHAR2(150 CHAR),
  CONFLICT_4                  VARCHAR2(150 CHAR),
  LANGUAGES                   VARCHAR2(250 CHAR),
  CURRENT_PRACTICE            VARCHAR2(150 CHAR),
  CELLPHONE_NUMBER            VARCHAR2(100 CHAR),
  CLINICAL_PRACTICE           CHAR(1 CHAR),
  PREFERRED_MAILING           VARCHAR2(20 CHAR),
  PREFERRED_EMAIL             VARCHAR2(20 CHAR),
  REVIEWER_TYPE               VARCHAR2(50 CHAR),
  ORG_TYPE                    VARCHAR2(150 CHAR),
  EMAIL_NOTIFICATION_REQUIRED CHAR(1 CHAR),
  SELF_ASSIGNABLE             CHAR(1 CHAR),
  RESEARCH_INTEREST           VARCHAR2(500 CHAR),  
  CREATED_DATE                DATE,
  CREATED_BY                  VARCHAR2(80 CHAR),
  UPDATED_DATE                DATE, 
  UPDATED_BY                  VARCHAR2(80 CHAR)  
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );     
  
create unique index ACTS_CRED_CONSULTANT_IX1 on ACTS_CRED_CONSULTANT (MD_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    
  
grant select, insert, update, delete on ACTS_CRED_CONSULTANT to MAXDAT_OLTP_SIUD;
grant select on ACTS_CRED_CONSULTANT to MAXDAT_READ_ONLY;   
  
  
CREATE TABLE ACTS_PM_RESPONSE_DETAILS
(  
  RESPONSE_DETAIL_ID             NUMBER(24) not null,
  RT_CITATION_DETAILS_ID         NUMBER(24),
  PANEL_MEMBER_RESPONSE_ID       NUMBER(24),
  ETK_ID                         NUMBER(24),
  ORDER_BY                       NUMBER(24),
  MTUS_GUIDLINES_FLAG            CHAR(1 CHAR),
  ACOEM_FLAG                     CHAR(1 CHAR),
  ACOEM_CAPTER1_FLAG             CHAR(1 CHAR),
  ACOEM_CAPTER2_FLAG             CHAR(1 CHAR),
  ACOEM_CAPTER3_FLAG             CHAR(1 CHAR),
  ACOEM_CAPTER5_FLAG             CHAR(1 CHAR),
  ACOEM_CAPTER8_FLAG             CHAR(1 CHAR),
  ACOEM_CAPTER9_FLAG             CHAR(1 CHAR),
  ACOEM_CAPTER10_FLAG            CHAR(1 CHAR),
  ACOEM_CAPTER11_FLAG            CHAR(1 CHAR),
  ACOEM_CAPTER12_FLAG            CHAR(1 CHAR),
  ACOEM_CAPTER13_FLAG            CHAR(1 CHAR),
  ACOEM_CAPTER14_FLAG            CHAR(1 CHAR),
  ACOEM_CAPTER15_FLAG            CHAR(1 CHAR),
  ACOEM_CAPTER16_FLAG            CHAR(1 CHAR),
  CPMTG_FLAG                     CHAR(1 CHAR),
  AMTG_FLAG                      CHAR(1 CHAR),
  PSTG_FLAG                      CHAR(1 CHAR),
  OTHER_GUIDELINES_FLAG          CHAR(1 CHAR),
  ODG_FLAG                       CHAR(1 CHAR),
  OMTG_FLAG                      CHAR(1 CHAR),
  REVIEW_DECISION_ID             NUMBER(24),
  RECOMMENDED_REVIEW_DECISION_ID NUMBER(24),
  CREATED_DATE                   DATE,
  CREATED_BY                     VARCHAR2(30 CHAR),
  UPDATED_DATE                   DATE, 
  UPDATED_BY                     VARCHAR2(30 CHAR) 
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );     

create unique index ACTS_PM_RESPONSE_DETAILS_IX1 on ACTS_PM_RESPONSE_DETAILS (RESPONSE_DETAIL_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
create index ACTS_PM_RESPONSE_DETAILS_IX2 on ACTS_PM_RESPONSE_DETAILS (PANEL_MEMBER_RESPONSE_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
grant select, insert, update, delete on ACTS_PM_RESPONSE_DETAILS to MAXDAT_OLTP_SIUD;
grant select on ACTS_PM_RESPONSE_DETAILS to MAXDAT_READ_ONLY;    
 

CREATE TABLE ACTS_PM_RESPONSE
(  
  PANEL_MEMBER_RESPONSE_ID       NUMBER(24) NOT NULL,
  CASE_CONSULTANT_REF_ID         NUMBER(24),
  MD_ID                          NUMBER(10),
  REVIEW_DECISION_ID             NUMBER(24),
  CREATED_DATE                   DATE,
  CREATED_BY                     VARCHAR2(80 CHAR),
  UPDATED_DATE                   DATE, 
  UPDATED_BY                     VARCHAR2(80 CHAR) 
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
create unique index ACTS_PM_RESPONSE_IX1 on ACTS_PM_RESPONSE (PANEL_MEMBER_RESPONSE_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
   
grant select, insert, update, delete on ACTS_PM_RESPONSE to MAXDAT_OLTP_SIUD;
grant select on ACTS_PM_RESPONSE to MAXDAT_READ_ONLY; 
  

CREATE TABLE ACTS_CONSULTANT_REF_HISTORY
(  
  HISTORY_ID             NUMBER(10) NOT NULL,
  CASE_CONSULTANT_REF_ID NUMBER(24),
  MD_ID                  NUMBER(10),
  MD_REVIEW_STATUS       VARCHAR2(20 CHAR),
  ACTION_DATE            DATE,
  CREATED_DATE           DATE,
  CREATED_BY             VARCHAR2(80 CHAR),
  UPDATED_DATE           DATE, 
  UPDATED_BY             VARCHAR2(80 CHAR) 
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
create unique index ACTS_CONSL_REF_HSTY_IX1 on ACTS_CONSULTANT_REF_HISTORY (HISTORY_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
create index ACTS_CONSL_REF_HSTY_IX2 on ACTS_CONSULTANT_REF_HISTORY (CASE_CONSULTANT_REF_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
 
grant select, insert, update, delete on ACTS_CONSULTANT_REF_HISTORY to MAXDAT_OLTP_SIUD;
grant select on ACTS_CONSULTANT_REF_HISTORY to MAXDAT_READ_ONLY; 


CREATE TABLE ACTS_CONSULTANT_REF
(  
  CASE_CONSULTANT_REF_ID       NUMBER(24) NOT NULL,
  ACTIVE_FLAG                  CHAR(1 CHAR) ,
  ASSIGNED_CONSULTANT          VARCHAR2(255 CHAR),
  ASSIGNED_DATE                DATE,
  REVIEW_RETURNED_DATE         DATE,
  MD_FLAG                      CHAR(1 CHAR),
  RE_REVIEW_DUE_DATE           DATE,
  REFERRAL_DATE                DATE,
  REVIEW_DUE_DATE              DATE,
  SUGGESTED_SPECIALITY         VARCHAR2(255 CHAR),
  APPEAL_CASE_ID               NUMBER(24),
  ACCEPTABLE_REVIEW            VARCHAR2(3 CHAR),
  ASSIGNED_MD_ID               NUMBER(10),
  PREV_CASE_CONSULTANT_REF_ID  NUMBER(24),
  MD_REVIEW_STATUS             VARCHAR2(32 CHAR),
  SUGGESTED_DUE_DATE           DATE,
  SUGGESTED_MD_ID              NUMBER(10),
  TRACKING_NUMBER              VARCHAR2(32 CHAR),
  MEDIA_RETURNED_DATE          DATE,
  DELIVERY_MODE_TYPE           VARCHAR2(32 CHAR),
  SEND_TO_PANEL_SCHEDULER      CHAR(5 CHAR),
  MD_REVIEW_NUMBER_TYPE        VARCHAR2(32 CHAR),
  BOARD_CERTIFICATION_QUEUE    VARCHAR2(32 CHAR),
  ASSIGNMENT_METHOD            VARCHAR2(32 CHAR),
  BENEFICIARY_NUMBER           VARCHAR2(256 CHAR),
  REF_SUGGESTED_SPECIALTY_ID   NUMBER(10),
  NON_STANDARD_PAYMENT         CHAR(1 CHAR),
  RUSH_FLAG                    CHAR(1 CHAR),
  AUTHORIZED                   CHAR(1 CHAR),
  AUTHORIZED_AMOUNT            FLOAT,
  AUTHORIZED_DATE              DATE,
  APPROVER_USER_ID             NUMBER(24),
  ATTESTATION_DATE             DATE,
  ATTESTED_FLAG                CHAR(1 CHAR),
  ATTESTED_MD_NAME             VARCHAR2(100 CHAR),
  CLERICAL_MODE_FLAG           CHAR(1 CHAR),
  REQUEST_FOR_INFORMATION_FLAG CHAR(1 CHAR),
  REVIEW_DECISION_ID           NUMBER(24),
  REFUSED_FLAG                 CHAR(1 CHAR),
  ALTERNATIVE_SERVICE          VARCHAR2(32 CHAR),
  REFUSAL_DATE                 DATE,
  REFUSAL_RESON_VALUE          VARCHAR2(32 CHAR),
  REFERRAL_INDICATOR           VARCHAR2(10 CHAR),
  ETK_PANEL_SCHEDULER_ID       NUMBER(24),
  RT_COUNT                     NUMBER(10),
  CLAIMS_ADMIN_CRITERIA_FLAG   CHAR(1 CHAR),
  PROVIDER_CRITERIA_FLAG       CHAR(1 CHAR),
  NEITHER_CRITERIA_FLAG	       CHAR(1 CHAR),
  DOCUMENTS_REVIEWED           CHAR(1 CHAR),
  SELFASSIGN_CASE_REFUSED      CHAR(1 CHAR),
  ACTUAL_ASSIGNMENT_METHOD     VARCHAR2(32 CHAR),
  CREATED_DATE                 DATE,
  CREATED_BY                   VARCHAR2(80 CHAR),
  UPDATED_DATE                 DATE, 
  UPDATED_BY                   VARCHAR2(80 CHAR) 
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
create unique index ACTS_CONSULTANT_REF_IX1 on ACTS_CONSULTANT_REF (CASE_CONSULTANT_REF_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
create index ACTS_CONSULTANT_REF_IX2 on ACTS_CONSULTANT_REF (APPEAL_CASE_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
grant select, insert, update, delete on ACTS_CONSULTANT_REF to MAXDAT_OLTP_SIUD;
grant select on ACTS_CONSULTANT_REF to MAXDAT_READ_ONLY;  
  

CREATE TABLE ACTS_APPEAL_CASE
(
  APPEAL_CASE_ID           NUMBER(24) NOT NULL,
  CASE_NUMBER              VARCHAR2(32 CHAR),
  CASE_STATUS              VARCHAR2(32 CHAR),
  CLOSED_DATE              DATE,
  DUE_DATE                 DATE,
  RECIEVED_DATE            DATE,
  REFERENCE_NUMBER         VARCHAR2(100 CHAR),
  INITIATED_DATE           DATE,
  START_DATE               DATE,
  STATUS_CHANGE_DATE       DATE,
  RELATED_CASE_ID          NUMBER(24),
  PROGRAM_ID               NUMBER(24),
  ASSIGNED_TO_USER_ID      NUMBER(24),
  CASE_DECISION_ID         NUMBER(24),
  CASE_DISPUTE_ID          NUMBER(24),
  PROGRAM_PROFILE_ID       NUMBER(24),
  CASE_PRE_REVIEW_ID       NUMBER(24),
  CASE_NOTE_ID             NUMBER(24),
  ATTACHED_DOCUMENT_ID     NUMBER(24),
  REFERRAL_COMPLETE_FLAG   CHAR(1 CHAR),
  DELETED_FLAG             CHAR(1 CHAR),
  REASON_DELETED           VARCHAR2(256 CHAR),
  PARENT_CASE_ID           NUMBER(24),
  REOPENED_FLAG            CHAR(1 CHAR),
  DISAGGREGATED_FLAG       CHAR(1 CHAR),
  CASE_QA_ID               NUMBER(24),
  SOURCE_TYPE              VARCHAR2(32 CHAR),
  ORIGINAL_DUE_DATE        DATE,
  RI_FLAG                  VARCHAR2(5 CHAR),
  WORKER_USER_ID           NUMBER(24),
  SUBMITTED_DATE           DATE,
  MPR_FLAG                 VARCHAR2(5 CHAR),
  APPEAL_END_DATE          DATE,
  APPELLANT_TYPE           VARCHAR2(50 CHAR),
  CASE_TYPE_QUEUE_VALUE    VARCHAR2(32 CHAR),
  NEED_PROCESSING_FLAG     CHAR(1 CHAR),
  PORTAL_USER_CREATE_ID    NUMBER(24),
  INVOICE_LINE_ITEM_ID     NUMBER(24),
  COMPLETED                VARCHAR2(1) DEFAULT 'N',
  CREATED_USER_NAME        VARCHAR2(256 CHAR),  
  CREATED_DATE             DATE,
  CREATED_BY               VARCHAR2(80 CHAR),
  UPDATED_DATE             DATE, 
  UPDATED_BY               VARCHAR2(80 CHAR)   
)  
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
create unique index ACTS_APPEAL_CASE_IX1 on ACTS_APPEAL_CASE (APPEAL_CASE_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    
  
create index ACTS_APPEAL_CASE_IX2 on ACTS_APPEAL_CASE (COMPLETED)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );   
  
grant select, insert, update, delete on ACTS_APPEAL_CASE to MAXDAT_OLTP_SIUD;
grant select on ACTS_APPEAL_CASE to MAXDAT_READ_ONLY;    


create table ACTS_SPECIALITY
(
  VALUE                VARCHAR2(32 CHAR) not null,
  DESCRIPTION          VARCHAR2(256 CHAR),
  ORDER_BY_DEFAULT     NUMBER(10),
  EFFECTIVE_START_DATE DATE,
  EFFECTIVE_END_DATE   DATE,
  PARENT_VALUE         VARCHAR2(32 CHAR),
  SPECIALITY_KEY       NUMBER,
  CREATED_BY           VARCHAR2(80 CHAR),
  CREATE_TS            DATE not null,
  UPDATED_BY           VARCHAR2(80 CHAR),
  UPDATE_TS            DATE not null  
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create unique index ACTS_SPECIALITY_VALUE_IX1 on ACTS_SPECIALITY (VALUE)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index MAXDAT.ACTS_SPECIALITY_SP_KEY_IX2 on MAXDAT.ACTS_SPECIALITY (SPECIALITY_KEY)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  

grant select, insert, update, delete on ACTS_SPECIALITY to MAXDAT_OLTP_SIUD;
grant select on ACTS_SPECIALITY to MAXDAT_READ_ONLY;  


create table ACTS_REFUSAL_REASON
(
  VALUE                VARCHAR2(32 CHAR) not null,
  DESCRIPTION          VARCHAR2(256 CHAR),
  ORDER_BY_DEFAULT     NUMBER(10),
  EFFECTIVE_START_DATE DATE,
  EFFECTIVE_END_DATE   DATE,
  CREATED_BY           VARCHAR2(80 CHAR),
  CREATE_TS            DATE not null,
  UPDATED_BY           VARCHAR2(80 CHAR),
  UPDATE_TS            DATE not null,
  PARENT_VALUE         VARCHAR2(32 CHAR)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create unique index ACTS_REFUSAL_REASON_VALUE_IX1 on ACTS_REFUSAL_REASON (VALUE)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
grant select, insert, update, delete on ACTS_REFUSAL_REASON to MAXDAT_OLTP_SIUD;
grant select on ACTS_REFUSAL_REASON to MAXDAT_READ_ONLY;


-- Create Semantic Views 

CREATE OR REPLACE VIEW D_ACTS_REVIEW_DECISION_SV AS SELECT * FROM ACTS_REVIEW_DECISION WITH READ ONLY;
CREATE OR REPLACE VIEW D_ACTS_CASE_QUEUE_SV AS SELECT * FROM ACTS_CASE_QUEUE WITH READ ONLY;
CREATE OR REPLACE VIEW D_ACTS_PROGRAM_SV AS SELECT * FROM ACTS_PROGRAM WITH READ ONLY;
CREATE OR REPLACE VIEW D_ACTS_USERS_SV AS SELECT * FROM ACTS_USERS WITH READ ONLY;
CREATE OR REPLACE VIEW D_ACTS_CRED_CONSULTANT_SV AS SELECT * FROM ACTS_CRED_CONSULTANT WITH READ ONLY;
CREATE OR REPLACE VIEW S_ACTS_PM_RESPONSE_DETAILS_SV AS SELECT * FROM ACTS_PM_RESPONSE_DETAILS WITH READ ONLY;
CREATE OR REPLACE VIEW S_ACTS_PM_RESPONSE_SV AS SELECT * FROM ACTS_PM_RESPONSE WITH READ ONLY;
CREATE OR REPLACE VIEW S_ACTS_CONSULTANT_REF_HIST_SV AS SELECT * FROM ACTS_CONSULTANT_REF_HISTORY WITH READ ONLY;
CREATE OR REPLACE VIEW S_ACTS_CONSULTANT_REF_SV AS SELECT * FROM ACTS_CONSULTANT_REF WITH READ ONLY;
CREATE OR REPLACE VIEW S_ACTS_APPEAL_CASE_SV AS SELECT * FROM ACTS_APPEAL_CASE WITH READ ONLY;
CREATE OR REPLACE VIEW D_ACTS_SPECIALITY_SV AS SELECT * FROM ACTS_SPECIALITY WITH READ ONLY;
CREATE OR REPLACE VIEW D_ACTS_REFUSAL_REASON_SV AS SELECT * FROM ACTS_REFUSAL_REASON WITH READ ONLY;