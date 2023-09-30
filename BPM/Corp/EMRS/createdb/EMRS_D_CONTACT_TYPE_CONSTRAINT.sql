--------------------------------------------------------
--  Constraints for Table EMRS_D_CONTACT_TYPE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_CONTACT_TYPE" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CONTACT_TYPE" MODIFY ("CONTACT_TYPE_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_CONTACT_TYPE" ADD CONSTRAINT "CONTACTYP_PK" PRIMARY KEY ("CONTACT_TYPE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;