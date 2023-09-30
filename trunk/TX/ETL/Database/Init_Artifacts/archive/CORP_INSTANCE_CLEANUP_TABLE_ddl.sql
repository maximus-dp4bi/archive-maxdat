
  CREATE TABLE "CORP_INSTANCE_CLEANUP_TABLE" 
   (	"CICT_ID" NUMBER(5,0) NOT NULL ENABLE, 
	"SYSTEM_NAME" VARCHAR2(32 BYTE), 
	"CLEANUP_NAME" VARCHAR2(100 BYTE), 
	"RUN" VARCHAR2(1 BYTE), 
	"START_DATE" DATE, 
	"START_TIME" VARCHAR2(10 BYTE), 
	"END_DATE" DATE, 
	"END_TIME" VARCHAR2(10 BYTE), 
	"STATEMENT" VARCHAR2(4000 BYTE), 
	"CREATED_TS" DATE NOT NULL ENABLE, 
	"LAST_UPDATE_TS" DATE NOT NULL ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE UNIQUE INDEX "CORP_INSTANCE_CLEANUP_IDX1" ON "CORP_INSTANCE_CLEANUP_TABLE" ("CICT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;
  


