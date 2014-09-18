--------------------------------------------------------
--  DDL for Index OUTSELTRG_CNTY_FK_I
--------------------------------------------------------

  CREATE INDEX "OUTSELTRG_CNTY_FK_I" ON "EMRS_F_ORCH_SELECTED_TARGET" ("COUNTY_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
