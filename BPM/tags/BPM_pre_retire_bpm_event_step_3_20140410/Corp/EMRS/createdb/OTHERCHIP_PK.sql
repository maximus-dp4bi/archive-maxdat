--------------------------------------------------------
--  DDL for Index OTHERCHIP_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "OTHERCHIP_PK" ON "EMRS_D_OTHER_CHIP_CODE" ("OTHER_CHIP_CODE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
