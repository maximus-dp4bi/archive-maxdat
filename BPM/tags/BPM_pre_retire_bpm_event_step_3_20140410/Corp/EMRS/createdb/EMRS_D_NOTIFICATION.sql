--------------------------------------------------------
--  DDL for Table EMRS_D_NOTIFICATION
--------------------------------------------------------

  CREATE TABLE "EMRS_D_NOTIFICATION" 
   (	"NOTIFICATION_ID" NUMBER(22,0), 
	"SEND_DATE" DATE, 
	"MAINTENANCE_TYPE_CD" VARCHAR2(32), 
	"MAINTENANCE_REASON" VARCHAR2(32), 
	"CREATED_BY" VARCHAR2(18), 
	"DATE_CREATED" DATE, 
	"SOURCE_RECORD_ID" NUMBER(22,0),
  "SOURCE_TABLE_NAME" VARCHAR2(40),
   "SELECTION_SEGMENT_ID" NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;