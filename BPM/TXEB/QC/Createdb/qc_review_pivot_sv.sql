--alter session set current_schema=maxdat
Create or replace view qc_review_pivot_sv as
select /*+ parallel(10) */
qc.*
, q1.group_text qsection_1
, q1.question_number Qnumber_1
, q1.question_text qtext_1
, qa1.survey_answer_text qanswer_1
, qa1.survey_answer_score qscore_1
, qa1.survey_response_created_by response_created_by_1
, qa1.response_created_by_name response_created_by_name_1
, qa1.response_updated_by_name response_updated_by_name_1
, qa1.survey_response_create_ts response_created_date_1
, qa1.survey_answer_Comments response_comments_1
, q2.group_text qsection_2
, q2.question_number Qnumber_2
, q2.question_text qtext_2
, qa2.survey_answer_text qanswer_2
, qa2.survey_answer_score qscore_2
, qa2.survey_response_created_by response_created_by_2
, qa2.response_created_by_name response_created_by_name_2
, qa2.response_updated_by_name response_updated_by_name_2
, qa2.survey_response_create_ts response_created_date_2
, qa2.survey_answer_Comments response_comments_2
, q3.group_text qsection_3
, q3.question_number Qnumber_3
, q3.question_text qtext_3
, qa3.survey_answer_text qanswer_3
, qa3.survey_answer_score qscore_3
, qa3.survey_response_created_by response_created_by_3
, qa3.response_created_by_name response_created_by_name_3
, qa3.response_updated_by_name response_updated_by_name_3
, qa3.survey_response_create_ts response_created_date_3
, qa3.survey_answer_Comments response_comments_3
, q4.group_text qsection_4
, q4.question_number Qnumber_4
, q4.question_text qtext_4
, qa4.survey_answer_text qanswer_4
, qa4.survey_answer_score qscore_4
, qa4.survey_response_created_by response_created_by_4
, qa4.response_created_by_name response_created_by_name_4
, qa4.response_updated_by_name response_updated_by_name_4
, qa4.survey_response_create_ts response_created_date_4
, qa4.survey_answer_Comments response_comments_4
, q5.group_text qsection_5
, q5.question_number Qnumber_5
, q5.question_text qtext_5
, qa5.survey_answer_text qanswer_5
, qa5.survey_answer_score qscore_5
, qa5.survey_response_created_by response_created_by_5
, qa5.response_created_by_name response_created_by_name_5
, qa5.response_updated_by_name response_updated_by_name_5
, qa5.survey_response_create_ts response_created_date_5
, qa5.survey_answer_Comments response_comments_5
, q6.group_text qsection_6
, q6.question_number Qnumber_6
, q6.question_text qtext_6
, qa6.survey_answer_text qanswer_6
, qa6.survey_answer_score qscore_6
, qa6.survey_response_created_by response_created_by_6
, qa6.response_created_by_name response_created_by_name_6
, qa6.response_updated_by_name response_updated_by_name_6
, qa6.survey_response_create_ts response_created_date_6
, qa6.survey_answer_Comments response_comments_6
, q7.group_text qsection_7
, q7.question_number Qnumber_7
, q7.question_text qtext_7
, qa7.survey_answer_text qanswer_7
, qa7.survey_answer_score qscore_7
, qa7.survey_response_created_by response_created_by_7
, qa7.response_created_by_name response_created_by_name_7
, qa7.response_updated_by_name response_updated_by_name_7
, qa7.survey_response_create_ts response_created_date_7
, qa7.survey_answer_Comments response_comments_7
, q8.group_text qsection_8
, q8.question_number Qnumber_8
, q8.question_text qtext_8
, qa8.survey_answer_text qanswer_8
, qa8.survey_answer_score qscore_8
, qa8.survey_response_created_by response_created_by_8
, qa8.response_created_by_name response_created_by_name_8
, qa8.response_updated_by_name response_updated_by_name_8
, qa8.survey_response_create_ts response_created_date_8
, qa8.survey_answer_Comments response_comments_8
, q9.group_text qsection_9
, q9.question_number Qnumber_9
, q9.question_text qtext_9
, qa9.survey_answer_text qanswer_9
, qa9.survey_answer_score qscore_9
, qa9.survey_response_created_by response_created_by_9
, qa9.response_created_by_name response_created_by_name_9
, qa9.response_updated_by_name response_updated_by_name_9
, qa9.survey_response_create_ts response_created_date_9
, qa9.survey_answer_Comments response_comments_9
, q10.group_text qsection_10
, q10.question_number Qnumber_10
, q10.question_text qtext_10
, qa10.survey_answer_text qanswer_10
, qa10.survey_answer_score qscore_10
, qa10.survey_response_created_by response_created_by_10
, qa10.response_created_by_name response_created_by_name_10
, qa10.response_updated_by_name response_updated_by_name_10
, qa10.survey_response_create_ts response_created_date_10
, qa10.survey_answer_Comments response_comments_10
, q11.group_text qsection_11
, q11.question_number Qnumber_11
, q11.question_text qtext_11
, qa11.survey_answer_text qanswer_11
, qa11.survey_answer_score qscore_11
, qa11.survey_response_created_by response_created_by_11
, qa11.response_created_by_name response_created_by_name_11
, qa11.response_updated_by_name response_updated_by_name_11
, qa11.survey_response_create_ts response_created_date_11
, qa11.survey_answer_Comments response_comments_11
, q12.group_text qsection_12
, q12.question_number Qnumber_12
, q12.question_text qtext_12
, qa12.survey_answer_text qanswer_12
, qa12.survey_answer_score qscore_12
, qa12.survey_response_created_by response_created_by_12
, qa12.response_created_by_name response_created_by_name_12
, qa12.response_updated_by_name response_updated_by_name_12
, qa12.survey_response_create_ts response_created_date_12
, qa12.survey_answer_Comments response_comments_12
, q13.group_text qsection_13
, q13.question_number Qnumber_13
, q13.question_text qtext_13
, qa13.survey_answer_text qanswer_13
, qa13.survey_answer_score qscore_13
, qa13.survey_response_created_by response_created_by_13
, qa13.response_created_by_name response_created_by_name_13
, qa13.response_updated_by_name response_updated_by_name_13
, qa13.survey_response_create_ts response_created_date_13
, qa13.survey_answer_Comments response_comments_13
, q14.group_text qsection_14
, q14.question_number Qnumber_14
, q14.question_text qtext_14
, qa14.survey_answer_text qanswer_14
, qa14.survey_answer_score qscore_14
, qa14.survey_response_created_by response_created_by_14
, qa14.response_created_by_name response_created_by_name_14
, qa14.response_updated_by_name response_updated_by_name_14
, qa14.survey_response_create_ts response_created_date_14
, qa14.survey_answer_Comments response_comments_14
, q15.group_text qsection_15
, q15.question_number Qnumber_15
, q15.question_text qtext_15
, qa15.survey_answer_text qanswer_15
, qa15.survey_answer_score qscore_15
, qa15.survey_response_created_by response_created_by_15
, qa15.response_created_by_name response_created_by_name_15
, qa15.response_updated_by_name response_updated_by_name_15
, qa15.survey_response_create_ts response_created_date_15
, qa15.survey_answer_Comments response_comments_15
, q16.group_text qsection_16
, q16.question_number Qnumber_16
, q16.question_text qtext_16
, qa16.survey_answer_text qanswer_16
, qa16.survey_answer_score qscore_16
, qa16.survey_response_created_by response_created_by_16
, qa16.response_created_by_name response_created_by_name_16
, qa16.response_updated_by_name response_updated_by_name_16
, qa16.survey_response_create_ts response_created_date_16
, qa16.survey_answer_Comments response_comments_16
, q17.group_text qsection_17
, q17.question_number Qnumber_17
, q17.question_text qtext_17
, qa17.survey_answer_text qanswer_17
, qa17.survey_answer_score qscore_17
, qa17.survey_response_created_by response_created_by_17
, qa17.response_created_by_name response_created_by_name_17
, qa17.response_updated_by_name response_updated_by_name_17
, qa17.survey_response_create_ts response_created_date_17
, qa17.survey_answer_Comments response_comments_17
, q18.group_text qsection_18
, q18.question_number Qnumber_18
, q18.question_text qtext_18
, qa18.survey_answer_text qanswer_18
, qa18.survey_answer_score qscore_18
, qa18.survey_response_created_by response_created_by_18
, qa18.response_created_by_name response_created_by_name_18
, qa18.response_updated_by_name response_updated_by_name_18
, qa18.survey_response_create_ts response_created_date_18
, qa18.survey_answer_Comments response_comments_18
, q19.group_text qsection_19
, q19.question_number Qnumber_19
, q19.question_text qtext_19
, qa19.survey_answer_text qanswer_19
, qa19.survey_answer_score qscore_19
, qa19.survey_response_created_by response_created_by_19
, qa19.response_created_by_name response_created_by_name_19
, qa19.response_updated_by_name response_updated_by_name_19
, qa19.survey_response_create_ts response_created_date_19
, qa19.survey_answer_Comments response_comments_19
, q20.group_text qsection_20
, q20.question_number Qnumber_20
, q20.question_text qtext_20
, qa20.survey_answer_text qanswer_20
, qa20.survey_answer_score qscore_20
, qa20.survey_response_created_by response_created_by_20
, qa20.response_created_by_name response_created_by_name_20
, qa20.response_updated_by_name response_updated_by_name_20
, qa20.survey_response_create_ts response_created_date_20
, qa20.survey_answer_Comments response_comments_20
, qs1.group_text Section1_group_text
, qs1.SURVEY_TEMPLATE_GROUP_ID s1_survey_template_group_id
, qs1.survey_score Section1_score
, qs2.group_text Section2_group_text
, qs2.SURVEY_TEMPLATE_GROUP_ID s2_survey_template_group_id
, qs2.survey_score Section2_score
, qs3.group_text Section3_group_text
, qs3.SURVEY_TEMPLATE_GROUP_ID s3_survey_template_group_id
, qs3.survey_score Section3_score
, null Overall_score
from qc_reviews_sv qc
left join qc_questions_sv q1 on trim(q1.question_number) = '1' and q1.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa1 on qa1.survey_id = qc.survey_id and qa1.survey_template_question_id = q1.survey_template_question_id
left join qc_questions_sv q2 on trim(q2.question_number) = '2' and q2.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa2 on qa2.survey_id = qc.survey_id and qa2.survey_template_question_id = q2.survey_template_question_id
left join qc_questions_sv q3 on trim(q3.question_number) = '3' and q3.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa3 on qa3.survey_id = qc.survey_id and qa3.survey_template_question_id = q3.survey_template_question_id
left join qc_questions_sv q4 on trim(q4.question_number) = '4' and q4.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa4 on qa4.survey_id = qc.survey_id and qa4.survey_template_question_id = q4.survey_template_question_id
left join qc_questions_sv q5 on trim(q5.question_number) = '5' and q5.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa5 on qa5.survey_id = qc.survey_id and qa5.survey_template_question_id = q5.survey_template_question_id
left join qc_questions_sv q6 on trim(q6.question_number) = '6' and q6.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa6 on qa6.survey_id = qc.survey_id and qa6.survey_template_question_id = q6.survey_template_question_id
left join qc_questions_sv q7 on trim(q7.question_number) = '7' and q7.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa7 on qa7.survey_id = qc.survey_id and qa7.survey_template_question_id = q7.survey_template_question_id
left join qc_questions_sv q8 on trim(q8.question_number) = '8' and q8.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa8 on qa8.survey_id = qc.survey_id and qa8.survey_template_question_id = q8.survey_template_question_id
left join qc_questions_sv q9 on trim(q9.question_number) = '9' and q9.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa9 on qa9.survey_id = qc.survey_id and qa9.survey_template_question_id = q9.survey_template_question_id
left join qc_questions_sv q10 on trim(q10.question_number) = '10' and q10.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa10 on qa10.survey_id = qc.survey_id and qa10.survey_template_question_id = q10.survey_template_question_id
left join qc_questions_sv q11 on trim(q11.question_number) = '11' and q11.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa11 on qa11.survey_id = qc.survey_id and qa11.survey_template_question_id = q11.survey_template_question_id
left join qc_questions_sv q12 on trim(q12.question_number) = '12' and q12.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa12 on qa12.survey_id = qc.survey_id and qa12.survey_template_question_id = q12.survey_template_question_id
left join qc_questions_sv q13 on trim(q13.question_number) = '13' and q13.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa13 on qa13.survey_id = qc.survey_id and qa13.survey_template_question_id = q13.survey_template_question_id
left join qc_questions_sv q14 on trim(q14.question_number) = '14' and q14.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa14 on qa14.survey_id = qc.survey_id and qa14.survey_template_question_id = q14.survey_template_question_id
left join qc_questions_sv q15 on trim(q15.question_number) = '15' and q15.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa15 on qa15.survey_id = qc.survey_id and qa15.survey_template_question_id = q15.survey_template_question_id
left join qc_questions_sv q16 on trim(q16.question_number) = '16' and q16.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa16 on qa16.survey_id = qc.survey_id and qa16.survey_template_question_id = q16.survey_template_question_id
left join qc_questions_sv q17 on trim(q17.question_number) = '17' and q17.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa17 on qa17.survey_id = qc.survey_id and qa17.survey_template_question_id = q17.survey_template_question_id
left join qc_questions_sv q18 on trim(q18.question_number) = '18' and q18.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa18 on qa18.survey_id = qc.survey_id and qa18.survey_template_question_id = q18.survey_template_question_id
left join qc_questions_sv q19 on trim(q19.question_number) = '19' and q19.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa19 on qa19.survey_id = qc.survey_id and qa19.survey_template_question_id = q19.survey_template_question_id
left join qc_questions_sv q20 on trim(q20.question_number) = '20' and q20.survey_template_id = qc.survey_template_id
left join qc_answers_sv qa20 on qa20.survey_id = qc.survey_id and qa20.survey_template_question_id = q20.survey_template_question_id
left join qc_scores_sv qs1 on (qs1.survey_id = qc.survey_id and qs1.sort_order = 0)
left join qc_scores_sv qs2 on (qs2.survey_id = qc.survey_id and qs2.sort_order = 1)
left join qc_scores_sv qs3 on (qs3.survey_id = qc.survey_id and qs3.sort_order = 2);

grant select on qc_review_pivot_sv to maxdat_read_only;
grant select on qc_review_pivot_sv to maxdat_reports;
