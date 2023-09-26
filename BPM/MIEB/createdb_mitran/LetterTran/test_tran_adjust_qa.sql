--SUCCESS
begin
maxdat_mitran.tran_adjust_qa(in_tran_detail_id => 358,
               in_qa_abort => null,
               in_qa_split => null,
               in_qa_reject => null,
               in_qa_signed => 'AR',
               in_qa_comments => null,
               in_qa_user_id => 'AR134',
               in_comments => null);
end;
--select * from f_transmittal_details_Sv where qa_signed is null;
--FAIL
begin
tran_adjust_qa(in_tran_detail_id => -9,
               in_qa_abort => null,
               in_qa_split => null,
               in_qa_reject => null,
               in_qa_signed => 'AR',
               in_qa_comments => null,
               in_qa_user_id => 'AR134',
               in_comments => null);
end;

select * from corp_etl_error_log order by ceel_id desc;

select * from d_tran_detail where qa_date is not null order by qa_Date desc;
