--------------------------------------------------------
--  DDL for Table EMRS_S_OUTREACH_FACTS
--------------------------------------------------------

  CREATE TABLE "EMRS_S_OUTREACH_FACTS" 
   (	"ACTIVITY_ID" NUMBER(*,0), 
	"ACTIVITY_NAME" VARCHAR2(50), 
	"ACTIVITY_DATE" DATE, 
	"ACTIVITY_CATEGORY" VARCHAR2(10), 
	"ACTIVITY_TYPE" VARCHAR2(2000), 
	"COUNTY_NAME" VARCHAR2(30), 
	"CSDA_CODE" VARCHAR2(10), 
	"DOOR_PRIZE_VALUE" NUMBER(10,2), 
	"FEE_AMOUNT" NUMBER(10,2), 
	"NBR_KITS_PROVIDED" NUMBER(*,0), 
	"NBR_RECIPIENT_ATTENDEES" NUMBER(*,0), 
	"NBR_STAFF_ATTENDEES" NUMBER(*,0), 
	"STAFF_FIRST" VARCHAR2(25), 
	"ST_CNTY_NUM" NUMBER(10,0), 
	"ACTIVITY_ACTION_TYPE_ID" NUMBER(*,0), 
	"COMM_TYPE_ID" NUMBER(*,0), 
	"LANG_ID" NUMBER(*,0), 
	"OBSERVATION_ID" NUMBER(*,0), 
	"REGION_ID" NUMBER(*,0), 
	"SRC_STAFF_ID" NUMBER(*,0), 
	"TIME_PERIOD_ID" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;

   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."ACTIVITY_ID" IS 'Activities ID';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."ACTIVITY_NAME" IS 'Activity Name';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."ACTIVITY_DATE" IS 'Activity Date';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."ACTIVITY_CATEGORY" IS 'Group Category';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."ACTIVITY_TYPE" IS 'Group Type Name';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."COUNTY_NAME" IS 'County Name';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."CSDA_CODE" IS 'CSDA Code';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."DOOR_PRIZE_VALUE" IS 'Door Prize Value';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."FEE_AMOUNT" IS 'Fee Amount';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."NBR_KITS_PROVIDED" IS 'Number of Kits Provided';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."NBR_RECIPIENT_ATTENDEES" IS 'Number of Recipient Attendees';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."NBR_STAFF_ATTENDEES" IS 'Number of Staff Attendees';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."STAFF_FIRST" IS 'Staff''s First Name';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."ST_CNTY_NUM" IS 'State County Number';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."ACTIVITY_ACTION_TYPE_ID" IS 'Activity_Trans - Target Group Type';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."COMM_TYPE_ID" IS 'Communication Type ID';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."LANG_ID" IS 'Language ID';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."OBSERVATION_ID" IS 'Observation ID';
   COMMENT ON COLUMN "EMRS_S_OUTREACH_FACTS"."REGION_ID" IS 'Regions ID';