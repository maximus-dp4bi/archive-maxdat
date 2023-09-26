alter session set current_schema = cisco_enterprise_cc;

select * from cc_c_contact_queue
where upper(queue_type) = 'TRANSFER';

update cc_c_contact_queue
set queue_name = 'MIEL_MORS_9648_NOAGNT'
where queue_number = 7924;

update cc_c_contact_queue
set queue_name = 'MIEL_MORS_9648_RONA'
where queue_number = 7925;

update cc_c_contact_queue
set queue_name = 'MIEL_MORS_9648_SEQ1'
where queue_number = 7926;

update cc_c_contact_queue
set queue_type = 'Transfer'
where queue_number = 6846;

update cc_c_unit_of_work
set unit_of_work_category = 'TRANSFER'
where unit_of_work_name = 'MI Bridges Lead Queue - English';

update cc_c_unit_of_work
set ivr = 1, acd = 0
where unit_of_work_name in (
'MI Bridges Technical Queue - English',
'MI Bridges Spanish',
'MI Bridges Functional Queue - English',
'MI Bridges Arabic',
'MI MORS English');

update cc_d_unit_of_work
set unit_of_work_category = 'TRANSFER'
where unit_of_work_name = 'MI Bridges Lead Queue - English';

update cc_d_unit_of_work
set ivr = 1
where unit_of_work_name in (
'MI Bridges Technical Queue - English',
'MI Bridges Spanish',
'MI Bridges Functional Queue - English',
'MI Bridges Arabic',
'MI MORS English');

commit;