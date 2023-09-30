alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_BPM_ACTIVITY_EVENTS
before insert or update on BPM_ACTIVITY_EVENTS
for each row
begin
  if inserting then
  
    if :new.BACE_ID is null then
      :new.BACE_ID := SEQ_BACE_ID.nextval;
    end if;
    
    if :new.EVENT_DATE is null then
      :new.EVENT_DATE := sysdate;
    end if;
                
  end if;
end;
/

create or replace trigger TRG_BIU_BPM_ATTRIBUTE
before insert or update on BPM_ATTRIBUTE
for each row
begin
  if inserting then
  
    if :new.BA_ID is null then
      :new.BA_ID := SEQ_BA_ID.nextval;
    end if;
    
    if :new.EFFECTIVE_DATE is null then
      :new.EFFECTIVE_DATE := sysdate;
    end if;
    
    if :new.END_DATE is null then
      :new.END_DATE := BPM_COMMON.GET_MAX_DATE;
    end if;
   
  end if;
end;
/


create or replace trigger TRG_BIU_BPM_INSTANCE
before insert or update on BPM_INSTANCE
for each row
begin
  if inserting then
  
    if :new.BI_ID is null then
      :new.BI_ID := SEQ_BI_ID.nextval;
    end if;
    
    if :new.END_DATE is null then
      :new.END_DATE := BPM_COMMON.GET_MAX_DATE;
    end if;
    
  end if;
end;
/


create or replace trigger TRG_BIU_BPM_INSTANCE_ATTR
before insert or update on BPM_INSTANCE_ATTRIBUTE
for each row
begin
  if inserting then
  
    if :new.BIA_ID is null then
      :new.BIA_ID := SEQ_BIA_ID.nextval;
    end if;
    
    if :new.start_date is null then
      :new.START_DATE := sysdate;
    end if;
    
    if :new.end_date is null then
      :new.END_DATE := BPM_COMMON.GET_MAX_DATE;
    end if;
                
  end if;
end;
/


create or replace trigger TRG_BIU_BPM_UPDATE_EVENT
before insert or update
on BPM_UPDATE_EVENT
for each row
begin
  if inserting then
  
    if :new.BUE_ID is null then
      :new.BUE_ID := SEQ_BUE_ID.nextval;
    end if;
    
  end if;
end;
/


alter session set plsql_code_type = interpreted;