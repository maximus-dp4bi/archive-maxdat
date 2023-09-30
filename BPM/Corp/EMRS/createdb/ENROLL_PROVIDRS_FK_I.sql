--------------------------------------------------------
--  DDL for Index ENROLL_PROVIDRS_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_PROVIDRS_FK_I" ON "EMRS_F_ENROLLMENT" ("PROVIDER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
