-- NY projects
insert into d_project (d_project_id, project_name, d_division_id, create_date, last_modified_date)
values (9, 'NY FPBP', 4, sysdate, sysdate);

insert into d_project (d_project_id, project_name, d_division_id, create_date, last_modified_date)
values (10, 'NY EC', 4, sysdate, sysdate);

-- NY programs
insert into d_program (d_program_id, program_name, create_date, last_modified_date)
values (7, 'SWCC', sysdate, sysdate);

insert into d_program (d_program_id, program_name, create_date, last_modified_date)
values (8, 'EC', sysdate, sysdate);

insert into d_program (d_program_id, program_name, create_date, last_modified_date)
values (9, 'FPBP', sysdate, sysdate);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.8','006','006_INSERT_NY_PROGRAMS_PROJECTS');

COMMIT;