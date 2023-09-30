declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_NETWORK';
    if c = 1 then
       execute immediate 'drop table EMRS_D_NETWORK cascade constraints';
    end if;
 end;
 /


CREATE TABLE MAXDAT.EMRS_D_NETWORK
	(
	  NETWORK_ID                    NUMBER (18) NOT NULL
	, PROVIDER_ID                   NUMBER (18)
	, PLAN_ID                       NUMBER (18)
	, FIRST_NAME                    VARCHAR2 (64)
	, FIRST_NAME_CANNON             VARCHAR2 (64)
	, FIRST_NAME_SOUNDLIKE          VARCHAR2 (64)
	, LAST_NAME                     VARCHAR2 (64)
	, LAST_NAME_SOUNDLIKE           VARCHAR2 (64)
	, LAST_NAME_CANNON              VARCHAR2 (64)
	, MIDDLE_NAME                   VARCHAR2 (32)
	, OFFICE_ADDR_1                 VARCHAR2 (128)
	, OFFICE_ADDR_2                 VARCHAR2 (50)
	, OFFICE_CITY                   VARCHAR2 (64)
	, OFFICE_STATE                  VARCHAR2 (2)
	, OFFICE_ZIP                    VARCHAR2 (32)
	, OFFICE_COUNTY                 VARCHAR2 (64)
	, OFFICE_PHONE                  VARCHAR2 (15)
	, OFFICE_FAX                    VARCHAR2 (15)
	, OFFICE_EMAIL                  VARCHAR2 (256)
	, AGE_LOW_LIMIT                 NUMBER (3) DEFAULT 0
	, AGE_HIGH_LIMIT                NUMBER (3) DEFAULT 120
	, MEDICAID_ID_EXT               VARCHAR2 (32)
	, WHEEL_CHAIR_ACCESSIBLE_IND    NUMBER (1)
	, PCP_IND                       NUMBER (1)
	, ACCEPTING_NEW_CLIENTS_MCO_IND NUMBER (1)
	, ACCEPTING_NEW_CLIENTS_PCP_IND NUMBER (1)
	, SEX_LIMITS_CD                 VARCHAR2 (32)
	, PROVIDER_GENDER_CD            VARCHAR2 (32)
	, CREATE_TS                     DATE
	, CREATED_BY                    VARCHAR2 (80)
	, UPDATE_TS                     DATE
	, UPDATED_BY                    VARCHAR2 (80)
	, LICENSE_NUMBER                VARCHAR2 (30)
	, START_DATE                    DATE
	, MULTIPLE_LOCATIONS_IND        NUMBER (1)
	, SITENAME                      VARCHAR2 (128)
	, SITENAME_SOUNDLIKE            VARCHAR2 (64)
	, SITENAME_CANNON               VARCHAR2 (64)
	, FQHC_STATUS_IND               NUMBER (1)
	, NETWORK_ID_EXT                VARCHAR2 (128)
	, PLAN_ID_EXT                   VARCHAR2 (128)
	, PROVIDER_ID_EXT               VARCHAR2 (128)
	, FILE_ID_EXT                   NUMBER (1)
	, STATUS_CD                     VARCHAR2 (2)
	, ACCEPTS_OBSTETRICS_IND        NUMBER (1) DEFAULT 1 NOT NULL
	, WOMEN_ONLY_IND                NUMBER (1)
	, ADMIT_PRIVILEGES_IND          NUMBER (1)
	, DELIVERY_PRIVILEGES_IND       NUMBER (1)
	, EFFECTIVE_DT                  DATE
	, END_DT                        DATE
	, LOCATION_CD                   VARCHAR2 (1)
	, EXTERNAL_GROUP_ID             VARCHAR2 (256)
	, PROGRAM_TYPE_CD               VARCHAR2 (32) DEFAULT 'MEDICAID'
	, ACCEPTING_NEW_CLIENTS_PCP_CD  VARCHAR2 (32)
	, ACCEPTING_NEW_CLIENTS_MCO_CD  VARCHAR2 (32)
	, NETWORK_GENERIC_FIELD1_DATE   DATE
	, NETWORK_GENERIC_FIELD2_DATE   DATE
	, NETWORK_GENERIC_FIELD3_NUM    NUMBER (18)
	, NETWORK_GENERIC_FIELD4_NUM    NUMBER (18)
	, NETWORK_GENERIC_FIELD5_TXT    VARCHAR2 (256)
	, NETWORK_GENERIC_FIELD6_TXT    VARCHAR2 (256)
	, NETWORK_GENERIC_FIELD7_TXT    VARCHAR2 (256)
	, NETWORK_GENERIC_FIELD8_TXT    VARCHAR2 (256)
	, NETWORK_GENERIC_FIELD9_TXT    VARCHAR2 (256)
	, NETWORK_GENERIC_FIELD10_TXT   VARCHAR2 (256)
	, NETWORK_GENERIC_REF11_ID      NUMBER (18)
	, NETWORK_GENERIC_REF12_ID      NUMBER (18)
	, RAW_ADDRESS_ID                NUMBER (18)
	, NORM_ADDRESS_ID               NUMBER (18)
	, ADDR_UPDATED_BY               VARCHAR2 (80)
	, ADDR_UPDATE_TS                DATE
	, HASH_NUM                      NUMBER (20),
	CONSTRAINT XPKNETWORK PRIMARY KEY (NETWORK_ID)
	)
;

CREATE INDEX NETWORK_ID11
	ON MAXDAT.EMRS_D_NETWORK (HASH_NUM, PROVIDER_ID, PLAN_ID)
;

CREATE INDEX NETWORK_IND01
	ON MAXDAT.EMRS_D_NETWORK (NETWORK_ID_EXT)
;

CREATE INDEX NETWORK_IND02
	ON MAXDAT.EMRS_D_NETWORK (PLAN_ID_EXT)
;

CREATE INDEX NETWORK_IND03
	ON MAXDAT.EMRS_D_NETWORK (FILE_ID_EXT)
;

CREATE INDEX NETWORK_IND04
	ON MAXDAT.EMRS_D_NETWORK (PLAN_ID)
;

CREATE INDEX NETWORK_IND05
	ON MAXDAT.EMRS_D_NETWORK (PROVIDER_ID)
;

CREATE INDEX NETWORK_IND06
	ON MAXDAT.EMRS_D_NETWORK (PROVIDER_ID_EXT, NETWORK_GENERIC_FIELD5_TXT, PCP_IND)
;

CREATE INDEX NETWORK_NORM_ADDR_ID
	ON MAXDAT.EMRS_D_NETWORK (NORM_ADDRESS_ID)
;

CREATE INDEX NETWORK_RAW_ADDR
	ON MAXDAT.EMRS_D_NETWORK (RAW_ADDRESS_ID)
;

CREATE INDEX NETWORK_TEST1
	ON MAXDAT.EMRS_D_NETWORK (LAST_NAME_CANNON, OFFICE_COUNTY, PROGRAM_TYPE_CD)
;


declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_NETWORK_LANGUAGE';
    if c = 1 then
       execute immediate 'drop table EMRS_D_NETWORK_LANGUAGE cascade constraints';
    end if;
 end;
 /


CREATE TABLE MAXDAT.EMRS_D_NETWORK_LANGUAGE
	(
	  NETWORK_ID          NUMBER (18)
	, LANGUAGE_TYPE_CD    VARCHAR2 (32)
	, PROVIDER_SPEAKS_IND NUMBER (1)
	, CREATE_TS           DATE
	, CREATED_BY          VARCHAR2 (80)
	, UPDATE_TS           DATE
	, UPDATED_BY          VARCHAR2 (80)
	, LANGUAGE_EXT_CD     VARCHAR2 (2)
	)
;

CREATE UNIQUE INDEX XPKNETWORK_LANGUAGE
	ON MAXDAT.EMRS_D_NETWORK_LANGUAGE (NETWORK_ID, LANGUAGE_TYPE_CD)
;

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_NETWORK_OFFICE_HOURS';
    if c = 1 then
       execute immediate 'drop table EMRS_D_NETWORK_OFFICE_HOURS cascade constraints';
    end if;
 end;
 /


CREATE TABLE MAXDAT.EMRS_D_NETWORK_OFFICE_HOURS
	(
	  NETWORK_OFFICE_HOURS_ID NUMBER (18) NOT NULL
	, DAY_OF_WEEK             VARCHAR2 (20)
	, OPEN_FROM               VARCHAR2 (8)
	, CLOSE_AT                VARCHAR2 (8)
	, CREATED_BY              VARCHAR2 (30)
	, CREATE_TS               DATE
	, UPDATED_BY              VARCHAR2 (30)
	, UPDATE_TS               DATE
	, NETWORK_ID              NUMBER (18),
	CONSTRAINT NOHR_PK PRIMARY KEY (NETWORK_OFFICE_HOURS_ID),
	CONSTRAINT NOHR_UK UNIQUE (NETWORK_ID, DAY_OF_WEEK)
	)
;

CREATE INDEX NETWORK_OFFICE_HOURS_IND01
	ON MAXDAT.EMRS_D_NETWORK_OFFICE_HOURS (NETWORK_ID)
;


declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_NETWORK_SPECIALTY';
    if c = 1 then
       execute immediate 'drop table EMRS_D_NETWORK_SPECIALTY cascade constraints';
    end if;
 end;
 /

CREATE TABLE MAXDAT.EMRS_D_NETWORK_SPECIALTY
	(
	  NETWORK_ID        NUMBER (18) NOT NULL
	, SPECIALTY_TYPE_CD VARCHAR2 (32) NOT NULL
	, CREATE_TS         DATE
	, CREATED_BY        VARCHAR2 (80)
	, UPDATE_TS         DATE
	, UPDATED_BY        VARCHAR2 (80)
	, SPECIALTY_EXT_CD  VARCHAR2 (2),
	CONSTRAINT XPKNETWORK_SPECIALTY PRIMARY KEY (NETWORK_ID, SPECIALTY_TYPE_CD)
	)
;

CREATE INDEX NETWORK_SPECIALTY_IND06
	ON MAXDAT.EMRS_D_NETWORK_SPECIALTY (SPECIALTY_EXT_CD)
;

CREATE INDEX NETWORK_SPECIALTY_IND07
	ON MAXDAT.EMRS_D_NETWORK_SPECIALTY (NETWORK_ID, SPECIALTY_EXT_CD)
;


declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_PANEL_LIMIT';
    if c = 1 then
       execute immediate 'drop table EMRS_D_PANEL_LIMIT cascade constraints';
    end if;
 end;
 /

CREATE TABLE MAXDAT.EMRS_D_PANEL_LIMIT
	(
	  PANEL_LIMIT_ID NUMBER (18) NOT NULL
	, NETWORK_ID     NUMBER (18)
	, PROVIDER_ID    NUMBER (18)
	, PANEL_SIZE     INTEGER
	, ENROLLED_COUNT INTEGER
	, HOLD_CD        VARCHAR2 (32)
	, CREATE_TS      DATE
	, CREATED_BY     VARCHAR2 (80)
	, UPDATE_TS      DATE
	, UPDATED_BY     VARCHAR2 (80)
	, TYPE_CD        VARCHAR2 (32)
	, PLAN_ID        NUMBER (18),
	CONSTRAINT XPKPANEL_LIMIT PRIMARY KEY (PANEL_LIMIT_ID)
	)
;

CREATE INDEX PANEL_LIMIT_IND01
	ON MAXDAT.EMRS_D_PANEL_LIMIT (PROVIDER_ID)
;

CREATE INDEX PANEL_LIMIT_IND02
	ON MAXDAT.EMRS_D_PANEL_LIMIT (PLAN_ID)
;

CREATE INDEX PANEL_LIMIT_IND03
	ON MAXDAT.EMRS_D_PANEL_LIMIT (NETWORK_ID)
;


declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_PROVIDER';
    if c = 1 then
       execute immediate 'drop table EMRS_D_PROVIDER cascade constraints';
    end if;
 end;
 /

CREATE TABLE MAXDAT.EMRS_D_PROVIDER
	(
	  PROVIDER_ID                  NUMBER (18) NOT NULL
	, PROVIDER_ID_EXT              VARCHAR2 (128)
	, DEA_ID_EXT                   VARCHAR2 (32)
	, NPI_ID_EXT                   VARCHAR2 (32)
	, STATUS_CD                    VARCHAR2 (32)
	, DBA_NAME                     VARCHAR2 (64)
	, TAX_NAME                     VARCHAR2 (64)
	, FIRST_NAME_CANNON            VARCHAR2 (64)
	, FIRST_NAME_SOUNDLIKE         VARCHAR2 (64)
	, TITLE                        VARCHAR2 (32)
	, FIRST_NAME                   VARCHAR2 (64)
	, LAST_NAME                    VARCHAR2 (64)
	, MIDDLE_NAME                  VARCHAR2 (64)
	, NAME_SUFFIX                  VARCHAR2 (32)
	, SSN                          VARCHAR2 (30)
	, PCP_IND                      NUMBER (1)
	, PROV_ENRL_CNT_STATE          NUMBER (9)
	, CREATE_TS                    DATE
	, CREATED_BY                   VARCHAR2 (80)
	, UPDATE_TS                    DATE
	, UPDATED_BY                   VARCHAR2 (80)
	, PHONE                        VARCHAR2 (15)
	, FAX                          VARCHAR2 (15)
	, EMAIL                        VARCHAR2 (64)
	, NPI_TYPE_CD                  VARCHAR2 (32)
	, LAST_NAME_CANNON             VARCHAR2 (64)
	, LAST_NAME_SOUNDLIKE          VARCHAR2 (32)
	, LICENSE_NUMBER               VARCHAR2 (30)
	, PROVIDER_GENDER_CD           VARCHAR2 (32)
	, OUT_OF_STATE_IND             NUMBER (1)
	, MEDICAID_IND                 NUMBER (1)
	, TYPE_CD                      VARCHAR2 (32)
	, CLASSIFICATION_CD            VARCHAR2 (32)
	, PROVIDER_GENERIC_FIELD1_DATE DATE
	, PROVIDER_GENERIC_FIELD2_DATE DATE
	, PROVIDER_GENERIC_FIELD3_NUM  NUMBER (18)
	, PROVIDER_GENERIC_FIELD4_NUM  NUMBER (18)
	, PROVIDER_GENERIC_FIELD5_TXT  VARCHAR2 (256)
	, PROVIDER_GENERIC_FIELD6_TXT  VARCHAR2 (256)
	, PROVIDER_GENERIC_FIELD7_TXT  VARCHAR2 (256)
	, PROVIDER_GENERIC_FIELD8_TXT  VARCHAR2 (256)
	, PROVIDER_GENERIC_FIELD9_TXT  VARCHAR2 (256)
	, PROVIDER_GENERIC_FIELD10_TXT VARCHAR2 (256)
	, PROVIDER_GENERIC_REF11_ID    NUMBER (18)
	, PROVIDER_GENERIC_REF12_ID    NUMBER (18),
	CONSTRAINT XPKPROVIDER PRIMARY KEY (PROVIDER_ID)
	)
;

CREATE INDEX PROVIDER_IND01
	ON MAXDAT.EMRS_D_PROVIDER (PROVIDER_ID_EXT)
;


declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_SELECTION_MISSING_INFO';
    if c = 1 then
       execute immediate 'drop table EMRS_D_SELECTION_MISSING_INFO cascade constraints';
    end if;
 end;
 /

CREATE TABLE MAXDAT.EMRS_D_SELECTION_MISSING_INFO
	(
	  MISSING_INFO_ID      NUMBER (18) NOT NULL
	, COMMENTS             VARCHAR2 (4000)
	, COMMENTS_FOR_CLIENT  VARCHAR2 (4000)
	, CREATE_TS            DATE
	, CREATED_BY           VARCHAR2 (80)
	, UPDATE_TS            DATE
	, UPDATED_BY           VARCHAR2 (80)
	, MISSING_INFO_TYPE_CD VARCHAR2 (32),
	CONSTRAINT XPKSELECTION_MISSING_INFO PRIMARY KEY (MISSING_INFO_ID)
	)
;

declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_SEL_MISSING_INFO_DETAILS';
    if c = 1 then
       execute immediate 'drop table EMRS_D_SEL_MISSING_INFO_DETAILS cascade constraints';
    end if;
 end;
 /

CREATE TABLE MAXDAT.EMRS_D_SEL_MISSING_INFO_DETAILS
	(
	  MISSING_INFO_DETAILS_ID NUMBER (18) NOT NULL
	, MISSING_INFO_ID         NUMBER (18)
	, ERROR_CODE              VARCHAR2 (32)
	, CLIENT_ID               NUMBER (18)
	, SEND_IN_LETTER_IND      NUMBER (1) DEFAULT 1
	, ADDITIONAL_MESSAGE_IND  NUMBER (1) DEFAULT 0
	, CREATE_TS               DATE
	, CREATED_BY              VARCHAR2 (80)
	, UPDATE_TS               DATE
	, UPDATED_BY              VARCHAR2 (80)
	, COMMENTS                VARCHAR2 (4000)
	, DENIAL_ERROR_CD         VARCHAR2 (32)
	, SUPPLEMENTAL_INFO       VARCHAR2 (256),
	CONSTRAINT XPKSEL_MISSING_INFO_DETAILS PRIMARY KEY (MISSING_INFO_DETAILS_ID)
	)
;

CREATE INDEX NDX_SELECT_MI_DETAIL1
	ON MAXDAT.EMRS_D_SEL_MISSING_INFO_DETAILS (MISSING_INFO_ID)
;



declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_SELECTION_SEGMENT';
    if c = 1 then
       execute immediate 'drop table EMRS_D_SELECTION_SEGMENT cascade constraints';
    end if;
 end;
 /

CREATE TABLE MAXDAT.EMRS_D_SELECTION_SEGMENT
	(
	  SELECTION_SEGMENT_ID   NUMBER (18) NOT NULL
	, CLIENT_ID              NUMBER (18)
	, PROGRAM_TYPE_CD        VARCHAR2 (32)
	, PLAN_TYPE_CD           VARCHAR2 (32)
	, START_DATE             DATE
	, END_DATE               DATE
	, STATUS_CD              VARCHAR2 (32)
	, STATUS_DATE            DATE
	, PLAN_ID                NUMBER (18)
	, PLAN_ID_EXT            VARCHAR2 (30)
	, NETWORK_ID             NUMBER (18)
	, PROVIDER_ID_EXT        VARCHAR2 (32)
	, PROVIDER_FIRST_NAME    VARCHAR2 (64)
	, PROVIDER_MIDDLE_NAME   VARCHAR2 (25)
	, PROVIDER_LAST_NAME     VARCHAR2 (64)
	, CHOICE_REASON_CD       VARCHAR2 (32)
	, DISENROLL_REASON_CD_1  VARCHAR2 (32)
	, DISENROLL_REASON_CD_2  VARCHAR2 (32)
	, CLIENT_AID_CATEGORY_CD VARCHAR2 (32)
	, COUNTY_CD              VARCHAR2 (32)
	, ZIPCODE                VARCHAR2 (32)
	, CREATED_BY             VARCHAR2 (80)
	, CREATE_TS              DATE
	, UPDATED_BY             VARCHAR2 (80)
	, UPDATE_TS              DATE
	, CONTRACT_ID            NUMBER (18)
	, START_ND               NUMBER (8) NOT NULL
	, END_ND                 NUMBER (8) NOT NULL
	, SELECTION_SOURCE_CD    VARCHAR2 (32),
	CONSTRAINT PK_SELECTION_SEGMENT PRIMARY KEY (SELECTION_SEGMENT_ID)
	)
	PCTFREE 50
	INITRANS 100
	STORAGE (BUFFER_POOL DEFAULT)
	ENABLE ROW MOVEMENT;

CREATE INDEX IDX1_SELECTION_SEGMENT
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (CLIENT_ID)
;

CREATE INDEX SELECTION_SEGMENT_COMP
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (CLIENT_ID, CONTRACT_ID, END_ND, PLAN_ID_EXT)
;

CREATE INDEX SELECTION_SEGMENT_COMP2
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (CLIENT_ID, END_DATE, END_ND, PLAN_ID, PLAN_ID_EXT)
;

CREATE INDEX SELECTION_SEGMENT_IDX01
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (CLIENT_ID, START_ND, END_ND)
;

CREATE INDEX SELECTION_SEGMENT_IDX07
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (COUNTY_CD, PLAN_ID, SELECTION_SOURCE_CD, CREATE_TS)
;

CREATE INDEX SELECTION_SEGMENT_IDX08
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (PROVIDER_ID_EXT, END_ND, PLAN_ID)
;

CREATE INDEX SELECTION_SEGMENT_IDX2
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (CLIENT_ID, START_DATE, END_DATE, STATUS_CD)
;

CREATE INDEX SELECTION_SEGMENT_IDX3
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (PLAN_ID)
;

CREATE INDEX SELECTION_SEGMENT_IDX4
	ON MAXDAT.EMRS_D_SELECTION_SEGMENT (CONTRACT_ID)
;



declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='EMRS_D_SELECTION_TXN';
    if c = 1 then
       execute immediate 'drop table EMRS_D_SELECTION_TXN cascade constraints';
    end if;
 end;
 /

CREATE TABLE MAXDAT.EMRS_D_SELECTION_TXN
	(
	  SELECTION_TXN_ID              NUMBER (18) NOT NULL
	, SELECTION_TXN_GROUP_ID        NUMBER (18)
	, PROGRAM_TYPE_CD               VARCHAR2 (32)
	, TRANSACTION_TYPE_CD           VARCHAR2 (32)
	, SELECTION_SOURCE_CD           VARCHAR2 (32)
	, REF_SOURCE_ID                 NUMBER (18)
	, REF_SOURCE_TYPE               VARCHAR2 (32)
	, REF_EXT_TXN_ID                VARCHAR2 (80)
	, PLAN_TYPE_CD                  VARCHAR2 (32)
	, PLAN_ID                       NUMBER (18)
	, PLAN_ID_EXT                   VARCHAR2 (30)
	, CONTRACT_ID                   NUMBER (18)
	, NETWORK_ID                    NUMBER (18)
	, PROVIDER_ID                   NUMBER (18)
	, PROVIDER_ID_EXT               VARCHAR2 (64)
	, PROVIDER_FIRST_NAME           VARCHAR2 (64)
	, PROVIDER_MIDDLE_NAME          VARCHAR2 (25)
	, PROVIDER_LAST_NAME            VARCHAR2 (64)
	, START_DATE                    DATE
	, END_DATE                      DATE
	, CHOICE_REASON_CD              VARCHAR2 (32)
	, DISENROLL_REASON_CD_1         VARCHAR2 (32)
	, DISENROLL_REASON_CD_2         VARCHAR2 (32)
	, OVERRIDE_REASON_CD            VARCHAR2 (32)
	, FOLLOWUP_REASON_CD            VARCHAR2 (32)
	, FOLLOWUP_CALL_DATE            DATE
	, FOLLOWUP_FORM_RCV_DATE        DATE
	, FOLLOWUP_BY                   VARCHAR2 (80)
	, MISSING_INFO_ID               NUMBER (18)
	, MISSING_SIGNATURE_IND         NUMBER (1)
	, OUTREACH_SESSION_ID           NUMBER (18)
	, BENEFITS_PACKAGE_CD           VARCHAR2 (32)
	, SELECTION_SEGMENT_ID          NUMBER (18)
	, CLIENT_ID                     NUMBER (18)
	, STATUS_CD                     VARCHAR2 (32)
	, STATUS_DATE                   DATE
	, CLIENT_AID_CATEGORY_CD        VARCHAR2 (32)
	, COUNTY                        VARCHAR2 (32)
	, ZIPCODE                       VARCHAR2 (32)
	, CLIENT_RESIDENCE_ADDRESS_ID   NUMBER (18)
	, PRIOR_SELECTION_SEGMENT_ID    NUMBER (18)
	, PRIOR_SELECTION_START_DATE    DATE
	, PRIOR_SELECTION_END_DATE      DATE
	, PRIOR_PLAN_ID                 NUMBER (18)
	, PRIOR_PLAN_ID_EXT             VARCHAR2 (32)
	, PRIOR_PROVIDER_ID             NUMBER (18)
	, PRIOR_PROVIDER_ID_EXT         VARCHAR2 (32)
	, PRIOR_PROVIDER_FIRST_NAME     VARCHAR2 (25)
	, PRIOR_PROVIDER_MIDDLE_NAME    VARCHAR2 (25)
	, PRIOR_PROVIDER_LAST_NAME      VARCHAR2 (64)
	, REF_SELECTION_TXN_ID          NUMBER (18)
	, SURPLUS_INFO                  NUMBER (10,2)
	, CREATED_BY                    VARCHAR2 (80)
	, CREATE_TS                     DATE
	, UPDATED_BY                    VARCHAR2 (80)
	, UPDATE_TS                     DATE
	, PRIOR_CONTRACT_ID             NUMBER (18)
	, PRIOR_NETWORK_ID              NUMBER (18)
	, START_ND                      NUMBER (8) NOT NULL
	, END_ND                        NUMBER (8) NOT NULL
	, PRIOR_CHOICE_REASON_CD        VARCHAR2 (32)
	, PRIOR_DISENROLL_REASON_CD_1   VARCHAR2 (32)
	, PRIOR_DISENROLL_REASON_CD_2   VARCHAR2 (32)
	, PRIOR_CLIENT_AID_CATEGORY_CD  VARCHAR2 (32)
	, PRIOR_COUNTY_CD               VARCHAR2 (32)
	, PRIOR_ZIPCODE                 VARCHAR2 (32)
	, ORIGINAL_START_DATE           DATE
	, ORIGINAL_END_DATE             DATE
	, SELECTION_GENERIC_FIELD1_DATE DATE
	, SELECTION_GENERIC_FIELD2_DATE DATE
	, SELECTION_GENERIC_FIELD3_NUM  NUMBER (18)
	, SELECTION_GENERIC_FIELD4_NUM  NUMBER (18)
	, SELECTION_GENERIC_FIELD5_TXT  VARCHAR2 (256)
	, SELECTION_GENERIC_FIELD6_TXT  VARCHAR2 (256)
	, SELECTION_GENERIC_FIELD7_TXT  VARCHAR2 (256)
	, SELECTION_GENERIC_FIELD8_TXT  VARCHAR2 (256)
	, SELECTION_GENERIC_FIELD9_TXT  VARCHAR2 (256)
	, SELECTION_GENERIC_FIELD10_TXT VARCHAR2 (256),
	CONSTRAINT PK_SELECTION_TXN PRIMARY KEY (SELECTION_TXN_ID)
	)
;

CREATE INDEX IDX1_SELECTION_TXN
	ON MAXDAT.EMRS_D_SELECTION_TXN (CLIENT_ID)
;

CREATE INDEX IDX2_SELECTION_TXN
	ON MAXDAT.EMRS_D_SELECTION_TXN (STATUS_CD)
;

CREATE INDEX IDX3_SELECTION_TXN
	ON MAXDAT.EMRS_D_SELECTION_TXN (CLIENT_ID, START_DATE, END_DATE, STATUS_CD)
;

CREATE INDEX IDX4_SELECTION_TXN
	ON MAXDAT.EMRS_D_SELECTION_TXN (REF_SELECTION_TXN_ID)
;

CREATE INDEX IDX_SELECTION_TXN_UPDATE_TS
	ON MAXDAT.EMRS_D_SELECTION_TXN (UPDATE_TS)
;

CREATE INDEX SELECTION_TXN_IDX01
	ON MAXDAT.EMRS_D_SELECTION_TXN (CLIENT_ID, START_ND, END_ND, STATUS_CD)
;

CREATE INDEX SELECTION_TXN_IDX06
	ON MAXDAT.EMRS_D_SELECTION_TXN (TRANSACTION_TYPE_CD)
;

CREATE INDEX SELECTION_TXN_IDX07
	ON MAXDAT.EMRS_D_SELECTION_TXN (COUNTY, PLAN_ID, SELECTION_SOURCE_CD, STATUS_CD, CREATE_TS)
;

CREATE INDEX SELECTION_TXN_IDX10
	ON MAXDAT.EMRS_D_SELECTION_TXN (PRIOR_PLAN_ID)
;

CREATE INDEX SELECTION_TXN_IDX11
	ON MAXDAT.EMRS_D_SELECTION_TXN (NETWORK_ID)
;

CREATE INDEX SELECTION_TXN_IDX5
	ON MAXDAT.EMRS_D_SELECTION_TXN (STATUS_CD, STATUS_DATE)
;

CREATE INDEX SELECTION_TXN_IDX6
	ON MAXDAT.EMRS_D_SELECTION_TXN (SELECTION_TXN_GROUP_ID)
;

CREATE INDEX SELECTION_TXN_IDX7
	ON MAXDAT.EMRS_D_SELECTION_TXN (PLAN_ID)
;

CREATE INDEX SELECTION_TXN_IDX8
	ON MAXDAT.EMRS_D_SELECTION_TXN (CONTRACT_ID)
;

CREATE INDEX SELECTION_TXN_IDX9
	ON MAXDAT.EMRS_D_SELECTION_TXN (PRIOR_CONTRACT_ID)
;

CREATE INDEX SELECTION_TXN_OUT_ID
	ON MAXDAT.EMRS_D_SELECTION_TXN (OUTREACH_SESSION_ID)
;


COMMIT;



-- Create Views
CREATE OR REPLACE VIEW MAXDAT.EMRS_D_NETWORK_SV AS
SELECT
	NETWORK_ID
	, PROVIDER_ID
	, PLAN_ID
	, FIRST_NAME
	, FIRST_NAME_CANNON
	, FIRST_NAME_SOUNDLIKE
	, LAST_NAME
	, LAST_NAME_SOUNDLIKE
	, LAST_NAME_CANNON
	, MIDDLE_NAME
	, OFFICE_ADDR_1
	, OFFICE_ADDR_2
	, OFFICE_CITY
	, OFFICE_STATE
	, OFFICE_ZIP
	, OFFICE_COUNTY
	, OFFICE_PHONE
	, OFFICE_FAX
	, OFFICE_EMAIL
	, AGE_LOW_LIMIT
	, AGE_HIGH_LIMIT
	, MEDICAID_ID_EXT
	, WHEEL_CHAIR_ACCESSIBLE_IND
	, PCP_IND
	, ACCEPTING_NEW_CLIENTS_MCO_IND
	, ACCEPTING_NEW_CLIENTS_PCP_IND
	, SEX_LIMITS_CD
	, PROVIDER_GENDER_CD
	, CREATE_TS
	, CREATED_BY
	, UPDATE_TS
	, UPDATED_BY
	, LICENSE_NUMBER
	, START_DATE
	, MULTIPLE_LOCATIONS_IND
	, SITENAME
	, SITENAME_SOUNDLIKE
	, SITENAME_CANNON
	, FQHC_STATUS_IND
	, NETWORK_ID_EXT
	, PLAN_ID_EXT
	, PROVIDER_ID_EXT
	, FILE_ID_EXT
	, STATUS_CD
	, ACCEPTS_OBSTETRICS_IND
	, WOMEN_ONLY_IND
	, ADMIT_PRIVILEGES_IND
	, DELIVERY_PRIVILEGES_IND
	, EFFECTIVE_DT
	, END_DT
	, LOCATION_CD
	, EXTERNAL_GROUP_ID
	, PROGRAM_TYPE_CD
	, ACCEPTING_NEW_CLIENTS_PCP_CD
	, ACCEPTING_NEW_CLIENTS_MCO_CD
	, NETWORK_GENERIC_FIELD1_DATE
	, NETWORK_GENERIC_FIELD2_DATE
	, NETWORK_GENERIC_FIELD3_NUM
	, NETWORK_GENERIC_FIELD4_NUM
	, NETWORK_GENERIC_FIELD5_TXT
	, NETWORK_GENERIC_FIELD6_TXT
	, NETWORK_GENERIC_FIELD7_TXT
	, NETWORK_GENERIC_FIELD8_TXT
	, NETWORK_GENERIC_FIELD9_TXT
	, NETWORK_GENERIC_FIELD10_TXT
	, NETWORK_GENERIC_REF11_ID
	, NETWORK_GENERIC_REF12_ID
	, RAW_ADDRESS_ID
	, NORM_ADDRESS_ID
	, ADDR_UPDATED_BY
	, ADDR_UPDATE_TS
	, HASH_NUM
FROM MAXDAT.EMRS_D_NETWORK
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_NETWORK_LANGUAGE_SV AS
SELECT
	NETWORK_ID
	, LANGUAGE_TYPE_CD
	, PROVIDER_SPEAKS_IND
	, CREATE_TS
	, CREATED_BY
	, UPDATE_TS
	, UPDATED_BY
	, LANGUAGE_EXT_CD
FROM MAXDAT.EMRS_D_NETWORK_LANGUAGE
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_NETWORK_OFFICE_HOURS_SV AS
SELECT
	NETWORK_OFFICE_HOURS_ID
	, DAY_OF_WEEK
	, OPEN_FROM
	, CLOSE_AT
	, CREATED_BY
	, CREATE_TS
	, UPDATED_BY
	, UPDATE_TS
	, NETWORK_ID
FROM MAXDAT.EMRS_D_NETWORK_OFFICE_HOURS
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_NETWORK_SPECIALTY_SV AS
SELECT
	NETWORK_ID
	, SPECIALTY_TYPE_CD
	, CREATE_TS
	, CREATED_BY
	, UPDATE_TS
	, UPDATED_BY
	, SPECIALTY_EXT_CD
FROM MAXDAT.EMRS_D_NETWORK_SPECIALTY
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_PANEL_LIMIT_SV AS
SELECT
	PANEL_LIMIT_ID
	, NETWORK_ID
	, PROVIDER_ID
	, PANEL_SIZE
	, ENROLLED_COUNT
	, HOLD_CD
	, CREATE_TS
	, CREATED_BY
	, UPDATE_TS
	, UPDATED_BY
	, TYPE_CD
	, PLAN_ID
FROM MAXDAT.EMRS_D_PANEL_LIMIT
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_PROVIDER_SV AS
SELECT
	PROVIDER_ID
	, PROVIDER_ID_EXT
	, DEA_ID_EXT
	, NPI_ID_EXT
	, STATUS_CD
	, DBA_NAME
	, TAX_NAME
	, FIRST_NAME_CANNON
	, FIRST_NAME_SOUNDLIKE
	, TITLE
	, FIRST_NAME
	, LAST_NAME
	, MIDDLE_NAME
	, NAME_SUFFIX
	, SSN
	, PCP_IND
	, PROV_ENRL_CNT_STATE
	, CREATE_TS
	, CREATED_BY
	, UPDATE_TS
	, UPDATED_BY
	, PHONE
	, FAX
	, EMAIL
	, NPI_TYPE_CD
	, LAST_NAME_CANNON
	, LAST_NAME_SOUNDLIKE
	, LICENSE_NUMBER
	, PROVIDER_GENDER_CD
	, OUT_OF_STATE_IND
	, MEDICAID_IND
	, TYPE_CD
	, CLASSIFICATION_CD
	, PROVIDER_GENERIC_FIELD1_DATE
	, PROVIDER_GENERIC_FIELD2_DATE
	, PROVIDER_GENERIC_FIELD3_NUM
	, PROVIDER_GENERIC_FIELD4_NUM
	, PROVIDER_GENERIC_FIELD5_TXT
	, PROVIDER_GENERIC_FIELD6_TXT
	, PROVIDER_GENERIC_FIELD7_TXT
	, PROVIDER_GENERIC_FIELD8_TXT
	, PROVIDER_GENERIC_FIELD9_TXT
	, PROVIDER_GENERIC_FIELD10_TXT
	, PROVIDER_GENERIC_REF11_ID
	, PROVIDER_GENERIC_REF12_ID
FROM MAXDAT.EMRS_D_PROVIDER
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_SEL_MISSING_INFO_DETLS_SV AS 
SELECT
	MISSING_INFO_DETAILS_ID
	, MISSING_INFO_ID
	, ERROR_CODE
	, CLIENT_ID
	, SEND_IN_LETTER_IND
	, ADDITIONAL_MESSAGE_IND
	, CREATE_TS
	, CREATED_BY
	, UPDATE_TS
	, UPDATED_BY
	, COMMENTS
	, DENIAL_ERROR_CD
	, SUPPLEMENTAL_INFO
FROM MAXDAT.EMRS_D_SEL_MISSING_INFO_DETAILS
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_SELECTION_MISSING_INFO_SV AS
SELECT
	MISSING_INFO_ID
	, COMMENTS
	, COMMENTS_FOR_CLIENT
	, CREATE_TS
	, CREATED_BY
	, UPDATE_TS
	, UPDATED_BY
	, MISSING_INFO_TYPE_CD
FROM MAXDAT.EMRS_D_SELECTION_MISSING_INFO
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_SELECTION_SEGMENT_SV AS
SELECT
	SELECTION_SEGMENT_ID
	, CLIENT_ID
	, PROGRAM_TYPE_CD
	, PLAN_TYPE_CD
	, START_DATE
	, END_DATE
	, STATUS_CD
	, STATUS_DATE
	, PLAN_ID
	, PLAN_ID_EXT
	, NETWORK_ID
	, PROVIDER_ID_EXT
	, PROVIDER_FIRST_NAME
	, PROVIDER_MIDDLE_NAME
	, PROVIDER_LAST_NAME
	, CHOICE_REASON_CD
	, DISENROLL_REASON_CD_1
	, DISENROLL_REASON_CD_2
	, CLIENT_AID_CATEGORY_CD
	, COUNTY_CD
	, ZIPCODE
	, CREATED_BY
	, CREATE_TS
	, UPDATED_BY
	, UPDATE_TS
	, CONTRACT_ID
	, START_ND
	, END_ND
	, SELECTION_SOURCE_CD
FROM MAXDAT.EMRS_D_SELECTION_SEGMENT
WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_SELECTION_TXN_SV AS
SELECT
	SELECTION_TXN_ID
	, SELECTION_TXN_GROUP_ID
	, PROGRAM_TYPE_CD
	, TRANSACTION_TYPE_CD
	, SELECTION_SOURCE_CD
	, REF_SOURCE_ID
	, REF_SOURCE_TYPE
	, REF_EXT_TXN_ID
	, PLAN_TYPE_CD
	, PLAN_ID
	, PLAN_ID_EXT
	, CONTRACT_ID
	, NETWORK_ID
	, PROVIDER_ID
	, PROVIDER_ID_EXT
	, PROVIDER_FIRST_NAME
	, PROVIDER_MIDDLE_NAME
	, PROVIDER_LAST_NAME
	, START_DATE
	, END_DATE
	, CHOICE_REASON_CD
	, DISENROLL_REASON_CD_1
	, DISENROLL_REASON_CD_2
	, OVERRIDE_REASON_CD
	, FOLLOWUP_REASON_CD
	, FOLLOWUP_CALL_DATE
	, FOLLOWUP_FORM_RCV_DATE
	, FOLLOWUP_BY
	, MISSING_INFO_ID
	, MISSING_SIGNATURE_IND
	, OUTREACH_SESSION_ID
	, BENEFITS_PACKAGE_CD
	, SELECTION_SEGMENT_ID
	, CLIENT_ID
	, STATUS_CD
	, STATUS_DATE
	, CLIENT_AID_CATEGORY_CD
	, COUNTY
	, ZIPCODE
	, CLIENT_RESIDENCE_ADDRESS_ID
	, PRIOR_SELECTION_SEGMENT_ID
	, PRIOR_SELECTION_START_DATE
	, PRIOR_SELECTION_END_DATE
	, PRIOR_PLAN_ID
	, PRIOR_PLAN_ID_EXT
	, PRIOR_PROVIDER_ID
	, PRIOR_PROVIDER_ID_EXT
	, PRIOR_PROVIDER_FIRST_NAME
	, PRIOR_PROVIDER_MIDDLE_NAME
	, PRIOR_PROVIDER_LAST_NAME
	, REF_SELECTION_TXN_ID
	, SURPLUS_INFO
	, CREATED_BY
	, CREATE_TS
	, UPDATED_BY
	, UPDATE_TS
	, PRIOR_CONTRACT_ID
	, PRIOR_NETWORK_ID
	, START_ND
	, END_ND
	, PRIOR_CHOICE_REASON_CD
	, PRIOR_DISENROLL_REASON_CD_1
	, PRIOR_DISENROLL_REASON_CD_2
	, PRIOR_CLIENT_AID_CATEGORY_CD
	, PRIOR_COUNTY_CD
	, PRIOR_ZIPCODE
	, ORIGINAL_START_DATE
	, ORIGINAL_END_DATE
	, SELECTION_GENERIC_FIELD1_DATE
	, SELECTION_GENERIC_FIELD2_DATE
	, SELECTION_GENERIC_FIELD3_NUM
	, SELECTION_GENERIC_FIELD4_NUM
	, SELECTION_GENERIC_FIELD5_TXT
	, SELECTION_GENERIC_FIELD6_TXT
	, SELECTION_GENERIC_FIELD7_TXT
	, SELECTION_GENERIC_FIELD8_TXT
	, SELECTION_GENERIC_FIELD9_TXT
	, SELECTION_GENERIC_FIELD10_TXT
FROM MAXDAT.EMRS_D_SELECTION_TXN
WITH READ ONLY;

COMMIT;
