--------------------------------------------------------
--  DDL for Index COMMU_LANG_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_LANG_FK_I" ON "EMRS_F_COMMUNICATION" ("LANGUAGE_CODE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
