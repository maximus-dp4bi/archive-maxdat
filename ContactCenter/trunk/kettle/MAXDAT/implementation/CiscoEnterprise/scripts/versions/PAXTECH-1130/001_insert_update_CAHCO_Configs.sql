alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q9','SURVEY',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q10','SURVEY',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q9','SURVEY',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q10','SURVEY',1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q9', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8834;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q9', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8835;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q9', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8836;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q9', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8837;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q9', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8838;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q9', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8839;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q10', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8840;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q10', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8841;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q10', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8842;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q10', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8843;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q10', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8844;
update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q10', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_percent = 0, service_seconds = 20, interval_minutes = 15 where queue_number = 8845;

commit;


-- ivr survey

INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q9', 'The Preventive Care information that I received from Health Care Options was', '8834', '5', 'Very Helpful', '8839');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q9', 'The Preventive Care information that I received from Health Care Options was', '8834', '4', 'Helpful', '8838');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q9', 'The Preventive Care information that I received from Health Care Options was', '8834', '3', 'Informative but I needed assistance', '8837');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q9', 'The Preventive Care information that I received from Health Care Options was', '8834', '2', 'Somewhat confusing', '8836');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q9', 'The Preventive Care information that I received from Health Care Options was', '8834', '1', 'Very confusing', '8835');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q10', 'Overall I find the Preventive Care services provided by my health plan', '8840', '5', 'Excellent', '8845');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q10', 'Overall I find the Preventive Care services provided by my health plan', '8840', '4', 'Good', '8844');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q10', 'Overall I find the Preventive Care services provided by my health plan', '8840', '3', 'Fair', '8843');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q10', 'Overall I find the Preventive Care services provided by my health plan', '8840', '2', 'Very Poor', '8842');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q10', 'Overall I find the Preventive Care services provided by my health plan', '8840', '1', 'Poor', '8841');

commit;

					