create or replace trigger TRG_BIU_D_DELTEK_HOURS_TMP
before insert or update on D_DELTEK_HOURS_TMP
for each row

begin

  if inserting then
          if :new.TMP_DDH_ID is null then
             :new.TMP_DDH_ID := seq_tmp_ddh_id.nextval;
          end if;
          :new.CREATE_DT := SYSDATE;
          :new.UPDATE_DT := SYSDATE;

        end if;

     if updating then
          :new.UPDATE_DT :=SYSDATE;
      end if;
end;
/
