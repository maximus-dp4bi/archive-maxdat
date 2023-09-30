create or replace procedure process_tran_edi as

v_code corp_etl_error_log.error_codes%TYPE;
v_desc corp_etl_error_log.error_desc%TYPE;
v_driver_key varchar2(100);
v_err_field varchar2(100);
verrmsg varchar2(1000);
vyear varchar2(10) := to_char(sysdate,'yyyy');
vpyear varchar2(10) := to_char(add_months(sysdate, -12),'yyyy');
vtrandate date;
vproject_code varchar2(30) := 'MIEB';
vprogram_code varchar2(30) := 'MEDICAID';
v_tran_header_id number(32);
v_lmdef_id number;
v_subprogram_code varchar2(20);
v_tran_detail_id number(32);
v_invoiced varchar2(10);
v_dtl_tran_header_id number(32);
v_inserted_new varchar2(1);
begin

corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_TRAN_EDI'
, in_process_name => 'PROCESS_TRAN_EDI'
, in_nr_of_error => 0
, in_error_desc => null
, in_error_field => null
, in_error_codes => null
, in_driver_table_name => 'ETL_L_TRAN_EDI'
, in_driver_key_number => 0
);

--update trandate

for jobrec in (select job_Ctrl_id, job_name from mi_job_ctrl where job_name = 'LOAD_TRAN_EDI' and status = 'WORK' order by job_ctrl_id)
  loop

for tranrec in (select distinct tran_date from etl_l_tran_edi where job_ctrl_id = jobrec.job_ctrl_id)
  loop

    v_tran_header_id := null;
    v_inserted_new := 'N';
    begin
    select tran_header_id
    into v_tran_header_id
    from d_tran_header
    where project_code = vproject_code and program_code = vprogram_code and tran_date = tranrec.tran_date
    and rownum = 1;
    exception when no_data_found then
      insert into d_tran_header
        (project_code, program_code, tran_date)
      values
        (vproject_code, vprogram_code, tranrec.tran_date)
        returning tran_header_id into v_tran_header_id;
        v_inserted_new := 'Y';
     when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;
        corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_TRAN_EDI'
        , in_process_name => 'PROCESS_TRAN_EDI'
        , in_nr_of_error => 0
        , in_error_desc => v_desc
        , in_error_field => null
        , in_error_codes => v_code
        , in_driver_table_name => 'MI_JOB_CTRL'
        , in_driver_key_number => jobrec.job_ctrl_id
        );
     end;

  if v_tran_header_id is not null then

     for dtlrec in (select lmdef.lmdef_id, lmdef.name lmdef_name, lmdef.subprogram_code
       , count(*) over(partition by te.job_ctrl_id, te.tran_date, lmdef.lmdef_id order by te.job_ctrl_id, te.tran_date, lmdef.lmdef_id) ltrcount
        ,te.*
            from etl_l_tran_edi te, d_letter_definition lmdef
           where 1=1
            and lmdef.report_label = trim(upper(te.letter_type))
            and te.job_ctrl_id = jobrec.job_ctrl_id
            and tran_date = tranrec.tran_date
            )
     loop
     if v_inserted_new = 'N' then
            begin
              v_tran_detail_id := null;
              v_invoiced := null;
              v_dtl_tran_header_id := null;

              if dtlrec.ltrcount > 1 then
                    select tran_detail_id, invoiced, tran_header_id
                  into v_tran_Detail_id, v_invoiced, v_dtl_tran_header_id
                  from d_tran_detail td
                  where td.tran_header_id = v_tran_header_id
                  and td.lmdef_id = dtlrec.lmdef_id
                  and upper(trim(td.ltr_filename)) = upper(trim(dtlrec.ltr_filename));
               else   
                    select tran_detail_id, invoiced, tran_header_id
                  into v_tran_Detail_id, v_invoiced, v_dtl_tran_header_id
                  from d_tran_detail td
                  where td.tran_header_id = v_tran_header_id
                  and td.lmdef_id = dtlrec.lmdef_id;
               end if;
                  
              --record found but header is different
              -- raise error
              if v_invoiced is not null and v_invoiced in ('Y','y') then
                    corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_TRAN_EDI'
                    , in_process_name => 'PROCESS_TRAN_EDI'
                    , in_nr_of_error => 0
                    , in_error_desc => 'dtlrec letter already invoiced ' || dtlrec.lmdef_name
                    , in_error_field => null
                    , in_error_codes => v_code
                    , in_driver_table_name => 'MI_JOB_CTRL'
                    , in_driver_key_number => jobrec.job_ctrl_id
                    );
              else
                 update d_tran_detail
                    set tran_job_id = dtlrec.tran_job_id,
                        ltr_filename = dtlrec.ltr_filename,
                        requested_qty = dtlrec.requested_qty,
                        resent = dtlrec.resent,
                        preqa_eyr_ltr_filename = dtlrec.preqa_eyr_ltr_filename,
                        preqa_eyr_ltr_qty = dtlrec.preqa_eyr_ltr_qty,
                        qa_abort_userid = dtlrec.qa_abort_userid,
                        qa_split_qty = dtlrec.qa_split_qty,
                        qa_rejected_qty = dtlrec.qa_rejected_qty,
                        qa_comments = dtlrec.qa_comments,
                        qa_signed = dtlrec.qa_signed,
                        eyr_mailed_date = dtlrec.eyr_mailed_date,
                        eyr_mailed_qty = dtlrec.eyr_mailed_qty,
                        eyr_ps_checked = dtlrec.eyr_ps_checked,
                        eyr_ps_comments = dtlrec.eyr_ps_comments,
                        update_ts = sysdate,
                        updated_by = user
                  where tran_detail_id = v_tran_detail_id;
              end if;

            exception when no_Data_found then
              --insert into d_tran_detail
              insert into d_tran_detail
                (tran_header_id, subprogram_code, tran_job_id, lmdef_id, ltr_filename, requested_qty, resent, preqa_eyr_ltr_filename, preqa_eyr_ltr_qty, qa_abort_userid, qa_split_qty, qa_rejected_qty, qa_comments, qa_signed, eyr_mailed_date, eyr_mailed_qty, eyr_ps_checked, eyr_ps_comments, create_ts, update_ts, created_by, updated_by)
              values
                (v_tran_header_id, dtlrec.subprogram_code, dtlrec.tran_job_id, dtlrec.lmdef_id, dtlrec.ltr_filename, dtlrec.requested_qty, dtlrec.resent, dtlrec.preqa_eyr_ltr_filename, dtlrec.preqa_eyr_ltr_qty, dtlrec.qa_abort_userid, dtlrec.qa_split_qty, dtlrec.qa_rejected_qty, dtlrec.qa_comments, dtlrec.qa_signed,  dtlrec.eyr_mailed_date, dtlrec.eyr_mailed_qty, dtlrec.eyr_ps_checked, dtlrec.eyr_ps_comments, dtlrec.create_ts, dtlrec.update_ts, dtlrec.created_by, dtlrec.updated_by);

            when others then
                  v_code := SQLCODE;
                  v_desc := SQLERRM;
                    corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_TRAN_EDI'
                    , in_process_name => 'PROCESS_TRAN_EDI'
                    , in_nr_of_error => 0
                    , in_error_desc => v_desc
                    , in_error_field => null
                    , in_error_codes => v_code
                    , in_driver_table_name => 'MI_JOB_CTRL'
                    , in_driver_key_number => jobrec.job_ctrl_id
                    );
              end;
       elsif v_inserted_new = 'Y' then
              insert into d_tran_detail
                (tran_header_id, subprogram_code, tran_job_id, lmdef_id, ltr_filename, requested_qty, resent, preqa_eyr_ltr_filename, preqa_eyr_ltr_qty, qa_abort_userid, qa_split_qty, qa_rejected_qty, qa_comments, qa_signed, eyr_mailed_date, eyr_mailed_qty, eyr_ps_checked, eyr_ps_comments, create_ts, update_ts, created_by, updated_by)
              values
                (v_tran_header_id, dtlrec.subprogram_code, dtlrec.tran_job_id, dtlrec.lmdef_id, dtlrec.ltr_filename, dtlrec.requested_qty, dtlrec.resent, dtlrec.preqa_eyr_ltr_filename, dtlrec.preqa_eyr_ltr_qty, dtlrec.qa_abort_userid, dtlrec.qa_split_qty, dtlrec.qa_rejected_qty, dtlrec.qa_comments, dtlrec.qa_signed,  dtlrec.eyr_mailed_date, dtlrec.eyr_mailed_qty, dtlrec.eyr_ps_checked, dtlrec.eyr_ps_comments, dtlrec.create_ts, dtlrec.update_ts, dtlrec.created_by, dtlrec.updated_by);
       end if;         
     end loop;
  end if;

end loop;

end loop;
commit;
exception when others then
            v_code := SQLCODE;
            v_desc := SQLERRM;
              corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_TRAN_EDI'
              , in_process_name => 'PROCESS_TRAN_EDI'
              , in_nr_of_error => 0
              , in_error_desc => 'Before end: ' || v_desc
              , in_error_field => null
              , in_error_codes => v_code
              , in_driver_table_name => 'ETL_L_LETTERS_EDI'
              , in_driver_key_number => 0
              );

end;
/
