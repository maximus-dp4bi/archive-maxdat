--------------------------------------------------------
--  DDL for Index COMMU_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "COMMU_PK" ON "EMRS_F_COMMUNICATION" ("COMMUNICATION_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
