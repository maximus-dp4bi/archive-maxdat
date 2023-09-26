insert into TS_SCORE_TYPE_LKUP(score_type_id,score_type_desc) values(0, '-------');
insert into TS_SCORE_TYPE_LKUP(score_type_id,score_type_desc) values(1, 'Greeting / Call Flow / Closing');
insert into TS_SCORE_TYPE_LKUP(score_type_id,score_type_desc) values(2, 'HIPAA COMPLIANCE / Verification of Caller Identity');
insert into TS_SCORE_TYPE_LKUP(score_type_id,score_type_desc) values(3, 'Accuracy of Information');
insert into TS_SCORE_TYPE_LKUP(score_type_id,score_type_desc) values(4, 'Customer Service Skills');
insert into TS_SCORE_TYPE_LKUP(score_type_id,score_type_desc) values(5, 'Documentation / Data Entered Correctly');

update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 5,
	score_type_id = 1
where
	qa_question_id = 1;

update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 0,
	score_type_id = 2
where
	qa_question_id = 2;

update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 0,
	score_type_id = 0,
	qa_question_end_date = sysdate	
where
	qa_question_id = 3;	
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 30,
	score_type_id = 3
where
	qa_question_id = 4;

update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 30,
	score_type_id = 4
where
	qa_question_id = 5;
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 15,
	score_type_id = 4
where
	qa_question_id = 6;
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 20,
	score_type_id = 4
where
	qa_question_id = 7;
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 20,
	score_type_id = 5
where
	qa_question_id = 8;
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 0,
	score_type_id = 0
where
	qa_question_id = 9;
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 0,
	score_type_id = 0
where
	qa_question_id = 10;
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 0,
	score_type_id = 0
where
	qa_question_id = 11;
	
update 
	TS_QA_QUESTION 
set 
	qa_question_max_score = 0,
	score_type_id = 0
where
	qa_question_id = 12;
	
update 
	TS_QA_QUESTION 
set 	
	score_type_id = 0
where
	qa_question_id > 12;


commit;