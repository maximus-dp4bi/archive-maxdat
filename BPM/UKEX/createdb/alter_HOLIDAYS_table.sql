/*
|| Script to create a Holidays Table in MAXDAT for the UK-Exeter project, which does not have a Holidays Table in their schema.
||   This will be a custom script added to the install
||
|| DWD 3/12/2014
|| DWD 3/24/2014 - Alread have a holiday table in MAXDAT - - just using sequence and trigger
CREATE TABLE HOLIDAYS
(
HOLIDAY_ID         NUMBER(18) NOT NULL,    
HOLIDAY_YEAR       NUMBER(4),     
HOLIDAY_DATE       DATE,          
DESCRIPTION        VARCHAR2(128), 
CREATED_BY         VARCHAR2(80),  
CREATE_TS          DATE,          
UPDATED_BY         VARCHAR2(80),  
UPDATE_TS          DATE,          
EXCLUDED_PROCESSES VARCHAR2(120)
)
tablespace MAXDAT_DATA;

alter table HOLIDAYS add constraint HLDY_PK primary key (HOLIDAY_ID);
*/

grant select on HOLIDAYS to MAXDAT_READ_ONLY;

create sequence HOLIDAYS_SEQ;

create or replace trigger TRG_HOLIDAYS
before insert or update on HOLIDAYS
for each row
begin

  if inserting then
    :new.HOLIDAY_ID := HOLIDAYS_SEQ.nextval;
    :new.CREATED_BY := user;
    :new.CREATE_TS := sysdate;
    :new.UPDATED_BY := user;
    :new.UPDATE_TS := sysdate;
  end if;
  
  if updating then
    :new.UPDATED_BY := user;
    :new.UPDATE_TS := sysdate;
        
  end if;
  
end;
/

