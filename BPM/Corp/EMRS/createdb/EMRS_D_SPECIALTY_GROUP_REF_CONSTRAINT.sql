--------------------------------------------------------
--  Constraints for Table EMRS_D_SPECIALTY_GROUP_REF
--------------------------------------------------------

  ALTER TABLE "EMRS_D_SPECIALTY_GROUP_REF" ADD CONSTRAINT "SPECGROUP_UK" UNIQUE ("SPECIALTY_GROUP_ID") ENABLE;
