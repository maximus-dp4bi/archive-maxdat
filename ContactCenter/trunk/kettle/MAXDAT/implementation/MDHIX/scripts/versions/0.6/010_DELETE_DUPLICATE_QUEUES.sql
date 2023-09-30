update cc_c_filter
set filter_type = 'ACD_CALL_TYPE_ID_INC'
where filter_type = 'ACD_CALL_TYPE_ID_IGNORE'
and value in (5236 ,5237);

commit;

delete from cc_c_contact_queue where queue_number in (5236 ,5237);

delete from cc_s_contact_queue where queue_number in (5236 ,5237);

delete from cc_d_contact_queue where queue_number in (5236 ,5237);

commit;