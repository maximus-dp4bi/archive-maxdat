--------------------------------------------------------
--  DDL for Index COMMU_DATEPERIOD_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_DATEPERIOD_FK_I" ON "EMRS_F_COMMUNICATION" ("DATE_PERIOD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
