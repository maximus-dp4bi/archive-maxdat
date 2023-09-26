--------------------------------------------------------
--  DDL for Index ADDRESSPK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADDRESSPK" ON "EMRS_D_ADDRESS" ("ADDRESS_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX IDX1_ADDRESS ON emrs_d_address(source_record_id) TABLESPACE MAXDAT_INDX;            
  CREATE INDEX IDX2_ADDRESS ON emrs_d_address(case_number) TABLESPACE MAXDAT_INDX;            
  CREATE INDEX IDX3_ADDRESS ON emrs_d_address(addr_ctlk_id) TABLESPACE MAXDAT_INDX;            
  CREATE INDEX IDX4_ADDRESS ON emrs_d_address(addr_zip) TABLESPACE MAXDAT_INDX;            
  CREATE INDEX IDX5_ADDRESS ON emrs_d_address(addr_type_cd) TABLESPACE MAXDAT_INDX;            
  CREATE INDEX IDX6_ADDRESS ON emrs_d_address(source_addr_begin_date, source_addr_end_date) TABLESPACE MAXDAT_INDX;    
          