-- delete call types from ignore list

delete from cc_c_filter
where filter_type = 'ACD_CALL_TYPE_ID_IGNORE';

commit;