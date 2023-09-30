--------------------------------------------------------
--  DDL for Index ENROLL_PROGTYPE_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_PROGTYPE_FK_I" ON "EMRS_F_ENROLLMENT" ("PROGRAM_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
