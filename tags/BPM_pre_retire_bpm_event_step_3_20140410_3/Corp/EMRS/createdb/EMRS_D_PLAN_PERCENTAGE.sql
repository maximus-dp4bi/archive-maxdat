--------------------------------------------------------
--  DDL for Table EMRS_D_PLAN_PERCENTAGE
--------------------------------------------------------

  CREATE TABLE "EMRS_D_PLAN_PERCENTAGE" 
   (	"PLAN_PERCENTAGE_ID" NUMBER(38,0), 
	"SOURCE_RECORD_ID" NUMBER(38,0), 
	"YEAR_MONTH" VARCHAR2(10), 
	"PLAN_TYPE_ID" NUMBER(38,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(30), 
	"SERVICE_AREA" VARCHAR2(30), 
	"SOURCE_PLAN_ID" NUMBER(38,0), 
	"PERCENTAGE" NUMBER(38,4), 
	"RECORD_DATE" DATE, 
	"RECORD_TIME" VARCHAR2(6), 
	"RECORD_NAME" VARCHAR2(240), 
	"MODIFIED_DATE" DATE, 
	"MODIFIED_TIME" VARCHAR2(6), 
	"MODIFIED_NAME" VARCHAR2(240), 
	"DATE_CREATED" DATE, 
	"CREATED_BY" VARCHAR2(18), 
	"DATE_UPDATED" DATE, 
	"UPDATED_BY" VARCHAR2(18)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;
