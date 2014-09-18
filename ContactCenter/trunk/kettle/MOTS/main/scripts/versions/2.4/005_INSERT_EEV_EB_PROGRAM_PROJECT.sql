-- EEV program/project
insert into d_program (d_program_id, program_name, create_date, last_modified_date)
values (5, 'EEV', to_date('2014/05/06', 'yyyy/mm/dd'), to_date('2014/05/06', 'yyyy/mm/dd'));

insert into d_project (d_project_id, project_name, d_division_id, create_date, last_modified_date)
values (10, 'IL EEV', 2, to_date('2014/05/20', 'yyyy/mm/dd'), to_date('2014/05/20', 'yyyy/mm/dd'));

-- EB project
insert into d_project (d_project_id, project_name, d_division_id, create_date, last_modified_date)
values (11, 'IL EB', 2, to_date('2014/05/20', 'yyyy/mm/dd'), to_date('2014/05/20', 'yyyy/mm/dd'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.4','005','005_INSERT_EEV_EB_PROGRAM_PROJECT');

COMMIT;