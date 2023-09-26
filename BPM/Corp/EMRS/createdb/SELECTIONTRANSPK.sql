--------------------------------------------------------
--  DDL for Index SELECTIONTRANSPK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SELECTIONTRANSPK" ON "EMRS_D_SELECTION_TRANSACTION" ("SELECTION_TRANSACTION_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;

  CREATE INDEX "IDX1_SELECTIONTRANS" ON "EMRS_D_SELECTION_TRANSACTION" ("SOURCE_RECORD_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "MAXDAT_INDX" ;
  
 CREATE INDEX IDX2_SELECTION_TRANS ON emrs_d_selection_transaction (selection_transaction_id,TRANSACTION_TYPE_CD,current_selection_status_id,record_date) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
 CREATE INDEX IDX3_SELECTION_TRANS ON emrs_d_selection_transaction (selection_transaction_id,TRANSACTION_TYPE_CD,current_selection_status_id,client_number,record_date) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
 CREATE INDEX IDX4_SELECTION_TRANS ON emrs_d_selection_transaction (selection_source_cd) tablespace MAXDAT_INDX;