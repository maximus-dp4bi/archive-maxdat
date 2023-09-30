CREATE OR REPLACE TRIGGER BUIR_ETL_L_MAILHOUSE
 BEFORE INSERT OR UPDATE
 ON ETL_L_MAILHOUSE
 FOR EACH ROW
BEGIN

  IF INSERTING THEN

    mieb_letters_etl_pkg.get_letter_job_ctrl_id
    (
        p_job_name              =>  'LOAD_EYR_DATA'
        ,p_filepath             =>  :NEW.filename
        ,p_job_ctrl_id          =>  :NEW.job_ctrl_id
        ,p_row_num              =>  :NEW.row_num
    );

    :NEW.record_content :=  

    :NEW.source_system || ',' || 
    :NEW.source_filename || ',' || 
    :NEW.record_number || ',' || 
    :NEW.letter_type || ',' || 
    :NEW.letter_request_id || ',' ||
    :NEW.printed_date || ',' ||
    :NEW.mailed_date || ',' || 
    :NEW.error_date || ',' ||
    :NEW.error_code;

    :NEW.created_by := user;
    :NEW.create_ts := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.update_ts := sysdate;

END BUIR_ETL_L_MAILHOUSE;
/

