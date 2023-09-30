drop trigger TRG_R_BIU_BPM_INSTANCE;

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

drop trigger TRG_R_BIU_BPM_INSTANCE_ATTR;

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

update BPM_INSTANCE set END_DATE = to_date('20770707','YYYYMMDD') where END_DATE is null;
commit;