--------------------------------------------------------
--  Constraints for Table EMRS_D_BUSINESS_CHANNEL
--------------------------------------------------------

  ALTER TABLE "EMRS_D_BUSINESS_CHANNEL" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_BUSINESS_CHANNEL" MODIFY ("DATE_CREATED" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_BUSINESS_CHANNEL" MODIFY ("CHANNEL_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_BUSINESS_CHANNEL" ADD CONSTRAINT "BIZCHANL_PK" PRIMARY KEY ("CHANNEL_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;