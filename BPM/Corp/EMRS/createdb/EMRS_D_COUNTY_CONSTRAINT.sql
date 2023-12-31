--------------------------------------------------------
--  Constraints for Table EMRS_D_COUNTY
--------------------------------------------------------

  ALTER TABLE "EMRS_D_COUNTY" ADD CONSTRAINT "CNTY_PK" PRIMARY KEY ("COUNTY_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_COUNTY" ADD CONSTRAINT "CNTY_CNTY_COMB_UK" UNIQUE ("STATE", "COUNTY_CODE", "PLAN_SERVICE_TYPE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_COUNTY" MODIFY ("STATE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_COUNTY" MODIFY ("COUNTY_ID" NOT NULL ENABLE);
