alter session set current_schema = cisco_enterprise_cc;

delete from cc_c_filter where value in ('5185','5186','5187') and filter_type = 'ACD_SKILL_GROUP_INC';
delete from cc_c_lookup where lookup_key in ('5185','5186','5187') and lookup_type in ('ACD_SKILLSET_PROJECT','ACD_SKILLSET_PROGRAM');

update cc_c_unit_of_work set unit_of_work_category = 'ESCALATION' where unit_of_work_name = 'SCEB - Escalation';
update cc_d_unit_of_work set unit_of_work_category = 'ESCALATION' where unit_of_work_name = 'SCEB - Escalation';

commit;

