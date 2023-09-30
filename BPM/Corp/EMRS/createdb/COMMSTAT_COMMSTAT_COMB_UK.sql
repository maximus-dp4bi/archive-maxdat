--------------------------------------------------------
--  DDL for Index COMMSTAT_COMMSTAT_COMB_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "COMMSTAT_COMMSTAT_COMB_UK" ON "EMRS_D_COMMUNICATION_STATUS" ("MANAGED_CARE_PROGRAM", "COMMUNICATION_STATUS_CODE", "COMMUNICATION_STATUS_NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
