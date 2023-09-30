--------------------------------------------------------
--  Constraints for Table EMRS_D_CASE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_CASE" MODIFY ("DATE_CREATED" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CASE" MODIFY ("CREATED_BY" NOT NULL ENABLE);  
  ALTER TABLE "EMRS_D_CASE" MODIFY ("CASE_NUMBER" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CASE" MODIFY ("MANAGED_CARE_PROGRAM" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CASE" MODIFY ("CASE_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CASE" MODIFY ("SOURCE_RECORD_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CASE" MODIFY ("CURRENT_FLAG" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CASE" ADD CONSTRAINT "CASES_PK" PRIMARY KEY ("CASE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
