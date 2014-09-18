--------------------------------------------------------
--  DDL for Index ZIPCODEPK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZIPCODEPK" ON "EMRS_D_ZIPCODE" ("ZIPCODE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
