--------------------------------------------------------
--  DDL for Table EMRS_D_RACE
--------------------------------------------------------

  CREATE TABLE "EMRS_D_RACE" 
   (	"RACE_ID" NUMBER(*,0), 
	"RACE_CODE" VARCHAR2(32), 
	"RACE_DESCRIPTION" VARCHAR2(240), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(50), 
	"SOURCE_RECORD_ID" NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_RACE"."RACE_ID" IS 'Race ID (SK)';
   COMMENT ON COLUMN "EMRS_D_RACE"."RACE_CODE" IS 'Race Code Number';
   COMMENT ON COLUMN "EMRS_D_RACE"."RACE_DESCRIPTION" IS 'Race Description';
   COMMENT ON COLUMN "EMRS_D_RACE"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program that Uses This Race Code;Description';