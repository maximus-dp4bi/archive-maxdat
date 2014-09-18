--------------------------------------------------------
--  DDL for Index COMMU_PROGTYPE_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_PROGTYPE_FK_I" ON "EMRS_F_COMMUNICATION" ("PROGRAM_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
