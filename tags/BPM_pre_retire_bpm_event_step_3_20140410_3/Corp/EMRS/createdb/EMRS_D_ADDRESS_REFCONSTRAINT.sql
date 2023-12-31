--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_ADDRESS
--------------------------------------------------------

  ALTER TABLE "EMRS_D_ADDRESS" ADD CONSTRAINT "ADDRESS_CASENUM_FK" FOREIGN KEY ("CASE_NUMBER")
	  REFERENCES "EMRS_D_CASE_REF" ("CASE_NUMBER") ENABLE;
  ALTER TABLE "EMRS_D_ADDRESS" ADD CONSTRAINT "ADDRESS_CLIENTNUM_FK" FOREIGN KEY ("CLIENT_NUMBER")
	  REFERENCES "EMRS_D_CLIENT_REF" ("CLIENT_NUMBER") ENABLE;
