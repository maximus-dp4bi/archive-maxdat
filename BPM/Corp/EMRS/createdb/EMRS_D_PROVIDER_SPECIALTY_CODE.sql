--------------------------------------------------------
--  DDL for Table EMRS_D_PROVIDER_SPECIALTY_CODE
--------------------------------------------------------

  CREATE TABLE "EMRS_D_PROVIDER_SPECIALTY_CODE" 
   (	"PROVIDER_SPECIALTY_CODE_ID" NUMBER(*,0), 
	"PROVIDER_SPECIALTY_CODE" VARCHAR2(32), 
	"PROVIDER_SPECIALTY" VARCHAR2(240), 
	"VALID_PCP" VARCHAR2(1), 
	"INVALID_PCP" VARCHAR2(1), 
	"SPECIAL_NEEDS" VARCHAR2(1), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(30), 
	"SOURCE_RECORD_ID" NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_PROVIDER_SPECIALTY_CODE"."PROVIDER_SPECIALTY_CODE_ID" IS 'Provider Specialty Code ID (PK)';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_SPECIALTY_CODE"."PROVIDER_SPECIALTY_CODE" IS 'Provider Specialty Code';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_SPECIALTY_CODE"."PROVIDER_SPECIALTY" IS 'Provider Specialty';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_SPECIALTY_CODE"."VALID_PCP" IS 'Valid PCP Provider';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_SPECIALTY_CODE"."INVALID_PCP" IS 'Invalid PCP Provider';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_SPECIALTY_CODE"."SPECIAL_NEEDS" IS 'Special Needs Provider';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_SPECIALTY_CODE"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program';
