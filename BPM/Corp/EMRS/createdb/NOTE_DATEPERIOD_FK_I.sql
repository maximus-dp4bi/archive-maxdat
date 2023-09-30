--------------------------------------------------------
--  DDL for Index NOTE_DATEPERIOD_FK_I
--------------------------------------------------------

  CREATE INDEX "NOTE_DATEPERIOD_FK_I" ON "EMRS_F_NOTE" ("DATE_PERIOD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
