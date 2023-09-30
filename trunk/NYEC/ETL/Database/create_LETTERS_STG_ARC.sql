-- Create archive table for letters_stg


  CREATE TABLE "MAXDAT"."LETTERS_STG_ARC" 
   (	"LETTER_ID" NUMBER(18,0) NOT NULL ENABLE, 
	"LETTER_REQUESTED_ON" DATE, 
	"LETTER_STATUS_CD" VARCHAR2(32 BYTE), 
	"LETTER_STATUS_REPORT_LABEL" VARCHAR2(64 BYTE), 
	"LETTER_CREATE_TS" DATE, 
	"LETTER_UPDATE_TS" DATE, 
	"LETTER_SENT_ON" DATE, 
	"LETTER_MAILED_DATE" DATE, 
	"LETTER_APP_ID" NUMBER(18,0), 
	"LETTER_CASE_ID" NUMBER(18,0), 
	"LETTER_PARENT_LMREQ_ID" NUMBER(18,0), 
	"LETTER_REF_TYPE" VARCHAR2(40 BYTE), 
	"LETTER_TYPE_CD" VARCHAR2(40 BYTE), 
	"LETTER_TYPE" VARCHAR2(4000 BYTE), 
	"LETTER_REQUEST_TYPE" VARCHAR2(2 BYTE), 
	"LETTER_LANG_CD" VARCHAR2(32 BYTE), 
	"LETTER_DRIVER_TYPE" VARCHAR2(4 BYTE), 
	"LET_MATERIAL_REQUEST_ID" NUMBER(18,0), 
	"MW_PROCESSED" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"AP_PROCESSED" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"MIB_PROCESSED" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"MI_PROCESSED" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"SR_PROCESSED" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"TP_PROCESSED" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"IR_PROCESSED" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"ALL_PROC_DONE_DATE" DATE, 
	"LETTER_CREATED_BY" VARCHAR2(80 BYTE), 
	"ARCH_DT" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE INDEX "MAXDAT"."LETTERS_APP_ID_STG_ARC_IDX" ON "MAXDAT"."LETTERS_STG_ARC" ("LETTER_APP_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE INDEX "MAXDAT"."LETTERS_ID_STG_ARC_IDX" ON "MAXDAT"."LETTERS_STG_ARC" ("LETTER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE INDEX "MAXDAT"."LETTERS_SENT_ON_STG_ARC_IDX" ON "MAXDAT"."LETTERS_STG_ARC" ("LETTER_SENT_ON") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE INDEX "MAXDAT"."LETTERS_STG_ARC_IDX" ON "MAXDAT"."LETTERS_STG_ARC" ("LETTER_TYPE_CD", "LETTER_APP_ID", "LETTER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE INDEX "MAXDAT"."LETTERS_TYPE_CD_STG_ARC_IDX" ON "MAXDAT"."LETTERS_STG_ARC" ("LETTER_TYPE_CD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;

  CREATE INDEX "MAXDAT"."LETTER_REQ_TPE_STG_ARC_IDX" ON "MAXDAT"."LETTERS_STG_ARC" ("LETTER_REQUEST_TYPE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_DATA" ;
  