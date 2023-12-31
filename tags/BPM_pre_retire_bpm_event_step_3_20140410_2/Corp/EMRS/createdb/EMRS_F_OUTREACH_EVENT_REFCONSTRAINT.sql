--------------------------------------------------------
--  Ref Constraints for Table EMRS_F_OUTREACH_EVENT
--------------------------------------------------------

  ALTER TABLE "EMRS_F_OUTREACH_EVENT" ADD CONSTRAINT "ORCHEVENT_COMMTYP_FK" FOREIGN KEY ("COMMUNICATION_TYPE_ID")
	  REFERENCES "EMRS_D_COMMUNICATION_TYPE" ("COMMUNICATION_TYPE_ID") ENABLE;
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" ADD CONSTRAINT "ORCHEVENT_DATEPERIOD_FK" FOREIGN KEY ("DATE_PERIOD_ID")
	  REFERENCES "EMRS_D_DATE_PERIOD" ("DATE_PERIOD_ID") ENABLE;
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" ADD CONSTRAINT "ORCHEVENT_LANG_FK" FOREIGN KEY ("LANGUAGE_CODE_ID")
	  REFERENCES "EMRS_D_LANGUAGE" ("LANGUAGE_CODE_ID") ENABLE;
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" ADD CONSTRAINT "ORCHEVENT_ORCHACTV_FK" FOREIGN KEY ("ACTIVITY_ID")
	  REFERENCES "EMRS_D_OUTREACH_ACTIVITY" ("ACTIVITY_ID") ENABLE;
  ALTER TABLE "EMRS_F_OUTREACH_EVENT" ADD CONSTRAINT "ORCHEVENT_STAFF_FK" FOREIGN KEY ("STAFF_ID")
	  REFERENCES "EMRS_D_STAFF_PEOPLE" ("STAFF_ID") ENABLE;
