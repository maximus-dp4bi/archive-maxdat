--------------------------------------------------------
--  Constraints for Table EMRS_D_HEADSTART_GRANTEE
--------------------------------------------------------

  ALTER TABLE "EMRS_D_HEADSTART_GRANTEE" MODIFY ("DATE_CREATED" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_HEADSTART_GRANTEE" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_HEADSTART_GRANTEE" MODIFY ("GRANTEE_NAME" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_HEADSTART_GRANTEE" MODIFY ("HEADSTART_GRANTEE_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_HEADSTART_GRANTEE" ADD CONSTRAINT "HEADGRNTEE_PK" PRIMARY KEY ("HEADSTART_GRANTEE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
