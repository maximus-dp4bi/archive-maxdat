--------------------------------------------------------
--  DDL for Index ADDRESSPK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADDRESSPK" ON "EMRS_D_ADDRESS" ("ADDRESS_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX IDX1_ADDRESS ON emrs_d_address(source_record_id) TABLESPACE MAXDAT_INDX;            
