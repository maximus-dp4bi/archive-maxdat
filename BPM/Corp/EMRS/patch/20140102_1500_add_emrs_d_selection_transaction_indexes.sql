CREATE INDEX IDX2_SELECTION_TRANS ON emrs_d_selection_transaction (selection_transaction_id,TRANSACTION_TYPE_CD,current_selection_status_id,record_date) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX3_SELECTION_TRANS ON emrs_d_selection_transaction (selection_transaction_id,TRANSACTION_TYPE_CD,current_selection_status_id,client_number,record_date) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);