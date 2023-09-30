--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_PLAN_PERCENTAGE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_PLAN_PERCENTAGE" ADD CONSTRAINT "PLAN_PERCENTAGE_PLANTYPE_FK" FOREIGN KEY ("PLAN_TYPE_ID")
	  REFERENCES "EMRS_D_PLAN_TYPE" ("PLAN_TYPE_ID") ENABLE;
