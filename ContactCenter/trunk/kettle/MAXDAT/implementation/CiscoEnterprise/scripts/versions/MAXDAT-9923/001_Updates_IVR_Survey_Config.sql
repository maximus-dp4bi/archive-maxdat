alter session set current_schema = cisco_enterprise_cc;

delete from cc_c_ivr_survey
where answer_queue_number in (7895, 7901, 7907, 7913, 7896, 7902, 7908, 7914, 7897, 7903, 7909, 7915, 7898, 7904, 7910, 7916, 7899, 7905, 7911, 7917);


INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q1', 'I am satisfied with my overall experience today', '7894', '5', 'Agree', '7899');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q1', 'I am satisfied with my overall experience today', '7894', '4', 'Somewhat Agree', '7898');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q1', 'I am satisfied with my overall experience today', '7894', '3', 'Neither Agree or Disagree', '7897');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q1', 'I am satisfied with my overall experience today', '7894', '2', 'Somewhat Disagree', '7896');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q1', 'I am satisfied with my overall experience today', '7894', '1', 'Disagree', '7895');

INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q2', 'The information I received was easy to understand', '7900', '5', 'Agree', '7905');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q2', 'The information I received was easy to understand', '7900', '4', 'Somewhat Agree', '7904');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q2', 'The information I received was easy to understand', '7900', '3', 'Neither Agree or Disagree', '7903');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q2', 'The information I received was easy to understand', '7900', '2', 'Somewhat Disagree', '7902');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q2', 'The information I received was easy to understand', '7900', '1', 'Disagree', '7901');

INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q3', 'The information I received was helpful in making my enrollment decision', '7906', '5', 'Agree', '7911');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q3', 'The information I received was helpful in making my enrollment decision', '7906', '4', 'Somewhat Agree', '7910');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q3', 'The information I received was helpful in making my enrollment decision', '7906', '3', 'Neither Agree or Disagree', '7909');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q3', 'The information I received was helpful in making my enrollment decision', '7906', '2', 'Somewhat Disagree', '7908');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q3', 'The information I received was helpful in making my enrollment decision', '7906', '1', 'Disagree', '7907');

INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q4', 'The Customer Service Representative was helpful and polite', '7912', '5', 'Agree', '7917');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q4', 'The Customer Service Representative was helpful and polite', '7912', '4', 'Somewhat Agree', '7916');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q4', 'The Customer Service Representative was helpful and polite', '7912', '3', 'Neither Agree or Disagree', '7915');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q4', 'The Customer Service Representative was helpful and polite', '7912', '2', 'Somewhat Disagree', '7914');
INSERT INTO CC_C_IVR_SURVEY (QUESTION_NUMBER, QUESTION, QUESTION_QUEUE_NUMBER, ANSWER_KEY, ANSWER_TEXT, ANSWER_QUEUE_NUMBER) VALUES ('Q4', 'The Customer Service Representative was helpful and polite', '7912', '1', 'Disagree', '7913');

commit;