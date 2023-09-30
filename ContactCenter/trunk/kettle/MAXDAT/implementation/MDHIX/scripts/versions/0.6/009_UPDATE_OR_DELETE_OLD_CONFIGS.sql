
delete from cc_c_filter
where filter_type = 'ACD_SKILL_GROUP_INC'
and value != '5000' 

delete from cc_c_lookup
where lookup_type = 'ACD_SKILLSET_PROGRAM'
and lookup_key != '5000' 


delete from cc_c_lookup
where lookup_type = 'ACD_SKILLSET_PROJECT'
and lookup_key != '5000' 

commit;