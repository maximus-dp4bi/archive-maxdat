--------------------------------------------------------
--  Constraints for Table EMRS_D_SELECTION_TRANSACTION
--------------------------------------------------------

  ALTER TABLE "EMRS_D_SELECTION_TRANSACTION" ADD CONSTRAINT "SELECTIONTRANSPK" PRIMARY KEY ("SELECTION_TRANSACTION_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_SELECTION_TRANSACTION" MODIFY ("SELECTION_TRANSACTION_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_SELECTION_TRANSACTION" MODIFY ("SOURCE_RECORD_ID" NOT NULL ENABLE);
