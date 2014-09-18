--------------------------------------------------------
--  DDL for Index NOTE_CNTY_FK_I
--------------------------------------------------------

  CREATE INDEX "NOTE_CNTY_FK_I" ON "EMRS_F_NOTE" ("COUNTY_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
