--------------------------------------------------------
--  Constraints for Table EMRS_D_CLIENT
--------------------------------------------------------

  ALTER TABLE "EMRS_D_CLIENT" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CLIENT" MODIFY ("MANAGED_CARE_PROGRAM" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CLIENT" MODIFY ("CLIENT_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CLIENT" ADD CONSTRAINT "CLIENT_PK" PRIMARY KEY ("CLIENT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_CLIENT" MODIFY ("CURRENT_FLAG" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CLIENT" MODIFY ("SOURCE_RECORD_ID" NOT NULL ENABLE);

-- ILEB-3508
create index IDX4_CLIENTCURRFLAG on EMRS_D_CLIENT (CURRENT_FLAG,0)
  tablespace MAXDAT_INDX;
create index IDX5_CLIENTZIP on EMRS_D_CLIENT (ZIP,0)
  tablespace MAXDAT_INDX;
