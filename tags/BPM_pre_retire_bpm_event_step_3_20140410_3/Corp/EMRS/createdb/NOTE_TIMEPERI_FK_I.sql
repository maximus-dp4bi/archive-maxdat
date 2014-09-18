--------------------------------------------------------
--  DDL for Index NOTE_TIMEPERI_FK_I
--------------------------------------------------------

  CREATE INDEX "NOTE_TIMEPERI_FK_I" ON "EMRS_F_NOTE" ("TIME_PERIOD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
