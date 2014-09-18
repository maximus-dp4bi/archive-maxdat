
  CREATE TABLE "MAXDAT"."CLIENT_ELIG_STATUS_STG" 
   (	"CLIENT_ELIG_STATUS_ID" NUMBER(18,0), 
	"PLAN_TYPE_CD" VARCHAR2(32 BYTE), 
	"ELIG_STATUS_CD" VARCHAR2(32 BYTE), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"CREATE_TS" DATE, 
	"CREATED_BY" VARCHAR2(80 BYTE), 
	"UPDATE_TS" DATE, 
	"UPDATED_BY" VARCHAR2(80 BYTE), 
	"CLIENT_ID" NUMBER(18,0), 
	"PROGRAM_CD" VARCHAR2(32 BYTE), 
	"SUB_STATUS_CODES" VARCHAR2(256 BYTE), 
	"REASONS" VARCHAR2(256 BYTE), 
	"MVX_CORE_REASON" VARCHAR2(256 BYTE), 
	"DEBUG" VARCHAR2(2000 BYTE), 
	"START_NDT" NUMBER(18,0), 
	"END_NDT" NUMBER(18,0), 
	"DISPOSITION_CD" VARCHAR2(32 BYTE), 
	"SUBPROGRAM_TYPE" VARCHAR2(32 BYTE), 
	 CONSTRAINT "PK_CLNT_ELIG_STAT_ID" PRIMARY KEY ("CLIENT_ELIG_STATUS_ID")
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

  CREATE INDEX "MAXDAT"."IDX_CL_ELIG_STAT_CLIENT_ID" ON "MAXDAT"."CLIENT_ELIG_STATUS_STG" ("CLIENT_ID") 
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX "MAXDAT"."IDX_CL_ELIG_STAT_CREATE_TS" ON "MAXDAT"."CLIENT_ELIG_STATUS_STG" ("CREATE_TS") 
   TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX "MAXDAT"."IDX_CL_ELIG_STAT_UPDATE_TS" ON "MAXDAT"."CLIENT_ELIG_STATUS_STG" ("UPDATE_TS") 
   TABLESPACE "MAXDAT_INDX" ;

create public synonym CLIENT_ELIG_STATUS_STG for CLIENT_ELIG_STATUS_STG;

Grant select on CLIENT_ELIG_STATUS_STG to MAXDAT_READ_ONLY;

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MAX_UPDATE_TS_CLNT_ELIG_STAT','D','2010/03/25 13:03:42','This is the most recent update_ts of the Client Elig Status table. This is a copy of the OLTP Source database. This will be used for the search > than',to_date('2014-04-08 16:57:09','YYYY-MM-DD HH24:MI:SS'),to_date('2014-04-08 16:56:07','YYYY-MM-DD HH24:MI:SS'));
