--------------------------------------------------------
--  DDL for Index ENROLL_REJERR_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_REJERR_FK_I" ON "EMRS_F_ENROLLMENT" ("REJECTION_ERROR_REASON_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
