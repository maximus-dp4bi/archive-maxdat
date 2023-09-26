--TNERPS-1437 - Adding skill group

alter session set current_schema = folsom_shared_cc;

insert into cc_c_filter (filter_type, value)
values ('ACD_SKILL_GROUP_INC','10000');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value)
values ('ACD_SKILLSET_PROJECT','10000','MassHealth');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value)
values ('ACD_SKILLSET_PROGRAM','10000','MassHealth');

commit;