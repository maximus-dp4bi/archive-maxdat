CREATE OR REPLACE TRIGGER MAXDAT.TRG_BIUR_Dev_Knowledge_Base
 BEFORE INSERT OR UPDATE
 ON Dev_Knowledge_Base
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.DKB_Id Is Null Then
                        Select Seq_dkb_Id.Nextval
                          Into :NEW.DKB_Id
                          From Dual;
                End If;
                :NEW.create_ts := SYSDATE;
                :new.create_by := user;

        End If;
        :NEW.update_ts := SYSDATE;
        :new.update_by := user;
End;
/
