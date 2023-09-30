-- C:\Documents and Settings\user\Desktop\MW_ETL.trg
--
-- Generated for Oracle 10g on Fri Jun 01  08:58:02 2012 by Server Generator 9.0.2.95.9
 

PROMPT Creating Trigger 'TRG_R_ETL_LIST_LKUP'
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
SHOW ERROR






PROMPT Creating Trigger 'TRG_BIU_R_HOLIDAYS'
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
SHOW ERROR

















