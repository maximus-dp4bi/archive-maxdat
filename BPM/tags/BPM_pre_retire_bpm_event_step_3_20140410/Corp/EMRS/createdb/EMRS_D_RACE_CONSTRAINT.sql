--------------------------------------------------------
--  Constraints for Table EMRS_D_RACE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_RACE" ADD CONSTRAINT "RACE_PK" PRIMARY KEY ("RACE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_RACE" MODIFY ("RACE_ID" NOT NULL ENABLE);