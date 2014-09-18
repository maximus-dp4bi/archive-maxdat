--------------------------------------------------------
--  DDL for Table CC_A_JOB_PROJECT
--------------------------------------------------------

  CREATE TABLE "CC_A_JOB_PROJECT" 
   (	"JOB_ID" NUMBER(19,0), 
	"D_PROJECT_ID" NUMBER(19,0), 
	"D_PROGRAM_ID" NUMBER(19,0), 
	"D_GEOGRAPHY_MASTER_ID" NUMBER(19,0)
   );
   
--------------------------------------------------------
--  DDL for Index CC_A_JOB_PROJECT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CC_A_JOB_PROJECT_PK" ON "CC_A_JOB_PROJECT" ("JOB_ID", "D_PROJECT_ID", "D_PROGRAM_ID", "D_GEOGRAPHY_MASTER_ID");
  
--------------------------------------------------------
--  Constraints for Table CC_A_JOB_PROJECT
--------------------------------------------------------

  ALTER TABLE "CC_A_JOB_PROJECT" ADD CONSTRAINT "CC_A_JOB_PROJECT_PK" PRIMARY KEY ("JOB_ID", "D_PROJECT_ID", "D_PROGRAM_ID", "D_GEOGRAPHY_MASTER_ID");

  ALTER TABLE "CC_A_JOB_PROJECT" MODIFY ("D_GEOGRAPHY_MASTER_ID" NOT NULL ENABLE);
  ALTER TABLE "CC_A_JOB_PROJECT" MODIFY ("D_PROGRAM_ID" NOT NULL ENABLE);
  ALTER TABLE "CC_A_JOB_PROJECT" MODIFY ("D_PROJECT_ID" NOT NULL ENABLE);
  ALTER TABLE "CC_A_JOB_PROJECT" MODIFY ("JOB_ID" NOT NULL ENABLE);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.6','001','001_ADD_CC_A_JOB_PROJECT_TABLE');

COMMIT;