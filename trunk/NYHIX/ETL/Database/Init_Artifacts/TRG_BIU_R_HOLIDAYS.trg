CREATE OR REPLACE TRIGGER TRG_BIU_R_HOLIDAYS
 BEFORE INSERT OR UPDATE
 ON HOLIDAYS
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.holiday_Id Is Null Then
                        Select Seq_holiday_Id.Nextval
                          Into :NEW.holiday_Id
                          From Dual;
                End If;
        IF :NEW.create_ts IS NULL THEN
                   :NEW.create_ts := SYSDATE;
                   :NEW.created_by := USER;

                END IF;
        End If;
        :NEW.update_ts := SYSDATE;
        :NEW.updated_by := USER;
END;
/
