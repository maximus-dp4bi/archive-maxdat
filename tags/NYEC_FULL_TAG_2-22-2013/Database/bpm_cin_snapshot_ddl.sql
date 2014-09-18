
PROMPT Creating Table 'BPM_CIN_SNAPSHOT'
CREATE TABLE BPM_CIN_SNAPSHOT
(CLNT_CLIENT_ID NUMBER(18) NOT NULL,
CLNT_CIN  VARCHAR2(30),
APP_PROV_LINK_END_TS DATE,
OFFICE_PHONE varchar(20),
OFFICE_FAX varchar(20),
CLNT_DOB DATE,
CLNT_LNAME VARCHAR2(40),
CLNT_FNAME VARCHAR2(25),
OFFICE_NAME VARCHAR2(80),
APPLICATION_ID NUMBER(18),
STATUS_CD VARCHAR2(32),
SNAPSHOT_DATE DATE not null,
DOC_TYPE varchar2(4))
/

COMMENT ON TABLE BPM_CIN_SNAPSHOT IS 'Used for NYEC Provider Notification report for FPBP to determine new and updated CIN for FPBP applicants'
/

PROMPT Creating Synonym 'BPM_CIN_SNAPSHOT' 
CREATE PUBLIC SYNONYM BPM_CIN_SNAPSHOT FOR BPM_CIN_SNAPSHOT
/

PROMPT Creating index 'snapshot_date_idx'
CREATE INDEX snapshot_date_idx ON
  BPM_CIN_SNAPSHOT (clnt_client_id, office_name)
  TABLESPACE MAXDAT_INDX
/

PROMPT Creating index 'app_prov_link_end_ts_idx'
CREATE INDEX app_prov_link_end_ts_idx ON
  BPM_CIN_SNAPSHOT (clnt_cin, office_name, application_id)
  TABLESPACE MAXDAT_INDX
/
PROMPT Creating index 'application_id_idx'
CREATE INDEX application_id_idx ON
  BPM_CIN_SNAPSHOT (APPLICATION_ID)
  TABLESPACE MAXDAT_INDX
/

PROMPT Creating index 'status_cd_idx'
CREATE INDEX status_cd_idx ON
  BPM_CIN_SNAPSHOT (STATUS_CD )
  TABLESPACE MAXDAT_INDX
/