--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_CLIENT
--------------------------------------------------------

  ALTER TABLE "EMRS_D_CLIENT" ADD CONSTRAINT "CLIENT_CLIENTNUM_FK" FOREIGN KEY ("CLIENT_NUMBER")
	  REFERENCES "EMRS_D_CLIENT_REF" ("CLIENT_NUMBER") ENABLE;
