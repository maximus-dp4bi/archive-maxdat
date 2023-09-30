--------------------------------------------------------
--  DDL for Index CLIENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CLIENT_PK" ON "EMRS_D_CLIENT" ("CLIENT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX IDX1_CLIENTNUM_PROGRAM ON EMRS_D_CLIENT(source_record_id, managed_care_program) TABLESPACE MAXDAT_INDX;  
  CREATE INDEX IDX2_CLIENTNUM ON EMRS_D_CLIENT(CLIENT_NUMBER) TABLESPACE MAXDAT_INDX; 
  CREATE INDEX IDX3_CLIENT_DATE ON EMRS_D_CLIENT(date_of_validity_start,date_of_validity_end) TABLESPACE MAXDAT_INDX; 