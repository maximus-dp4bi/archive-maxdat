CREATE OR REPLACE TRIGGER TRG_R_AIUD_ETL_LIST_LKUP_HIST
AFTER INSERT OR UPDATE OR DELETE
 ON CORP_ETL_LIST_LKUP
 FOR EACH ROW
Begin
        If Inserting Then
          insert into CORP_ETL_LIST_LKUP_HIST VALUES
          (CELL_HISTORY_SEQ.nextval,--"CELL_HISTORY_ID" 
           'INSERT',--"HIST_TYPE" 
           :new.cell_id,--"CELL_ID" 
           :new.name,--"NAME" 
           :new.LIST_TYPE,--"LIST_TYPE" 
           :new.VALUE,--"VALUE" 
           :new.OUT_VAR,--"OUT_VAR" 
           :new.REF_TYPE,--"REF_TYPE" 
           :new.REF_ID,--"REF_ID" 
           :new.START_DATE,--"START_DATE" 
           :new.END_DATE,--"END_DATE"
           :new.COMMENTS,--"COMMENTS" 
           :new.CREATED_TS,--"CREATED_TS" 
           :new.UPDATED_TS,--"UPDATED_TS" 
           sysdate,--"HIST_CREATED_TS" 
           user,   --HIST_USER
           sysdate--"HIST_UPDATED_TS" 
           );
        End If;
        If Updating Then
          insert into CORP_ETL_LIST_LKUP_HIST VALUES
          (CELL_HISTORY_SEQ.nextval,--"CELL_HISTORY_ID"
           'UPDATE',--"HIST_TYPE"
           :old.cell_id,--"CELL_ID"
           :old.name,--"NAME"
           :old.LIST_TYPE,--"LIST_TYPE"
           :old.VALUE,--"VALUE"
           :old.OUT_VAR,--"OUT_VAR"
           :old.REF_TYPE,--"REF_TYPE"
           :old.REF_ID,--"REF_ID"
           :old.START_DATE,--"START_DATE"
           :old.END_DATE,--"END_DATE"
           :old.COMMENTS,--"COMMENTS"
           :old.CREATED_TS,--"CREATED_TS"
           :old.UPDATED_TS,--"UPDATED_TS"
           sysdate,--"HIST_CREATED_TS"
           user,   --HIST_USER
           sysdate--"HIST_UPDATED_TS"
           );
        End If;
        If Deleting Then
          insert into CORP_ETL_LIST_LKUP_HIST VALUES
          (CELL_HISTORY_SEQ.nextval,--"CELL_HISTORY_ID"
           'DELETE',--"HIST_TYPE"
           :old.cell_id,--"CELL_ID"
           :old.name,--"NAME"
           :old.LIST_TYPE,--"LIST_TYPE"
           :old.VALUE,--"VALUE"
           :old.OUT_VAR,--"OUT_VAR"
           :old.REF_TYPE,--"REF_TYPE"
           :old.REF_ID,--"REF_ID"
           :old.START_DATE,--"START_DATE"
           :old.END_DATE,--"END_DATE"
           :old.COMMENTS,--"COMMENTS"
           :old.CREATED_TS,--"CREATED_TS"
           :old.UPDATED_TS,--"UPDATED_TS"
           sysdate,--"HIST_CREATED_TS"
           user,   --HIST_USER
           sysdate--"HIST_UPDATED_TS"
           );
        End If;
  End;
/
