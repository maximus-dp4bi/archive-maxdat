-- cc_a_list_lkup


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
					,'MI_Survey_project_lookup'
					,'Survey Project Name Lookup'
					,'MAXMIEB'
					,'MIEB'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Survey Project Name Lookup'
					,SYSDATE
					,SYSDATE);
					
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
					,'MI_Survey_project_lookup'
					,'Survey Project Name Lookup'
					,'MAXMICSCC'
					,'MI CSCC'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Survey Project Name Lookup'
					,SYSDATE
					,SYSDATE);	
					
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
					,'MI_Survey_project_lookup'
					,'Survey Project Name Lookup'
					,'MAXMIAPCC'
					,'MI APCC'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Survey Project Name Lookup'
					,SYSDATE
					,SYSDATE);
					
commit;


-- cc_c_survey_lkup

INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('MIEB', 'MIEB', 11, 'MIEB Satisfaction Survey - Enrolls');
INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('MIEB', 'MIEB', 13, 'MIEB Satisfaction Survey – Beneficiary Helpline');
INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('MIEB', 'MIEB', 14, 'MIEB Satisfaction Survey  - MIChild');
INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('MI CSCC', 'Multiple', 16, 'CSCC Satisfaction Survey');
INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('MI APCC', 'MI Provider Support', 17, 'APCC Satisfaction Survey');
INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('MIEB', 'Multiple - Provider Support Services', 18, 'PSS Satisfaction Survey');
INSERT INTO CC_C_SURVEY_LKUP (PROJECT_NAME, PROGRAM_NAME, SUB_PROGRAM_CODE, SUB_PROGRAM_NAME) VALUES ('MIEB', 'Multiple – MI Bridges', 19, 'MBSH Satisfaction Survey');

commit;

-- cc_c_question_type_lkup

INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 1, 'First Call Resolution');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 2, 'Promised Call Back');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 3, 'Referrals');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 4, 'Customer Satisfaction');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 5, 'Overall Service');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 6, 'Reason Dissatisfied');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 7, 'Net Promoter Score');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 8, 'Source of Number');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 9, 'Information Clear');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 10, 'CSR Polite');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 11, 'Wait Time');

COMMIT;

-- cc_c_question_answer_lkup

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (1, 'First Call Resolution', 'Did we answer your questions today?', 'Yes',1 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (1, 'First Call Resolution', 'Did we answer your questions today?', 'No',1 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (1, 'First Call Resolution', 'Did we answer your questions today?', 'Some',1 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (1, 'First Call Resolution', 'Did we answer your questions today?', 'No Response',1 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (1, 'First Call Resolution', 'Did we answer your questions today?', 'Invalid Response',1 ,5 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (2, 'Promised Call Back', 'Did the Customer Service Representative promise to call you back or have someone else call you back?', 'Yes',2 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (2, 'Promised Call Back', 'Did the Customer Service Representative promise to call you back or have someone else call you back?', 'No',2 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (2, 'Promised Call Back', 'Did the Customer Service Representative promise to call you back or have someone else call you back?', 'No Response',2 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (3, 'Referrals', 'Did the Customer Service Representative tell you to call another number to get answers to your questions?', 'Yes',3 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (3, 'Referrals', 'Did the Customer Service Representative tell you to call another number to get answers to your questions?', 'No',3 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Yes',4 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'No',4 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'No Response',4 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Invalid Response',4 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (5, 'Overall Service', 'How good was our overall service today?', 'Excellent',5 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (5, 'Overall Service', 'How good was our overall service today?', 'Good',5 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (5, 'Overall Service', 'How good was our overall service today?', 'Average',5 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (5, 'Overall Service', 'How good was our overall service today?', 'No Response',5 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (5, 'Overall Service', 'How good was our overall service today?', 'Invalid Response',5 ,5 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Questions Not Answered',6 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Unclear Information',6 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Long Wait',6 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Not Polite',6 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Other',6 ,5 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Repeat',6 ,6 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'No Response',6 ,7 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (7, 'Net Promoter Score', 'Would you call us again or tell a friend to call us with questions like the ones you had today?', 'Yes',7 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (7, 'Net Promoter Score', 'Would you call us again or tell a friend to call us with questions like the ones you had today?', 'No',7 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (7, 'Net Promoter Score', 'Would you call us again or tell a friend to call us with questions like the ones you had today?', 'No Response',7 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (7, 'Net Promoter Score', 'Would you call us again or tell a friend to call us with questions like the ones you had today?', 'Invalid Response',7 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Mail',8 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Online',8 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'TV or Radio',8 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Friend',8 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Other',8 ,5 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Repeat',8 ,6 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'No Response',8 ,7 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (8, 'Source of Number', 'Where did you find our number to call?', 'Invalid Response',8 ,8 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (9, 'Information Clear', 'Was the information we gave you clear and easy to understand?', 'Yes',9 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (9, 'Information Clear', 'Was the information we gave you clear and easy to understand?', 'No',9 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (9, 'Information Clear', 'Was the information we gave you clear and easy to understand?', 'No Response',9 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (9, 'Information Clear', 'Was the information we gave you clear and easy to understand?', 'Invalid Response',9 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (10, 'CSR Polite', 'Was the Customer Service Representative polite and respectful?', 'Yes',10 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (10, 'CSR Polite', 'Was the Customer Service Representative polite and respectful?', 'No',10 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (10, 'CSR Polite', 'Was the Customer Service Representative polite and respectful?', 'No Response',10 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (10, 'CSR Polite', 'Was the Customer Service Representative polite and respectful?', 'Invalid Response',10 ,4 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (11, 'Wait Time', 'Were you satisfied with how quickly someone answered your call and started to speak with you?', 'Yes',11 ,1 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (11, 'Wait Time', 'Were you satisfied with how quickly someone answered your call and started to speak with you?', 'No',11 ,2 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (11, 'Wait Time', 'Were you satisfied with how quickly someone answered your call and started to speak with you?', 'No Response',11 ,3 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (11, 'Wait Time', 'Were you satisfied with how quickly someone answered your call and started to speak with you?', 'Invalid Response',11 ,4 );

COMMIT;