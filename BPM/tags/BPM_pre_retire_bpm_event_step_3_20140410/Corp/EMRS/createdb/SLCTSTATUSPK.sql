--------------------------------------------------------
--  DDL for Index SLCTSTATUSPK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SLCTSTATUSPK" ON "EMRS_D_SELECTION_STATUS" ("SELECTION_STATUS_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
