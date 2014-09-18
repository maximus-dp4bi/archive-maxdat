--------------------------------------------------------
--  DDL for Index ENROLL_SUBPROG_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_SUBPROG_FK_I" ON "EMRS_F_ENROLLMENT" ("SUB_PROGRAM_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
