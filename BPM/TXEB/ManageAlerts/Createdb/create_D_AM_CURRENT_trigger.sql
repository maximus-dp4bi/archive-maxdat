  alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_D_AM_CURRENT 
before insert or update on D_AM_CURRENT
for each row
begin
  if inserting then
    if :new.am_ID is null then
      :new.am_ID := SEQ_am_ID.nextval;
    end if;
    if :new.create_dt is null then
      :new.create_dt  := sysdate;
    end if;
    if :new.created_by is null then
      :new.created_by  := user;
    end if;
    if :new.alert_status is not null then
      :new.alert_status_dt := sysdate;
    end if;
  end if;
  if updating then
    if :new.alert_status <> :old.alert_status or (:new.alert_status is not null and :old.alert_status is null) then
       :new.alert_status_dt := sysdate;
    end if;
  end if;  
end;
/

alter session set plsql_code_type = interpreted;
