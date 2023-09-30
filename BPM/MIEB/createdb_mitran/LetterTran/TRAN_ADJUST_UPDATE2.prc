CREATE OR REPLACE Procedure TRAN_ADJUST_UPDATE2
    (
  IN_TRAN_DETAIL_ID IN number
  , IN_LETTER_REPORT_LABEL IN VARCHAR2
  , IN_TRAN_FILENAME IN VARCHAR2
  , IN_TRAN_QTY IN NUMBER
  , IN_RESENT IN VARCHAR2
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

end;
/
