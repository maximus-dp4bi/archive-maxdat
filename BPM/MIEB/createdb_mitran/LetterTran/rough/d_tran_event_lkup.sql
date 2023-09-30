create table d_tran_event_lkup (
name    varchar2(32)
,description  varchar2(100)
, report_label  varchar2(100)
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
  );
;

alter table d_tran_event_lkup
  add constraint tran_event_lkup_PK primary key (name);

CREATE OR REPLACE TRIGGER "BUIR_TRAN_EVENT_LKUP"
 BEFORE INSERT OR UPDATE
 ON d_tran_event_lkup
 FOR EACH ROW
BEGIN
  IF INSERTING THEN

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_TRAN_EVENT_LKUP;
