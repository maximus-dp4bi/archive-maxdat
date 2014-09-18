--------------------------------------------------------
--  DDL for Index COMMU_CLIENT_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_CLIENT_FK_I" ON "EMRS_F_COMMUNICATION" ("CLIENT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
