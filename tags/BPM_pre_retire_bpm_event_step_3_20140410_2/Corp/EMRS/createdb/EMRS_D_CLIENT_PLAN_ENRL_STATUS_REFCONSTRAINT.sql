--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_CLIENT_PLAN_ENRL_STATUS
--------------------------------------------------------

  ALTER TABLE "EMRS_D_CLIENT_PLAN_ENRL_STATUS" ADD CONSTRAINT "CLIENT_PLANTYPE_FK" FOREIGN KEY ("PLAN_TYPE_ID")
	  REFERENCES "EMRS_D_PLAN_TYPE" ("PLAN_TYPE_ID") ENABLE;
  ALTER TABLE "EMRS_D_CLIENT_PLAN_ENRL_STATUS" ADD CONSTRAINT "CURRENRLSTATUS_FK" FOREIGN KEY ("CURRENT_ENROLLMENT_STATUS_ID")
	  REFERENCES "EMRS_D_ENROLLMENT_STATUS" ("ENROLLMENT_STATUS_ID") ENABLE;
  ALTER TABLE "EMRS_D_CLIENT_PLAN_ENRL_STATUS" ADD CONSTRAINT "ENRLSTATUS_CLIENTNUM_FK" FOREIGN KEY ("CLIENT_NUMBER")
	  REFERENCES "EMRS_D_CLIENT_REF" ("CLIENT_NUMBER") ENABLE;
  ALTER TABLE "EMRS_D_CLIENT_PLAN_ENRL_STATUS" ADD CONSTRAINT "ENRLSTATUS_FK" FOREIGN KEY ("ENROLLMENT_STATUS_ID")
	  REFERENCES "EMRS_D_ENROLLMENT_STATUS" ("ENROLLMENT_STATUS_ID") ENABLE;
