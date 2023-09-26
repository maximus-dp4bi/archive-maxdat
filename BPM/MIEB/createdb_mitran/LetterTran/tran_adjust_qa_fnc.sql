CREATE OR REPLACE Procedure TRAN_ADJUST_QA
    (
    IN_TRAN_DETAIL_ID IN NUMBER
  , IN_QA_ABORT IN VARCHAR2
  , IN_QA_SPLIT IN NUMBER
  , IN_QA_REJECT IN NUMBER
  , IN_QA_SIGNED in varchar2
  , IN_QA_COMMENTS IN varchar2
  , IN_QA_USER_ID IN VARCHAR2
  , IN_COMMENTS IN  VARCHAR2
   )

AS

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
v_tran_header_id number(32);


BEGIN
  v_driver_key := nvl(to_char(IN_TRAN_detail_ID),'null');
  v_err_field := 'in_tran_detail_id';

            corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MITRAN_TRAN_FORM_QA'
            , in_process_name => 'MITRAN_TRAN_FORM_QA'
            , in_nr_of_error => 0
            , in_error_desc => v_Desc
            , in_error_field => v_err_field
            , in_error_codes => v_code
            , in_driver_table_name => 'LETTER_TRAN_ADJUSTMENT_FORM'
            , in_driver_key_number => v_driver_key
            );
            commit;

  verrmsg := null;

v_tran_detail_id := in_tran_detail_id;

if in_tran_detail_id is null then
          verrmsg := nvl(verrmsg,'     Please fix errors: ') || chr(10) || 'Transmittal Letter record cannot be identified; ';
end if;

if in_tran_detail_id is not null then
  begin
        select tran_detail_id
         into v_tran_detail_id
          from d_tran_detail
         where tran_detail_id = in_tran_detail_id
         and rownum = 1;
   exception when no_data_found then
          verrmsg := nvl(verrmsg,'     Please fix errors: ') || chr(10) || 'Transmittal Letter record cannot be identified; ';
         when others then
            v_code := SQLCODE;
            v_desc := SQLERRM;

            corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MITRAN_TRAN_FORM_QA'
            , in_process_name => 'MITRAN_TRAN_FORM_QA'
            , in_nr_of_error => 0
            , in_error_desc => v_Desc
            , in_error_field => v_err_field
            , in_error_codes => v_code
            , in_driver_table_name => 'LETTER_TRAN_ADJUSTMENT_FORM'
            , in_driver_key_number => v_driver_key
            );
            commit;
              raise_application_error(-20102, chr(10) ||'Oracle Error:' || v_code || ':' || substr(v_desc,1,500)|| chr(10));
     end;

end if;

if in_qa_signed is null and (in_qa_split is not null or in_qa_reject is not null or in_qa_abort is not null or in_qa_comments is not null) then
  verrmsg := nvl(verrmsg,'     Please fix errors: ') || CHR(10) || 'QA needs approver Signature; ';
end if;

/*if IN_LETTER_ADJUST_REASON_LABEL is not null then
    BEGIN
      SELECT LETTER_ADJUST_REASON_CODE INTO V_LETTER_ADJUST_REASON_CODE FROM D_LETTER_ADJUST_REASON WHERE REPORT_LABEL = IN_LETTER_ADJUST_REASON_LABEL and rownum = 1;
    EXCEPTION WHEN no_data_found then
              verrmsg := nvl(verrmsg,' ') || chr(10) || 'Adjustment Reason not found';
      when too_many_rows then
           null;
        when others then
          null;
    end;
end if;
*/

if verrmsg is not null then
  verrmsg := nvl(verrmsg,' ') || chr(10);
  raise_application_error(-20101,verrmsg);
  return;
end if;

    IF V_tran_detail_ID > 0 THEN
      verrmsg := '';
            update d_tran_detail
               set qa_abort_userid = IN_QA_ABORT,
                   qa_split_qty = IN_QA_SPLIT,
                   qa_rejected_qty = IN_QA_REJECT,
                   qa_comments = IN_QA_COMMENTS,
                   qa_signed = IN_QA_SIGNED,
                   qa_userid = IN_QA_USER_ID,
                   comments = IN_comments,
                   form_updated_by = IN_QA_USER_ID
             where tran_detail_id = v_tran_detail_id;

      commit;
    end if;
  exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;

      COMMIT;
     if trim(verrmsg) is not null then
         raise_application_error(-20101,verrmsg ||'         '|| chr(10));
     else
      corp_etl_stage_pkg.log_etl_msg(in_job_name => 'TRAN_FORM_QA'
      , in_process_name => 'TRAN_FORM_QA'
      , in_nr_of_error => 0
      , in_error_desc => v_Desc
      , in_error_field => v_err_field
      , in_error_codes => v_code
      , in_driver_table_name => 'LETTER_TRAN_ADJUSTMENT_FORM'
      , in_driver_key_number => v_driver_key
      );
      commit;
        raise_application_error(-20102, chr(10)||'Oracle Error:' || (v_code) || ':' || substr(v_desc,1,500) || chr(10));
     end if;

END;
/
