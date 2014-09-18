CREATE OR REPLACE TRIGGER TRG_R_BIU_BPM_ATTRIBUTE
 BEFORE INSERT OR UPDATE
 ON BPM_ATTRIBUTE
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.BA_ID Is Null Then
                        Select SEQ_BA_ID.Nextval
                          Into :new.BA_ID
                          From Dual;
                End If;
                IF :NEW.EFFECTIVE_DATE IS NULL THEN
                   SELECT SYSDATE INTO :NEW.EFFECTIVE_DATE FROM dual;
                END IF;
                IF :NEW.END_DATE IS NULL THEN
                   SELECT TO_DATE('20770707','YYYYMMDD') INTO :NEW.END_DATE FROM dual;
                END IF;                
        End If;
End;
/

CREATE OR REPLACE TRIGGER TRG_R_BIU_BPM_INSTANCE
 BEFORE INSERT OR UPDATE
 ON BPM_INSTANCE
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.BI_ID Is Null Then
                        Select SEQ_BI_ID.Nextval
                          Into :new.BI_ID
                          From Dual;
                End If;
                If :new.END_DATE is null then
                  :new.END_DATE := TO_DATE('20770707','YYYYMMDD');
                END IF;
        End If;
End;
/

CREATE OR REPLACE TRIGGER TRG_R_BIU_BPM_INSTANCE_ATTR
 BEFORE INSERT OR UPDATE
 ON BPM_INSTANCE_ATTRIBUTE
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.BIA_ID Is Null Then
                        Select SEQ_BIA_ID.Nextval
                          Into :new.BIA_ID
                          From Dual;
                End If;
                IF :NEW.START_DATE IS NULL THEN
                   SELECT SYSDATE INTO :NEW.START_DATE FROM dual;
                END IF;
                IF :NEW.END_DATE IS NULL THEN
                   SELECT TO_DATE('20770707','YYYYMMDD') INTO :NEW.END_DATE FROM dual;
                END IF;
        End If;
End;
/


CREATE OR REPLACE TRIGGER TRG_R_BIU_BPM_UPDATE_EVENT
 BEFORE INSERT OR UPDATE
 ON BPM_UPDATE_EVENT
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.BUE_ID Is Null Then
                        Select SEQ_BUE_ID.Nextval
                          Into :new.BUE_ID
                          From Dual;
                End If;
        End If;
End;
/

CREATE OR REPLACE TRIGGER TRG_R_BIU_BPM_ACTIVITY_EVENTS
 BEFORE INSERT OR UPDATE
 ON BPM_ACTIVITY_EVENTS
 FOR EACH ROW
Begin
        If Inserting Then
                If :new.BACE_ID Is Null Then
                        Select SEQ_BACE_ID.Nextval
                          Into :new.BACE_ID
                          From Dual;
                End If;
                IF :NEW.EVENT_DATE IS NULL THEN
                   SELECT SYSDATE INTO :NEW.EVENT_DATE FROM dual;
                END IF;
        End If;
End;
/
