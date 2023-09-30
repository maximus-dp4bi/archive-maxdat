--------------------------------------------------------
--  Constraints for Table EMRS_D_TIME_PERIOD
--------------------------------------------------------

  ALTER TABLE "EMRS_D_TIME_PERIOD" ADD CONSTRAINT "TIMEPERI_PK" PRIMARY KEY ("TIME_PERIOD_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("MILITARY_SECOND" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("MILITARY_MINUTE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("MILITARY_HOUR" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("SECOND" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("MINUTE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("HOUR" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("OPEN_LUNCH_CLOSE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("MORNING_NOON_NIGHT" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("HOUR_MINUTE_MILITARY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("HOUR_MINUTE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_TIME_PERIOD" MODIFY ("TIME_PERIOD_ID" NOT NULL ENABLE);