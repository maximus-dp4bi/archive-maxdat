CREATE OR REPLACE TRIGGER TRG_R_ETL_LIST_LKUP
 BEFORE INSERT OR UPDATE
 ON CORP_ETL_LIST_LKUP
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.cell_Id Is Null Then
                        Select Seq_cell_Id.Nextval
                          Into :NEW.cell_Id
                          From Dual;
                End If;
        IF :NEW.created_ts IS NULL THEN
                   :NEW.created_ts := SYSDATE;
                END IF;
        End If;
        :NEW.updated_ts := SYSDATE;
  End;
/
