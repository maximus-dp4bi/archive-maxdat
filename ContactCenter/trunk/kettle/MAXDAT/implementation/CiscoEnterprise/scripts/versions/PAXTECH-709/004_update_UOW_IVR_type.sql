alter session set current_schema = cisco_enterprise_cc;

update cc_c_unit_of_work
set acd = 0, ivr = 1
where unit_of_work_name in
(
'Consumer English'
,'Consumer Spanish'
,'Consumer Other'
,'BNA Consumer Assistance'
,'BNA Technical Assistance'
);

update cc_d_unit_of_work
set acd = 0, ivr = 1
where unit_of_work_name in
(
'Consumer English'
,'Consumer Spanish'
,'Consumer Other'
,'BNA Consumer Assistance'
,'BNA Technical Assistance'
);

commit;