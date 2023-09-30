create or replace procedure process_letters_edi as

v_code corp_etl_error_log.error_codes%TYPE;
v_desc corp_etl_error_log.error_desc%TYPE;
v_driver_key varchar2(100);
v_err_field varchar2(100);
verrmsg varchar2(1000);
vyear varchar2(10) := to_char(sysdate,'yyyy');
vpyear varchar2(10) := to_char(add_months(sysdate, -12),'yyyy');
vtrandate date;
vproject_code varchar2(30);
vprogram_code varchar2(30);
v_tran_header_id number(32);
v_lmdef_id number;
v_subprogram_code varchar2(20);
v_tran_detail_id number(32);
begin

corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
, in_process_name => 'PROCESS_LETTERS_EDI'
, in_nr_of_error => 0
, in_error_desc => null
, in_error_field => null
, in_error_codes => null
, in_driver_table_name => 'ETL_L_LETTERS_EDI'
, in_driver_key_number => 0
);

begin
  select project_code into vproject_code from d_project where sysdate between start_date and end_Date and rownum = 1;
exception when others then
  vproject_code := 'MIEB';
end;

begin
  select program_Code into vprogram_code from d_program where sysdate between start_date and end_date and rownum = 1;
exception when others then
  vprogram_code := 'MEDICAID';
end;



--update trandate

for jobrec in (select job_Ctrl_id, job_name from mi_job_ctrl where job_name = 'LOAD_LETTERS_EDI' and status = 'WORK' order by job_ctrl_id)
  loop

for filerec in (select distinct xml_filename from etl_l_letters_edi where job_ctrl_id = jobrec.job_ctrl_id)
  loop

    begin
    vtrandate := to_date(substr(filerec.xml_filename, instr(filerec.xml_filename, vyear), 8),'yyyymmdd');
    exception when others then
    null;
    end;
    if vtrandate is null then
    begin
    vtrandate := to_date(substr(filerec.xml_filename, instr(filerec.xml_filename, vpyear), 8),'yyyymmdd');
    exception when others then
    null;
    end;
    end if;
    if vtrandate is null then
        corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
        , in_process_name => 'PROCESS_LETTERS_EDI'
        , in_nr_of_error => 0
        , in_error_desc => 'Tran date null for ' || filerec.xml_filename
        , in_error_field => null
        , in_error_codes => null
        , in_driver_table_name => 'ETL_L_LETTERS_EDI'
        , in_driver_key_number => 0
        );
     end if;

     begin

         update etl_l_letters_edi set tran_Date = coalesce(vtrandate, to_date(xml_dateofletter,'mm/dd/yyyy')) where job_Ctrl_id = jobrec.job_ctrl_id and xml_filename = filerec.xml_filename and tran_date is null;
     exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;
        corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
        , in_process_name => 'PROCESS_LETTERS_EDI'
        , in_nr_of_error => 0
        , in_error_desc => v_desc
        , in_error_field => null
        , in_error_codes => v_code
        , in_driver_table_name => 'MI_JOB_CTRL'
        , in_driver_key_number => jobrec.job_ctrl_id
        );
     end;

     commit;
end loop;

end loop;

--- delete old records if exist for same xml_filename
for jobrec in (select job_Ctrl_id, job_name from mi_job_ctrl where job_name = 'LOAD_LETTERS_EDI' and status = 'WORK' order by job_ctrl_id)
  loop
for filerec in (select distinct xml_filename from etl_l_letters_edi where job_ctrl_id = jobrec.job_ctrl_id)
  loop
  delete etl_l_letters_edi where xml_filename = filerec.xml_filename and job_ctrl_id < jobrec.job_ctrl_id;
  commit;
end loop;
end loop;


for jobrec in (select job_Ctrl_id, job_name from mi_job_ctrl where job_name = 'LOAD_LETTERS_EDI' and status = 'WORK' order by job_ctrl_id)
  loop

for trec in (select distinct tran_Date from etl_l_letters_edi where job_ctrl_id = jobrec.job_ctrl_id)
  loop

    v_tran_header_id := null;
    begin
    select tran_header_id
    into v_tran_header_id
    from d_tran_header
    where project_code = vproject_code and program_code = vprogram_code and tran_date = trec.tran_date
    and rownum = 1;
    exception when no_data_found then
      insert into d_tran_header
        (project_code, program_code, tran_date)
      values
        (vproject_code, vprogram_code, trec.tran_date)
        returning tran_header_id into v_tran_header_id;
     when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;
        corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
        , in_process_name => 'PROCESS_LETTERS_EDI'
        , in_nr_of_error => 0
        , in_error_desc => v_desc
        , in_error_field => null
        , in_error_codes => v_code
        , in_driver_table_name => 'MI_JOB_CTRL'
        , in_driver_key_number => jobrec.job_ctrl_id
        );
     end;

for drec in (select xml_filename, xml_lettertype, xml_materialcd, count(1) qty from etl_l_letters_edi where job_Ctrl_id = jobrec.job_Ctrl_id and tran_date = trec.tran_Date group by xml_filename, xml_lettertype, xml_materialcd order by xml_lettertype, xml_materialcd)
loop
    v_lmdef_id := null;
    v_subprogram_code := null;
    dbms_output.put_line('Record:' || drec.xml_filename ||':'||drec.xml_lettertype);
    begin
      select lmdef_id, subprogram_code into v_lmdef_id, v_subprogram_code
      from d_letter_Definition where name = case when drec.xml_lettertype = 'XX' then drec.xml_materialcd else drec.xml_lettertype end and rownum = 1;
    exception when others then
      v_code := SQLCODE;
      v_desc := SQLERRM;
        corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
        , in_process_name => 'PROCESS_LETTERS_EDI'
        , in_nr_of_error => 0
        , in_error_desc => 'LMDEF error ' ||v_desc
        , in_error_field => null
        , in_error_codes => v_code
        , in_driver_table_name => 'MI_JOB_CTRL'
        , in_driver_key_number => jobrec.job_ctrl_id
        );
     end;

    dbms_output.put_line('Record:' || drec.xml_filename ||':'||drec.xml_lettertype||':'||v_tran_header_id || ':'|| v_lmdef_id);

   if v_lmdef_id is not null then
     v_tran_detail_id := null;
      begin
      select tran_detail_id
      into v_tran_detail_id
      from d_tran_detail
      where tran_header_id = v_tran_header_id
      and ltr_filename = drec.xml_filename
      and lmdef_id = v_lmdef_id;

      update d_tran_detail set requested_qty = drec.qty where tran_detail_id = v_tran_detail_id;

      exception when no_data_found then
        begin

        insert into d_tran_detail
          (tran_detail_id, tran_header_id, subprogram_code, lmdef_id, ltr_filename, requested_qty)
        values
          (v_tran_detail_id, v_tran_header_id, v_subprogram_code, v_lmdef_id, drec.xml_filename, drec.qty);
        exception when others then
            v_code := SQLCODE;
            v_desc := SQLERRM;
              corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
              , in_process_name => 'PROCESS_LETTERS_EDI'
              , in_nr_of_error => 0
              , in_error_desc => 'Insert detail:' ||drec.xml_filename||' '|| v_desc
              , in_error_field => null
              , in_error_codes => v_code
              , in_driver_table_name => 'MI_JOB_CTRL'
              , in_driver_key_number => jobrec.job_ctrl_id
              );
          end;
                          
          when others then
            v_code := SQLCODE;
            v_desc := SQLERRM;
              corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
              , in_process_name => 'PROCESS_LETTERS_EDI'
              , in_nr_of_error => 0
              , in_error_desc => 'Select tran_detail ' || v_desc
              , in_error_field => null
              , in_error_codes => v_code
              , in_driver_table_name => 'MI_JOB_CTRL'
              , in_driver_key_number => jobrec.job_ctrl_id
              );
       end;
   end if;

end loop;
end loop;
end loop;
commit;
exception when others then
            v_code := SQLCODE;
            v_desc := SQLERRM;
              corp_etl_stage_pkg.log_etl_msg(in_job_name => 'PROCESS_LETTERS_EDI'
              , in_process_name => 'PROCESS_LETTERS_EDI'
              , in_nr_of_error => 0
              , in_error_desc => 'Before end: ' || v_desc
              , in_error_field => null
              , in_error_codes => v_code
              , in_driver_table_name => 'ETL_L_LETTERS_EDI'
              , in_driver_key_number => 0
              );

end;
/
