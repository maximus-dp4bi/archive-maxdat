create or replace procedure ins_letter63_data_mieb as
v_maxletterid number(32) := 999999999999;
v_afterletterid number(32) := 999999999999;
begin
  begin
  select max(dp_letter_request_id) into v_maxletterid from d_letter_request where lmdef_id = 63;
  exception when others then
    null;
  end;

  insert into d_letter_request (select * from maxdat_mieb.d_letter_request mieblr where mieblr.dp_letter_request_id > v_maxletterid
   and mieblr.requested_on >= to_date('8/25/2022','mm/dd/yyyy') and lmdef_id = 63);
   
  insert into d_letter_request_link (select * from maxdat_mieb.d_letter_request_link h where h.letter_request_id in (select letter_request_id from d_letter_request where dp_letter_request_id > v_maxletterid));
  insert into d_letter_request_hist (select * from maxdat_mieb.d_letter_request_hist h where h.dp_letter_request_id in (select dp_letter_request_id from d_letter_request where dp_letter_request_id > v_maxletterid));
  commit;

  begin
  select max(dp_letter_request_id) into v_afterletterid from d_letter_request where lmdef_id = 63;
  exception when others then
    null;
  end;
        corp_etl_stage_pkg.log_etl_msg(in_job_name => 'ins_letter63_data_mieb'
        , in_process_name => 'ins_letter63_data_mieb'
        , in_nr_of_error => 0
        , in_error_desc => 'LetterID :Before: ' || to_char(v_maxletterid) || ' After:' || to_char(v_afterletterid)
        , in_error_field => null
        , in_error_codes => null
        , in_driver_table_name => 'MAX Letter id'
        , in_driver_key_number => v_maxletterid
        );
  commit;
exception when others then
        corp_etl_stage_pkg.log_etl_msg(in_job_name => 'ins_letter63_data_mieb'
        , in_process_name => 'ins_letter63_data_mieb'
        , in_nr_of_error => 0
        , in_error_desc => 'Not able to insert 63 data'
        , in_error_field => null
        , in_error_codes => null
        , in_driver_table_name => 'MAX Letter id'
        , in_driver_key_number => v_maxletterid
        );
        commit;
end;
