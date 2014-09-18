--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_CASE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_CASE" ADD CONSTRAINT "CASE_CASENUM_FK" FOREIGN KEY ("CASE_NUMBER")
	  REFERENCES "EMRS_D_CASE_REF" ("CASE_NUMBER") ENABLE;
