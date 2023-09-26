create or replace package MIEB_LETTERS_ETL_PKG as

    -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '';
    SVN_REVISION varchar2(20) := '';
    SVN_REVISION_DATE varchar2(60) := '';
    SVN_REVISION_AUTHOR varchar2(20) := '';

    con_pkg       CONSTANT    VARCHAR2(30)                            := $$PLSQL_UNIT;
    c_abort       CONSTANT    corp_etl_error_log.err_level%TYPE       := 'ABORT';
    c_critical    CONSTANT    corp_etl_error_log.err_level%TYPE       := 'CRITICAL';
    c_log         CONSTANT    corp_etl_error_log.err_level%TYPE       := 'LOG';
    c_date_format CONSTANT    VARCHAR2(10)                            := 'mm/dd/yyyy';

    PROCEDURE   ins_load_eyr_files_req
                (
                    p_job_name                              IN                      MI_JOB_CTRL.job_name%TYPE,
                    p_job_param_1                           IN                      MI_JOB_CTRL.job_param_1%TYPE                        DEFAULT NULL,
                    p_job_param_2                           IN                      MI_JOB_CTRL.job_param_2%TYPE                        DEFAULT NULL,
                    p_job_param_3                           IN                      MI_JOB_CTRL.job_param_3%TYPE                        DEFAULT NULL
                );

    PROCEDURE   get_letter_job_ctrl_id
                (
                    p_job_name                              IN                      VARCHAR2,
                    p_filepath                              IN                      VARCHAR2,
                    p_job_ctrl_id                                       OUT         NUMBER,
                    p_row_num                                           OUT         NUMBER
                );

    PROCEDURE   proc_mi_job_ctrl
                (
                    p_job_name                              IN                      MI_JOB_CTRL.job_name%TYPE,
                    p_batch_size                            IN                      NUMBER
                );

    PROCEDURE   LETTER_REQUEST_INS;
    PROCEDURE   LETTER_REQUEST_UPD;

    PROCEDURE   LETTER_REQUEST_LINK_INS;
    PROCEDURE   LETTER_REQUEST_LINK_UPD;

end;
/
grant execute on MIEB_LETTERS_ETL_PKG to MAXDAT_MIEB_PFP_E;
grant execute on MIEB_LETTERS_ETL_PKG to MAXDAT_MITRAN_READ_ONLY;


CREATE OR REPLACE PACKAGE BODY MIEB_LETTERS_ETL_PKG AS

    v_code corp_etl_error_log.error_codes%TYPE;
    v_desc corp_etl_error_log.error_desc%TYPE;

PROCEDURE   ins_load_eyr_files_req
            (
                p_job_name                              IN                      MI_JOB_CTRL.job_name%TYPE,
                p_job_param_1                           IN                      MI_JOB_CTRL.job_param_1%TYPE                        DEFAULT NULL,
                p_job_param_2                           IN                      MI_JOB_CTRL.job_param_2%TYPE                        DEFAULT NULL,
                p_job_param_3                           IN                      MI_JOB_CTRL.job_param_3%TYPE                        DEFAULT NULL
            )
IS
BEGIN

    INSERT
      INTO  MI_JOB_CTRL (   job_name,    job_param_1,   job_param_2,    job_param_3 )
    SELECT  p_job_name,
            p_job_param_1,
            p_job_param_2,
            p_job_param_3
      FROM  DUAL
     WHERE  NOT EXISTS  (
                            SELECT  1
                              FROM  MI_JOB_CTRL
                             WHERE  job_name                    =   p_job_name
                               AND  NVL(job_param_1, '???')     =   NVL(p_job_param_1, '???')
                               AND  NVL(job_param_2, '???')     =   NVL(p_job_param_2, '???')
                               AND  NVL(job_param_3, '???')     =   NVL(p_job_param_3, '???')
                               AND  status                      =   'PEND'
                        );

END         ins_load_eyr_files_req;

PROCEDURE   get_letter_job_ctrl_id
            (
                p_job_name                              IN                      VARCHAR2
                ,p_filepath                             IN                      VARCHAR2
                ,p_job_ctrl_id                                      OUT         NUMBER
                ,p_row_num                                          OUT         NUMBER
            )
IS
    l_filename                                                                  VARCHAR2(300);
    l_job_ctrl_id                                                               MI_JOB_CTRL.job_ctrl_id%TYPE;
BEGIN

    l_filename  :=  get_filename_from_path(p_filepath);

    BEGIN

        SELECT  MIN(job_ctrl_id)
          INTO  l_job_ctrl_id
          FROM  MI_JOB_CTRL
         WHERE  job_name            =   p_job_name
           AND  job_param_1         =   l_filename
           AND  status              =   'PEND';

    EXCEPTION

        WHEN    NO_DATA_FOUND
        THEN    l_job_ctrl_id   :=  NULL;

    END;

    IF
    (
        l_job_ctrl_id IS NULL
    )
    THEN

        INSERT
          INTO  MI_JOB_CTRL     (   job_name,       job_param_1,    job_param_2,    status,     status_dt   )
        VALUES                  (   p_job_name,     l_filename,     '1',            'PEND',     sysdate     )
        RETURNING   job_ctrl_id
             INTO   l_job_ctrl_id;

        p_job_ctrl_id   :=  l_job_ctrl_id;
        p_row_num   :=  1;        

    ELSE

        p_job_ctrl_id   :=  l_job_ctrl_id;

        SELECT  TO_NUMBER(job_param_2) + 1
          INTO  p_row_num
          FROM  MI_JOB_CTRL
         WHERE  job_ctrl_id     =   p_job_ctrl_id;

    END IF;

    UPDATE  MI_JOB_CTRL
       SET  job_param_2         =   p_row_num
     WHERE  job_ctrl_id         =   p_job_ctrl_id;

END         get_letter_job_ctrl_id;

FUNCTION    get_d_letter_definition_rec
            (
                p_source                                IN                      D_LETTER_DEFINITION.letter_source_code%TYPE,
                p_name                                  IN                      D_LETTER_DEFINITION.name%TYPE
            )
RETURN                                                                          D_LETTER_DEFINITION%ROWTYPE
IS
    l_d_letter_definition_rec                                                   D_LETTER_DEFINITION%ROWTYPE;
BEGIN

    BEGIN

        SELECT  *
          INTO  l_d_letter_definition_rec
          FROM  D_LETTER_DEFINITION
         WHERE  letter_source_code              =   p_source
           AND  name                            =   p_name
           AND  sysdate BETWEEN effective_from_date and effective_thru_date;

    EXCEPTION

        WHEN    NO_DATA_FOUND
        THEN    NULL;

    END;

    RETURN  l_d_letter_definition_rec;

END         get_d_letter_definition_rec;

FUNCTION    get_d_lmdef_invoice_rec
            (
                p_source                                IN                      D_LETTER_DEFINITION.letter_source_code%TYPE,
                p_invoice_group                                IN                      D_LETTER_DEFINITION.Letter_Invoice_Group_Code%TYPE,
                p_name                                  IN                      D_LETTER_DEFINITION.name%TYPE
            )
RETURN                                                                          D_LETTER_DEFINITION%ROWTYPE
IS
    l_d_letter_definition_rec                                                   D_LETTER_DEFINITION%ROWTYPE;
BEGIN

    BEGIN

        SELECT  *
          INTO  l_d_letter_definition_rec
          FROM  D_LETTER_DEFINITION
         WHERE  Letter_Invoice_Group_Code              =   p_invoice_group
           and  letter_source_code              = p_source
           AND  name                            =   p_name
           AND  sysdate BETWEEN effective_from_date and effective_thru_date;

    EXCEPTION

        WHEN    NO_DATA_FOUND
        THEN    NULL;

    END;

    RETURN  l_d_letter_definition_rec;

END         get_d_lmdef_invoice_rec;


FUNCTION    get_d_letter_request_rec
            (
                p_letter_request_id                     IN                      D_LETTER_REQUEST.letter_request_id%TYPE
            )
RETURN                                                                          D_LETTER_REQUEST%ROWTYPE
IS
    l_d_letter_request_rec                                                      D_LETTER_REQUEST%ROWTYPE;
BEGIN

    BEGIN

        SELECT  *
          INTO  l_d_letter_request_rec
          FROM  D_LETTER_REQUEST
         WHERE  letter_request_id               =   TO_NUMBER(p_letter_request_id);

    EXCEPTION

        WHEN    NO_DATA_FOUND
        THEN    NULL;

    END;

    RETURN  l_d_letter_request_rec;

END         get_d_letter_request_rec;

FUNCTION    get_d_letter_request_rec
            (
                p_mailhouse_rec                   IN                      ETL_L_MAILHOUSE%ROWTYPE 
                , p_lmdef_rec                     IN                      D_LETTER_DEFINITION%ROWTYPE           
            )
RETURN   D_LETTER_REQUEST%ROWTYPE
IS
    l_d_letter_request_rec                                                      D_LETTER_REQUEST%ROWTYPE;
BEGIN

    BEGIN

        SELECT  *
          INTO  l_d_letter_request_rec
          FROM  D_LETTER_REQUEST
         WHERE  lmdef_id = p_lmdef_rec.lmdef_id
                and EYR_source_system = p_mailhouse_rec.SOURCE_SYSTEM
                and eyr_source_filename = p_mailhouse_rec.source_filename
                and eyr_record_number = p_mailhouse_rec.record_number
                and eyr_letter_type = p_mailhouse_rec.letter_type
                and eyr_mailed_date = p_mailhouse_rec.mailed_date
                ;

    EXCEPTION

        WHEN    NO_DATA_FOUND
        THEN    NULL;

    END;

    RETURN  l_d_letter_request_rec;

END         get_d_letter_request_rec;



FUNCTION    validate_etl_l_mailhouse_rec
            (
                p_etl_l_mailhouse_rec                   IN                      ETL_L_MAILHOUSE%ROWTYPE
            )
RETURN                                                                          VARCHAR2
IS
    l_d_letter_definition_rec                                                   D_LETTER_DEFINITION%ROWTYPE;
    l_d_letter_request_rec                                                      D_LETTER_REQUEST%ROWTYPE;    

    l_message                                                                   VARCHAR2(4000);
BEGIN

    l_d_letter_definition_rec   :=  get_d_lmdef_invoice_rec
                                    (
                                        p_source    =>  'EYR',
                                        p_invoice_group => p_etl_l_mailhouse_rec.source_system,
                                        p_name      =>  p_etl_l_mailhouse_rec.letter_type
                                    );


    IF
    (
        l_d_letter_definition_rec.lmdef_id IS NULL  
    )
    THEN
        l_message := l_message || 'Letter type does not exist in D_LETTER_DEFINITION for SOURCE_SYSTEM and LETTER_TYPE; ';
    END IF;

    IF
    (
        p_etl_l_mailhouse_rec.source_filename IS NULL
    )
    THEN
        l_message := l_message || 'No value found for SOURCE_FILENAME; ';    
    END IF;

    IF
    (
        NVL(LENGTH(TRIM(TRANSLATE(p_etl_l_mailhouse_rec.record_number, '0123456789', ' '))), 0) != 0
    )
    THEN
        l_message := l_message || 'Invalid value found for RECORD_NUMBER; ';            
    END IF;


 /*   IF
    (
        p_etl_l_mailhouse_rec.letter_request_id IS NULL        
    )
    THEN
        l_message := l_message || 'No value found for LETTER_REQUEST_ID; ';                
    ELSIF
    (
        NVL(LENGTH(TRIM(TRANSLATE(p_etl_l_mailhouse_rec.letter_request_id, '0123456789', ' '))), 0) != 0
    )
    THEN
        l_message := l_message || 'Invalid value found for LETTER_REQUEST_ID; ';            
    ELSE

        l_d_letter_request_rec      :=  get_d_letter_request_rec
                                        (
                                            p_letter_request_id =>  TO_NUMBER(p_etl_l_mailhouse_rec.letter_request_id)
                                        );    

        IF
        (
            l_d_letter_request_rec.letter_request_id IS NOT NULL
        )
        THEN
            l_message := l_message || 'Letter request exists in D_LETTER_REQUEST for LETTER_REQUEST_ID; ';
        END IF;

    END IF;
*/
        l_d_letter_request_rec      :=  get_d_letter_request_rec
                                        (
                                            p_mailhouse_rec =>  p_etl_l_mailhouse_rec
                                            , p_lmdef_rec => l_d_letter_definition_rec
                                        );    

       IF
        (
            l_d_letter_request_rec.letter_request_id IS NOT NULL
        )
        THEN
            l_message := l_message || 'Letter request already exists for this data; ';
        END IF;


    IF
    (
        p_etl_l_mailhouse_rec.printed_date IS NULL
    )
    THEN
        l_message := l_message || 'PRINTED_DATE is NULL; ';
    ELSE

        IF
        (
            try_parse_date(p_etl_l_mailhouse_rec.printed_date, c_date_format) IS NULL  
        )
        THEN
            l_message := l_message || 'Bad date format for PRINTED_DATE.  Expected format ' || c_date_format ||'; ';        
        END IF;

    END IF;

    IF
    (
        p_etl_l_mailhouse_rec.mailed_date IS NULL
    )
    THEN
        l_message := l_message || 'MAILED_DATE is NULL; ';
    ELSE

        IF
        (
            try_parse_date(p_etl_l_mailhouse_rec.mailed_date, c_date_format) IS NULL  
        )
        THEN
            l_message := l_message || 'Bad date format for MAILED_DATE.  Expected format ' || c_date_format ||'; ';        
        END IF;

    END IF;

    IF
    (
        p_etl_l_mailhouse_rec.tran_date IS not NULL
    )
    THEN

        IF
        (
            try_parse_date(p_etl_l_mailhouse_rec.tran_date, c_date_format) IS NULL  
        )
        THEN
            l_message := l_message || 'Bad date format for Tran_DATE.  Expected format ' || c_date_format ||'; ';        
        END IF;

    END IF;

    RETURN l_message;

END         validate_etl_l_mailhouse_rec;

PROCEDURE   proc_etl_l_mailhouse
            (
                p_job_ctrl_id                           IN                      ETL_L_MAILHOUSE.job_ctrl_id%TYPE,
                p_batch_size                            IN                      NUMBER
            )
IS

    TYPE t_etl_l_mailhouse_arr IS TABLE OF ETL_L_MAILHOUSE%ROWTYPE;

    l_etl_mailhouse_arr                                                         t_etl_l_mailhouse_arr;
    l_d_letter_definition_rec                                                   D_LETTER_DEFINITION%ROWTYPE;    

    l_message                                                                   VARCHAR2(4000);
    l_job_name                                                                  CORP_ETL_JOB_STATISTICS.job_name%TYPE;
    l_job_id                                                                    CORP_ETL_JOB_STATISTICS.Job_Id%Type;  

    l_ins_cnt                                                                   NUMBER;
    l_error_cnt                                                                 NUMBER;
    v_seq_id                                                                    number(32);

BEGIN

    l_job_name  :=  'MIEB_LETTERS_ETL_PKG.PROC_ETL_L_MAILHOUSE(' || p_job_ctrl_id || ')';

    DELETE FROM Errlog_Letter WHERE ora_err_tag$ = l_job_name;

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, l_job_name,'STARTED',SYSDATE)
    RETURNING JOB_ID INTO l_job_id;

    LOOP

        SELECT  *
                BULK COLLECT INTO
                l_etl_mailhouse_arr
          FROM  ETL_L_MAILHOUSE
         WHERE  job_ctrl_id                 =   p_job_ctrl_id
           AND  processed_ind               =   0
           AND  rownum                      <=  p_batch_size;

        FOR i IN 1..l_etl_mailhouse_arr.COUNT
        LOOP

            BEGIN

                l_message   :=

                validate_etl_l_mailhouse_rec
                (
                    p_etl_l_mailhouse_rec       =>  l_etl_mailhouse_arr(i)
                );

                IF
                (
                    l_message IS NULL
                )
                THEN

                    l_d_letter_definition_rec   :=  get_d_lmdef_invoice_rec
                                                    (
                                                        p_source    =>  'EYR',
                                                        p_invoice_group => l_etl_mailhouse_arr(i).source_system,
                                                        p_name      =>  l_etl_mailhouse_arr(i).letter_type
                                                    );
                    select D_EYR_LETTER_REQUEST_ID_SEQ.nextval into v_seq_id from dual;                                                    

                    INSERT
                      INTO  D_LETTER_REQUEST    (   
                            lmdef_id,                               
                            letter_request_id,                                      
                            printed_on,                                                         
                            mailed_date,
                            EYR_job_ctrl_id,
                            EYR_row_num    ,
                            EYR_filename   ,
                            EYR_source_system,
                            EYR_source_filename ,
                            EYR_record_number   ,
                            EYR_letter_type    ,
                            EYR_printed_date  ,
                            EYR_mailed_date ,
                            EYR_TRAN_DATE 
                            )
                    VALUES                      
                            (   l_d_letter_definition_rec.lmdef_id,     
                            v_seq_id,    
                            TO_DATE(l_etl_mailhouse_arr(i).printed_date, c_date_format),        
                            TO_DATE(l_etl_mailhouse_arr(i).mailed_date, c_date_format)  
                            , l_etl_mailhouse_arr(i).job_ctrl_id
                            , l_etl_mailhouse_arr(i).row_num
                            , l_etl_mailhouse_arr(i).filename
                            , l_etl_mailhouse_arr(i).source_system
                            , l_etl_mailhouse_arr(i).source_filename
                            , l_etl_mailhouse_arr(i).record_number
                            , l_etl_mailhouse_arr(i).letter_type
                            , l_etl_mailhouse_arr(i).printed_date
                            , l_etl_mailhouse_arr(i).mailed_date
                            , TO_DATE(l_etl_mailhouse_arr(i).tran_Date, c_date_format)
                            );

                END IF;

                UPDATE  ETL_L_MAILHOUSE
                   SET  processed_ind           =   1,
                        process_ts              =   SYSDATE,
                        error_check_results     =   NVL(l_message, 'SUCCESS'),
                        letter_request_id       = v_seq_id
                 WHERE  job_ctrl_id             =   l_etl_mailhouse_arr(i).job_ctrl_id
                   AND  row_num                 =   l_etl_mailhouse_arr(i).row_num;

                COMMIT;
                l_ins_cnt :=  l_ins_cnt + 1;

            EXCEPTION

                WHEN    OTHERS
                THEN    v_code := SQLCODE;
                        v_desc := SQLERRM;

                        INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
                        VALUES( c_critical, con_pkg, l_job_name, 1, v_desc, v_code, 'ETL_L_MAILHOUSE');

                        l_error_cnt :=  l_error_cnt + 1;

            END;

        END LOOP;

        EXIT WHEN l_etl_mailhouse_arr.COUNT = 0;

    END LOOP;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , record_count = (l_ins_cnt + l_error_cnt)
         , processed_count = (l_ins_cnt + l_error_cnt)
         , record_inserted_count = l_ins_cnt
         , error_count = l_error_cnt
         , job_status_cd = 'COMPLETED'
     WHERE job_id =  l_job_id;

    COMMIT;

END         proc_etl_l_mailhouse;

PROCEDURE   proc_mi_job_ctrl
            (
                p_job_name                              IN                      MI_JOB_CTRL.job_name%TYPE,
                p_batch_size                            IN                      NUMBER
            )
IS

    TYPE t_mi_job_ctrl_arr IS TABLE OF MI_JOB_CTRL%ROWTYPE;

    l_mi_job_ctrl_arr                                                           t_mi_job_ctrl_arr;

BEGIN

    LOOP

        SELECT  *
                BULK COLLECT INTO
                l_mi_job_ctrl_arr
          FROM  MI_JOB_CTRL
         WHERE  job_name            =   p_job_name
           AND  status              =   'PEND'
           AND  rownum              <=  p_batch_size;

        FOR i IN 1..l_mi_job_ctrl_arr.COUNT
        LOOP

            BEGIN

                UPDATE  MI_JOB_CTRL
                   SET  status                      =   'WORK'
                 WHERE  job_ctrl_id                 =   l_mi_job_ctrl_arr(i).job_ctrl_id;

                proc_etl_l_mailhouse
                (
                    p_job_ctrl_id       =>  l_mi_job_ctrl_arr(i).job_ctrl_id,
                    p_batch_size        =>  p_batch_size
                );

                UPDATE  MI_JOB_CTRL
                   SET  status                      =   'DONE'
                 WHERE  job_ctrl_id                 =   l_mi_job_ctrl_arr(i).job_ctrl_id;

            EXCEPTION

                WHEN    OTHERS
                THEN    UPDATE  MI_JOB_CTRL
                           SET  status                      =   'ERR'
                         WHERE  job_ctrl_id                 =   l_mi_job_ctrl_arr(i).job_ctrl_id;


            END;

            COMMIT;

        END LOOP;

        EXIT WHEN l_mi_job_ctrl_arr.COUNT = 0;

    END LOOP;

END         proc_mi_job_ctrl;


PROCEDURE LETTER_REQUEST_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_Letter WHERE ora_err_tag$ = 'LETTER_REQUEST_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_LETTER_REQUEST 
          ( letter_request_id,
            case_id,
            lmdef_id,
            requested_on,
            request_type,
            produced_by,
            language_cd,
            driver_type,
            status_cd,
            rep_lmreq_id,
            sent_on,
            created_by,
            create_ts,
            updated_by,
            update_ts,
            printed_on,
            staff_id_printed_by,
            note_refid,
            return_date,
            return_reason_cd,   
            parent_lmreq_id,
            reprint_parent_lmreq_id,
            lmact_cd,
            ldis_cd,    
            authorized_lmreq_id,
            error_codes,
            nmbr_requested,
            program_type_cd,
            material_request_id,
            mailing_address_id,
            response_due_date,
            mailed_date,
            reject_reason_cd,
            status_err_src,
            letter_out_generation_num,
            portal_view_ind,
            is_digital_ind)
    SELECT lmreq_id,
            case_id,
            lmdef_id,
            requested_on,
            request_type,
            produced_by,
            language_cd,
            driver_type,
            status_cd,
            rep_lmreq_id,
            sent_on,
            created_by,
            create_ts,
            updated_by,
            update_ts,
            printed_on,
            staff_id_printed_by,
            note_refid,
            return_date,
            return_reason_cd,   
            parent_lmreq_id,
            reprint_parent_lmreq_id,
            lmact_cd,
            ldis_cd,    
            authorized_lmreq_id,
            error_codes,
            nmbr_requested,
            program_type_cd,
            material_request_id,
            mailing_address_id,
            response_due_date,
            mailed_date,
            reject_reason_cd,
            status_err_src,
            letter_out_generation_num,
            portal_view_ind,
            is_digital_ind         
    FROM s_letter_request_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM d_letter_request ce WHERE e.lmreq_id = ce.letter_request_id)
     LOG Errors INTO Errlog_Letter ('LETTER_REQUEST_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST', LETTER_REQUEST_ID
      FROM Errlog_Letter
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_INS', 1, v_desc, v_code, 'D_LETTER_REQUEST');

      COMMIT;
END LETTER_REQUEST_INS;

PROCEDURE LETTER_REQUEST_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_Letter WHERE ora_err_tag$ = 'LETTER_REQUEST_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_LETTER_REQUEST e
   USING (SELECT tmp.*
          FROM (SELECT lmreq_id letter_request_id,
                  case_id,
                  lmdef_id,
                  requested_on,
                  request_type,
                  produced_by,
                  language_cd,
                  driver_type,
                  status_cd,
                  rep_lmreq_id,
                  sent_on,
                  created_by,
                  create_ts,
                  updated_by,
                  update_ts,
                  printed_on,
                  staff_id_printed_by,
                  note_refid,
                  return_date,
                  return_reason_cd,   
                  parent_lmreq_id,
                  reprint_parent_lmreq_id,
                  lmact_cd,
                  ldis_cd,    
                  authorized_lmreq_id,
                  error_codes,
                  nmbr_requested,
                  program_type_cd,
                  material_request_id,
                  mailing_address_id,
                  response_due_date,
                  mailed_date,
                  reject_reason_cd,
                  status_err_src,
                  letter_out_generation_num,
                  portal_view_ind,
                  is_digital_ind         
                FROM s_letter_request_stg e                 
              ) tmp
          JOIN d_letter_request t ON tmp.letter_request_id = t.letter_request_id
          WHERE COALESCE(t.case_id,0) != COALESCE(tmp.case_id,0)            
            OR COALESCE(t.lmdef_id,0) != COALESCE(tmp.lmdef_id,0)            
            OR COALESCE(t.requested_on, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.requested_on, TO_DATE('07/07/7777','mm/dd/yyyy'))          
            OR COALESCE(t.request_type,'*') != COALESCE(tmp.request_type,'*')
            OR COALESCE(t.produced_by,'*') != COALESCE(tmp.produced_by,'*')
            OR COALESCE(t.language_cd,'*') != COALESCE(tmp.language_cd,'*')
            OR COALESCE(t.driver_type,'*') != COALESCE(tmp.driver_type,'*')
            OR COALESCE(t.status_cd,'*') != COALESCE(tmp.status_cd,'*')
            OR COALESCE(t.rep_lmreq_id,0) != COALESCE(tmp.rep_lmreq_id,0) 
            OR COALESCE(t.sent_on, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.sent_on, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))            
            OR COALESCE(t.printed_on, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.printed_on, TO_DATE('07/07/7777','mm/dd/yyyy'))                        
            OR COALESCE(t.staff_id_printed_by,0) != COALESCE(tmp.staff_id_printed_by,0) 
            OR COALESCE(t.note_refid,0) != COALESCE(tmp.note_refid,0) 
            OR COALESCE(t.return_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.return_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.return_reason_cd,'*') != COALESCE(tmp.return_reason_cd,'*')
            OR COALESCE(t.parent_lmreq_id,0) != COALESCE(tmp.parent_lmreq_id,0) 
            OR COALESCE(t.reprint_parent_lmreq_id,0) != COALESCE(tmp.reprint_parent_lmreq_id,0) 
            OR COALESCE(t.lmact_cd,'*') != COALESCE(tmp.lmact_cd,'*')                       
            OR COALESCE(t.ldis_cd,'*') != COALESCE(tmp.ldis_cd,'*') 
            OR COALESCE(t.authorized_lmreq_id,0) != COALESCE(tmp.authorized_lmreq_id,0) 
            OR COALESCE(t.error_codes,'*') != COALESCE(tmp.error_codes,'*') 
            OR COALESCE(t.nmbr_requested,0) != COALESCE(tmp.nmbr_requested,0)             
            OR COALESCE(t.program_type_cd,'*') != COALESCE(tmp.program_type_cd,'*') 
            OR COALESCE(t.material_request_id,0) != COALESCE(tmp.material_request_id,0) 
            OR COALESCE(t.mailing_address_id,0) != COALESCE(tmp.mailing_address_id,0)
            OR COALESCE(t.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.response_due_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.mailed_date, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.reject_reason_cd,'*') != COALESCE(tmp.reject_reason_cd,'*') 
            OR COALESCE(t.status_err_src,'*') != COALESCE(tmp.status_err_src,'*') 
            OR COALESCE(t.letter_out_generation_num,0) != COALESCE(tmp.letter_out_generation_num,0) 
            OR COALESCE(t.portal_view_ind,0) != COALESCE(tmp.portal_view_ind,0)            
            OR COALESCE(t.is_digital_ind,0) != COALESCE(tmp.is_digital_ind,0)                     
          ) ce ON (e.letter_request_id = ce.letter_request_id)
    WHEN MATCHED THEN UPDATE
     SET e.case_id = ce.case_id
         ,e.lmdef_id = ce.lmdef_id
         ,e.requested_on = ce.requested_on
         ,e.request_type = ce.request_type
         ,e.produced_by = ce.produced_by
         ,e.language_cd = ce.language_cd
         ,e.driver_type = ce.driver_type
         ,e.status_cd = ce.status_cd
         ,e.rep_lmreq_id = ce.rep_lmreq_id
         ,e.sent_on = ce.sent_on
         ,e.created_by = ce.created_by
         ,e.create_ts = ce.create_ts
         ,e.updated_by = ce.updated_by
         ,e.update_ts = ce.update_ts
         ,e.printed_on = ce.printed_on
         ,e.staff_id_printed_by = ce.staff_id_printed_by
         ,e.note_refid = ce.note_refid
         ,e.return_date = ce.return_date
         ,e.return_reason_cd = ce.return_reason_cd
         ,e.parent_lmreq_id = ce.parent_lmreq_id
         ,e.reprint_parent_lmreq_id = ce.reprint_parent_lmreq_id
         ,e.lmact_cd = ce.lmact_cd
         ,e.ldis_cd = ce.ldis_cd
         ,e.authorized_lmreq_id = ce.authorized_lmreq_id
         ,e.error_codes = ce.error_codes
         ,e.nmbr_requested = ce.nmbr_requested
         ,e.program_type_cd = ce.program_type_cd
         ,e.material_request_id = ce.material_request_id
         ,e.mailing_address_id = ce.mailing_address_id
         ,e.response_due_date = ce.response_due_date
         ,e.mailed_date = ce.mailed_date
         ,e.reject_reason_cd = ce.reject_reason_cd
         ,e.status_err_src = ce.status_err_src
         ,e.letter_out_generation_num = ce.letter_out_generation_num
         ,e.portal_view_ind = ce.portal_view_ind
         ,e.is_digital_ind =  ce.is_digital_ind
     Log Errors INTO Errlog_Letter ('LETTER_REQUEST_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST', LETTER_REQUEST_ID
      FROM Errlog_Letter
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_UPD';

    v_err_cnt := SQL%RowCount;

   UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_UPD', 1, v_desc, v_code, 'D_LETTER_REQUEST');

      COMMIT;
END LETTER_REQUEST_UPD;

PROCEDURE LETTER_REQUEST_LINK_INS
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_ins_cnt number;
    v_err_cnt number;

BEGIN

    DELETE FROM Errlog_LtrLink WHERE ora_err_tag$ = 'LETTER_REQUEST_LINK_INS';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_LINK_INS','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

    INSERT /*+ Enable_Parallel_Dml Parallel */
      INTO D_LETTER_REQUEST_LINK 
          (lmlink_id,
            letter_request_id,
            reference_type,
            reference_id,
            created_by,
            create_ts,
            updated_by,    
            update_ts,
            additional_reference_type,
            additional_reference_id,
            client_id,
            client_enroll_status_id)
    SELECT
          lmlink_id,
            letter_request_id,
            reference_type,
            reference_id,
            created_by,
            create_ts,
            updated_by,    
            update_ts,
            additional_reference_type,
            additional_reference_id,
            client_id,
            client_enroll_status_id      
    FROM s_letter_link_stg e     
    WHERE NOT EXISTS(SELECT 1 FROM d_letter_request_link ce WHERE e.lmlink_id = ce.lmlink_id)
     LOG Errors INTO Errlog_LtrLink ('LETTER_REQUEST_LINK_INS') Reject Limit Unlimited;

    v_ins_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_ins_cnt
         , PROCESSED_COUNT = v_ins_cnt
         , RECORD_INSERTED_COUNT = v_ins_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_INS', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST_LINK', LMLINK_ID
      FROM Errlog_LtrLink
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_LINK_INS';

    v_err_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_ins_cnt + v_err_cnt
         , PROCESSED_COUNT = v_ins_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_INS', 1, v_desc, v_code, 'D_LETTER_REQUEST_LINK');

      COMMIT;
END LETTER_REQUEST_LINK_INS;

PROCEDURE LETTER_REQUEST_LINK_UPD
IS
    v_job_id CORP_ETL_JOB_STATISTICS.Job_Id%Type;
    v_upd_cnt number;
    v_err_cnt number;
BEGIN

    DELETE FROM Errlog_LtrLink WHERE ora_err_tag$ = 'LETTER_REQUEST_LINK_UPD';

    INSERT INTO Corp_Etl_Job_Statistics (Job_id, Job_Name, Job_Status_CD, Job_Start_Date)
    VALUES (SEQ_JOB_ID.Nextval, 'LETTER_REQUEST_LINK_UPD','STARTED',SYSDATE)
    RETURNING JOB_ID INTO v_job_id;

   MERGE /*+ Enable_Parallel_Dml Parallel */
    INTO  D_LETTER_REQUEST_LINK e
   USING (SELECT tmp.*
          FROM (SELECT lmlink_id,
                  letter_request_id,
                  reference_type,
                  reference_id,
                  created_by,
                  create_ts,
                  updated_by,    
                  update_ts,
                  additional_reference_type,
                  additional_reference_id,
                  client_id,
                  client_enroll_status_id  
                FROM s_letter_link_stg e                
              ) tmp
          JOIN d_letter_request_link t ON tmp.lmlink_id = t.lmlink_id
          WHERE COALESCE(t.letter_request_id,0) != COALESCE(tmp.letter_request_id,0) 
            OR COALESCE(t.reference_type,'*') != COALESCE(tmp.reference_type,'*')          
            OR COALESCE(t.reference_id,0) != COALESCE(tmp.reference_id,0) 
            OR COALESCE(t.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.create_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.created_by,'*') != COALESCE(tmp.created_by,'*')
            OR COALESCE(t.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy')) != COALESCE(tmp.update_ts, TO_DATE('07/07/7777','mm/dd/yyyy'))
            OR COALESCE(t.updated_by,'*') != COALESCE(tmp.updated_by,'*')
            OR COALESCE(t.additional_reference_type,'*') != COALESCE(tmp.additional_reference_type,'*')          
            OR COALESCE(t.additional_reference_id,0) != COALESCE(tmp.additional_reference_id,0) 
            OR COALESCE(t.client_id,0) != COALESCE(tmp.client_id,0) 
            OR COALESCE(t.client_enroll_status_id,0) != COALESCE(tmp.client_enroll_status_id,0)                        
          ) ce ON (e.lmlink_id = ce.lmlink_id)
    WHEN MATCHED THEN UPDATE
     SET e.letter_request_id = ce.letter_request_id
        ,e.reference_type = ce.reference_type
        ,e.reference_id = ce.reference_id
        ,e.create_ts = ce.create_ts
        ,e.created_by = ce.created_by
        ,e.update_ts = ce.update_ts
        ,e.updated_by = ce.updated_by
        ,e.additional_reference_type = ce.additional_reference_type
        ,e.additional_reference_id = ce.additional_reference_id
        ,e.client_id = ce.client_id
        ,e.client_enroll_status_id = ce.client_enroll_status_id              
     Log Errors INTO Errlog_LtrLink ('LETTER_REQUEST_LINK_UPD') Reject Limit Unlimited;

    v_upd_cnt := SQL%RowCount;

    UPDATE CORP_ETL_JOB_STATISTICS
       SET Job_end_date = SYSDATE
         , RECORD_COUNT = v_upd_cnt
         , PROCESSED_COUNT = v_upd_cnt
         , RECORD_UPDATED_COUNT = v_upd_cnt
         , JOB_STATUS_CD = 'COMPLETED'
     WHERE JOB_ID =  v_job_id;

    COMMIT;

    INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name,driver_key_number)
    SELECT c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_UPD', 1, Ora_Err_Mesg$, ora_err_number$, 'D_LETTER_REQUEST_LINK', LMLINK_ID
      FROM Errlog_LtrLink
     WHERE Ora_Err_Tag$ = 'LETTER_REQUEST_LINK_UPD';

    v_err_cnt := SQL%RowCount;

   UPDATE CORP_ETL_JOB_STATISTICS
       SET ERROR_COUNT = v_err_cnt
         , RECORD_COUNT = v_upd_cnt + v_err_cnt
         , PROCESSED_COUNT = v_upd_cnt + v_err_cnt
     WHERE JOB_ID =  v_job_id;

    COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      v_code := SQLCODE;
      v_desc := SQLERRM;

      INSERT INTO corp_etl_error_log( err_level, job_name, process_name, nr_of_error, error_desc , error_codes, driver_table_name)
      VALUES( c_critical, con_pkg, 'MIEB_LETTERS_ETL_PKG.LETTER_REQUEST_LINK_UPD', 1, v_desc, v_code, 'D_LETTER_REQUEST_LINK');

      COMMIT;
END LETTER_REQUEST_LINK_UPD;


END;
/
grant execute on MIEB_LETTERS_ETL_PKG to MAXDAT_MIEB_PFP_E;
grant execute on MIEB_LETTERS_ETL_PKG to MAXDAT_MITRAN_READ_ONLY;


