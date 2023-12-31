--------------------------------------------------------
--  DDL for Table EMRS_D_COMMUNICATION_ACTION
--------------------------------------------------------

  CREATE TABLE "EMRS_D_COMMUNICATION_ACTION" 
   (	"COMMUNICATION_ACTION_ID" NUMBER(*,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(50), 
	"COMMUNICATION_ACTION_NAME" VARCHAR2(20), 
	"COMMUNICATION_ACTION_DESCRIPTI" VARCHAR2(100), 
	"VERSION" NUMBER(2,0), 
	"DATE_OF_VALIDITY_START" DATE, 
	"DATE_OF_VALIDITY_END" DATE, 
	"CREATED_BY" VARCHAR2(18), 
	"DATE_CREATED" DATE, 
	"UPDATED_BY" VARCHAR2(18), 
	"DATE_UPDATED" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."COMMUNICATION_ACTION_ID" IS 'Communication Action ID (PK)';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program that Uses This CSDA';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."COMMUNICATION_ACTION_NAME" IS 'Communication Action Name';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."COMMUNICATION_ACTION_DESCRIPTI" IS 'Communication Action Description';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."VERSION" IS 'Type-2 SCD Version Number';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."DATE_OF_VALIDITY_START" IS 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."DATE_OF_VALIDITY_END" IS 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."CREATED_BY" IS 'Warehouse Load Created By';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."DATE_CREATED" IS 'Warehouse Load Creation Date';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."UPDATED_BY" IS 'Warehouse Load Updated By';
   COMMENT ON COLUMN "EMRS_D_COMMUNICATION_ACTION"."DATE_UPDATED" IS 'Warehouse Load Date Updated';
