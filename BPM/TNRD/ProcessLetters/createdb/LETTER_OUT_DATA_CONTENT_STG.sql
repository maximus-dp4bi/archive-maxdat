CREATE TABLE "MAXDAT"."LETTER_OUT_DATA_CONTENT_STG" 
(
    LETTER_OUT_DATA_ID NUMBER NOT NULL 
,   LETTER_REQ_ID NUMBER 
,   DATEOFLETTER VARCHAR2(80 BYTE) 
,   RESPONDBYDATE VARCHAR2(80 BYTE)
,   COVERAGEENDDATEVALUE DATE 
,   DAY20APPEALDTBUSVALUE DATE
,   DAY40APPEALDTBUSVALUE DATE 
,   DAY40APPEALDTCALVALUE DATE 
,   EFFECTIVEDATEVALUE DATE 
,   MAGIMONTHLYINCOMEVALUE NUMBER 
,   MAGIMONTHLYTHRESHOLDCHIPVALUE NUMBER 
,   MAGIMONTHLYTHRESHOLDMEDVALUE NUMBER
,   MAGIMONTHLYTHRESHOLDQDWIVALUE NUMBER
,   MAGIMONTHLYTHRESHOLDQI1VALUE NUMBER
,   MAGIMONTHLYTHRESHOLDQMBVALUE NUMBER 
,   MAGIMONTHLYTHRESHOLDSLMBVALUE NUMBER 
,   MEDICAIDTERMDATEVALUE DATE 
,   OUTCOMEREASONCDVALUE VARCHAR2(80 BYTE) 
,   OUTCOMEREASONCDCHIPVALUE VARCHAR2(80 BYTE) 
,   OUTCOMEREASONCDMSPVALUE VARCHAR2(80 BYTE)
,   OUTCOMEREASONCDMSPONLYVALUE VARCHAR2(80 BYTE)
,   OUTCOMEREASONCDSTDVALUE VARCHAR2(80 BYTE) 
,   PROGRAMENDMEDVALUE VARCHAR2(1 BYTE) 
,   PROGRAMENDCHIPVALUE VARCHAR2(1 BYTE) 
,   RECIPIENTCHOICESINDVALUE VARCHAR2(1 BYTE)
,   SPENDDOWNAMOUNTVALUE NUMBER
,   ORIGDUEDATEVALUE DATE
,   JOB_ID NUMBER 
,   CREATE_TS DATE 
,   CREATED_BY VARCHAR2(80 BYTE) 
,   UPDATE_TS DATE 
,   UPDATED_BY VARCHAR2(80 BYTE) 
 ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE INDEX "MAXDAT"."IDX01_LETTER_OUT_DATA_CONTENT_STG" ON "MAXDAT"."LETTER_OUT_DATA_CONTENT_STG" ("LETTER_REQ_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;



