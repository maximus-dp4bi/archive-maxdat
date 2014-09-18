--------------------------------------------------------
--  DDL for Index ENROLL_GROUP_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ENROLL_GROUP_UK" ON "EMRS_F_ENROLLMENT" ("ENROLLMENT_GROUP_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
