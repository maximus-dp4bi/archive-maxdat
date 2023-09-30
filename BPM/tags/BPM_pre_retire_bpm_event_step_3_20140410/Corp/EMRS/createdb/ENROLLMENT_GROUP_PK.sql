--------------------------------------------------------
--  DDL for Index ENROLLMENT_GROUP_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ENROLLMENT_GROUP_PK" ON "EMRS_D_ENROLLMENT_NOTIFICATION" ("ENROLLMENT_GROUP_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
