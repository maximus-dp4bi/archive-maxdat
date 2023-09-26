DROP TABLE MAXDAT_LAEB.ERRLOG_SELECTION_TXN CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_SELECTION_TXN
	(
	  ORA_ERR_NUMBER$               NUMBER
	, ORA_ERR_MESG$                 VARCHAR2 (2000)
	, ORA_ERR_ROWID$                UROWID
	, ORA_ERR_OPTYP$                VARCHAR2 (2)
	, ORA_ERR_TAG$                  VARCHAR2 (2000)
	, SELECTION_TXN_ID              VARCHAR2 (4000)
	, SELECTION_TXN_GROUP_ID        VARCHAR2 (4000)
	, PROGRAM_TYPE_CD               VARCHAR2 (4000)
	, TRANSACTION_TYPE_CD           VARCHAR2 (4000)
	, SELECTION_SOURCE_CD           VARCHAR2 (4000)
	, REF_SOURCE_ID                 VARCHAR2 (4000)
	, REF_SOURCE_TYPE               VARCHAR2 (4000)
	, REF_EXT_TXN_ID                VARCHAR2 (4000)
	, PLAN_TYPE_CD                  VARCHAR2 (4000)
	, PLAN_ID                       VARCHAR2 (4000)
	, PLAN_ID_EXT                   VARCHAR2 (4000)
	, CONTRACT_ID                   VARCHAR2 (4000)
	, NETWORK_ID                    VARCHAR2 (4000)
	, PROVIDER_ID                   VARCHAR2 (4000)
	, PROVIDER_ID_EXT               VARCHAR2 (4000)
	, PROVIDER_FIRST_NAME           VARCHAR2 (4000)
	, PROVIDER_MIDDLE_NAME          VARCHAR2 (4000)
	, PROVIDER_LAST_NAME            VARCHAR2 (4000)
	, START_DATE                    VARCHAR2 (4000)
	, END_DATE                      VARCHAR2 (4000)
	, CHOICE_REASON_CD              VARCHAR2 (4000)
	, DISENROLL_REASON_CD_1         VARCHAR2 (4000)
	, DISENROLL_REASON_CD_2         VARCHAR2 (4000)
	, OVERRIDE_REASON_CD            VARCHAR2 (4000)
	, FOLLOWUP_REASON_CD            VARCHAR2 (4000)
	, FOLLOWUP_CALL_DATE            VARCHAR2 (4000)
	, FOLLOWUP_FORM_RCV_DATE        VARCHAR2 (4000)
	, FOLLOWUP_BY                   VARCHAR2 (4000)
	, MISSING_INFO_ID               VARCHAR2 (4000)
	, MISSING_SIGNATURE_IND         VARCHAR2 (4000)
	, OUTREACH_SESSION_ID           VARCHAR2 (4000)
	, BENEFITS_PACKAGE_CD           VARCHAR2 (4000)
	, SELECTION_SEGMENT_ID          VARCHAR2 (4000)
	, CLIENT_ID                     VARCHAR2 (4000)
	, STATUS_CD                     VARCHAR2 (4000)
	, STATUS_DATE                   VARCHAR2 (4000)
	, CLIENT_AID_CATEGORY_CD        VARCHAR2 (4000)
	, COUNTY                        VARCHAR2 (4000)
	, ZIPCODE                       VARCHAR2 (4000)
	, CLIENT_RESIDENCE_ADDRESS_ID   VARCHAR2 (4000)
	, PRIOR_SELECTION_SEGMENT_ID    VARCHAR2 (4000)
	, PRIOR_SELECTION_START_DATE    VARCHAR2 (4000)
	, PRIOR_SELECTION_END_DATE      VARCHAR2 (4000)
	, PRIOR_PLAN_ID                 VARCHAR2 (4000)
	, PRIOR_PLAN_ID_EXT             VARCHAR2 (4000)
	, PRIOR_PROVIDER_ID             VARCHAR2 (4000)
	, PRIOR_PROVIDER_ID_EXT         VARCHAR2 (4000)
	, PRIOR_PROVIDER_FIRST_NAME     VARCHAR2 (4000)
	, PRIOR_PROVIDER_MIDDLE_NAME    VARCHAR2 (4000)
	, PRIOR_PROVIDER_LAST_NAME      VARCHAR2 (4000)
	, REF_SELECTION_TXN_ID          VARCHAR2 (4000)
	, SURPLUS_INFO                  VARCHAR2 (4000)
	, CREATED_BY                    VARCHAR2 (4000)
	, CREATE_TS                     VARCHAR2 (4000)
	, UPDATED_BY                    VARCHAR2 (4000)
	, UPDATE_TS                     VARCHAR2 (4000)
	, PRIOR_CONTRACT_ID             VARCHAR2 (4000)
	, PRIOR_NETWORK_ID              VARCHAR2 (4000)
	, START_ND                      VARCHAR2 (4000)
	, END_ND                        VARCHAR2 (4000)
	, PRIOR_CHOICE_REASON_CD        VARCHAR2 (4000)
	, PRIOR_DISENROLL_REASON_CD_1   VARCHAR2 (4000)
	, PRIOR_DISENROLL_REASON_CD_2   VARCHAR2 (4000)
	, PRIOR_CLIENT_AID_CATEGORY_CD  VARCHAR2 (4000)
	, PRIOR_COUNTY_CD               VARCHAR2 (4000)
	, PRIOR_ZIPCODE                 VARCHAR2 (4000)
	, ORIGINAL_START_DATE           VARCHAR2 (4000)
	, ORIGINAL_END_DATE             VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD1_DATE VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD2_DATE VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD3_NUM  VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD4_NUM  VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD5_TXT  VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD6_TXT  VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD7_TXT  VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD8_TXT  VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD9_TXT  VARCHAR2 (4000)
	, SELECTION_GENERIC_FIELD10_TXT VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);


DROP TABLE MAXDAT_LAEB.ERRLOG_SELECT_MISS_INFO CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_SELECT_MISS_INFO
	(
	  ORA_ERR_NUMBER$      NUMBER
	, ORA_ERR_MESG$        VARCHAR2 (2000)
	, ORA_ERR_ROWID$       UROWID
	, ORA_ERR_OPTYP$       VARCHAR2 (2)
	, ORA_ERR_TAG$         VARCHAR2 (2000)
	, MISSING_INFO_ID      VARCHAR2 (4000)
	, COMMENTS             VARCHAR2 (4000)
	, COMMENTS_FOR_CLIENT  VARCHAR2 (4000)
	, CREATE_TS            VARCHAR2 (4000)
	, CREATED_BY           VARCHAR2 (4000)
	, UPDATE_TS            VARCHAR2 (4000)
	, UPDATED_BY           VARCHAR2 (4000)
	, MISSING_INFO_TYPE_CD VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);


DROP TABLE MAXDAT_LAEB.ERRLOG_SELECTION_SEGMENT CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_SELECTION_SEGMENT
	(
	  ORA_ERR_NUMBER$        NUMBER
	, ORA_ERR_MESG$          VARCHAR2 (2000)
	, ORA_ERR_ROWID$         UROWID
	, ORA_ERR_OPTYP$         VARCHAR2 (2)
	, ORA_ERR_TAG$           VARCHAR2 (2000)
	, SELECTION_SEGMENT_ID   VARCHAR2 (4000)
	, CLIENT_ID              VARCHAR2 (4000)
	, PROGRAM_TYPE_CD        VARCHAR2 (4000)
	, PLAN_TYPE_CD           VARCHAR2 (4000)
	, START_DATE             VARCHAR2 (4000)
	, END_DATE               VARCHAR2 (4000)
	, STATUS_CD              VARCHAR2 (4000)
	, STATUS_DATE            VARCHAR2 (4000)
	, PLAN_ID                VARCHAR2 (4000)
	, PLAN_ID_EXT            VARCHAR2 (4000)
	, NETWORK_ID             VARCHAR2 (4000)
	, PROVIDER_ID_EXT        VARCHAR2 (4000)
	, PROVIDER_FIRST_NAME    VARCHAR2 (4000)
	, PROVIDER_MIDDLE_NAME   VARCHAR2 (4000)
	, PROVIDER_LAST_NAME     VARCHAR2 (4000)
	, CHOICE_REASON_CD       VARCHAR2 (4000)
	, DISENROLL_REASON_CD_1  VARCHAR2 (4000)
	, DISENROLL_REASON_CD_2  VARCHAR2 (4000)
	, CLIENT_AID_CATEGORY_CD VARCHAR2 (4000)
	, COUNTY_CD              VARCHAR2 (4000)
	, ZIPCODE                VARCHAR2 (4000)
	, CREATED_BY             VARCHAR2 (4000)
	, CREATE_TS              VARCHAR2 (4000)
	, UPDATED_BY             VARCHAR2 (4000)
	, UPDATE_TS              VARCHAR2 (4000)
	, CONTRACT_ID            VARCHAR2 (4000)
	, START_ND               VARCHAR2 (4000)
	, END_ND                 VARCHAR2 (4000)
	, SS_GENERIC_FIELD1_DATE VARCHAR2 (4000)
	, SS_GENERIC_FIELD2_DATE VARCHAR2 (4000)
	, SS_GENERIC_FIELD3_NUM  VARCHAR2 (4000)
	, SS_GENERIC_FIELD4_NUM  VARCHAR2 (4000)
	, SS_GENERIC_FIELD5_TXT  VARCHAR2 (4000)
	, SS_GENERIC_FIELD6_TXT  VARCHAR2 (4000)
	, SS_GENERIC_FIELD7_TXT  VARCHAR2 (4000)
	, SS_GENERIC_FIELD8_TXT  VARCHAR2 (4000)
	, SS_GENERIC_FIELD9_TXT  VARCHAR2 (4000)
	, SS_GENERIC_FIELD10_TXT VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);


DROP TABLE MAXDAT_LAEB.ERRLOG_SELECT_MISS_INFO_DETAIL CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_SELECT_MISS_INFO_DETAIL
	(
	  ORA_ERR_NUMBER$         NUMBER
	, ORA_ERR_MESG$           VARCHAR2 (2000)
	, ORA_ERR_ROWID$          UROWID
	, ORA_ERR_OPTYP$          VARCHAR2 (2)
	, ORA_ERR_TAG$            VARCHAR2 (2000)
	, MISSING_INFO_DETAILS_ID VARCHAR2 (4000)
	, MISSING_INFO_ID         VARCHAR2 (4000)
	, COMMENTS                VARCHAR2 (4000)
	, COMMENTS_FOR_CLIENT     VARCHAR2 (4000)
	, CREATE_TS               VARCHAR2 (4000)
	, CREATED_BY              VARCHAR2 (4000)
	, UPDATE_TS               VARCHAR2 (4000)
	, UPDATED_BY              VARCHAR2 (4000)
	, MISSING_INFO_TYPE_CD    VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);

DROP TABLE MAXDAT_LAEB.ERRLOG_NETWORK CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_NETWORK
	(
	  ORA_ERR_NUMBER$               NUMBER
	, ORA_ERR_MESG$                 VARCHAR2 (2000)
	, ORA_ERR_ROWID$                UROWID
	, ORA_ERR_OPTYP$                VARCHAR2 (2)
	, ORA_ERR_TAG$                  VARCHAR2 (2000)
	, NETWORK_ID                    VARCHAR2 (4000)
	, PROVIDER_ID                   VARCHAR2 (4000)
	, PLAN_ID                       VARCHAR2 (4000)
	, FIRST_NAME                    VARCHAR2 (4000)
	, FIRST_NAME_CANNON             VARCHAR2 (4000)
	, FIRST_NAME_SOUNDLIKE          VARCHAR2 (4000)
	, LAST_NAME                     VARCHAR2 (4000)
	, LAST_NAME_SOUNDLIKE           VARCHAR2 (4000)
	, LAST_NAME_CANNON              VARCHAR2 (4000)
	, MIDDLE_NAME                   VARCHAR2 (4000)
	, OFFICE_ADDR_1                 VARCHAR2 (4000)
	, OFFICE_ADDR_2                 VARCHAR2 (4000)
	, OFFICE_CITY                   VARCHAR2 (4000)
	, OFFICE_STATE                  VARCHAR2 (4000)
	, OFFICE_ZIP                    VARCHAR2 (4000)
	, OFFICE_COUNTY                 VARCHAR2 (4000)
	, OFFICE_PHONE                  VARCHAR2 (4000)
	, OFFICE_FAX                    VARCHAR2 (4000)
	, OFFICE_EMAIL                  VARCHAR2 (4000)
	, AGE_LOW_LIMIT                 VARCHAR2 (4000)
	, AGE_HIGH_LIMIT                VARCHAR2 (4000)
	, MEDICAID_ID_EXT               VARCHAR2 (4000)
	, WHEEL_CHAIR_ACCESSIBLE_IND    VARCHAR2 (4000)
	, PCP_IND                       VARCHAR2 (4000)
	, ACCEPTING_NEW_CLIENTS_MCO_IND VARCHAR2 (4000)
	, ACCEPTING_NEW_CLIENTS_PCP_IND VARCHAR2 (4000)
	, SEX_LIMITS_CD                 VARCHAR2 (4000)
	, PROVIDER_GENDER_CD            VARCHAR2 (4000)
	, CREATE_TS                     VARCHAR2 (4000)
	, CREATED_BY                    VARCHAR2 (4000)
	, UPDATE_TS                     VARCHAR2 (4000)
	, UPDATED_BY                    VARCHAR2 (4000)
	, LICENSE_NUMBER                VARCHAR2 (4000)
	, START_DATE                    VARCHAR2 (4000)
	, MULTIPLE_LOCATIONS_IND        VARCHAR2 (4000)
	, SITENAME                      VARCHAR2 (4000)
	, SITENAME_SOUNDLIKE            VARCHAR2 (4000)
	, SITENAME_CANNON               VARCHAR2 (4000)
	, FQHC_STATUS_IND               VARCHAR2 (4000)
	, NETWORK_ID_EXT                VARCHAR2 (4000)
	, PLAN_ID_EXT                   VARCHAR2 (4000)
	, PROVIDER_ID_EXT               VARCHAR2 (4000)
	, FILE_ID_EXT                   VARCHAR2 (4000)
	, STATUS_CD                     VARCHAR2 (4000)
	, ACCEPTS_OBSTETRICS_IND        VARCHAR2 (4000)
	, WOMEN_ONLY_IND                VARCHAR2 (4000)
	, ADMIT_PRIVILEGES_IND          VARCHAR2 (4000)
	, DELIVERY_PRIVILEGES_IND       VARCHAR2 (4000)
	, EFFECTIVE_DT                  VARCHAR2 (4000)
	, END_DT                        VARCHAR2 (4000)
	, LOCATION_CD                   VARCHAR2 (4000)
	, EXTERNAL_GROUP_ID             VARCHAR2 (4000)
	, PROGRAM_TYPE_CD               VARCHAR2 (4000)
	, ACCEPTING_NEW_CLIENTS_PCP_CD  VARCHAR2 (4000)
	, ACCEPTING_NEW_CLIENTS_MCO_CD  VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD1_DATE   VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD2_DATE   VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD3_NUM    VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD4_NUM    VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD5_TXT    VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD6_TXT    VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD7_TXT    VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD8_TXT    VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD9_TXT    VARCHAR2 (4000)
	, NETWORK_GENERIC_FIELD10_TXT   VARCHAR2 (4000)
	, NETWORK_GENERIC_REF11_ID      VARCHAR2 (4000)
	, NETWORK_GENERIC_REF12_ID      VARCHAR2 (4000)
	, RAW_ADDRESS_ID                VARCHAR2 (4000)
	, NORM_ADDRESS_ID               VARCHAR2 (4000)
	, ADDR_UPDATED_BY               VARCHAR2 (4000)
	, ADDR_UPDATE_TS                VARCHAR2 (4000)
	, HASH_NUM                      VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);

DROP TABLE MAXDAT_LAEB.ERRLOG_PROVIDER CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_PROVIDER
	(
	  ORA_ERR_NUMBER$              NUMBER
	, ORA_ERR_MESG$                VARCHAR2 (2000)
	, ORA_ERR_ROWID$               UROWID
	, ORA_ERR_OPTYP$               VARCHAR2 (2)
	, ORA_ERR_TAG$                 VARCHAR2 (2000)
	, PROVIDER_ID                  VARCHAR2 (4000)
	, PROVIDER_ID_EXT              VARCHAR2 (4000)
	, DEA_ID_EXT                   VARCHAR2 (4000)
	, NPI_ID_EXT                   VARCHAR2 (4000)
	, STATUS_CD                    VARCHAR2 (4000)
	, DBA_NAME                     VARCHAR2 (4000)
	, TAX_NAME                     VARCHAR2 (4000)
	, FIRST_NAME_CANNON            VARCHAR2 (4000)
	, FIRST_NAME_SOUNDLIKE         VARCHAR2 (4000)
	, TITLE                        VARCHAR2 (4000)
	, FIRST_NAME                   VARCHAR2 (4000)
	, LAST_NAME                    VARCHAR2 (4000)
	, MIDDLE_NAME                  VARCHAR2 (4000)
	, NAME_SUFFIX                  VARCHAR2 (4000)
	, SSN                          VARCHAR2 (4000)
	, PCP_IND                      VARCHAR2 (4000)
	, PROV_ENRL_CNT_STATE          VARCHAR2 (4000)
	, CREATE_TS                    VARCHAR2 (4000)
	, CREATED_BY                   VARCHAR2 (4000)
	, UPDATE_TS                    VARCHAR2 (4000)
	, UPDATED_BY                   VARCHAR2 (4000)
	, PHONE                        VARCHAR2 (4000)
	, FAX                          VARCHAR2 (4000)
	, EMAIL                        VARCHAR2 (4000)
	, NPI_TYPE_CD                  VARCHAR2 (4000)
	, LAST_NAME_CANNON             VARCHAR2 (4000)
	, LAST_NAME_SOUNDLIKE          VARCHAR2 (4000)
	, LICENSE_NUMBER               VARCHAR2 (4000)
	, PROVIDER_GENDER_CD           VARCHAR2 (4000)
	, OUT_OF_STATE_IND             VARCHAR2 (4000)
	, MEDICAID_IND                 VARCHAR2 (4000)
	, TYPE_CD                      VARCHAR2 (4000)
	, CLASSIFICATION_CD            VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD1_DATE VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD2_DATE VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD3_NUM  VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD4_NUM  VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD5_TXT  VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD6_TXT  VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD7_TXT  VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD8_TXT  VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD9_TXT  VARCHAR2 (4000)
	, PROVIDER_GENERIC_FIELD10_TXT VARCHAR2 (4000)
	, PROVIDER_GENERIC_REF11_ID    VARCHAR2 (4000)
	, PROVIDER_GENERIC_REF12_ID    VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);


DROP TABLE MAXDAT_LAEB.ERRLOG_NETWORK_LANGUAGE CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_NETWORK_LANGUAGE
	(
	  ORA_ERR_NUMBER$     NUMBER
	, ORA_ERR_MESG$       VARCHAR2 (2000)
	, ORA_ERR_ROWID$      UROWID
	, ORA_ERR_OPTYP$      VARCHAR2 (2)
	, ORA_ERR_TAG$        VARCHAR2 (2000)
	, NETWORK_ID          VARCHAR2 (4000)
	, LANGUAGE_TYPE_CD    VARCHAR2 (4000)
	, PROVIDER_SPEAKS_IND VARCHAR2 (4000)
	, CREATE_TS           VARCHAR2 (4000)
	, CREATED_BY          VARCHAR2 (4000)
	, UPDATE_TS           VARCHAR2 (4000)
	, UPDATED_BY          VARCHAR2 (4000)
	, LANGUAGE_EXT_CD     VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);

DROP TABLE MAXDAT_LAEB.ERRLOG_PANEL_LIMIT CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_PANEL_LIMIT
	(
	  ORA_ERR_NUMBER$ NUMBER
	, ORA_ERR_MESG$   VARCHAR2 (2000)
	, ORA_ERR_ROWID$  UROWID
	, ORA_ERR_OPTYP$  VARCHAR2 (2)
	, ORA_ERR_TAG$    VARCHAR2 (2000)
	, PANEL_LIMIT_ID  VARCHAR2 (4000)
	, NETWORK_ID      VARCHAR2 (4000)
	, PROVIDER_ID     VARCHAR2 (4000)
	, PANEL_SIZE      VARCHAR2 (4000)
	, ENROLLED_COUNT  VARCHAR2 (4000)
	, HOLD_CD         VARCHAR2 (4000)
	, CREATE_TS       VARCHAR2 (4000)
	, CREATED_BY      VARCHAR2 (4000)
	, UPDATE_TS       VARCHAR2 (4000)
	, UPDATED_BY      VARCHAR2 (4000)
	, TYPE_CD         VARCHAR2 (4000)
	, PLAN_ID         VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);


DROP TABLE MAXDAT_LAEB.ERRLOG_NETWORK_OFFICE_HOURS CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_NETWORK_OFFICE_HOURS
	(
	  ORA_ERR_NUMBER$         NUMBER
	, ORA_ERR_MESG$           VARCHAR2 (2000)
	, ORA_ERR_ROWID$          UROWID
	, ORA_ERR_OPTYP$          VARCHAR2 (2)
	, ORA_ERR_TAG$            VARCHAR2 (2000)
	, NETWORK_OFFICE_HOURS_ID VARCHAR2 (4000)
	, DAY_OF_WEEK             VARCHAR2 (4000)
	, OPEN_FROM               VARCHAR2 (4000)
	, CLOSE_AT                VARCHAR2 (4000)
	, CREATED_BY              VARCHAR2 (4000)
	, CREATE_TS               VARCHAR2 (4000)
	, UPDATED_BY              VARCHAR2 (4000)
	, UPDATE_TS               VARCHAR2 (4000)
	, NETWORK_ID              VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);


DROP TABLE MAXDAT_LAEB.ERRLOG_SELECTN_TXN_STAT_HIST CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_SELECTN_TXN_STAT_HIST
	(
	  ORA_ERR_NUMBER$              NUMBER
	, ORA_ERR_MESG$                VARCHAR2 (2000)
	, ORA_ERR_ROWID$               UROWID
	, ORA_ERR_OPTYP$               VARCHAR2 (2)
	, ORA_ERR_TAG$                 VARCHAR2 (2000)
	, SELECTION_TXN_STATUS_HIST_ID VARCHAR2 (4000)
	, SELECTION_TXN_ID             VARCHAR2 (4000)
	, STATUS_CD                    VARCHAR2 (4000)
	, CREATED_BY                   VARCHAR2 (4000)
	, CREATE_TS                    VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);


DROP TABLE MAXDAT_LAEB.ERRLOG_NETWORK_SPECIALTY CASCADE CONSTRAINTS;

CREATE TABLE MAXDAT_LAEB.ERRLOG_NETWORK_SPECIALTY
	(
	  ORA_ERR_NUMBER$   NUMBER
	, ORA_ERR_MESG$     VARCHAR2 (2000)
	, ORA_ERR_ROWID$    UROWID
	, ORA_ERR_OPTYP$    VARCHAR2 (2)
	, ORA_ERR_TAG$      VARCHAR2 (2000)
	, NETWORK_ID        VARCHAR2 (4000)
	, SPECIALTY_TYPE_CD VARCHAR2 (4000)
	, CREATE_TS         VARCHAR2 (4000)
	, CREATED_BY        VARCHAR2 (4000)
	, UPDATE_TS         VARCHAR2 (4000)
	, UPDATED_BY        VARCHAR2 (4000)
	, SPECIALTY_EXT_CD  VARCHAR2 (4000)
	)
	TABLESPACE MAXDAT_LAEB_DATA
	STORAGE (BUFFER_POOL DEFAULT);

GRANT SELECT ON MAXDAT_LAEB.ERRLOG_NETWORK_SPECIALTY TO MAXDAT_LAEB_READ_ONLY;
