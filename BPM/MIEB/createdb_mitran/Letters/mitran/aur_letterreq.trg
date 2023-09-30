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

