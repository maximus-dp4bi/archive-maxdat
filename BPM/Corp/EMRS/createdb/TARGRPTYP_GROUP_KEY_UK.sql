--------------------------------------------------------
--  DDL for Index TARGRPTYP_GROUP_KEY_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TARGRPTYP_GROUP_KEY_UK" ON "EMRS_D_TARGET_GROUP_TYPE" ("TARGET_GROUP_TYPE_CODE", "SOURCE_RECORD_ID", "TARGET_GROUP_TYPE_CATEGORY", "TARGET_GROUP_TYPE_NAME", "MANAGED_CARE_PROGRAM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
