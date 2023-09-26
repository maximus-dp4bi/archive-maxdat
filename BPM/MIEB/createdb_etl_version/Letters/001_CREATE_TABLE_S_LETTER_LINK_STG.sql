CREATE TABLE S_LETTER_LINK_STG 
(
  LMLINK_ID NUMBER(18, 0) 
, LETTER_REQUEST_ID NUMBER(18, 0) 
, REFERENCE_TYPE VARCHAR2(40 BYTE) 
, REFERENCE_ID NUMBER(18, 0) 
, CREATED_BY VARCHAR2(80 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE 
, ADDITIONAL_REFERENCE_TYPE VARCHAR2(30 BYTE) 
, ADDITIONAL_REFERENCE_ID NUMBER(18, 0) 
, CLIENT_ID NUMBER(18, 0) 
, CLIENT_ENROLL_STATUS_ID NUMBER(18, 0) 
) 
TABLESPACE MAXDAT_MIEB_DATA;

CREATE UNIQUE INDEX S_LETTER_LINK_STG_PK ON S_LETTER_LINK_STG (LMLINK_ID ASC) TABLESPACE MAXDAT_MIEB_DATA;
ALTER TABLE S_LETTER_LINK_STG ADD CONSTRAINT S_LETTER_LINK_STG_PK PRIMARY KEY (LMLINK_ID) USING INDEX S_LETTER_LINK_STG_PK ENABLE;

GRANT SELECT ON S_LETTER_LINK_STG TO MAXDAT_MIEB_READ_ONLY;