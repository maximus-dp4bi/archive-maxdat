--------------------------------------------------------
--  DDL for Index OUTSELTRG_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "OUTSELTRG_PK" ON "EMRS_F_ORCH_SELECTED_TARGET" ("OUTREACH_SELECTED_TARGET_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
