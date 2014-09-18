--------------------------------------------------------
--  DDL for Index ENROLL_ENRLASTAT_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_ENRLASTAT_FK_I" ON "EMRS_F_ENROLLMENT" ("ENROLLMENT_ACTION_STATUS_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
