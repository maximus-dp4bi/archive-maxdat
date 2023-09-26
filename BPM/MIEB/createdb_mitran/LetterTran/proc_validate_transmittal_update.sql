create or replace procedure validate_transmittal_update (
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
  , OUT_ERRORS IN OUT VARCHAR2
)
AS
V_TRAN_HEADER_ID NUMBER(32);

V_LMDEF_ID NUMBER := 0;
V_PROGRAM_CON_XWALK_CODE VARCHAR2(100);
--V_LETTER_TYPE_NAME VARCHAR2(100);
V_LETTER_ADJUST_REASON_CODE VARCHAR2(100);
--NOTE:  IN_CHANGE_STATUS = CHANGE_STATUS_DESC and IN_CHANGE_STATUS_CODE = CHANGE_STATUS
v_code corp_etl_error_log.error_codes%TYPE;
v_desc corp_etl_error_log.error_desc%TYPE;
v_driver_key varchar2(100);
v_err_field varchar2(100);
v_date_limit date;
verrstart varchar2(100) := CHR(10) || CHR(10) || 'Please fix below errors:' || chr(10);
verrmsg varchar2(1000);
v_tran_detail_id number(32);
verror number := 0;
v_tran_detail_invoiced varchar2(10);
v_formname varchar2(10) := 'UPD';

BEGIN
  v_driver_key := nvl(IN_LETTER_REPORT_LABEL,'null') ||'/'|| nvl(to_char(IN_TRAN_DATE,'mmddyyyy'),'null') ||'/'|| nvl(to_char(IN_TRAN_QTY),'null') ;
  v_err_field := 'IN_LETTER_REPORT_LABEL/IN_TRAN_DATE/IN_TRAN_QTY';

begin
  select to_date(value,'mm/dd/yyyy') into v_date_limit from corp_etl_control where name = 'FORM_ADJUST_DATE_LIMIT';
exception when others then
  v_date_limit := trunc(add_months(sysdate,13),'YYYY');
end;
--first level pool errors
    verrmsg := verrstart;

    if in_tran_date is null then
       verror := verror + 1;
         verrmsg := verrmsg || 'Transmittal Date cannot be null' ||CHR(10);
    end if;

    if in_tran_qty <=0 or in_tran_qty is null then
       verror := verror + 1;
      verrmsg := verrmsg || 'Transmittal Quantity incorrect'|| chr(10);
    end if;

    if IN_LETTER_REPORT_LABEL is null then
       verror := verror + 1;
      verrmsg := verrmsg || 'Letter Type cannot be null'|| chr(10);
    end if;

    if IN_TRAN_DATE < v_date_limit  then
       verror := verror + 1;
        verrmsg := verrmsg || 'Transmittal Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY') || chr(10);
    end if;

    if IN_TRAN_DATE >= trunc(sysdate+1)  then
       verror := verror + 1;
    verrmsg := verrmsg || 'Transmittal Date cannot be in the future' || chr(10);
    end if;

    if IN_EYR_MAILED_DATE is not null and IN_EYR_MAILED_DATE >= trunc(sysdate+1) then
       verror := verror + 1;
        verrmsg := verrmsg || 'EYR Mailed Date cannot be in the future' || chr(10);
    end if;
/*    if IN_QA_USER_ID IS NULL THEN
      verror := verror+1;
      verrmsg := verrmsg || 'QA User Information required' || chr(10);
    end if;
*/---end first level errors

dbms_output.put_line('error count: ' || to_char(nvl(verror,0)));
    if verror> 0 then
       out_errors := verrmsg;
       return;
    end if;

---second level
    verrmsg := verrstart;
       verror := 0;

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
       verror := verror + 1;
       verrmsg := verrmsg || 'Letter Adjustment Reason not found' || chr(10);
      when too_many_rows then
           null;
        when others then
          null;
    end;

    BEGIN
      SELECT LETTER_ADJUST_REASON_CODE INTO V_LETTER_ADJUST_REASON_CODE FROM D_LETTER_ADJUST_REASON WHERE REPORT_LABEL = IN_LETTER_ADJUST_REASON_LABEL;
    EXCEPTION WHEN no_data_found then
              null;
      when too_many_rows then
           null;
        when others then
          null;
    end;

    if v_tran_header_id is not null and v_lmdef_id is not null then
    begin
      select tran_detail_id, invoiced into v_tran_detail_id, v_tran_detail_invoiced from d_tran_detail_sv td where td.tran_header_id = v_tran_header_id and td.LMDEF_ID = v_lmdef_id and rownum = 1;
    exception when no_Data_found then
              null;
     when others then
       null;
    end;
    end if;
    
    if v_tran_detail_id is not null and v_formname IN ('UPD','QA') and (v_tran_detail_invoiced is not null or v_tran_detail_invoiced = 'Y' ) then
       verror := verror + 1;
      verrmsg := verrmsg || 'Transmittal already invoiced, cannot Update' || chr(10);
    end if;

    if in_tran_qty is not null and in_tran_filename is null then
       verror := verror + 1;
      verrmsg :=  verrmsg || 'Transmittal entry for this letter is missing Letter Filename'|| chr(10);
    end if;

    if (in_eyr_qty is not null and in_eyr_filename is null ) or (in_eyr_qty is null and in_eyr_filename is not null) then
       verror := verror + 1;
      verrmsg := verrmsg || 'Both EYR Letter filename and EYR Quantity is required' || chr(10);
    end if;

    if (in_qa_abort is not null or in_qa_split is not null or in_qa_reject is not null) and IN_QA_USER_ID is null then
       verror := verror + 1;
      verrmsg := verrmsg || 'QA User required when QA fields are not empty' || chr(10);
    end if;

    if (in_qa_abort is not null or in_qa_split is not null or in_qa_reject is not null) and IN_QA_SIGNED is null then
       verror := verror + 1;
      verrmsg := verrmsg || 'QA Approver Signature required when QA fields are not empty' || chr(10);
    end if;

    if (in_eyr_mailed_date is not null and in_eyr_mailed_qty is null) or (in_eyr_mailed_date is null and in_eyr_mailed_qty is not null) then
       verror := verror + 1;
      verrmsg := verrmsg || 'Both EYR Mailed Qty and EYR Mailed letter Filename is required' || chr(10);
    end if;

    if (in_eyr_mailed_qty is not null and (in_tran_qty is null or in_eyr_qty is null)) then
       verror := verror + 1;
      verrmsg := verrmsg || 'Both Letter Quantity and EYR Quantity required when Mailed Quantity is entered'  || chr(10);
    end if;

dbms_output.put_line('error count: ' || to_char(nvl(verror,0)));
    if verror> 0 then
      out_errors := verrmsg || CHR(10);
      return;
    end if;

END;
/