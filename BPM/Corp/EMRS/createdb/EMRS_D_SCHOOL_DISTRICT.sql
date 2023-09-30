--------------------------------------------------------
--  DDL for Table EMRS_D_SCHOOL_DISTRICT
--------------------------------------------------------

  CREATE TABLE "EMRS_D_SCHOOL_DISTRICT" 
   (	"SCHOOL_DISTRICT_ID" NUMBER(*,0), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(30), 
	"REGION_NAME" VARCHAR2(30), 
	"COUNTY_NAME" VARCHAR2(30), 
	"DISTRICT_TYPE" VARCHAR2(20), 
	"DISTRICT_NAME" VARCHAR2(100), 
	"SCHOOL_NAME" VARCHAR2(50), 
	"SR_FIPS_COUNTY_NBR" NUMBER(*,0), 
	"SR_REGION_ID" NUMBER(*,0), 
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

   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."SCHOOL_DISTRICT_ID" IS 'School District ID (PK)';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."MANAGED_CARE_PROGRAM" IS 'Managed Care Program';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."REGION_NAME" IS 'Region Name';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."COUNTY_NAME" IS 'County Name';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."DISTRICT_TYPE" IS 'District Type';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."DISTRICT_NAME" IS 'District Name';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."SR_FIPS_COUNTY_NBR" IS 'Source-System County ID';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."SR_REGION_ID" IS 'Source-System Region ID';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."SOURCE_RECORD_ID" IS 'Source-System SCHID Record ID #';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."VERSION" IS 'Type-2 SCD Version Number';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."DATE_OF_VALIDITY_START" IS 'ETL Required Column to Designate the Start-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."DATE_OF_VALIDITY_END" IS 'ETL Required Column to Designate the End-Date for a Valid Slowly Changing Dimension (SCD) Record';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."CREATED_BY" IS 'Warehouse Load Created By';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."DATE_CREATED" IS 'Warehouse Load Creation Date';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."UPDATED_BY" IS 'Warehouse Load Updated By';
   COMMENT ON COLUMN "EMRS_D_SCHOOL_DISTRICT"."DATE_UPDATED" IS 'Warehouse Load Date Updated';