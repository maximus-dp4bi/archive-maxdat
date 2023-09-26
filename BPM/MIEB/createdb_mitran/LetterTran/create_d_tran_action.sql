/*
drop sequence tran_action_id_seq;
drop view d_tran_action_sv;
drop table d_tran_action;
drop trigger BUIR_TRAN_action;
*/
/*
insert into d_tran_action(tran_date, action_code,filename, action_comments, action_date, action_user)
values (to_date('8/10/2022','mm/dd/yyyy'), 'REQA_TRAN', 'Aug102022_Transmittal.xlsx','Resending with correction after QA',to_date('8/14/2022','mm/dd/yyyy'), user);
select * from d_tran_events;
*/
create sequence tran_action_id_seq start with 1 increment by 1 cache 10;

drop table d_tran_action;

create table d_tran_action (
tran_action_id number(32)
, tran_date date
, action_code varchar2(100)
, action_code_other varchar2(100)
, action_date  date
, action_user  varchar2(100)
, filename     varchar2(100)
, action_comments varchar2(2000)
, create_ts   date
, update_ts   date
, created_by    varchar2(50)
, updated_by    varchar2(50)
) tablespace MAXDAT_MITRAN_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
;

alter table d_tran_action
  add constraint TRAN_action_PK primary key (TRAN_action_ID);

CREATE OR REPLACE TRIGGER BUIR_TRAN_action
 BEFORE INSERT OR UPDATE
 ON D_tran_action
 FOR EACH ROW
DECLARE
    v_seq_id     d_tran_action.tran_action_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.tran_action_id IS NULL THEN
        SElECT tran_action_id_seq.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.tran_action_id       := v_seq_id;
      END IF;

    if :new.created_by is null then
      :NEW.created_by := user;
    end if;  
    :NEW.create_ts := sysdate;

  END IF;

  if :new.updated_by is null then
    :NEW.updated_by := user;
  end if;  
  :NEW.update_ts := sysdate;

  if (inserting or (updating and :new.action_code <> :old.action_code)) then
     declare
     v_event_name varchar2(100);
     v_tran_header_id number(32);
     begin
       select event_name into v_event_name from d_tran_action_lkup al where al.action_code = :new.action_code and rownum = 1;
       if v_event_name is not null and :new.tran_date is not null then
          select tran_header_id into v_tran_header_id from d_tran_header th where th.tran_date = :new.tran_date and rownum = 1;
          if v_tran_header_id is not null then
             insert into d_tran_events(event_date,event_name,tran_ref_table,tran_ref_pkid, filename, ltr_source_code)
             values(:new.action_date, v_event_name, 'D_TRAN_HEADER',v_tran_header_id, :new.filename, null);
          end if;
       end if;
     exception when others then
       null;
     end;
  end if;


END BUIR_TRAN_action;
/

create or replace view d_tran_action_sv as select * from d_tran_action;
