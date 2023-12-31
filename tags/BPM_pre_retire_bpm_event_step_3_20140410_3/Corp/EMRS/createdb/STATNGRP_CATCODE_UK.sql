--------------------------------------------------------
--  DDL for Index STATNGRP_CATCODE_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "STATNGRP_CATCODE_UK" ON "EMRS_D_STATUS_IN_GROUP" ("STATUS_IN_GROUP_CODE", "STATUS_IN_GROUP_CATEGORY", "MANAGED_CARE_PROGRAM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;
