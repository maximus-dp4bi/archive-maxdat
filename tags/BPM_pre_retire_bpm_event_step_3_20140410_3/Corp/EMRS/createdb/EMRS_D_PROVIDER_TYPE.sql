--------------------------------------------------------
--  DDL for Table EMRS_D_PROVIDER_TYPE
--------------------------------------------------------

  CREATE TABLE "EMRS_D_PROVIDER_TYPE" 
   (	"PROVIDER_TYPE_ID" NUMBER(*,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(50), 
	"PROVIDER_NAME" VARCHAR2(240), 
	"PROVIDER_CODE" VARCHAR2(32), 
	"VALID" VARCHAR2(1), 
	"INVALID" VARCHAR2(1), 
	"SOURCE_RECORD_ID" NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_PROVIDER_TYPE"."PROVIDER_TYPE_ID" IS 'Provider Type ID (PK)';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_TYPE"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program that Uses This CSDA';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_TYPE"."PROVIDER_NAME" IS 'Provider Name';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_TYPE"."PROVIDER_CODE" IS 'Provider Code';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_TYPE"."VALID" IS 'Provider is Valid';
   COMMENT ON COLUMN "EMRS_D_PROVIDER_TYPE"."INVALID" IS 'Provider is Invalid';
