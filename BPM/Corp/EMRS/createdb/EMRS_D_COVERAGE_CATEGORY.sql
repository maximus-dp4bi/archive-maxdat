--------------------------------------------------------
--  DDL for Table EMRS_D_COVERAGE_CATEGORY
--------------------------------------------------------

  CREATE TABLE "EMRS_D_COVERAGE_CATEGORY" 
   (	"COVERAGE_CATEGORY_ID" NUMBER(*,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(30), 
	"COVERAGE_CATEGORY_TYPE" VARCHAR2(30), 
	"COVERAGE_CATEGORY_CODE" VARCHAR2(32), 
	"COVERAGE_CATEGORY" VARCHAR2(240), 
	"SOURCE_RECORD_ID" NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_COVERAGE_CATEGORY"."COVERAGE_CATEGORY_ID" IS 'Coverage Category ID (PK)';
   COMMENT ON COLUMN "EMRS_D_COVERAGE_CATEGORY"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program';
   COMMENT ON COLUMN "EMRS_D_COVERAGE_CATEGORY"."COVERAGE_CATEGORY_TYPE" IS 'Coverage Category Type';
   COMMENT ON COLUMN "EMRS_D_COVERAGE_CATEGORY"."COVERAGE_CATEGORY_CODE" IS 'Coverage Category Code';
   COMMENT ON COLUMN "EMRS_D_COVERAGE_CATEGORY"."COVERAGE_CATEGORY" IS 'Coverage Category';
