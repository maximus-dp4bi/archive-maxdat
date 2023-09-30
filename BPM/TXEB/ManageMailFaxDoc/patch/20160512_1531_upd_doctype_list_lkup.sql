update corp_etl_list_lkup
set out_var = 'NorthSTAR Enrollment Data Entry'
where cell_id = 56;

update corp_etl_list_lkup
set out_var = 'Complaint Data Entry Task'
where cell_id = 1328;

UPDATE corp_etl_list_lkup l
SET ref_id = (select step_definition_id from step_definition_stg s where s.name = l.out_var) 
WHERE name  = 'ProcessMail_work_expected' 
AND list_type LIKE 'DOC_TYPE%'
and out_var not in ('Enrollment Data Entry Task','CHIP Enrollment MI','Complaint Data Entry Task')
and ref_id is null;

UPDATE corp_etl_list_lkup
SET ref_id = 32304
WHERE out_var = 'CHIP Enrollment MI'
and ref_id is null;

UPDATE corp_etl_list_lkup
SET ref_id = 1101
WHERE out_var = 'Complaint Data Entry Task'
and ref_id is null;

commit;