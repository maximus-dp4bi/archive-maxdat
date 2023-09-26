CREATE OR REPLACE Procedure TRAN_ADJUST_UPDATE
    (
  IN_TRAN_DETAIL_ID IN number
  , IN_LETTER_REPORT_LABEL IN VARCHAR2
  , IN_TRAN_FILENAME IN VARCHAR2
  , IN_TRAN_QTY IN NUMBER
  , IN_RESENT IN VARCHAR2
  , IN_EYR_QTY IN NUMBER
  , IN_EYR_FILENAME IN VARCHAR2
  , IN_QA_ABORT IN VARCHAR2
  , IN_QA_SPLIT IN NUMBER
  , IN_QA_REJECT IN NUMBER
  , IN_QA_SIGNED IN VARCHAR2
  , IN_QA_USER_ID IN VARCHAR2
  , IN_QA_COMMENTS in varchar2
  , IN_EYR_MAILED_DATE IN DATE
  , IN_EYR_MAILED_QTY IN NUMBER
  , IN_EYR_USER IN VARCHAR2
  , IN_EYR_NOTES IN VARCHAR2
  , IN_LETTER_ADJUST_REASON_LABEL IN VARCHAR2
  , IN_COMMENTS IN VARCHAR2
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
v_tran_detail_id_exists number(32);
v_project_code varchar2(30);
v_program_code varchar2(30);
v_subprogram_code varchar2(100);
v_tran_header_id number(32);
V_TRAN_DATE DATE;

BEGIN
  v_driver_key := nvl(to_char(IN_TRAN_detail_ID),'null');
  v_err_field := 'in_tran_detail_id';

            corp_etl_stage_pkg.log_etl_msg(in_job_name => 'TRAN_ADJUST_UPDATE'
            , in_process_name => 'TRAN_ADJUST_UPDATE'
            , in_nr_of_error => 0
            , in_error_desc => v_Desc
            , in_error_field => v_err_field
            , in_error_codes => v_code
            , in_driver_table_name => 'LETTER_TRAN_ADJUSTMENT_FORM'
            , in_driver_key_number => v_driver_key
            );
            commit;

  verrmsg := '';

V_TRAN_DETAIL_ID := IN_TRAN_DETAIL_ID;

  verrmsg := null;

If in_tran_detail_id is null then
          verrmsg := nvl(verrmsg,' ') || chr(10) || 'Transmittal Letter record cannot be identified; ';
end if;

if in_tran_detail_id is not null then
  begin
        select d.tran_detail_id, d.TRAN_HEADER_ID, h.tran_date
         into v_tran_detail_id, V_TRAN_HEADER_ID, v_tran_date
          from d_tran_detail d, d_tran_header h
         where h.tran_header_id = d.tran_header_id
         and d.tran_detail_id = in_tran_detail_id
         and rownum = 1;
   exception when no_data_found then
          verrmsg := nvl(verrmsg,' ') || chr(10) || 'Transmittal Letter record cannot be identified; ';
         when others then
            v_code := SQLCODE;
            v_desc := SQLERRM;

            corp_etl_stage_pkg.log_etl_msg(in_job_name => 'TRAN_ADJUST_UPDATE'
            , in_process_name => 'TRAN_ADJUST_UPDATE'
            , in_nr_of_error => 0
            , in_error_desc => v_Desc
            , in_error_field => v_err_field
            , in_error_codes => v_code
            , in_driver_table_name => 'TRAN_UPDATE_FORM'
            , in_driver_key_number => v_driver_key
            );
            commit;
              raise_application_error(-20102, chr(10) ||'Oracle Error:' || v_code || ':' || substr(v_desc,1,500)|| chr(10));
     end;

end if;

validate_transmittal_update(
  IN_LETTER_report_LABEL
  , v_tran_date
  , IN_TRAN_FILENAME
  , IN_TRAN_QTY
  , IN_RESENT
  , IN_EYR_QTY
  , IN_EYR_FILENAME
  , IN_QA_ABORT
  , IN_QA_SPLIT
  , IN_QA_REJECT
  , IN_QA_SIGNED
  , IN_QA_USER_ID
  , IN_QA_COMMENTS
  , IN_EYR_MAILED_DATE
  , IN_EYR_MAILED_QTY
  , IN_EYR_USER
  , IN_EYR_NOTES
  , IN_LETTER_ADJUST_REASON_LABEL
  , IN_COMMENTS
 , IN_UPDATED_BY
  , OUT_ERRORS => verrmsg
);

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
       select program_code, project_code, subprogram_code into v_program_code, v_project_code, v_subprogram_code from d_letter_definition where lmdef_id = v_lmdef_id and sysdate between effective_from_date and effective_thru_date;
    exception when others then
      null;
    end;

    if v_tran_header_id is not null and v_lmdef_id is not null then
    begin
      select tran_detail_id into v_tran_detail_id_exists from d_tran_detail_sv td
      where td.tran_header_id = v_tran_header_id and td.LMDEF_ID = v_lmdef_id
      and td.tran_detail_id <> v_tran_detail_id and rownum = 1;
    exception when no_Data_found then
              null;
     when others then
       null;
    end;
      if v_tran_Detail_id_exists is not null and v_tran_detail_id_exists > 0 then
        v_tran_detail_id_exists := null;
        begin
          select tran_detail_id
          into v_tran_detail_id_exists from d_tran_detail_sv td
          where td.tran_header_id = v_tran_header_id and td.LMDEF_ID = v_lmdef_id
          and trim(upper(td.LTR_FILENAME)) = trim(upper(in_tran_filename))
          and td.tran_detail_id <> v_tran_detail_id
          and rownum = 1;
        exception when no_Data_found then
                  null;
         when others then
           null;
        end;
      end if;
      if v_tran_Detail_id_exists is not null and v_tran_detail_id_exists > 0 then
        verrmsg := verrmsg || chr(10) || 'Transmittal record for this Letter already exists; ' ;
      end if;
    end if;


    if in_letter_adjust_reason_label is not null then
    BEGIN
      SELECT LETTER_ADJUST_REASON_CODE INTO V_LETTER_ADJUST_REASON_CODE FROM D_LETTER_ADJUST_REASON WHERE REPORT_LABEL = IN_LETTER_ADJUST_REASON_LABEL;
    EXCEPTION WHEN no_data_found then
      if v_tran_Detail_id_exists > 0 then
        verrmsg := verrmsg || chr(10) || 'Adjustment Reason not found; ' ;
      end if;
      when too_many_rows then
           null;
        when others then
          null;
    end;
    end if;

    if verrmsg is not null then
      raise_application_error(-20101,verrmsg || '              ' || chr(10));
      return;
    end if;

    IF V_LMDEF_ID > 0 THEN
      verrmsg := '';
      if v_tran_header_id is not null and v_project_code is not null and v_program_code is not null and v_tran_detail_id is not null then
            update d_tran_detail
               set subprogram_code = case when v_subprogram_code <> subprogram_code then v_subprogram_code else subprogram_code end,
                   lmdef_id = case when lmdef_id <> v_lmdef_id then v_lmdef_id else lmdef_id end,
                   ltr_filename = IN_TRAN_FILENAME,
                   requested_qty = IN_TRAN_QTY,
                   resent = IN_RESENT,
                   preqa_eyr_ltr_filename = IN_EYR_FILENAME,
                   preqa_eyr_ltr_qty = IN_EYR_QTY,
                   qa_abort_userid = IN_QA_ABORT,
                   qa_split_qty = IN_QA_SPLIT,
                   qa_rejected_qty = IN_QA_REJECT,
                   qa_comments = IN_QA_COMMENTS,
                   QA_SIGNED = in_qa_signed,
                   qa_userid = IN_QA_USER_ID,
                   eyr_mailed_date = IN_EYR_MAILED_DATE,
                   eyr_mailed_qty = IN_EYR_MAILED_QTY,
                   eyr_ps_checked = IN_EYR_USER,
                   eyr_ps_comments = IN_EYR_NOTES,
                   comments = in_comments,
                   form_updated_by = IN_UPDATED_BY,
                   adjust_reason_code = V_LETTER_ADJUST_REASON_CODE
             where tran_detail_id = v_tran_detail_id;

      end if;

      commit;
    end if;
 /* exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;

      COMMIT;
     if verrmsg is not null then
         raise_application_error(-20101,verrmsg);
     else
      corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MITRAN_TRAN_FORM_UPDATE'
      , in_process_name => 'MITRAN_TRAN_FORM_UPDATE'
      , in_nr_of_error => 0
      , in_error_desc => v_Desc
      , in_error_field => v_err_field
      , in_error_codes => v_code
      , in_driver_table_name => 'LETTER_TRAN_ADJUSTMENT_FORM'
      , in_driver_key_number => v_driver_key
      );
      commit;
        raise_application_error(-20102, 'Oracle Error:' || v_code || ':' || substr(v_desc,1,500));
     end if;
*/
END;
/
grant execute on TRAN_ADJUST_QA to MAXDAT_MITRAN_PFP_E;
grant execute on TRAN_ADJUST_QA to MAXDAT_MITRAN_READ_ONLY;
grant execute on TRAN_ADJUST_QA to MAXDAT_REPORTS;
