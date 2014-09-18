--------------------------------------------------------
--  DDL for Index NOTE_COMMACTN_FK_I
--------------------------------------------------------

  CREATE INDEX "NOTE_COMMACTN_FK_I" ON "EMRS_F_NOTE" ("COMMUNICATION_ACTION_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
