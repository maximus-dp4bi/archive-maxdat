--------------------------------------------------------
--  DDL for Table EMRS_D_RISK_GROUP
--------------------------------------------------------

  CREATE TABLE "EMRS_D_RISK_GROUP" 
   (	"RISK_GROUP_ID" NUMBER(*,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(30), 
	"RISK_GROUP" VARCHAR2(240), 
	"RISK_GROUP_CODE" VARCHAR2(32), 
	"SOURCE_RECORD_ID" NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_RISK_GROUP"."RISK_GROUP_ID" IS 'Risk Group ID (PK)';
   COMMENT ON COLUMN "EMRS_D_RISK_GROUP"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program';
   COMMENT ON COLUMN "EMRS_D_RISK_GROUP"."RISK_GROUP" IS 'Risk Group';
   COMMENT ON COLUMN "EMRS_D_RISK_GROUP"."RISK_GROUP_CODE" IS 'Risk Group Code';
