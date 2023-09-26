--------------------------------------------------------
--  DDL for Index PROVIDRS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROVIDRS_PK" ON "EMRS_D_PROVIDER" ("PROVIDER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX IDX1_PROVIDERNUM_PROGRAM ON EMRS_D_PROVIDER(source_record_id, managed_care_program) TABLESPACE MAXDAT_INDX;   
  CREATE INDEX IDX2_PROVNUM_PROGRAM ON EMRS_D_PROVIDER(PROVIDER_NUMBER,MANAGED_CARE_PROGRAM) TABLESPACE MAXDAT_INDX;
  CREATE INDEX IDX3_PROVIDER_DATE ON EMRS_D_PROVIDER(date_of_validity_start,date_of_validity_end) TABLESPACE MAXDAT_INDX; 