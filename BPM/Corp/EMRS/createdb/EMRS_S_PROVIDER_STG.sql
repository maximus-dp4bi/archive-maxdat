
--------------------------------------------------------
--  DDL for Table EMRS_S_PROVIDER_STG
--------------------------------------------------------

  CREATE TABLE "EMRS_S_PROVIDER_STG" 
   (	"PROVIDER_ID" NUMBER(*,0), 
	"PROVIDER_CODE" VARCHAR2(128), 
	"MANAGED_CARE_PROGRAM" VARCHAR2(30), 
	"PLAN_ID" VARCHAR2(10), 
	"PROVIDER_TITLE" VARCHAR2(32), 
	"PROVIDER_FIRST_NAME" VARCHAR2(64), 
	"PROVIDER_LAST_NAME" VARCHAR2(64), 
	"ATTENTION_LINE" VARCHAR2(40), 
	"ADDRESS_1" VARCHAR2(128), 
	"ADDRESS_2" VARCHAR2(50), 
	"ADDRESS_3" VARCHAR2(30), 
	"CITY" VARCHAR2(64), 
	"STATE" VARCHAR2(6), 
	"ZIP" VARCHAR2(32), 
	"PHONE" VARCHAR2(20), 
	"COUNTY_ID" VARCHAR2(64), 
	"PROVIDER_LICENSE_NUMBER" VARCHAR2(30), 
	"PROVIDER_LICENSE_NUMBER_OLD" VARCHAR2(11), 
	"PROVIDER_LICENSE_NATIONAL_ID" VARCHAR2(11), 
	"PROVIDER_LICENSE_CATEGORY" VARCHAR2(1), 
	"NPI_BENEFIT_CODE" VARCHAR2(3), 
	"NPI_PRIMARY_TAXONOMY_CODE" VARCHAR2(10), 
	"RACE_ID" VARCHAR2(9), 
	"PROVIDER_TYPE" VARCHAR2(3), 
	"PROVIDER_SPECIALTY" VARCHAR2(2), 
	"PROVIDER_TAX_ID" VARCHAR2(16), 
	"PROVIDER_SEX_RESTRICTIONS" VARCHAR2(5), 
	"CSDA_ID" VARCHAR2(7), 
	"AGE_HIGH" NUMBER(*,0), 
	"AGE_LOW" NUMBER(*,0), 
	"LANGUAGE_SERVED_1" VARCHAR2(32), 
	"LANGUAGE_SERVED_2" VARCHAR2(32), 
	"LANGUAGE_SERVED_3" VARCHAR2(32), 
	"TOTAL_CLIENTS_ALLOWED" NUMBER(18,0), 
	"SOURCE_RECORD_DATE" DATE, 
	"SOURCE_RECORD_TIME" VARCHAR2(5), 
	"SOURCE_RECORD_NAME" VARCHAR2(10), 
	"DATE_OF_VALIDITY_START" DATE, 
	"DATE_OF_VALIDITY_END" DATE, 
	"OFC_HR_OPEN_FROM" VARCHAR2(200), 
	"OFC_HR_CLOSE_AT" VARCHAR2(200), 
	"OFC_HR_DAYS_OF_WEEK" VARCHAR2(200), 
	"SOURCE_RECORD_ID" NUMBER(22,0), 
	"VERSION" NUMBER(*,0), 
	"PROVIDER_NUMBER" NUMBER(22,0), 
	"UPD_PROVIDER_ID" NUMBER(*,0), 
	"RECORD_STATUS" VARCHAR2(30),
  "PROV_STATUS_CODE" VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

--------------------------------------------------------
--  DDL for Index PROVIDERSTG
--------------------------------------------------------

  CREATE INDEX "IDX1_PROVIDERSTG" ON "EMRS_S_PROVIDER_STG" ("PROVIDER_NUMBER") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX "IDX2_PROVIDERSTG" ON "EMRS_S_PROVIDER_STG" ("RECORD_STATUS") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;
  
  CREATE OR REPLACE PUBLIC SYNONYM EMRS_S_PROVIDER_STG FOR EMRS_S_PROVIDER_STG;