--------------------------------------------------------
--  DDL for Index COMMU_TIMEPERI_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_TIMEPERI_FK_I" ON "EMRS_F_COMMUNICATION" ("TIME_PERIOD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
