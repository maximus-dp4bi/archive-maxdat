--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_PROVIDER_SPECIALTY
--------------------------------------------------------

  ALTER TABLE "EMRS_D_PROVIDER_SPECIALTY" ADD CONSTRAINT "PROVSPECIALTY_CODE_FK" FOREIGN KEY ("PROVIDER_SPECIALTY_CODE_ID")
	  REFERENCES "EMRS_D_PROVIDER_SPECIALTY_CODE" ("PROVIDER_SPECIALTY_CODE_ID") ENABLE;
  ALTER TABLE "EMRS_D_PROVIDER_SPECIALTY" ADD CONSTRAINT "SPECIALTY_PROVIDERNUM_FK" FOREIGN KEY ("PROVIDER_NUMBER")
	  REFERENCES "EMRS_D_PROVIDER_REF" ("PROVIDER_NUMBER") ENABLE;
