--------------------------------------------------------
--  DDL for Index ENROLL_COMMTYP_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_COMMTYP_FK_I" ON "EMRS_F_ENROLLMENT" ("COMMUNICATION_TYPE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
