--------------------------------------------------------
--  DDL for Index COMMU_CNTY_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_CNTY_FK_I" ON "EMRS_F_COMMUNICATION" ("COUNTY_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
