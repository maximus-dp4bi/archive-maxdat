--------------------------------------------------------
--  File created - Friday-July-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CORP_ETL_CONTROL
--------------------------------------------------------

DROP TABLE CORP_ETL_CONTROL;

  CREATE TABLE "CORP_ETL_CONTROL" 
   (	"NAME" VARCHAR2(50 BYTE), 
	"VALUE_TYPE" VARCHAR2(1 BYTE), 
	"VALUE" VARCHAR2(100 BYTE), 
	"DESCRIPTION" VARCHAR2(400 BYTE), 
	"CREATED_TS" DATE, 
	"UPDATED_TS" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ;

   COMMENT ON COLUMN "CORP_ETL_CONTROL"."NAME" IS 'Named Variable which will have a value stored';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."VALUE_TYPE" IS 'Type of the named variable';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."VALUE" IS 'Holds the value for the named variable identifier - secondary lookup value';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."DESCRIPTION" IS 'Description of named variable';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."CREATED_TS" IS 'Date variable created';
   COMMENT ON COLUMN "CORP_ETL_CONTROL"."UPDATED_TS" IS 'Date Variable updated';
REM INSERTING into CORP_ETL_CONTROL
SET DEFINE OFF;
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MIN_NUM_OBSERVATIONS','N','8','Minimum number of observations for calculating control chart parameters',to_date('26-JUN-14 05:21:26','DD-MON-RR HH:MI:SS'),to_date('26-JUN-14 05:21:26','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MAX_NUM_OBSERVATIONS','N','20','Maximum number of observations for calculating control chart parameters',to_date('26-JUN-14 05:21:26','DD-MON-RR HH:MI:SS'),to_date('26-JUN-14 05:21:26','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('NUM_ALLOWABLE_GAPS','N','0','Number of allowable gaps in time periods reported',to_date('26-JUN-14 05:21:26','DD-MON-RR HH:MI:SS'),to_date('26-JUN-14 05:21:26','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('NUM_STANDARD_ERRORS','N','3','Number of standard errors',to_date('26-JUN-14 05:21:27','DD-MON-RR HH:MI:SS'),to_date('26-JUN-14 05:21:27','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('RECALC_NUM_OBSERVATIONS_1','N','12','Number of observations used for control chart parameters recalculation at 1/3',to_date('30-JUN-14 01:36:34','DD-MON-RR HH:MI:SS'),to_date('30-JUN-14 01:36:34','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('RECALC_NUM_OBSERVATIONS_2','N','16','Number of observations used for control chart parameters recalculation at 2/3',to_date('30-JUN-14 01:36:35','DD-MON-RR HH:MI:SS'),to_date('30-JUN-14 01:36:35','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('TREND_INDICATOR_CALCULATION_1','V','CONTROL CHART','Trend indicator calculation method',to_date('30-JUN-14 02:13:36','DD-MON-RR HH:MI:SS'),to_date('30-JUN-14 02:13:36','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('TREND_INDICATOR_CALCULATION_2','V','DELTA','Trend indicator calculation method',to_date('30-JUN-14 02:13:36','DD-MON-RR HH:MI:SS'),to_date('30-JUN-14 02:13:36','DD-MON-RR HH:MI:SS'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('TREND_INDICATOR_CALCULATION_3','V','NO TREND','Trend indicator calculation method',to_date('30-JUN-14 02:13:36','DD-MON-RR HH:MI:SS'),to_date('30-JUN-14 02:13:36','DD-MON-RR HH:MI:SS'));
--------------------------------------------------------
--  DDL for Index CECTL_PK
--------------------------------------------------------
/*
  CREATE UNIQUE INDEX "CECTL_PK" ON "CORP_ETL_CONTROL" ("NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ENABLE;
  */
--------------------------------------------------------
--  Constraints for Table CORP_ETL_CONTROL
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_CONTROL" ADD CONSTRAINT "CECTL_PK" PRIMARY KEY ("NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ENABLE;
  
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("UPDATED_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("CREATED_TS" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("VALUE" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("VALUE_TYPE" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_CONTROL" MODIFY ("NAME" NOT NULL ENABLE);

  
  
  --------------------------------------------------------
--  DDL for Table CORP_ETL_JOB_STATISTICS
--------------------------------------------------------

  CREATE TABLE "CORP_ETL_JOB_STATISTICS" 
   (	"JOB_ID" NUMBER, 
	"JOB_NAME" VARCHAR2(80 BYTE), 
	"JOB_STATUS_CD" VARCHAR2(20 BYTE), 
	"FILE_NAME" VARCHAR2(512 BYTE), 
	"RECORD_COUNT" NUMBER, 
	"PROCESSED_COUNT" NUMBER, 
	"ERROR_COUNT" NUMBER, 
	"WARNING_COUNT" NUMBER, 
	"RECORD_INSERTED_COUNT" NUMBER, 
	"RECORD_UPDATED_COUNT" NUMBER, 
	"JOB_START_DATE" DATE, 
	"JOB_END_DATE" DATE, 
	"PARENT_JOB_ID" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ;
--------------------------------------------------------
--  DDL for Index CORP_ETL_JOB_STATISTICS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CORP_ETL_JOB_STATISTICS_PK" ON "CORP_ETL_JOB_STATISTICS" ("JOB_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ;
--------------------------------------------------------
--  Constraints for Table CORP_ETL_JOB_STATISTICS
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_JOB_STATISTICS" ADD CONSTRAINT "CORP_ETL_JOB_STATISTICS_PK" PRIMARY KEY ("JOB_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
   ENABLE;
  ALTER TABLE "CORP_ETL_JOB_STATISTICS" MODIFY ("JOB_STATUS_CD" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_JOB_STATISTICS" MODIFY ("JOB_NAME" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_JOB_STATISTICS" MODIFY ("JOB_ID" NOT NULL ENABLE);
  
  
  --------------------------------------------------------
--  DDL for Sequence SEQ_CORP_ETL_JOB_STATS
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_CORP_ETL_JOB_STATS"  MINVALUE 1 MAXVALUE 9999999999999999999 INCREMENT BY 1 START WITH 303 CACHE 20 NOORDER  NOCYCLE ;


  