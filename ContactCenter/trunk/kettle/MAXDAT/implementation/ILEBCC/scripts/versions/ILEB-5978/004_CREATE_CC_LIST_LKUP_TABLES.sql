-- Create the following tables for storing lookup values in ILEB contact center

create sequence CC_CELL_HISTORY_SEQ;

create sequence SEQ_CC_CELL_ID;
grant select on SEQ_CC_CELL_ID to MAXDAT_READ_ONLY; 

create table CC_A_LIST_LKUP
  (CC_CELL_ID    number not null,
   NAME       varchar2(30) not null,
   LIST_TYPE  varchar2(30) not null,
   VALUE      varchar2(100) not null,
   OUT_VAR    varchar2(500),
   REF_TYPE   varchar2(100),
   REF_ID     number(38),
   START_DATE date,
   END_DATE   date,
   COMMENTS   varchar2(4000),
   CREATED_TS date not null,
   UPDATED_TS date not null)
tablespace MAXDAT_DATA;

comment on table CC_A_LIST_LKUP is 'Used to create list of values to used when pulling data for savvion';

comment on column CC_A_LIST_LKUP.NAME is 'LIST(lookup rule name for list of values)/IFTHEN(IF VALUE THEN OUT_VAR)/ID(REFERENCE AND ID)';
comment on column CC_A_LIST_LKUP.VALUE is 'Either a list or reference value - Secondary lookup value';
comment on column CC_A_LIST_LKUP.OUT_VAR is 'Value to be extracted from table';
comment on column CC_A_LIST_LKUP.REF_TYPE is 'Table name if ref id is prim key';
comment on column CC_A_LIST_LKUP.REF_ID is 'Prim key when ref_type has table name';
comment on column CC_A_LIST_LKUP.START_DATE is 'used to turn on value';
comment on column CC_A_LIST_LKUP.END_DATE is 'Used to turn off value';

alter table CC_A_LIST_LKUP add constraint CC_A_LIST_LKUP_PK primary key (CC_CELL_ID)
using index tablespace MAXDAT_INDX;

alter table CC_A_LIST_LKUP add constraint CC_A_LIST_LKUP_UK unique (NAME,LIST_TYPE,VALUE)
using index tablespace MAXDAT_INDX;

grant select on CC_A_LIST_LKUP to MAXDAT_READ_ONLY; 


create table CC_A_LIST_LKUP_HIST
  (CC_CELL_HISTORY_ID number not null,
   HIST_TYPE       varchar2(100),
   CC_CELL_ID         number not null,
   NAME            varchar2(30) not null,
   LIST_TYPE       varchar2(30) not null,
   VALUE           varchar2(100) not null,
   OUT_VAR         varchar2(500),
   REF_TYPE        varchar2(100),
   REF_ID          number(38),
   START_DATE      date,
   END_DATE        date,
   COMMENTS        varchar2(4000),
   CREATED_TS      date not null,
   UPDATED_TS      date not null,
   HIST_CREATED_TS date not null,
   HIST_USER       varchar2(4000),
   HIST_UPDATED_TS date not null)
tablespace MAXDAT_DATA;

alter table CC_A_LIST_LKUP_HIST add constraint CC_A_LIST_LKUP_HIST_PK primary key (CC_CELL_HISTORY_ID)
using index tablespace MAXDAT_INDX;

grant select on CC_A_LIST_LKUP_HIST to MAXDAT_READ_ONLY;



create or replace trigger TRG_BIU_CC_A_LIST_LKUP
before insert or update on CC_A_LIST_LKUP
for each row
begin
  if inserting then
    if :new.CC_CELL_ID is null then
      :new.CC_CELL_ID := SEQ_CC_CELL_ID.nextval;
    end if;
    if :new.CREATED_TS is null then
      :new.CREATED_TS := sysdate;
    end if;
  end if;
  :new.UPDATED_TS := sysdate;
end;
/


create or replace trigger TRG_ADIU_CC_A_LIST_LKUP
after insert or update or delete on CC_A_LIST_LKUP
for each row
begin

  if inserting then
    insert into CC_A_LIST_LKUP_HIST
      (CC_CELL_HISTORY_ID,
       HIST_TYPE,
       CC_CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CC_CELL_HISTORY_SEQ.nextval,
       'INSERT',
       :new.CC_CELL_ID,
       :new.NAME,
       :new.LIST_TYPE,
       :new.VALUE,
       :new.OUT_VAR,
       :new.REF_TYPE,
       :new.REF_ID,
       :new.START_DATE, 
       :new.END_DATE,
       :new.COMMENTS,
       :new.CREATED_TS,
       :new.UPDATED_TS,
       sysdate,
       user,
       sysdate);
  end if;
  
  if updating then
    insert into CC_A_LIST_LKUP_HIST 
      (CC_CELL_HISTORY_ID,
       HIST_TYPE,
       CC_CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CC_CELL_HISTORY_SEQ.nextval,
       'UPDATE',
       :old.CC_CELL_ID,
       :old.name,
       :old.LIST_TYPE,
       :old.value,
       :old.OUT_VAR,
       :old.REF_TYPE,
       :old.REF_ID,
       :old.START_DATE,
       :old.END_DATE,
       :old.COMMENTS,
       :old.CREATED_TS,
       :old.UPDATED_TS,
       sysdate,
       user,
       sysdate);
       
  end if;
  
  if deleting then
    insert into CC_A_LIST_LKUP_HIST
      (CC_CELL_HISTORY_ID,
       HIST_TYPE,
       CC_CELL_ID,
       NAME,
       LIST_TYPE,
       VALUE,
       OUT_VAR,
       REF_TYPE,
       REF_ID,
       START_DATE,
       END_DATE,
       COMMENTS,
       CREATED_TS,
       UPDATED_TS,
       HIST_CREATED_TS,
       HIST_USER,
       HIST_UPDATED_TS)
    values
      (CC_CELL_HISTORY_SEQ.nextval,
       'DELETE',
       :old.CC_CELL_ID,
       :old.name,
       :old.LIST_TYPE,
       :old.value,
       :old.OUT_VAR,
       :old.REF_TYPE,
       :old.REF_ID,
       :old.START_DATE,
       :old.END_DATE,
       :old.COMMENTS,
       :old.CREATED_TS,
       :old.UPDATED_TS,
       sysdate,
       user,
       sysdate);
  end if;
  
end;
/

