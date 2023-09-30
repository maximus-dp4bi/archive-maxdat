
-- Create table
create table D_LETTER_REQUEST_HIST
(
  dp_letter_request_hist_id       NUMBER not null,
  dp_letter_request_id       NUMBER not null,
  letter_request_id          NUMBER(18),
  lmdef_id                   NUMBER(18),
  requested_on               DATE,
  status_cd                  VARCHAR2(32),
  sent_on                    DATE,
  created_by                 VARCHAR2(80),
  create_ts                  DATE,
  updated_by                 VARCHAR2(80),
  update_ts                  DATE,
  printed_on                 DATE,
  return_date                DATE,
  parent_lmreq_id            NUMBER(18),
  reprint_parent_lmreq_id    NUMBER(18),
  program_type_cd            VARCHAR2(32),
  mailed_date                DATE,
  reject_reason_cd           VARCHAR2(32),
  dp_updated_by              VARCHAR2(80),
  dp_date_updated            DATE,
  dp_created_by              VARCHAR2(80),
  dp_date_created            DATE,
  program_con_xwalk_code     VARCHAR2(30),
  con_status_code            VARCHAR2(80),
  con_update_code            VARCHAR2(80),
  con_mailing_date           DATE,
  con_control_number         VARCHAR2(80),
  con_recipient_id           VARCHAR2(80),
  con_mi_card_id             VARCHAR2(80),
  con_job_ctrl_id            NUMBER(38),
  con_source_job_id          NUMBER(38),
  con_source_row_num         NUMBER(1),
  con_error_count            NUMBER(18),
  stg_checksum               NUMBER(10),
  new_status_cd              varchar2(32),
  new_mailed_date            date,
  new_con_mailed_date        date,
  new_con_status_code        varchar2(80),
  new_con_update_code        varchar2(80),
  new_con_mailing_date       date
)
tablespace MAXDAT_MIEB_DATA
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

CREATE UNIQUE INDEX D_LETTER_REQUEST_HIST_PK ON D_LETTER_REQUEST_HIST  (DP_LETTER_REQUEST_HIST_ID ASC) TABLESPACE MAXDAT_MIEB_DATA;
ALTER TABLE D_LETTER_REQUEST_HIST ADD CONSTRAINT D_LETTER_REQUEST_HIST_PK PRIMARY KEY (DP_LETTER_REQUEST_HIST_ID) USING INDEX D_LETTER_REQUEST_HIST_PK ENABLE;

CREATE SEQUENCE D_SEQ_LETTER_HIST_ID INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20;

create or replace trigger AUR_LETTERREQ
 after UPDATE
 ON d_letter_request
 FOR EACH ROW
DECLARE
    v_seq_id     D_LETTER_REQUEST_hist.dp_letter_request_hist_id%TYPE;
BEGIN

IF
:NEW.status_cd                  != :OLD.status_cd
OR (:NEW.mailed_date                != :OLD.mailed_date and :new.mailed_date is not null and :old.mailed_date is not null)
OR (:NEW.con_status_code            != :OLD.con_status_code and :new.con_status_code is not null and :old.con_status_code is not null)
OR (:NEW.con_update_code            != :OLD.con_update_code and :new.con_update_code is not null and :old.con_update_code is not null)
OR (:NEW.con_mailing_date           != :OLD.con_mailing_date and :new.con_mailing_date is not null and :old.con_mailing_date is not null)
THEN
  select D_SEQ_LETTER_HIST_ID.nextval into v_seq_id from dual;

          INSERT INTO D_LETTER_REQUEST_HIST (
          dp_letter_request_hist_id
          ,dp_letter_request_id
        ,letter_request_id
        ,lmdef_id
        ,requested_on
        ,status_cd
        ,sent_on
        ,created_by
        ,create_ts
        ,updated_by
        ,update_ts
        ,printed_on
        ,return_date
        ,parent_lmreq_id
        ,reprint_parent_lmreq_id
        ,program_type_cd
        ,mailed_date
        ,reject_reason_cd
        ,dp_updated_by
        ,dp_date_updated
        ,dp_created_by
        ,dp_date_created
        ,program_con_xwalk_code
        ,con_status_code
        ,con_update_code
        ,con_mailing_date
        ,con_control_number
        ,con_recipient_id
        ,con_mi_card_id
        ,con_job_ctrl_id
        ,con_source_job_id
        ,con_source_row_num
        ,con_error_count
        ,stg_checksum
        ,new_status_cd
        ,new_mailed_date
        ,new_con_mailed_date
        ,new_con_status_code
        ,new_con_update_code
        ,new_con_mailing_date
        )
        VALUES
        (
         v_seq_id
        ,:OLD.dp_letter_request_id
        ,:OLD.letter_request_id
        ,:OLD.lmdef_id
        ,:OLD.requested_on
        ,:OLD.status_cd
        ,:OLD.sent_on
        ,:OLD.created_by
        ,:OLD.create_ts
        ,:OLD.updated_by
        ,:OLD.update_ts
        ,:OLD.printed_on
        ,:OLD.return_date
        ,:OLD.parent_lmreq_id
        ,:OLD.reprint_parent_lmreq_id
        ,:OLD.program_type_cd
        ,:OLD.mailed_date
        ,:OLD.reject_reason_cd
        ,:OLD.dp_updated_by
        ,:OLD.dp_date_updated
        ,:OLD.dp_created_by
        ,:OLD.dp_date_created
        ,:OLD.program_con_xwalk_code
        ,:OLD.con_status_code
        ,:OLD.con_update_code
        ,:OLD.con_mailing_date
        ,:OLD.con_control_number
        ,:OLD.con_recipient_id
        ,:OLD.con_mi_card_id
        ,:OLD.con_job_ctrl_id
        ,:OLD.con_source_job_id
        ,:OLD.con_source_row_num
        ,:OLD.con_error_count
        ,:OLD.stg_checksum
        ,:new.status_cd
        ,:new.mailed_date
        ,:new.con_mailing_date
        ,:new.con_status_code
        ,:new.con_update_code
        ,:new.con_mailing_date
        );
  end if;

END AUR_LETTERREQ;
/

-- Grant/Revoke object privileges 
grant select on D_LETTER_REQUEST_hist to MAXDAT_MIEB_READ_ONLY;
grant select, insert, update, delete on D_LETTER_REQUEST_hist to SR18956;
grant select, insert, update, delete on D_LETTER_REQUEST_hist to TM151500;
