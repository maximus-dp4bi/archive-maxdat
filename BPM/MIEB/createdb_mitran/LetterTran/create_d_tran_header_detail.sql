create sequence tran_job_id_seq start with 200000 increment by 1;
create sequence tran_header_id_seq start with 1 increment by 1 cache 10;
create sequence tran_detail_id_seq start with 1 increment by 1 cache 50;

--drop table d_tran_header;

Create table d_tran_header (
tran_header_id    number(32)
, project_code    varchar2(32)
, program_code    varchar2(32)    
, tran_date   date
, comments    varchar2(2000)
, create_ts   date
, update_ts   date
, created_by    varchar2(50)
, updated_by    varchar2(50)
)
tablespace MAXDAT_MITRAN_DATA
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
alter table d_tran_header
  add constraint TRAN_HEADER_PK primary key (TRAN_HEADER_ID);

create unique index D_TRAN_HEADER_UK on D_TRAN_HEADER (PROJECT_CODE, TRAN_DATE)
  tablespace MAXDAT_MITRAN_DATA
  pctfree 10
  initrans 2
  maxtrans 255;

CREATE OR REPLACE TRIGGER "BUIR_TRAN_HEADER"
 BEFORE INSERT OR UPDATE
 ON D_tran_header
 FOR EACH ROW
DECLARE
    v_seq_id     d_tran_HEADER.tran_header_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.tran_header_id IS NULL THEN
        SElECT tran_HEADER_id_seq.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.tran_header_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_TRAN_header;
/

create or replace view d_tran_header_sv as select * from d_tran_header;

--DROP TABLE D_TRAN_dETAIL; 
Create table d_tran_detail (
tran_Detail_id    number(32)
, tran_header_id  number(32)
, subprogram_code    varchar2(32)
, tran_job_id   number(32)
, LMDEF_ID  number(32)
, ltr_filename    varchar2(100)
, requested_qty   number(32)
, resent    varchar(10)
, preqa_eyr_ltr_filename  varchar2(100)
, preqa_eyr_ltr_qty   number(32)
, preqa_eyr_extra   varchar2(100)
, qa_abort_userid   varchar2(100)
, qa_split_qty      number(32)
, qa_rejected_qty   number(32)
, qa_comments     varchar2(1000)
, qa_signed     varchar2(100)
, qa_date     date
, qa_userid     varchar2(100)
, eyr_mailed_date   date
, eyr_mailed_qty    number(32)
, eyr_ps_checked    varchar2(100)
, eyr_ps_comments   varchar2(100)
, invoiced      varchar2(1)
, invoiced_date     date
, comments    varchar2(2000)
, form_created_by varchar2(50)
, form_updateD_by varchar2(50)
, create_ts   date
, update_ts   date
, created_by    varchar2(50)
, updated_by    varchar2(50)
)
tablespace MAXDAT_MITRAN_DATA
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

alter table d_tran_DETAIL
  add constraint TRAN_DETAIL_PK primary key (TRAN_DETAIL_ID);
  
alter table d_tran_detail 
      add constraint TRAN_DETAIL_FK foreign key (tran_header_id) references d_tran_header(tran_header_id);
        

create unique index D_TRAN_DETAIL_UK on D_TRAN_DETAIL (tran_header_id, subPROGRAM_CODE, lmdef_id)
  tablespace MAXDAT_MITRAN_DATA
  pctfree 10
  initrans 2
  maxtrans 255;


CREATE OR REPLACE TRIGGER BUIR_TRAN_detail
 BEFORE INSERT OR UPDATE
 ON D_tran_detail
 FOR EACH ROW
DECLARE
    v_seq_id     d_tran_detail.tran_detail_id%TYPE;
BEGIN

  IF INSERTING THEN

      if :new.qa_signed is not null then
        :new.qa_date := sysdate;
      end if;

      IF :NEW.tran_detail_id IS NULL THEN
        SElECT tran_detail_id_seq.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.tran_detail_id       := v_seq_id;
      END IF;

      IF :NEW.tran_job_id IS NULL THEN
        SElECT tran_job_id_seq.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.tran_job_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

    if :new.form_Created_by is not null then
        ins_tran_Event(:new.create_ts, 'TRAN_LETTER_DETAIL_ADDED','D_TRAN_DETAIL',:new.tran_Detail_id);
    else
        ins_tran_Event(:new.create_ts, 'TRAN_LETTER_DETAIL_ADDED_SYSTEM','D_TRAN_DETAIL',:new.tran_Detail_id);
    end if;

  else
        :NEW.updated_by := user;
        :NEW.update_ts := sysdate;
       if (
         nvl(:new.qa_signed,'A') <> nvl(:old.qa_signed,'A')
         ) then
           :new.qa_date := sysdate;
        elsif :new.qa_signed is null then
          :new.qa_date := null;
          :new.qa_userid := null;
        end if;

       if :new.form_updated_by is not null then
          ins_tran_Event(:new.create_ts, 'TRAN_LETTER_DETAIL_UPDATED','D_TRAN_DETAIL',:new.tran_Detail_id);
       end if;
       if :new.qa_signed is not null and :old.qa_signed is null then
          ins_tran_Event(:new.create_ts, 'TRAN_LETTER_DETAIL_QA_DONE','D_TRAN_DETAIL',:new.tran_Detail_id);
       end if;
       if (
         nvl(:new.qa_abort_userid ,'A') <> nvl(:old.qa_abort_userid,'A') or
         nvl(:new.qa_split_qty ,-99999999) <> nvl(:old.qa_split_qty,-99999999) or
         nvl(:new.qa_rejected_qty ,-99999999) <> nvl(:old.qa_rejected_qty,-99999999) or
         nvl(:new.qa_date ,to_date('1/1/1900','mm/dd/yyyy')) <> nvl(:old.qa_date,to_date('1/1/1900','mm/dd/yyyy'))
         ) then
          ins_tran_Event(:new.create_ts, 'TRAN_LETTER_DETAIL_QA_EDIT'
          ,'D_TRAN_DETAIL',:new.tran_Detail_id
          , 'QA_ABORT_USERID',:NEW.qa_abort_userid
          ,'QA_SPLIT_QTY',TO_CHAR(:NEW.qa_split_qty)
          ,'QA_REJECTED_QTY',TO_CHAR(:NEW.qa_rejected_qty)
          );
       end if;
  end if;

END BUIR_TRAN_detail;
/

alter table d_tran_detail add (
adjust_reason_code varchar2(32)
);

create or replace view d_tran_detail_sv as select * from d_tran_detail;


grant select,insert, update on d_tran_detail to MAXDAT_MITRAN_OLTP_SIU;
grant select,insert, update, delete on d_tran_detail to MAXDAT_MITRAN_OLTP_SIUD;
grant select on d_tran_detail to MAXDAT_MITRAN_READ_ONLY;
grant select on d_tran_detail_sv to MAXDAT_MITRAN_READ_ONLY;
