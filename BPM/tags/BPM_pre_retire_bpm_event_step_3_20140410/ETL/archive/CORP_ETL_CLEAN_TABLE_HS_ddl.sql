-- Create the history table for CORP_ETL_CLEAN_TABLE

  CREATE TABLE "CORP_ETL_CLEAN_TABLE_HS" 
   (	"CECT_HS_ID" NUMBER(5,0), 
	"CECT_ID" NUMBER(5,0), 
	"TABLE_NAME" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"COLUMN_NAME" VARCHAR2(100 BYTE), 
	"DELETE_WHERE_CLAUSE" VARCHAR2(4000 BYTE), 
	"DAYS_TILL_DELETE" NUMBER, 
	"START_DATE" DATE NOT NULL ENABLE, 
	"END_DATE" DATE NOT NULL ENABLE, 
	"CREATED_TS" DATE NOT NULL ENABLE, 
	"LAST_UPDATE_TS" DATE NOT NULL ENABLE, 
	"ARC_FLAG" VARCHAR2(1 BYTE), 
	"ARC_TABLE" VARCHAR2(100 BYTE), 
	"HS_CREATED_TS" DATE NOT NULL ENABLE, 
	"HS_LAST_UPDATE_TS" DATE NOT NULL ENABLE, 
	"HS_ACTION" VARCHAR2(10 BYTE), 
	 PRIMARY KEY ("CECT_HS_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;