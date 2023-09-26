create sequence tran_event_id_seq start with 1 increment by 1 cache 50;

create table d_tran_events (
tran_event_id   number(32)  
, event_date    date
, event_name    varchar2(100)
, tran_ref_table  varchar2(100)
, tran_ref_pkid   number(32)
, filename    varchar2(100)
, ltr_source_code varchar2(32)
, detail1_name    varchar2(50)
, detail2_name    varchar2(50)    
, detail3_name    varchar2(50)
, detail4_name    varchar2(50)
, detail5_name    varchar2(50)
, detail1_value   varchar2(50)
, detail2_value   varchar2(50)
, detail3_value   varchar2(50)
, detail4_value   varchar2(50)
, detail5_value   varchar2(50)
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

alter table d_tran_events
  add constraint TRAN_event_PK primary key (TRAN_event_ID);

CREATE OR REPLACE TRIGGER "BUIR_TRAN_EVENT"
 BEFORE INSERT OR UPDATE
 ON d_tran_events
 FOR EACH ROW
DECLARE
    v_seq_id     d_tran_events.tran_event_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.tran_event_id IS NULL THEN
        SElECT tran_event_id_seq.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.tran_event_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_TRAN_EVENT;
/

create or replace view d_tran_events_sv as select * from d_tran_Events;

