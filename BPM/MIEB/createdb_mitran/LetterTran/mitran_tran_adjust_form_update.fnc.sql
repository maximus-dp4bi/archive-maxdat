CREATE OR REPLACE Procedure MITRAN_TRAN_ADJUST_FORM_INSERT
    (
  IN_LETTER_REPORT_LABEL IN VARCHAR2
  , IN_TRAN_DATE IN DATE
  , IN_TRAN_FILENAME IN VARCHAR2
  , IN_TRAN_QTY IN NUMBER
  , IN_RESENT IN VARCHAR2
  , IN_EYR_QTY IN NUMBER
  , IN_EYR_FILENAME IN VARCHAR2
  , IN_QA_ABORT IN VARCHAR2
  , IN_QA_SPLIT IN NUMBER
  , IN_QA_REJECT IN NUMBER
  , IN_USER_ID IN VARCHAR2
  , IN_QA_COMMENTS in varchar2
  , IN_EYR_MAILED_DATE IN DATE
  , IN_EYR_MAILED_QTY IN NUMBER
  , IN_EYR_USER IN VARCHAR2
  , IN_EYR_NOTES IN VARCHAR2
  , IN_LETTER_ADJUST_REASON_LABEL IN VARCHAR2
  , IN_COMMENTS IN VARCHAR2
  , IN_CREATED_BY IN VARCHAR2
  , IN_UPDATED_BY IN VARCHAR2
   )

AS

V_LMDEF_ID NUMBER := 0;
V_PROGRAM_CON_XWALK_CODE VARCHAR2(100);
--V_LETTER_TYPE_NAME VARCHAR2(100);
V_LETTER_ADJUST_REASON_CODE VARCHAR2(100);
--NOTE:  IN_CHANGE_STATUS = CHANGE_STATUS_DESC and IN_CHANGE_STATUS_CODE = CHANGE_STATUS
v_code corp_etl_error_log.error_codes%TYPE;
v_desc corp_etl_error_log.error_desc%TYPE;
v_driver_key varchar2(100);
v_err_field varchar2(100);
verrmsg varchar2(1000);
v_tran_detail_id number(32);
v_project_code varchar2(30);
v_program_code varchar2(30);
v_subprogram_code varchar2(100);
v_tran_header_id number(32);

BEGIN
  v_driver_key := nvl(IN_LETTER_REPORT_LABEL,'null') ||'/'|| nvl(to_char(IN_TRAN_DATE,'mmddyyyy'),'null') ||'/'|| nvl(to_char(IN_TRAN_QTY),'null') ;
  v_err_field := 'IN_LETTER_REPORT_LABEL/IN_TRAN_DATE/IN_TRAN_QTY';

  verrmsg := '';

validate_transmittal(
  IN_LETTER_REPORT_LABEL
  , IN_TRAN_DATE
  , IN_TRAN_FILENAME
  , IN_TRAN_QTY
  , IN_RESENT
  , IN_EYR_QTY
  , IN_EYR_FILENAME
  , IN_QA_ABORT
  , IN_QA_SPLIT
  , IN_QA_REJECT
  , IN_USER_ID
  , IN_QA_COMMENTS
  , IN_EYR_MAILED_DATE
  , IN_EYR_MAILED_QTY
  , IN_EYR_USER
  , IN_EYR_NOTES
  , IN_LETTER_ADJUST_REASON_LABEL
  , IN_COMMENTS
  , IN_CREATED_BY
  , IN_UPDATED_BY
  , IN_FORMNAME => 'ADD'
  , OUT_ERRORS => verrmsg
);

if verrmsg is not null then
  raise_application_error(-20101,verrmsg);
  return;
end if;


    BEGIN
      select tran_header_id into v_tran_header_id from d_tran_header th where th.tran_date = IN_tran_date and rownum = 1;
    EXCEPTION WHEN no_data_found then
        null;
      when too_many_rows then
       null;
      when others then
      null;
    end;


    BEGIN
      SELECT letter_definition_id,LT.PROGRAM_CON_XWALK_CODE  INTO V_LMDEF_ID,V_PROGRAM_CON_XWALK_CODE FROM D_LETTER_TYPE_SV LT WHERE upper(LT.REPORT_LABEL) =  upper(IN_LETTER_REPORT_LABEL);
    EXCEPTION WHEN no_data_found then
              null;
      when too_many_rows then
           null;
        when others then
          null;
    end;

    begin
       select program_code, project_code into v_program_code, v_project_code from d_letter_definition where lmdef_id = v_lmdef_id and sysdate between effective_from_date and effective_thru_date;
    exception when others then
      null;
    end;

    begin
      select subprogram_code   into  v_subprogram_code from d_subprogram_con_xwalk_sv where sysdate between effective_date and end_date;
    exception when others then
      null;
    end;

    if v_tran_header_id is not null and v_lmdef_id is not null then
    begin
      select tran_detail_id into v_tran_detail_id from d_tran_detail_sv td where td.tran_header_id = v_tran_header_id and td.LMDEF_ID = v_lmdef_id and rownum = 1;
    exception when no_Data_found then
              null;
     when others then
       null;
    end;
    end if;
    if v_tran_detail_id is not null then
      raise_application_error(-20106, 'Transmittal entry for this letter already exists, please use Update');
    end if;


    BEGIN
      SELECT LETTER_ADJUST_REASON_CODE INTO V_LETTER_ADJUST_REASON_CODE FROM D_LETTER_ADJUST_REASON WHERE REPORT_LABEL = IN_LETTER_ADJUST_REASON_LABEL;
    EXCEPTION WHEN no_data_found then
              null;
      when too_many_rows then
           null;
        when others then
          null;
    end;

    IF V_LMDEF_ID > 0 THEN
      verrmsg := '';
      if v_tran_header_id is null and v_project_code is not null and v_program_code is not null then

           insert into d_tran_header
             ( project_code, program_code, tran_date)
           values
             ( v_project_code, v_program_code, in_tran_date)
           returning tran_header_id into v_tran_header_id  ;
      end if;
      if v_tran_detail_id is null then
           insert into d_tran_detail
             (tran_header_id
             , subprogram_code
             ,  lmdef_id
             , ltr_filename
             , requested_qty
             , resent
             , preqa_eyr_ltr_filename
             , preqa_eyr_ltr_qty
             , qa_abort_userid
             , qa_split_qty
             , qa_rejected_qty
             , qa_comments
             , qa_userid
             , eyr_mailed_date
             , eyr_mailed_qty
             , eyr_ps_checked
             , eyr_ps_comments
             , comments
             , form_created_by
             , form_updated_by
             , adjust_reason_code
             )
           values
             (v_tran_header_id
             , v_subprogram_code
             ,  v_lmdef_id
             , IN_TRAN_FILENAME
             , IN_TRAN_QTY
             , IN_RESENT
             , IN_EYR_FILENAME
             , IN_EYR_QTY
             , IN_USER_ID
             , IN_QA_SPLIT
             , IN_QA_REJECT
             , IN_QA_COMMENTS
             , IN_USER_ID
             , IN_EYR_MAILED_DATE
             , IN_EYR_MAILED_QTY
             , IN_EYR_USER
             , IN_EYR_NOTES
             , IN_COMMENTS
             , IN_creaTED_BY
             , IN_UPDATED_BY
             , V_LETTER_ADJUST_REASON_CODE)
           returning tran_detail_id into v_tran_detail_id;
      end if;

      commit;
    end if;
  exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;

      COMMIT;
     if verrmsg is not null then
         raise_application_error(-20101,verrmsg);
     else
      corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MITRAN_TRAN_FORM_INSERT'
      , in_process_name => 'MITRAN_TRAN_FORM_INSERT'
      , in_nr_of_error => 0
      , in_error_desc => v_Desc
      , in_error_field => v_err_field
      , in_error_codes => v_code
      , in_driver_table_name => 'LETTER_TRAN_ADJUSTMENT_FORM'
      , in_driver_key_number => v_driver_key
      );
      commit;
        raise_application_error(v_code, v_desc);
     end if;

END;
