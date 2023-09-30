--------------------------------------------------------
--  DDL for Index COMMSTAT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "COMMSTAT_PK" ON "EMRS_D_COMMUNICATION_STATUS" ("COMMUNICATION_STATUS_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
