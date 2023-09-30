

CREATE TABLE D_CLIENT_ELIGIBILITY 
   (ELIG_SEGMENT_AND_DETAILS_ID	NUMBER,
    SEGMENT_TYPE_CD	VARCHAR2(32 BYTE),
    CLIENT_ID	NUMBER(18,0),
    ME_START_DATE	DATE,
    ME_END_DATE	DATE,
    ME_START_ND	NUMBER,
    ME_END_ND	NUMBER,
    AID_CATEGORY	VARCHAR2(32),
    TYPE_CASE	VARCHAR2(32),
    AC_TC	VARCHAR2(65),
    COA	VARCHAR2(8),
    PRIOR_START_DATE	DATE,
    PRIOR_END_DATE	DATE,
    PRIOR_COA	VARCHAR2(8),
    PRIOR_AC	VARCHAR2(32),
    PRIOR_TC	VARCHAR2(32),
    PRIOR_ESAD_ID	NUMBER,
    PREGNANCY_FLAG	NUMBER,
    CLOSE_REASON	VARCHAR2(32),
    SEQUENCE_ID	VARCHAR2(32),
    LAST_ACTIVITY	VARCHAR2(32),
    APPROVAL_CD	VARCHAR2(32),
    SEGMENT_CREATE_DATE	VARCHAR2(32),
    SEQUENCE_NUM	NUMBER,
    COMPARABLE_KEY	VARCHAR2(2000)
   ) TABLESPACE &tablespace_name;
   
grant select on D_CLIENT_ELIGIBILITY to &role_name;

CREATE INDEX CLNT_ELIG_CLNT_STRT_END_DATE ON D_CLIENT_ELIGIBILITY (CLIENT_ID ASC, ME_START_DATE DESC, ME_END_DATE DESC) TABLESPACE &tablespace_name;
CREATE INDEX CLNT_ELIG_CLNT_STRT_END_ND ON D_CLIENT_ELIGIBILITY (CLIENT_ID ASC, ME_START_ND DESC, ME_END_ND DESC) TABLESPACE &tablespace_name;

CREATE TABLE s_client_eligibility_stg(
segment_type_cd VARCHAR2(32),
client_id NUMBER(18,0),
aid_category VARCHAR2(32),
type_case VARCHAR2(32),
coa VARCHAR2(8),
sequence_id VARCHAR2(32),
elig_segment_and_details_id NUMBER(18,0),
me_start_date DATE,
me_end_date DATE,
me_start_nd NUMBER(8,0),
me_end_nd NUMBER(8,0),
close_reason VARCHAR2(32),
last_activity VARCHAR2(32),
approval_cd VARCHAR2(32),
segment_create_date VARCHAR2(32),
sequence_num NUMBER(8,0),
comparable_key VARCHAR2(2000)) TABLESPACE &tablespace_name;

GRANT SELECT ON s_client_eligibility_stg TO &role_name;

CREATE TABLE s_client_elig_prior_stg(
segment_type_cd VARCHAR2(32),
client_id NUMBER(18,0),
aid_category VARCHAR2(32),
type_case VARCHAR2(32),
coa VARCHAR2(8),
sequence_id VARCHAR2(32),
elig_segment_and_details_id NUMBER(18,0),
me_start_date DATE,
me_end_date DATE,
me_start_nd NUMBER(8,0),
me_end_nd NUMBER(8,0),
close_reason VARCHAR2(32),
last_activity VARCHAR2(32),
approval_cd VARCHAR2(32),
segment_create_date VARCHAR2(32),
sequence_num NUMBER(8,0),
comparable_key VARCHAR2(2000),
prior_start_date DATE,
prior_end_date DATE,
prior_coa VARCHAR2(8),
prior_ac VARCHAR2(32),
prior_tc VARCHAR2(32),
prior_esad_id NUMBER(18,0)) TABLESPACE &tablespace_name;

begin
     DBMS_ERRLOG.CREATE_ERROR_LOG ('D_CLIENT_ELIGIBILITY','ERRLOG_DCLIENTELIG');
end;
  /

GRANT SELECT ON s_client_elig_prior_stg TO &role_name;