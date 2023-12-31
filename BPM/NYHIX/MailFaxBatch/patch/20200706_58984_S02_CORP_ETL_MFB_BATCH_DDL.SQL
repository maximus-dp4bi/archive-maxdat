ALTER TABLE MAXDAT.CORP_ETL_MFB_BATCH_ARS_OLTP ADD FAX_BATCH_SOURCE VARCHAR2(100);

ALTER TABLE MAXDAT.CORP_ETL_MFB_BATCH_ARS_STG ADD FAX_BATCH_SOURCE VARCHAR2(100);

ALTER TABLE MAXDAT.CORP_ETL_MFB_BATCH_WIP ADD FAX_BATCH_SOURCE VARCHAR2(100);

ALTER TABLE MAXDAT.CORP_ETL_MFB_BATCH ADD FAX_BATCH_SOURCE VARCHAR2(100);

ALTER TABLE MAXDAT.D_MFB_CURRENT ADD FAX_BATCH_SOURCE VARCHAR2(100);



CREATE UNIQUE INDEX MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_IX1 
ON MAXDAT.CORP_ETL_MFB_BATCH_EVENTS (CEMFBBE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;
  
CREATE INDEX MAXDAT.MFB_BVNTS_INX 
ON MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_WIP (BATCH_GUID, BATCH_MODULE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX;

-- THIS IS ONLY FOR PRODUCTION  
-- IGNORE ERROR IN UAT


ALTER TABLE MAXDAT.CORP_ETL_MFB_DOCUMENT  DROP CONSTRAINT SYS_C0084547;  