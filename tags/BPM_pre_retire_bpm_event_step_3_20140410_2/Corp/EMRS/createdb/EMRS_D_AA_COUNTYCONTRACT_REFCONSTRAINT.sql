--------------------------------------------------------
--  Ref Constraints for Table EMRS_D_AA_COUNTYCONTRACT
--------------------------------------------------------

  ALTER TABLE "EMRS_D_AA_COUNTYCONTRACT" ADD CONSTRAINT "AA_COUNTYCONTRACT_CONTRACT_FK" FOREIGN KEY ("AA_CONTRACT_ID")
	  REFERENCES "EMRS_D_AA_CONTRACT" ("AA_CONTRACT_ID") ENABLE;
