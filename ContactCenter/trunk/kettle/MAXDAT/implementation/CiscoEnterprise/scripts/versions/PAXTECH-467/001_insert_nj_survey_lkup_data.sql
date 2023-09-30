alter session set current_schema = cisco_enterprise_cc;

--Project and Program

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('New Jersey State Based Exchange', 'Get Covered New Jersey', 'Eastern', 'New Jersey', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'New Jersey State Based Exchange', 2, 1 );

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'New Jersey State Based Exchange'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Get Covered New Jersey', 1 );

insert into cc_d_state (state_name) values ('New Jersey');

insert into cc_d_geography_master (geography_master_id, geography_name, country_id, state_id, province_id, district_id, region_id)
values (SEQ_CC_D_GEOGRAPHY_MASTER.nextval, 'New Jersey', (select country_id from cc_d_country where country_name = 'USA'), (select state_id from cc_d_state where state_name = 'New Jersey'), 0, 0, (select region_id from cc_d_region where region_name = 'Eastern'));

commit;

--cc_c_list_lkup

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'NJ_Survey_project_lookup'
					,'Survey Project Name Lookup'
					,'MAXNJSBE'
					,'New Jersey State Based Exchange'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Survey Project Name Lookup'
					,SYSDATE
					,SYSDATE);
					
-- cc_c_survey_lkup

INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('New Jersey State Based Exchange', 'Get Covered New Jersey', 80, 'NJSBE Satisfaction Survey');

commit;

-- cc_c_question_type_lkup

INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 12, 'Reason for Call');

COMMIT;

-- cc_c_question_answer_lkup

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (1, 'First Call Resolution', 'Did we answer your questions today?', 'Repeat',1 ,6 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (2, 'Promised Call Back', 'Did the Customer Service Representative promise to call you back or have someone else call you back?', 'Repeat',2 ,5 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (3, 'Referrals', 'Did the Customer Service Representative tell you to call another number to get answers to your questions?', 'Repeat',3 ,5 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Repeat',4 ,5 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (5, 'Overall Service', 'How good was our overall service today?', 'Repeat',5 ,6);

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (7, 'Net Promoter Score', 'Would you call us again or tell a friend to call us with questions like the ones you had today?', 'Repeat',7 ,5 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Plan',8 ,9 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Provider',8 ,10 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Broker',8 ,11 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (9, 'Information Clear', 'Was the information we gave you clear and easy to understand?', 'Repeat',9 ,5 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (10, 'CSR Polite', 'Was the Customer Service Representative polite and respectful?', 'Repeat',10 ,5 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (11, 'Wait Time', 'Were you satisfied with how quickly someone answered your call and started to speak with you?', 'Repeat',11 ,5 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'Plan Change',12 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'Received Letter',12 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'Web Question',12 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'General Question',12 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'Referred',12 ,5 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'No Response',12 ,6 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'Invalid Response',12 ,7 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (12, 'Reason for Call', 'What was the reason for your call today?', 'Repeat',12 ,8 );


COMMIT;