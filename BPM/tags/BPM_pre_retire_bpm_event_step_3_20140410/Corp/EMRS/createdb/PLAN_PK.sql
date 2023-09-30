--------------------------------------------------------
--  DDL for Index PLAN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PLAN_PK" ON "EMRS_D_PLAN" ("PLAN_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;

CREATE INDEX IDX_EMRSPLAN1 ON EMRS_D_PLAN(plan_code) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX_EMRSPLAN2 ON EMRS_D_PLAN(csda) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX_EMRSPLAN3 ON EMRS_D_PLAN(managed_care_program) TABLESPACE MAXDAT_INDX;