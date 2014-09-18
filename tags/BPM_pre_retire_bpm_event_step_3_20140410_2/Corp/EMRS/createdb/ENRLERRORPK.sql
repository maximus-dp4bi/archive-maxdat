--------------------------------------------------------
--  DDL for Index ENRLERRORPK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ENRLERRORPK" ON "EMRS_D_ENROLLMENT_ERROR_CODE" ("ENROLLMENT_ERROR_CODE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
