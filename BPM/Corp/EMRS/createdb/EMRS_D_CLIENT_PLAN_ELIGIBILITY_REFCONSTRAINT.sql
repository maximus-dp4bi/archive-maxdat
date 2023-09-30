--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_CLIENT_PLAN_ELIGIBILITY
--------------------------------------------------------

  ALTER TABLE "EMRS_D_CLIENT_PLAN_ELIGIBILITY" ADD CONSTRAINT "CLIENTNUM_FK" FOREIGN KEY ("CLIENT_NUMBER")
	  REFERENCES "EMRS_D_CLIENT_REF" ("CLIENT_NUMBER") ENABLE;
  ALTER TABLE "EMRS_D_CLIENT_PLAN_ELIGIBILITY" ADD CONSTRAINT "ELIG_PLAN_TYPE_FK" FOREIGN KEY ("PLAN_TYPE_ID")
	  REFERENCES "EMRS_D_PLAN_TYPE" ("PLAN_TYPE_ID") ENABLE;
  ALTER TABLE "EMRS_D_CLIENT_PLAN_ELIGIBILITY" ADD CONSTRAINT "ELIG_SUBPROGRAM_FK" FOREIGN KEY ("SUB_PROGRAM_ID")
	  REFERENCES "EMRS_D_SUB_PROGRAM" ("SUB_PROGRAM_ID") ENABLE;