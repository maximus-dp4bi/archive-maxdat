--------------------------------------------------------
--  Constraints for Table EMRS_D_LANGUAGE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_LANGUAGE" MODIFY ("LANGUAGE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_LANGUAGE" MODIFY ("LANGUAGE_CODE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_LANGUAGE" MODIFY ("MANAGED_CARE_PROGRAM" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_LANGUAGE" MODIFY ("LANGUAGE_CODE_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_LANGUAGE" ADD CONSTRAINT "LANG_PK" PRIMARY KEY ("LANGUAGE_CODE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_LANGUAGE" ADD CONSTRAINT "LANG_LANG_COMB_UK" UNIQUE ("LANGUAGE_CODE", "MANAGED_CARE_PROGRAM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
