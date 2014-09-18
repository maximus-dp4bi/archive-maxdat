--------------------------------------------------------
--  DDL for Index NOTE_CLIENT_FK_I
--------------------------------------------------------

  CREATE INDEX "NOTE_CLIENT_FK_I" ON "EMRS_F_NOTE" ("CLIENT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
