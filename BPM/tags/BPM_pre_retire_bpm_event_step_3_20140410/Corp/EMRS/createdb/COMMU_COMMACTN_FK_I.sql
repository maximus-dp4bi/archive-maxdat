--------------------------------------------------------
--  DDL for Index COMMU_COMMACTN_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_COMMACTN_FK_I" ON "EMRS_F_COMMUNICATION" ("COMMUNICATION_ACTION_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
