--test tran_adjust_insert
--select * from d_letter_type_sv;
--success
declare
verrmsg varchar2(1000);
begin
  validate_transmittal(
in_letter_report_label => 'MAXEB - OE',
in_tran_date => to_date('8/24/2022','mm/dd/yyyy'),
in_tran_filename => 'LTR0001.csv',
in_tran_qty => 10,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_user_id => null,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_created_by => user,
in_updated_by => user
  , IN_FORMNAME => 'ADD'
  , OUT_ERRORS => verrmsg
);
dbms_output.put_line('Err:' || verrmsg);
end;

--success insert
begin
  tran_adjust_insert(
in_letter_report_label => 'MAXEB - RC',
in_tran_date => to_date('8/22/2022','mm/dd/yyyy'),
in_tran_filename => 'LTR0001.csv',
in_tran_qty => 10,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_signed => null,
in_user_id => null,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_created_by => user,
in_updated_by => user
);
end;
/* 
select * from d_tran_header where create_ts >= trunc(sysdate);
select * from d_tran_Detail where create_ts >= trunc(sysdate);
delete d_tran_detail where create_ts >= trunc(sysdate);
delete d_tran_header where create_ts >= trunc(sysdate);
select * from f_transmittal_Details_Sv where tran_date = to_date('8/23/2022','mm/dd/yyyy');

*/

-- child exists
begin
  tran_adjust_insert(
in_letter_report_label => 'MAXEB - OE',
in_tran_date => to_date('8/23/2022','mm/dd/yyyy'),
in_tran_filename => 'LTR0001.csv',
in_tran_qty => 10,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_signed => null,
in_user_id => null,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_created_by => user,
in_updated_by => user
);
end;
--add new detail
begin
  tran_adjust_insert(
in_letter_report_label => 'MAXEB - IA',
in_tran_date => to_date('8/23/2022','mm/dd/yyyy'),
in_tran_filename => 'LTR0001.csv',
in_tran_qty => 10,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_signed => null,
in_user_id => null,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_created_by => user,
in_updated_by => user
);
end;
--add new detail
begin
  tran_adjust_insert(
in_letter_report_label => 'MAXEB - CN',
in_tran_date => to_date('8/23/2022','mm/dd/yyyy'),
in_tran_filename => 'LTR0002.csv',
in_tran_qty => 20,
in_resent => null,
in_eyr_qty => 20,
in_eyr_filename => 'LTR0002.csv',
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_signed => null,
in_user_id => null,
in_qa_comments => null,
in_eyr_mailed_date => to_date('8/23/2022','mm/dd/yyyy'),
in_eyr_mailed_qty => 20,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_created_by => user,
in_updated_by => user
);
end;

--Qty null
begin
  tran_adjust_insert(
in_letter_report_label => 'MAXEB - OE',
in_tran_date => null,
in_tran_filename => null,
in_tran_qty => null,
in_resent => null,
in_eyr_qty => null,
in_eyr_filename => null,
in_qa_abort => null,
in_qa_split => null,
in_qa_reject => null,
in_qa_signed => null,
in_user_id => null,
in_qa_comments => null,
in_eyr_mailed_date => null,
in_eyr_mailed_qty => null,
in_eyr_user => null,
in_eyr_notes => null,
in_letter_adjust_reason_label => null,
in_comments => null,
in_created_by => user,
in_updated_by => user
);
end;

