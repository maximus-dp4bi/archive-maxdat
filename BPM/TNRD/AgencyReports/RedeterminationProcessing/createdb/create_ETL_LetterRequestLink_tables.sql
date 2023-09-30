
CREATE TABLE LETTER_REQUEST_LINK_STG
(
  LMLINK_ID NUMBER(18, 0) NOT NULL 
, REFERENCE_TYPE VARCHAR2(40 BYTE) 
, REFERENCE_ID NUMBER(18, 0) 
, CREATED_BY VARCHAR2(80 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, LMREQ_ID NUMBER(18, 0) 
, UPDATE_TS DATE 
, ADDITIONAL_REFERENCE_TYPE VARCHAR2(30 BYTE) 
, ADDITIONAL_REFERENCE_ID NUMBER(18, 0) 
, CLIENT_ID NUMBER(18, 0) 
, CLIENT_ENROLL_STATUS_ID NUMBER(18, 0) 
) 
TABLESPACE MAXDAT_DATA;

COMMENT ON TABLE LETTER_REQUEST_LINK_STG IS 'This table stores the letter request details i.e. Clients, selections, etc';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.LMLINK_ID IS 'PK';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.REFERENCE_TYPE IS 'Name of table that is referred';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.REFERENCE_ID IS 'PK of the record in the table indicated by ''REFERENCE_TYPE''';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.CREATED_BY IS 'Contains the username or component which originally created the record';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.CREATE_TS IS 'Contains the timestamp of when the record was originally created';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.UPDATED_BY IS 'Contains the username or component which most recently updated the record';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.LMREQ_ID IS 'FK to LETTER_REQUEST';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.UPDATE_TS IS 'Contains the timestamp of when the record was updated';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.ADDITIONAL_REFERENCE_TYPE IS 'Name of additional table that is referred';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.ADDITIONAL_REFERENCE_ID IS 'PK of the record in the table indicated by ADDITIONAL_REFERENCE_TYPE';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.CLIENT_ID IS 'FK to CLIENT';
COMMENT ON COLUMN LETTER_REQUEST_LINK_STG.CLIENT_ENROLL_STATUS_ID IS 'FK to CLIENT_ENROLL_STATUS';

CREATE INDEX IDX__LETTER_LINK__LMREQ_ID ON LETTER_REQUEST_LINK_STG (LMREQ_ID ASC) TABLESPACE MAXDAT_INDX;

CREATE INDEX IDX__LETTER_LINK__OTHER ON LETTER_REQUEST_LINK_STG (LMREQ_ID ASC, CLIENT_ID ASC, CLIENT_ENROLL_STATUS_ID ASC) TABLESPACE MAXDAT_INDX;

CREATE INDEX LETTER_REQUEST_LINK_IDX5 ON LETTER_REQUEST_LINK_STG (CLIENT_ENROLL_STATUS_ID ASC) TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX LETTER_REQUEST_LINK_PK ON LETTER_REQUEST_LINK_STG (LMLINK_ID ASC)  TABLESPACE MAXDAT_INDX;

CREATE INDEX LETTER_REQ_LINK_IDX01 ON LETTER_REQUEST_LINK_STG (CLIENT_ID ASC) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON LETTER_REQUEST_LINK_STG to MAXDAT_READ_ONLY;