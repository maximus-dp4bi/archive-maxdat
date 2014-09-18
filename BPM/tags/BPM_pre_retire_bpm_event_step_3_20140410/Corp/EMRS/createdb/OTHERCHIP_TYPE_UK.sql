--------------------------------------------------------
--  DDL for Index OTHERCHIP_TYPE_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "OTHERCHIP_TYPE_UK" ON "EMRS_D_OTHER_CHIP_CODE" ("OTHER_CHIP_CODE_TYPE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
