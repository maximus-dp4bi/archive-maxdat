CREATE TABLE CASES_STG 
(
  CASE_ID NUMBER(18, 0) NOT NULL 
, CASE_CIN VARCHAR2(30 BYTE) 
, CONSTRAINT XPKCASE PRIMARY KEY 
  (
    CASE_ID 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE MAXDAT_DATA 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS;

CREATE INDEX IDX3_CASE_CIN ON MAXDAT.CASES_STG (CASE_CIN ASC) 
LOGGING 
TABLESPACE MAXDAT_INDX 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
);