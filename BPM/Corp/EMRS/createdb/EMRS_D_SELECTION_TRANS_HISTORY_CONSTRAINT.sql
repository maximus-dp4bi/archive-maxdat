--------------------------------------------------------
--  Constraints for Table EMRS_D_SELECTION_TRANS_HISTORY
--------------------------------------------------------

  ALTER TABLE "EMRS_D_SELECTION_TRANS_HISTORY" MODIFY ("SELECTION_TRANS_HISTORY_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_SELECTION_TRANS_HISTORY" MODIFY ("SOURCE_RECORD_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_SELECTION_TRANS_HISTORY" MODIFY ("SELECTION_TRANSACTION_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_SELECTION_TRANS_HISTORY" MODIFY ("SELECTION_STATUS_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_SELECTION_TRANS_HISTORY" ADD CONSTRAINT "SELECTIONTRANSHISTPK" PRIMARY KEY ("SELECTION_TRANS_HISTORY_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
