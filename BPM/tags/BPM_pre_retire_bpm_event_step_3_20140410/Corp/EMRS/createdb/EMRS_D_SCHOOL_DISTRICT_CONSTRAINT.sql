--------------------------------------------------------
--  Constraints for Table EMRS_D_SCHOOL_DISTRICT
--------------------------------------------------------

  ALTER TABLE "EMRS_D_SCHOOL_DISTRICT" ADD CONSTRAINT "SCHODIST_SCHODIST_COMB_UK" UNIQUE ("MANAGED_CARE_PROGRAM", "SOURCE_RECORD_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_SCHOOL_DISTRICT" ADD CONSTRAINT "SCHODIST_PK" PRIMARY KEY ("SCHOOL_DISTRICT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_SCHOOL_DISTRICT" MODIFY ("DATE_CREATED" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_SCHOOL_DISTRICT" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_SCHOOL_DISTRICT" MODIFY ("SCHOOL_DISTRICT_ID" NOT NULL ENABLE);