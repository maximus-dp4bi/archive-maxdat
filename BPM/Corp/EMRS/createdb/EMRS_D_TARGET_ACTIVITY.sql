--------------------------------------------------------
--  DDL for Table EMRS_D_TARGET_ACTIVITY
--------------------------------------------------------

  CREATE TABLE "EMRS_D_TARGET_ACTIVITY" 
   (	"TARGET_ACTIVITY_ID" NUMBER(*,0), 
	"ACTIVITY_NAME" VARCHAR2(50), 
	"ACTIVITY_DATE" DATE, 
	"SR_COMM_TYPE_ID" NUMBER(*,0), 
	"SR_LANGUAGE_ID" NUMBER(*,0), 
	"SR_OBSERVATION_ID" NUMBER(*,0), 
	"SR_REGION_ID" NUMBER(*,0), 
	"SR_STAFF_ID" NUMBER(*,0), 
	"SOURCE_RECORD_ID" NUMBER(*,0), 
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

   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."TARGET_ACTIVITY_ID" IS 'Outreach Target Activity ID (PK)';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."ACTIVITY_NAME" IS 'Activity Name';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."ACTIVITY_DATE" IS 'Activity Date';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."SR_COMM_TYPE_ID" IS 'Source-System Communication TypeID';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."SR_LANGUAGE_ID" IS 'Source-System Language ID';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."SR_OBSERVATION_ID" IS 'Source-System Observation ID';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."SR_REGION_ID" IS 'Source-System Region ID';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."SR_STAFF_ID" IS 'Source-System Staff ID';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."SOURCE_RECORD_ID" IS 'Source-System Primary-Key Record ID #';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."VERSION" IS 'Type-2 SCD Version Number';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."DATE_OF_VALIDITY_START" IS 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."DATE_OF_VALIDITY_END" IS 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."CREATED_BY" IS 'Warehouse Load Created By';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."DATE_CREATED" IS 'Warehouse Load Creation Date';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."UPDATED_BY" IS 'Warehouse Load Updated By';
   COMMENT ON COLUMN "EMRS_D_TARGET_ACTIVITY"."DATE_UPDATED" IS 'Warehouse Load Date Updated';