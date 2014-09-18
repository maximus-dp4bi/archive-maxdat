--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_PLAN
--------------------------------------------------------

  ALTER TABLE "EMRS_D_PLAN" ADD CONSTRAINT "PLAN_TYPE_FK" FOREIGN KEY ("PLAN_TYPE_ID")
	  REFERENCES "EMRS_D_PLAN_TYPE" ("PLAN_TYPE_ID") ENABLE;
