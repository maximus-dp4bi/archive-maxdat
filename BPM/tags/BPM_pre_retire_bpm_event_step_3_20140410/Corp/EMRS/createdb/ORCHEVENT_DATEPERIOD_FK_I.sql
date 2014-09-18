--------------------------------------------------------
--  DDL for Index ORCHEVENT_DATEPERIOD_FK_I
--------------------------------------------------------

  CREATE INDEX "ORCHEVENT_DATEPERIOD_FK_I" ON "EMRS_F_OUTREACH_EVENT" ("DATE_PERIOD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
