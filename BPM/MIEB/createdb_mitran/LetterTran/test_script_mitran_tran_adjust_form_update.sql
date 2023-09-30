--test tran_adjust_update
--select * from d_letter_type_sv;
--success
declare
verrmsg varchar2(1000);
begin
  validate_transmittal_update(
in_letter_report_label => 'MAXEB - FIM',
in_tran_date => to_date('8/23/2022','mm/dd/yyyy'),
in_tran_filename => 'LTR00010.csv',
in_tran_qty => 20,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_user_id => '36755',
in_qa_signed => 'AS',
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => 'blah',
in_comments => null,
in_updated_by => user
  , OUT_ERRORS => verrmsg
);
dbms_output.put_line('Err:' || verrmsg);
end;

--success 
begin
  tran_adjust_update(
  in_tran_Detail_id => 358,
in_letter_report_label => 'MAXEB - RC',
in_tran_filename => 'LTR0001_changed.csv',
in_tran_qty => 40,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_signed => null,
in_qa_user_id => user,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_updated_by => user
);
end;
/* 
select * from d_tran_header where create_ts >= trunc(sysdate);
select * from d_tran_Detail where create_ts >= trunc(sysdate);
select * from d_tran_detail where tran_detail_id = 358;
select * from d_letter_definition where name = 'RC';


delete d_tran_detail where create_ts >= trunc(sysdate);
delete d_tran_header where create_ts >= trunc(sysdate);
select * from f_transmittal_Details_Sv where tran_date = to_date('8/23/2022','mm/dd/yyyy');

*/

-- child not exists
begin
  tran_adjust_update(
  in_tran_Detail_id => 358,
in_letter_report_label => 'MAXEB - OE',
in_tran_filename => 'LTR0001_changed.csv',
in_tran_qty => 50,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_signed => null,
in_qa_user_id => user,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_updated_by => user
);
end;

--Qty null
begin
  tran_adjust_update(
  in_tran_Detail_id => 358,
in_letter_report_label => 'MAXEB - RC',
in_tran_filename => 'LTR0001_changed.csv',
in_tran_qty => 40,
in_resent => null,
in_eyr_qty => 40,
in_eyr_filename => 'Letter08202022',
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => 2,
in_qa_signed => 'AS',
in_qa_user_id => user,
in_qa_comments => null,
in_eyr_mailed_date => to_date('8/8/2022','mm/dd/yyyy'),
in_eyr_mailed_qty => 10,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_updated_by => user
);
end;

--errror
begin
  tran_adjust_update(
  in_tran_Detail_id => 358,
in_letter_report_label => 'MAXEB - RC',
in_tran_filename => 'LTR0001_changed.csv',
in_tran_qty => 40,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => 'Letter08202022',
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => 2,
in_qa_signed => null,
in_qa_user_id => user,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => 10,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => 'blah',
in_comments => null,
in_updated_by => user
);
end;
