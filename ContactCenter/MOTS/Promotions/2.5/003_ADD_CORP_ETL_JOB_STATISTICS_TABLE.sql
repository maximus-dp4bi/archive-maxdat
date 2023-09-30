
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
   );
--------------------------------------------------------
--  DDL for Index CORP_ETL_JOB_STATISTICS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CORP_ETL_JOB_STATISTICS_PK" ON "CORP_ETL_JOB_STATISTICS" ("JOB_ID");
--------------------------------------------------------
--  Constraints for Table CORP_ETL_JOB_STATISTICS
--------------------------------------------------------

  ALTER TABLE "CORP_ETL_JOB_STATISTICS" MODIFY ("JOB_ID" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_JOB_STATISTICS" MODIFY ("JOB_NAME" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_JOB_STATISTICS" MODIFY ("JOB_STATUS_CD" NOT NULL ENABLE);
  ALTER TABLE "CORP_ETL_JOB_STATISTICS" ADD CONSTRAINT "CORP_ETL_JOB_STATISTICS_PK" PRIMARY KEY ("JOB_ID");

  
--------------------------------------------------------
--  DDL for Sequence SEQ_CORP_ETL_JOB_STATS
--------------------------------------------------------

	CREATE SEQUENCE  "SEQ_CORP_ETL_JOB_STATS"  MINVALUE 1 MAXVALUE 9999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE;

  
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.5','003','003_ADD_CORP_ETL_JOB_STATISTICS');

COMMIT;