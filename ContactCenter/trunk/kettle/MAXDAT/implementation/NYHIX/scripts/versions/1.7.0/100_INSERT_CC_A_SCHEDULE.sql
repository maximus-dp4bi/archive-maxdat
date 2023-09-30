
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '00:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '01:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '02:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '03:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '04:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '05:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '06:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '08:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '09:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '10:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '11:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '12:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '14:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '15:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '16:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '17:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '18:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '19:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '20:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '21:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '22:00:00');
insert into cc_a_schedule (job_type, execution_time) values ('load_production_planning', '23:00:00');



INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.7.0',100,'100_INSERT_CC_A_SCHEDULE');

COMMIT;