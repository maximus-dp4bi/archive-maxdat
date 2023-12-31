--------------------------------------------------------
--  File created - Thursday-September-05-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CC_S_TMP_IVR_STEP
--------------------------------------------------------

  CREATE TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" 
   (	"ID" NUMBER, 
	"CLIENT" VARCHAR2(200 BYTE), 
	"STEPTIME" DATE, 
	"CONNID" VARCHAR2(200 BYTE), 
	"SESSIONID" VARCHAR2(250 BYTE), 
	"STEPNAME" VARCHAR2(200 BYTE), 
	"STEPVALUE" VARCHAR2(200 BYTE), 
	"NODENAME" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PROJ_STG" ;
--------------------------------------------------------
--  DDL for Index CC_S_IVR_STEP_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECTUSER"."CC_S_IVR_STEP_PK" ON "PROJECTUSER"."CC_S_TMP_IVR_STEP" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PROJ_STG" ;
--------------------------------------------------------
--  Constraints for Table CC_S_TMP_IVR_STEP
--------------------------------------------------------

  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" ADD CONSTRAINT "CC_S_IVR_STEP_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PROJ_STG"  ENABLE;
  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" MODIFY ("STEPVALUE" NOT NULL ENABLE);
  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" MODIFY ("STEPNAME" NOT NULL ENABLE);
  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" MODIFY ("SESSIONID" NOT NULL ENABLE);
  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" MODIFY ("CONNID" NOT NULL ENABLE);
  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" MODIFY ("STEPTIME" NOT NULL ENABLE);
  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" MODIFY ("CLIENT" NOT NULL ENABLE);
  ALTER TABLE "PROJECTUSER"."CC_S_TMP_IVR_STEP" MODIFY ("ID" NOT NULL ENABLE);
