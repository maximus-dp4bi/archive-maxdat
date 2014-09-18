--------------------------------------------------------
--  DDL for Index OUTSELTRG_TARGACTV_FK_I
--------------------------------------------------------

  CREATE INDEX "OUTSELTRG_TARGACTV_FK_I" ON "EMRS_F_ORCH_SELECTED_TARGET" ("TARGET_ACTIVITY_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
