--------------------------------------------------------
--  Constraints for Table EMRS_D_STATUS_IN_GROUP
--------------------------------------------------------

  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" ADD CONSTRAINT "STATNGRP_CATCODE_UK" UNIQUE ("STATUS_IN_GROUP_CODE", "STATUS_IN_GROUP_CATEGORY", "MANAGED_CARE_PROGRAM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" MODIFY ("STATUS_IN_GROUP" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" MODIFY ("STATUS_IN_GROUP_CODE" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" MODIFY ("STATUS_IN_GROUP_CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" MODIFY ("MANAGED_CARE_PROGRAM" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" MODIFY ("STATUS_IN_GROUP_ID" NOT NULL ENABLE);
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" ADD CONSTRAINT "STATNGRP_GRP_UK" UNIQUE ("STATUS_IN_GROUP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" ADD CONSTRAINT "STATNGRP_CAT_UK" UNIQUE ("STATUS_IN_GROUP_CATEGORY")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
  ALTER TABLE "EMRS_D_STATUS_IN_GROUP" ADD CONSTRAINT "STATNGRP_PK" PRIMARY KEY ("STATUS_IN_GROUP_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX"  ENABLE;
