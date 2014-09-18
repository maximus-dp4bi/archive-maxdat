alter session set plsql_code_type = native;

create or replace trigger TRG_AI_D_STAFF
after insert on STAFF_STG
for each row

begin

  insert into D_STAFF 
   (STAFF_ID,
    EXT_STAFF_NUMBER,
    FIRST_NAME,
    MIDDLE_INITAL,
    LAST_NAME,
    START_DATE,
    END_DATE,
    CREATE_TS,
    UPDATE_TS)
  values
   (:new.STAFF_ID,
    :new.EXT_STAFF_NUMBER,
    :new.FIRST_NAME,
    :new.MIDDLE_NAME,
    :new.LAST_NAME,
    :new.START_DATE,
    :new.END_DATE,
    :new.CREATE_TS,
    :new.UPDATE_TS);
end;
/


create or replace trigger TRG_AU_D_STAFF
after update on STAFF_STG 
for each row 

begin

        update D_STAFF
        set 
          EXT_STAFF_NUMBER = :new.EXT_STAFF_NUMBER ,
          FIRST_NAME = :new.FIRST_NAME,
          MIDDLE_INITAL = :new.MIDDLE_NAME,
          LAST_NAME = :new.LAST_NAME,
          START_DATE = :new.START_DATE,
          END_DATE = :new.END_DATE,
          CREATE_TS = :new.CREATE_TS,
          UPDATE_TS = :new.UPDATE_TS
        where STAFF_ID = :old.STAFF_ID
        and UPDATE_TS <> :new.UPDATE_TS;
end;
/

alter session set plsql_code_type = interpreted;