--------------------------------------------------------
--  DDL for Table EMRS_D_CLIENT_PLAN_ENRL_STATUS
--------------------------------------------------------

  CREATE TABLE "EMRS_D_CLIENT_PLAN_ENRL_STATUS" 
   (	"CLIENT_ENROLL_STATUS_ID" NUMBER(*,0), 
	"CLIENT_NUMBER" NUMBER(*,0), 
	"PLAN_TYPE_ID" NUMBER(*,0), 
	"ENROLLMENT_STATUS_ID" NUMBER(*,0), 
	"CURRENT_ENROLLMENT_STATUS_ID" NUMBER(*,0), 
	"CREATED_BY" VARCHAR2(30), 
	"DATE_CREATED" DATE, 
	"DATE_OF_VALIDITY_START" DATE, 
	"DATE_OF_VALIDITY_END" DATE, 
	"DATE_UPDATED" DATE, 
	"UPDATED_BY" VARCHAR2(30), 
	"CURRENT_FLAG" VARCHAR2(1), 
	"VERSION" NUMBER(*,0), 
	"SOURCE_RECORD_ID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;