--------------------------------------------------------
--  Constraints for Table EMRS_D_ACTION_TYPE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_ACTION_TYPE" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_ACTION_TYPE" MODIFY ("SOURCE_RECORD_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_ACTION_TYPE" MODIFY ("ACTION_TYPE_NAME" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_ACTION_TYPE" MODIFY ("MANAGED_CARE_PROGRAM" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_ACTION_TYPE" MODIFY ("ACTION_TYPE_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_ACTION_TYPE" ADD CONSTRAINT "ACTNTYP_PK" PRIMARY KEY ("ACTION_TYPE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
