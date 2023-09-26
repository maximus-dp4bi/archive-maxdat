--drop table d_tran_action_lkup;

create table d_tran_action_lkup (
action_code varchar2(50)
, action_description varchar2(200)
, report_label varchar2(100)
, effective_from date
, effective_to date
, event_name varchar2(100)
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

alter table d_tran_action_lkup
  add constraint tran_action_lkup_PK primary key (action_code);

CREATE OR REPLACE TRIGGER BUIR_TRAN_action_LKUP
 BEFORE INSERT OR UPDATE
 ON d_tran_action_lkup
 FOR EACH ROW
BEGIN
  IF INSERTING THEN

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.effective_from    :=  NVL(:NEW.effective_from, TO_DATE(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1 || '-01-01', 'YYYY-MM-DD'));
  :NEW.effective_to   :=  NVL(:NEW.effective_to, TO_DATE('7777-01-01', 'YYYY-MM-DD'));

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_TRAN_action_LKUP;
/

create or replace view d_tran_action_lkup_sv as select * from d_tran_action_lkup where trunc(sysdate) between effective_from and effective_to;

