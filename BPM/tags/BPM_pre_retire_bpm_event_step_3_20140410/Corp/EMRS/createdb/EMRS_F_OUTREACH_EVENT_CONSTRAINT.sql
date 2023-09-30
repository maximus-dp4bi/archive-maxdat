--------------------------------------------------------
--  Constraints for Table EMRS_F_OUTREACH_EVENT
--------------------------------------------------------

  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("DATE_CREATED" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("NUMBER_COUNT" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("STAFF_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("LANGUAGE_CODE_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("DATE_PERIOD_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("COMMUNICATION_TYPE_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("ACTIVITY_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" MODIFY ("OUTREACH_EVENT_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" ADD CONSTRAINT "ORCHEVENT_ORCH_EVENTS_UK" UNIQUE ("LANGUAGE_CODE_ID", "DATE_PERIOD_ID", "COMMUNICATION_TYPE_ID", "ACTIVITY_ID", "STAFF_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" ADD CONSTRAINT "ORCHEVENT_PK" PRIMARY KEY ("OUTREACH_EVENT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
