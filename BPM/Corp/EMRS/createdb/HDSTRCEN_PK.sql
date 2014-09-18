--------------------------------------------------------
--  DDL for Index HDSTRCEN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HDSTRCEN_PK" ON "EMRS_S_HEADSTART_GRANT_CENTERS" ("SOURCE_RECORD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
