update cc_c_filter
set filter_type = 'ACD_CALL_TYPE_ID_IGNORE'
where value in ('5236', '5237', '5324')
and filter_type = 'ACD_CALL_TYPE_ID_INC';

commit;

