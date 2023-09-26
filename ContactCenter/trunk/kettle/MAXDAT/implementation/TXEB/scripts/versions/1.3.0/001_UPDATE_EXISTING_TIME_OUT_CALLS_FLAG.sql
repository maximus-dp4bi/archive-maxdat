update cc_s_call_detail
set time_out_call=1
where dnis is not null
and call_date<'18-SEP-14';

commit;
