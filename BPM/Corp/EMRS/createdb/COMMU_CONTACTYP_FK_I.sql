--------------------------------------------------------
--  DDL for Index COMMU_CONTACTYP_FK_I
--------------------------------------------------------

  CREATE INDEX "COMMU_CONTACTYP_FK_I" ON "EMRS_F_COMMUNICATION" ("CONTACT_TYPE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
