alter session set current_schema = cisco_enterprise_cc;

-- cc_c_question_type_lkup

INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 13, 'Call Resolution');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 14, 'Commit Call Back');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 15, 'Same Issue');
INSERT INTO CC_C_QUESTION_TYPE_LKUP (QUESTION_TYPE_ID, QUESTION_TYPE) VALUES ( 16, 'Dissatisfied Reason');


COMMIT;

-- cc_c_question_answer_lkup

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Completely Satisfied',4 ,6 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Mostly Satisfied',4 ,7 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Neutral',4 ,8 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Mostly Dissatisfied',4 ,9 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Completely Dissatisfied',4 ,10 );

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (13, 'Call Resolution', 'Did we fully answer your question and address any issues you had today?', 'Yes', 13, 1);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (13, 'Call Resolution', 'Did we fully answer your question and address any issues you had today?', 'Some', 13, 2);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (13, 'Call Resolution', 'Did we fully answer your question and address any issues you had today?', 'No', 13, 3);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (13, 'Call Resolution', 'Did we fully answer your question and address any issues you had today?', 'No Response', 13, 4);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (13, 'Call Resolution', 'Did we fully answer your question and address any issues you had today?', 'Invalid Response', 13, 5);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (13, 'Call Resolution', 'Did we fully answer your question and address any issues you had today?', 'Repeat', 13, 6);

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (14, 'Commit Call Back', 'Did the Customer Service Representative commit to calling you back or have someone else call you back?', 'Yes', 14, 1);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (14, 'Commit Call Back', 'Did the Customer Service Representative commit to calling you back or have someone else call you back?', 'No', 14, 2);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (14, 'Commit Call Back', 'Did the Customer Service Representative commit to calling you back or have someone else call you back?', 'No Response', 14, 3);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (14, 'Commit Call Back', 'Did the Customer Service Representative commit to calling you back or have someone else call you back?', 'Invalid Response', 14, 4);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (14, 'Commit Call Back', 'Did the Customer Service Representative commit to calling you back or have someone else call you back?', 'Repeat', 14, 5);

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (15, 'Same Issue', 'For any questions or issues you called about today, have you already talked to a Customer Service Representative about the same question or issue in the last week?', 'Yes', 15, 1);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (15, 'Same Issue', 'For any questions or issues you called about today, have you already talked to a Customer Service Representative about the same question or issue in the last week?', 'No', 15, 2);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (15, 'Same Issue', 'For any questions or issues you called about today, have you already talked to a Customer Service Representative about the same question or issue in the last week?', 'No Response', 15, 3);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (15, 'Same Issue', 'For any questions or issues you called about today, have you already talked to a Customer Service Representative about the same question or issue in the last week?', 'Invalid Response', 15, 4);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (15, 'Same Issue', 'For any questions or issues you called about today, have you already talked to a Customer Service Representative about the same question or issue in the last week?', 'Repeat', 15, 5);

--INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (6, 'Reason Dissatisfied', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Multiple Reasons', 6, 9);

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Questions Not Answered', 16, 1);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Unclear Information', 16, 2);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Long Wait', 16, 3);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Not Polite', 16, 4);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Multiple Reasons', 16, 5);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Other', 16, 6);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Repeat', 16, 7);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'No Response', 16, 8);
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (16, 'Dissatisfied Reason', 'We''re sorry you were not satisfied with our service. Please tell us why', 'Invalid Response', 16, 9);

COMMIT;