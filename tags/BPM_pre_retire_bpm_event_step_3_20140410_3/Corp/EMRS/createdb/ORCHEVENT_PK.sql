--------------------------------------------------------
--  DDL for Index ORCHEVENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORCHEVENT_PK" ON "EMRS_F_OUTREACH_EVENT" ("OUTREACH_EVENT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
