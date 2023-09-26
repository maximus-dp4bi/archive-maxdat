create or replace Procedure TRAN_COMM_INSERT
    (
   IN_TRAN_DATE IN DATE
  , IN_ACTION_LABEL IN VARCHAR2
  , IN_ACTION_CODE_OTHER IN VARCHAR2
  , IN_ACTION_DATE IN DATE
  , IN_ACTION_USER IN VARCHAR2
  , IN_FILENAME IN VARCHAR2
  , IN_COMMENTS IN VARCHAR2
  , IN_CREATED_BY IN VARCHAR2
  )
AS

V_TRAN_HEADER_ID NUMBER(32);
v_code corp_etl_error_log.error_codes%TYPE;
v_desc corp_etl_error_log.error_desc%TYPE;
v_driver_key varchar2(100);
v_err_field varchar2(100);
v_date_limit date;
v_action_code varchar2(100);
verrstart varchar2(100) := CHR(10) || CHR(10) || '                       Please fix below errors: ' || chr(10);
verrmsg varchar2(1000);
verror number := 0;

BEGIN
  v_driver_key := nvl(IN_ACTION_LABEL,'null') ||'/'|| nvl(to_char(IN_TRAN_DATE,'mmddyyyy'),'null') ;
  v_err_field := 'IN_ACTION_CODE/IN_TRAN_DATE';

    verrmsg := verrstart;

begin
	select to_date(value,'mm/dd/yyyy') into v_date_limit from corp_etl_control where name = 'FORM_ADJUST_DATE_LIMIT';
exception when others then
	v_date_limit := trunc(add_months(sysdate,13),'YYYY');
end;

    if IN_ACTION_USER IS NULL THEN
       verror := verror + 1;
         verrmsg := verrmsg || 'Action User cannot be null; ' ||CHR(10);
      --raise_application_error(-20104, 'Action User cannot be null');
    END IF;
    
    
 If  IN_TRAN_DATE is not null --or trunc(IN_START_DATE) > trunc(sysdate)
  and IN_ACTION_LABEL IS NOT NULL

 then

    if IN_TRAN_DATE < v_date_limit  then
       verror := verror + 1;
         verrmsg := verrmsg || 'Transmittal Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY')||'; ' ||CHR(10);
  	--raise_application_error(-20103, 'Transmittal Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY'));
    end if;

   if in_action_date < v_date_limit then
       verror := verror + 1;
         verrmsg := verrmsg || 'Action Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY')||'; ' ||CHR(10);
  	--raise_application_error(-20105, 'Action Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY'));
    end if;
    
    /* Action date cannot be prior to Transmittal Date */
        
       if in_action_date < in_tran_date then
           verror := verror + 1;
             verrmsg := verrmsg || 'Action Date cannot be prior to ' || to_char(in_tran_date,'DD-fmMonth-YYYY')||'; ' ||CHR(10);
      	--raise_application_error(-20105, 'Action Date cannot be prior to ' || to_char(v_date_limit,'DD-fmMonth-YYYY'));
    end if;

    if IN_TRAN_DATE > trunc(sysdate+1)  then
       verror := verror + 1;
         verrmsg := verrmsg || 'Transmittal Date cannot be in the future; ' ||CHR(10);
  	--raise_application_error(-20103, 'Transmittal Date cannot be in the future');
    end if;

   if in_action_date > trunc(sysdate+1) then
       verror := verror + 1;
         verrmsg := verrmsg || 'Action Date cannot be in the future; ' ||CHR(10);
  	--raise_application_error(-20105, 'Action Date cannot be in the future');
    end if;
    
      /* Action date cannot be NULL */
      
       if in_action_date is null then
           verror := verror + 1;
             verrmsg := verrmsg || 'Action Date cannot be NULL; ' ||CHR(10);
      	--raise_application_error(-20105, 'Action Date cannot be NULL');
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
          select action_code into v_action_code from d_tran_action_lkup where upper(report_label) = upper(in_action_label);
    EXCEPTION WHEN no_data_found then
              null;
      when too_many_rows then
           null;
        when others then
          null;
    end;

    --IF v_tran_header_id > 0 THEN
      if v_action_code is not null then
          insert into d_tran_action(tran_date, action_code, action_code_other, action_date, action_user, filename, action_comments, create_ts, created_by, update_ts, updated_by)
          values (in_tran_date, v_action_code, in_action_code_other, in_action_date, in_action_user, in_filename, in_comments, sysdate, in_created_by, sysdate, user);
          commit;
        else
         verror := verror + 1;
         verrmsg := verrmsg || 'Action Taken not found; ' ||CHR(10);
--          raise_application_error(-20101, 'Action Taken not found');
        end if;
     /*ELSE
        raise_application_error(-20101, 'Transmittal not found');

    END IF;*/

  ELSE
         verror := verror + 1;
         verrmsg := verrmsg || 'Input values incorrect; ' ||CHR(10);
   --raise_application_error(-20102, 'Input values incorrect');
  END IF;
  if verror > 0 then
             raise_application_error(-20101,verrmsg ||'         '|| chr(10));
  end if;
  exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;

      corp_etl_stage_pkg.log_etl_msg(in_job_name => 'MITRAN_TRAN_COMM_INSERT'
      , in_process_name => 'MITRAN_TRAN_COMM_INSERT'
      , in_nr_of_error => 0
      , in_error_desc => v_Desc
      , in_error_field => v_err_field
      , in_error_codes => v_code
      , in_driver_table_name => 'LETTER_TRAN_COMM_FORM'
      , in_driver_key_number => v_driver_key
      );
      COMMIT;
        raise_application_error(v_code, v_desc);

END;
