create sequence tran_comm_id_seq start with 1 increment by 1 cache 10;

create table d_tran_comm (
tran_comm_id number(32)
, tran_date date
, action_taken varchar2(100)
, action_taken_other varchar2(100)
, action_date  date
, action_user  varchar2(100)
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

alter table d_tran_comm
  add constraint TRAN_comm_PK primary key (TRAN_comm_ID);

CREATE OR REPLACE TRIGGER "BUIR_TRAN_comm"
 BEFORE INSERT OR UPDATE
 ON D_tran_comm
 FOR EACH ROW
DECLARE
    v_seq_id     d_tran_comm.tran_comm_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.tran_comm_id IS NULL THEN
        SElECT tran_comm_id_seq.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.tran_comm_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_TRAN_comm;
/

create or replace view d_tran_comm_sv as select * from d_tran_comm;
