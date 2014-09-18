--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_SELECTION_TRANSACTION
--------------------------------------------------------

  ALTER TABLE "EMRS_D_SELECTION_TRANSACTION" ADD CONSTRAINT "SLCTTRANS_CLIENTNUM_FK" FOREIGN KEY ("CLIENT_NUMBER")
	  REFERENCES "EMRS_D_CLIENT_REF" ("CLIENT_NUMBER") ENABLE;
  ALTER TABLE "EMRS_D_SELECTION_TRANSACTION" ADD CONSTRAINT "SLCTTRANS_SLCTSTATUS_FK" FOREIGN KEY ("CURRENT_SELECTION_STATUS_ID")
	  REFERENCES "EMRS_D_SELECTION_STATUS" ("SELECTION_STATUS_ID") ENABLE;
