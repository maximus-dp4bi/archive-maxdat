--------------------------------------------------------
--  DDL for Index ENROLL_STATNGRP_FK_I
--------------------------------------------------------

  CREATE INDEX "ENROLL_STATNGRP_FK_I" ON "EMRS_F_ENROLLMENT" ("STAT_IN_GRP_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
