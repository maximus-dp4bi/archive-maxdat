delete from cc_s_ivr_response
where application_name = 'MAXVAEB'
and call_date between  '01-DEC-18' and '05-DEC-18';

commit;