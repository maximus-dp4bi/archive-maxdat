--------------------------------------------------------
--  DDL for Index ENRL_REJECTREASON_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ENRL_REJECTREASON_UK" ON "EMRS_D_ENROLLMENT_REJECTION" ("ENROLLMENT_ID", "REJECTION_ERROR_REASON_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
