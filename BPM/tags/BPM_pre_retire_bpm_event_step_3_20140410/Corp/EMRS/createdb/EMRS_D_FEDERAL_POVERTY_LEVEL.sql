--------------------------------------------------------
--  DDL for Table EMRS_D_FEDERAL_POVERTY_LEVEL
--------------------------------------------------------

  CREATE TABLE "EMRS_D_FEDERAL_POVERTY_LEVEL" 
   (	"FPL_ID" NUMBER(*,0), 
	"FPL_YEAR" DATE, 
	"FPL_LOCALE" VARCHAR2(100), 
	"FPL_NUMBER_IN_FAMILY" NUMBER(3,0), 
	"FPL_MAX_DOLLARS" NUMBER(6,0), 
	"FPL_DESCRIPTION" VARCHAR2(100), 
	"SOURCE_RECORD_ID" NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_FEDERAL_POVERTY_LEVEL"."FPL_ID" IS ' Federal Poverty Level ID (PK)';
   COMMENT ON COLUMN "EMRS_D_FEDERAL_POVERTY_LEVEL"."FPL_YEAR" IS ' Federal Poverty Level Effective Year';
   COMMENT ON COLUMN "EMRS_D_FEDERAL_POVERTY_LEVEL"."FPL_LOCALE" IS ' Federal Poverty Level Locale';
   COMMENT ON COLUMN "EMRS_D_FEDERAL_POVERTY_LEVEL"."FPL_NUMBER_IN_FAMILY" IS ' Federal Poverty Level Number of Family Members';
   COMMENT ON COLUMN "EMRS_D_FEDERAL_POVERTY_LEVEL"."FPL_MAX_DOLLARS" IS ' Federal Poverty Level Maximum Dollar Income';
   COMMENT ON COLUMN "EMRS_D_FEDERAL_POVERTY_LEVEL"."FPL_DESCRIPTION" IS ' Federal Poverty Level Description';
