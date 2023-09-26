alter session set plsql_code_type = native;

create or replace Procedure MI_LETTER_ADJUST_FORM_INSERT
    (
  IN_LETTER_REPORT_LABEL IN VARCHAR2
  , IN_ADJUSTMENT_DATE IN DATE
  , IN_LETTER_ADJUST_REASON_LABEL IN VARCHAR2
  , IN_ADJUSTMENT_COUNT IN NUMBER
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
v_date_limit date;
BEGIN
  v_driver_key := nvl(IN_LETTER_REPORT_LABEL,'null') ||'/'|| nvl(to_char(IN_ADJUSTMENT_DATE,'mmddyyyy'),'null') ||'/'|| nvl(to_char(IN_ADJUSTMENT_COUNT),'null') ;
  v_err_field := 'IN_LETTER_REPORT_LABEL/IN_ADJUSTMENT_DATE/IN_ADJUSTMENT_DATE';

begin
	select to_date(value,'mm/dd/yyyy') into v_date_limit from corp_etl_control where name = 'FORM_ADJUST_DATE_LIMIT';
exception when others then
	v_date_limit := trunc(add_months(sysdate,13),'YYYY');
end;

 If  IN_LETTER_REPORT_LABEL is not null  
  and IN_ADJUSTMENT_COUNT is not null --or trunc(IN_START_DATE) > trunc(sysdate)
  and IN_ADJUSTMENT_COUNT <> 0  
     
 then
 
    if in_adjustment_date < v_date_limit then
  	raise_application_error(-20103, 'Adjustment Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY'));
    end if;

    BEGIN
      SELECT letter_definition_id,LT.PROGRAM_CON_XWALK_CODE  INTO V_LMDEF_ID,V_PROGRAM_CON_XWALK_CODE FROM D_LETTER_TYPE_SV LT WHERE LT.REPORT_LABEL =  IN_LETTER_REPORT_LABEL;
    EXCEPTION WHEN no_data_found then
              null;
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

    IF V_LMDEF_ID > 0 THEN            
        INSERT INTO LETTER_ADJUSTMENT_FORM(
               LMDEF_ID
               , PROGRAM_CON_XWALK_CODE
 --              , LETTER_TYPE_NAME
               , ADJUSTMENT_DATE
               , LETTER_ADJUST_REASON_CODE
               , ADJUSTMENT_COUNT
               , COMMENTS, CREATED_BY
               , CREATION_DATE
               , UPDATED_BY
               , UPDATED_DATE)
               VALUES (
               V_LMDEF_ID
               , V_PROGRAM_CON_XWALK_CODE
--               , V_LETTER_TYPE_NAME
               , IN_ADJUSTMENT_DATE
               , V_LETTER_ADJUST_REASON_CODE
               , IN_ADJUSTMENT_COUNT
               , IN_COMMENTS
               , IN_CREATED_BY
               , SYSDATE
               , IN_UPDATED_BY
               , sysdate
               );

               commit;
     ELSE
        raise_application_error(-20101, 'Letter Type Name not found');

    END IF;

  ELSE
        raise_application_error(-20102, 'Input values incorrect');
  END IF; 
  exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;

      corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MI_LETTER_ADJUST_FORM_INSERT'
      , in_process_name => 'MI_LETTER_ADJUST_FORM_INSERT'
      , in_nr_of_error => 0
      , in_error_desc => v_Desc
      , in_error_field => v_err_field
      , in_error_codes => v_code
      , in_driver_table_name => 'LETTER_ADJUSTMENT_FORM'
      , in_driver_key_number => v_driver_key
      );
      COMMIT;       
        raise_application_error(v_code, v_desc);

END;
/

create or replace Procedure MI_LETTER_ADJUST_FORM_UPDATE
    (
  IN_LETTER_ADJUSTMENT_FORM_ID IN NUMBER
  , IN_LETTER_REPORT_LABEL IN VARCHAR2
  , IN_ADJUSTMENT_DATE IN DATE
  , IN_LETTER_ADJUST_REASON_LABEL IN VARCHAR2
  , IN_ADJUSTMENT_COUNT IN NUMBER
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
v_date_limit date;
v_log_input varchar2(1000);
BEGIN
  v_driver_key := nvl(IN_LETTER_ADJUSTMENT_FORM_ID,0) || '/'||nvl(IN_LETTER_REPORT_LABEL,'null') ||'/'|| nvl(to_char(IN_ADJUSTMENT_DATE,'mmddyyyy'),'null') ||'/'|| nvl(to_char(IN_ADJUSTMENT_DATE),'null') ;
  v_err_field := 'IN_LETTER_ADJUSTMENT_FORM_ID/IN_LETTER_REPORT_LABEL/IN_ADJUSTMENT_DATE/IN_ADJUSTMENT_DATE';

begin
  v_log_input := IN_LETTER_ADJUSTMENT_FORM_ID || '|' || IN_LETTER_REPORT_LABEL || '|' || IN_ADJUSTMENT_DATE || '|' || IN_LETTER_ADJUST_REASON_LABEL || '|' || IN_ADJUSTMENT_COUNT || '|' || IN_COMMENTS;
      corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MI_LETTER_ADJUST_FORM_INSERT'
      , in_process_name => 'MI_LETTER_ADJUST_FORM_INSERT Log'
      , in_nr_of_error => 0
      , in_error_desc => v_log_input
      , in_error_field => 'input values'
      , in_error_codes => '0'
      , in_driver_table_name => 'LETTER_ADJUSTMENT_FORM'
      , in_driver_key_number => v_driver_key
      );

	select to_date(value,'mm/dd/yyyy') into v_date_limit from corp_etl_control where name = 'FORM_ADJUST_DATE_LIMIT';
exception when others then
	v_date_limit := trunc(add_months(sysdate,13),'YYYY');
end;

 If  IN_LETTER_REPORT_LABEL is not null  
  and IN_ADJUSTMENT_COUNT is not null --or trunc(IN_START_DATE) > trunc(sysdate)
  and IN_LETTER_ADJUSTMENT_FORM_ID > 0
     
 then
    if in_adjustment_date < v_date_limit then
  	raise_application_error(-20103, 'Adjustment Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY'));
    end if;
    
  BEGIN
      SELECT letter_definition_id,LT.PROGRAM_CON_XWALK_CODE   INTO V_LMDEF_ID,V_PROGRAM_CON_XWALK_CODE  FROM D_LETTER_TYPE_SV LT WHERE LT.REPORT_LABEL =  IN_LETTER_REPORT_LABEL;
    EXCEPTION WHEN no_data_found then
              null;
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

    IF V_LMDEF_ID > 0 THEN            
        update LETTER_ADJUSTMENT_FORM
        set  LMDEF_ID =  V_LMDEF_ID
               , PROGRAM_CON_XWALK_CODE = V_PROGRAM_CON_XWALK_CODE
--               , LETTER_TYPE_NAME = V_LETTER_TYPE_NAME
               , ADJUSTMENT_DATE = IN_ADJUSTMENT_DATE
               , LETTER_ADJUST_REASON_CODE = V_LETTER_ADJUST_REASON_CODE
               , ADJUSTMENT_COUNT = IN_ADJUSTMENT_COUNT
               , COMMENTS = IN_COMMENTS
               , UPDATED_BY = IN_UPDATED_BY
               , UPDATED_DATE = sysdate
               where LETTER_ADJUSTMENT_FORM_ID = IN_LETTER_ADJUSTMENT_FORM_ID;

               commit;
     ELSE
        raise_application_error(-20101, 'Letter Type Name not found');

    END IF;

  ELSE
        raise_application_error(-20102, 'Input values incorrect');
  END IF; 
  exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;

      corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MI_LETTER_ADJUST_FORM_INSERT'
      , in_process_name => 'MI_LETTER_ADJUST_FORM_INSERT'
      , in_nr_of_error => 0
      , in_error_desc => v_Desc
      , in_error_field => v_err_field
      , in_error_codes => v_code
      , in_driver_table_name => 'LETTER_ADJUSTMENT_FORM'
      , in_driver_key_number => v_driver_key
      );
      COMMIT;       
        raise_application_error(v_code, v_desc);

END;
/

grant execute on MI_LETTER_ADJUST_FORM_UPDATE to maxdat_reports;
grant execute on MI_LETTER_ADJUST_FORM_INSERT to maxdat_reports;
grant execute on MI_LETTER_ADJUST_FORM_UPDATE to MAXDAT_MIEB_READ_ONLY;
grant execute on MI_LETTER_ADJUST_FORM_INSERT to MAXDAT_MIEB_READ_ONLY;
grant insert, update on LETTER_ADJUSTMENT_FORM to MAXDAT_MIEB_READ_ONLY;
grant select,insert, update,delete on LETTER_ADJUSTMENT_FORM to maxdat_reports;

alter session set plsql_code_type = interpreted;
