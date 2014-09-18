--------------------------------------------------------
--  DDL for Index SCHODIST_SCHODIST_COMB_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCHODIST_SCHODIST_COMB_UK" ON "EMRS_D_SCHOOL_DISTRICT" ("MANAGED_CARE_PROGRAM", "SOURCE_RECORD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
