--------------------------------------------------------
--  DDL for Index NOTE_COMMSTAT_FK_I
--------------------------------------------------------

  CREATE INDEX "NOTE_COMMSTAT_FK_I" ON "EMRS_F_NOTE" ("COMMUNICATION_STATUS_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
