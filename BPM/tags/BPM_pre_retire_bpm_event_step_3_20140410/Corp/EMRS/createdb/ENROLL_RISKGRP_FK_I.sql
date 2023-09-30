--------------------------------------------------------
--  DDL for Index ENROLL_RISKGRP_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_RISKGRP_FK_I" ON "EMRS_F_ENROLLMENT" ("RISK_GROUP_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
