--------------------------------------------------------
--  DDL for Index ENROLL_CHGREASON_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_CHGREASON_FK_I" ON "EMRS_F_ENROLLMENT" ("CHANGE_REASON_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
