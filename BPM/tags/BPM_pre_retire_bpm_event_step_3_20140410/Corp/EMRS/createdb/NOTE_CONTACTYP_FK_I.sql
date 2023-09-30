--------------------------------------------------------
--  DDL for Index NOTE_CONTACTYP_FK_I
--------------------------------------------------------

  CREATE INDEX "NOTE_CONTACTYP_FK_I" ON "EMRS_F_NOTE" ("CONTACT_TYPE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
