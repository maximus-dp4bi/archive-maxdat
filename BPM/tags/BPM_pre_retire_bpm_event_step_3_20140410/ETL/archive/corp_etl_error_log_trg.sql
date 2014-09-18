
CREATE OR REPLACE TRIGGER TRG_BIUR_CORP_ETL_ERROR_LOG
 BEFORE INSERT OR UPDATE
 ON CORP_ETL_ERROR_LOG
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.ceel_Id Is Null Then
                        Select Seq_ceel_Id.Nextval
                          Into :NEW.ceel_Id
                          From Dual;
                End If;
        IF :NEW.create_ts IS NULL THEN
                   :NEW.create_ts := SYSDATE;
                END IF;
        End If;
        :NEW.update_ts := SYSDATE;
End;
/  
