--------------------------------------------------------
--  File created - Thursday-May-15-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table LM_LETTER_REQUESTS_TEMP
--------------------------------------------------------

  CREATE TABLE "LM_LETTER_REQUESTS_TEMP" (
  "LMREQ_ID" NUMBER(38,0),
  "LMDEF_ID" NUMBER(38,0),
  "REQUESTED_ON" DATE,
  "STATUS" VARCHAR2(100),
  "STATUS_DATE" DATE,
  "DRIVER_PRIMARY_KEY" VARCHAR2(38),
  "BATCH_ID" NUMBER,
  "RPT_REG_LMREQ_ID" NUMBER,
  "SOURCE" VARCHAR2(80),
  "USERNAME" VARCHAR2(80),
  "XML_DATA" CLOB,
  "TRIGGERING_METHOD" VARCHAR2(3),
  "TEMPLATE_VERSION" NUMBER,
  "INSERT_DATE" DATE DEFAULT SYSDATE,
  "INSERT_USER" VARCHAR2(100 CHAR),
  "UPDATE_DATE" DATE,
  "LAST_UPDATE_USER" VARCHAR2(100 CHAR),
  "INSERT_USER_ROLE" VARCHAR2(100 CHAR),
  "UPDATE_USER_ROLE" VARCHAR2(100 CHAR),
  "INSERT_JOB_NAME" VARCHAR2(100 CHAR),
  "LAST_UPDATE_JOB_NAME" VARCHAR2(100 CHAR));
/
--------------------------------------------------------
--  DDL for Index REQ_LMREQ_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "REQ_LMREQ_ID_PK" ON "LM_LETTER_REQUESTS_TEMP" ("LMREQ_ID") ;
/
--------------------------------------------------------
--  DDL for Index IDX_LMLR_DEF_ID
--------------------------------------------------------

  CREATE INDEX "IDX_LMLR_DEF_ID" ON "LM_LETTER_REQUESTS_TEMP" ("LMDEF_ID") ;
/
--------------------------------------------------------
--  DDL for Index IDX_LM_LETTERS_TEMP_STATUSDATE
--------------------------------------------------------

  CREATE INDEX "IDX_LM_LETTERS_TEMP_STATUSDATE" ON "LM_LETTER_REQUESTS_TEMP" ("STATUS_DATE") ;
/
--------------------------------------------------------
--  DDL for Index IDX_LM_LETTER_TEMP_DKEY
--------------------------------------------------------

  CREATE INDEX "IDX_LM_LETTER_TEMP_DKEY" ON "LM_LETTER_REQUESTS_TEMP" ("DRIVER_PRIMARY_KEY") ;
/
--------------------------------------------------------
--  DDL for Index IDX_LM_LETTER_TEMP_STATUS
--------------------------------------------------------

  CREATE INDEX "IDX_LM_LETTER_TEMP_STATUS" ON "LM_LETTER_REQUESTS_TEMP" ("STATUS") ;
/
