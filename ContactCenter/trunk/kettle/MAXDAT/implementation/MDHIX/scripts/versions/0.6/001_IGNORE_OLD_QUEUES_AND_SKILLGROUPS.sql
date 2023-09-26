update cc_c_filter
set filter_type = 'ACD_CALL_TYPE_ID_IGNORE'
where filter_type = 'ACD_CALL_TYPE_ID_INC'
and value != '5000';

update cc_c_filter
set filter_type = 'ACD_SKILL_GROUP_IGNORE'
where filter_type = 'ACD_SKILL_GROUP_INC'
and value != '5000';


update cc_c_lookup
set lookup_type = 'ACD_SKILLSET_PROGRAM_IGNORE'
where lookup_type = 'ACD_SKILLSET_PROGRAM'
and lookup_key != '5000';

update cc_c_lookup
set lookup_type = 'ACD_SKILLSET_PROJECT_IGNORE'
where lookup_type = 'ACD_SKILLSET_PROJECT'
and lookup_key != '5000';


commit;