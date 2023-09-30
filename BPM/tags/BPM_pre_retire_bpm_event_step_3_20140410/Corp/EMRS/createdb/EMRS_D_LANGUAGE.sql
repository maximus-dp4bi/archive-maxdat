--------------------------------------------------------
--  DDL for Table EMRS_D_LANGUAGE
--------------------------------------------------------

  CREATE TABLE "EMRS_D_LANGUAGE" 
   (	"LANGUAGE_CODE_ID" NUMBER(*,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(30), 
	"LANGUAGE_CODE" VARCHAR2(32), 
	"LANGUAGE" VARCHAR2(240), 
	"BUSINESS_START_DATE" DATE, 
	"BUSINESS_END_DATE" DATE, 
	"SOURCE_RECORD_ID" VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_LANGUAGE"."LANGUAGE_CODE_ID" IS 'Language Code ID (PK)';
   COMMENT ON COLUMN "EMRS_D_LANGUAGE"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program';
   COMMENT ON COLUMN "EMRS_D_LANGUAGE"."LANGUAGE_CODE" IS 'Language Code';
   COMMENT ON COLUMN "EMRS_D_LANGUAGE"."LANGUAGE" IS 'Language';
   COMMENT ON COLUMN "EMRS_D_LANGUAGE"."BUSINESS_START_DATE" IS 'Business Start Date (Business begins using this Language)';
   COMMENT ON COLUMN "EMRS_D_LANGUAGE"."BUSINESS_END_DATE" IS 'Business End Date (Business stops using this Language)';
   COMMENT ON COLUMN "EMRS_D_LANGUAGE"."SOURCE_RECORD_ID" IS 'Source-System Primary-Key Record ID #';
