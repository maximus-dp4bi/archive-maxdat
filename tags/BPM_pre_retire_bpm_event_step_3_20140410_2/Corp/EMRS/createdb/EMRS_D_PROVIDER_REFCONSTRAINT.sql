--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_PROVIDER
--------------------------------------------------------

  ALTER TABLE "EMRS_D_PROVIDER" ADD CONSTRAINT "PROV_PROVIDERNUM_FK" FOREIGN KEY ("PROVIDER_NUMBER")
	  REFERENCES "EMRS_D_PROVIDER_REF" ("PROVIDER_NUMBER") ENABLE;
