alter session set current_schema = cisco_enterprise_cc;

INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Completely Satisfied',4 ,6 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Mostly Satisfied',4 ,7 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Neutral',4 ,8 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Mostly Dissatisfied',4 ,9 );
INSERT INTO CC_C_QUESTION_ANSWER_LKUP(QUESTION_TYPE_ID, QUESTION_TYPE, QUESTION_REPORT_LABEL, ANSWER_REPORT_LABEL, QUESTION_ORDER, ANSWER_ORDER) VALUES (4, 'Customer Satisfaction', 'Were you satisfied with our overall service today?', 'Completely Dissatisfied',4 ,10 );

COMMIT;