--------------------------------------------------------
--  Constraints for Table EMRS_D_FEDERAL_POVERTY_LEVEL
--------------------------------------------------------

  ALTER TABLE "EMRS_D_FEDERAL_POVERTY_LEVEL" MODIFY ("FPL_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_FEDERAL_POVERTY_LEVEL" ADD CONSTRAINT "FPL_YRLONU_UK" UNIQUE ("FPL_YEAR", "FPL_NUMBER_IN_FAMILY", "FPL_LOCALE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_FEDERAL_POVERTY_LEVEL" ADD CONSTRAINT "FPL_PK" PRIMARY KEY ("FPL_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;