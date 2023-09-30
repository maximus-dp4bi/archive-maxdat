CREATE OR REPLACE VIEW MAXDAT.QC_REVIEW_PIVOT_SV
AS select
qc."SURVEY_HEADER_INFO_ID",qc."SURVEY_ID",qc."SUPERVISOR_ID",qc."CISCO_AGENT_ID",qc."CLIENT_PROGRAM",qc."CALL_TYPE",qc."CALL_DURATION",qc."CALIBRATION",qc."BRIEF_CALL_SUMMARY",qc."ERROR_COMMENT",qc."SUPPORTING_DOCUMENTATION",qc."CHALLENGE_TYPE",qc."SUP_FIRST_NAME",qc."SUP_LAST_NAME",qc."SUP_MIDDLE_NAME",qc."SUP_DISPLAY_NAME",qc."AGENT_ID",qc."EXT_STAFF_NUMBER",qc."AG_FIRST_NAME",qc."AG_LAST_NAME",qc."AG_MIDDLE_NAME",qc."AG_DISPLAY_NAME",qc."AG_TITLE",qc."QCST_DISPLAY_NAME",qc."UPDATED_BY_DISPLAY_NAME",qc."REVIEW_DATE",qc."REVIEW_WEEK_DT",qc."CREATED_BY",qc."CREATE_TS",qc."UPDATED_BY",qc."UPDATE_TS",qc."ID_NUM",qc."DATE_OF_CALL",qc."DATE_OF_CALL_WEEK_DT",qc."CLIENT_ID",qc."CASE_ID",qc."SURVEY_COMMENTS",qc."SURVEY_STATUS_CD",qc."SURVEY_TEMPLATE_ID",qc."SURVEY_LANGUAGE_CD",qc."TITLE",qc."SURVEY_TEMPLATE_CATEGORY_CD",qc."CALL_DURATION_HHMISS",qc."TRACKING_DATE",qc."REVIEWER_SUPERVISOR_ID",qc."REVIEWER_SUPERVISOR_NAME",qc."DATE_OF_CALL_WEEK_START",qc."DATE_OF_CALL_WEEK_END",qc."REVIEW_WEEK_START",qc."REVIEW_WEEK_END"
, q1.group_text qsection_1
, q1.question_number Qnumber_1
, q1.question_text qtext_1
, q1.survey_answer_text qanswer_1
, q1.survey_answer_score qscore_1
, q1.survey_response_created_by response_created_by_1
, q1.response_created_by_name response_created_by_name_1
, q1.response_updated_by_name response_updated_by_name_1
, q1.survey_response_create_ts response_created_date_1
, q1.survey_answer_Comments response_comments_1
, q2.group_text qsection_2
, q2.question_number Qnumber_2
, q2.question_text qtext_2
, q2.survey_answer_text qanswer_2
, q2.survey_answer_score qscore_2
, q2.survey_response_created_by response_created_by_2
, q2.response_created_by_name response_created_by_name_2
, q2.response_updated_by_name response_updated_by_name_2
, q2.survey_response_create_ts response_created_date_2
, q2.survey_answer_Comments response_comments_2
, q3.group_text qsection_3
, q3.question_number Qnumber_3
, q3.question_text qtext_3
, q3.survey_answer_text qanswer_3
, q3.survey_answer_score qscore_3
, q3.survey_response_created_by response_created_by_3
, q3.response_created_by_name response_created_by_name_3
, q3.response_updated_by_name response_updated_by_name_3
, q3.survey_response_create_ts response_created_date_3
, q3.survey_answer_Comments response_comments_3
, q4.group_text qsection_4
, q4.question_number Qnumber_4
, q4.question_text qtext_4
, q4.survey_answer_text qanswer_4
, q4.survey_answer_score qscore_4
, q4.survey_response_created_by response_created_by_4
, q4.response_created_by_name response_created_by_name_4
, q4.response_updated_by_name response_updated_by_name_4
, q4.survey_response_create_ts response_created_date_4
, q4.survey_answer_Comments response_comments_4
, q5.group_text qsection_5
, q5.question_number Qnumber_5
, q5.question_text qtext_5
, q5.survey_answer_text qanswer_5
, q5.survey_answer_score qscore_5
, q5.survey_response_created_by response_created_by_5
, q5.response_created_by_name response_created_by_name_5
, q5.response_updated_by_name response_updated_by_name_5
, q5.survey_response_create_ts response_created_date_5
, q5.survey_answer_Comments response_comments_5
, q6.group_text qsection_6
, q6.question_number Qnumber_6
, q6.question_text qtext_6
, q6.survey_answer_text qanswer_6
, q6.survey_answer_score qscore_6
, q6.survey_response_created_by response_created_by_6
, q6.response_created_by_name response_created_by_name_6
, q6.response_updated_by_name response_updated_by_name_6
, q6.survey_response_create_ts response_created_date_6
, q6.survey_answer_Comments response_comments_6
, q7.group_text qsection_7
, q7.question_number Qnumber_7
, q7.question_text qtext_7
, q7.survey_answer_text qanswer_7
, q7.survey_answer_score qscore_7
, q7.survey_response_created_by response_created_by_7
, q7.response_created_by_name response_created_by_name_7
, q7.response_updated_by_name response_updated_by_name_7
, q7.survey_response_create_ts response_created_date_7
, q7.survey_answer_Comments response_comments_7
, q8.group_text qsection_8
, q8.question_number Qnumber_8
, q8.question_text qtext_8
, q8.survey_answer_text qanswer_8
, q8.survey_answer_score qscore_8
, q8.survey_response_created_by response_created_by_8
, q8.response_created_by_name response_created_by_name_8
, q8.response_updated_by_name response_updated_by_name_8
, q8.survey_response_create_ts response_created_date_8
, q8.survey_answer_Comments response_comments_8
, q9.group_text qsection_9
, q9.question_number Qnumber_9
, q9.question_text qtext_9
, q9.survey_answer_text qanswer_9
, q9.survey_answer_score qscore_9
, q9.survey_response_created_by response_created_by_9
, q9.response_created_by_name response_created_by_name_9
, q9.response_updated_by_name response_updated_by_name_9
, q9.survey_response_create_ts response_created_date_9
, q9.survey_answer_Comments response_comments_9
, q10.group_text qsection_10
, q10.question_number Qnumber_10
, q10.question_text qtext_10
, q10.survey_answer_text qanswer_10
, q10.survey_answer_score qscore_10
, q10.survey_response_created_by response_created_by_10
, q10.response_created_by_name response_created_by_name_10
, q10.response_updated_by_name response_updated_by_name_10
, q10.survey_response_create_ts response_created_date_10
, q10.survey_answer_Comments response_comments_10
, q11.group_text qsection_11
, q11.question_number Qnumber_11
, q11.question_text qtext_11
, q11.survey_answer_text qanswer_11
, q11.survey_answer_score qscore_11
, q11.survey_response_created_by response_created_by_11
, q11.response_created_by_name response_created_by_name_11
, q11.response_updated_by_name response_updated_by_name_11
, q11.survey_response_create_ts response_created_date_11
, q11.survey_answer_Comments response_comments_11
, q12.group_text qsection_12
, q12.question_number Qnumber_12
, q12.question_text qtext_12
, q12.survey_answer_text qanswer_12
, q12.survey_answer_score qscore_12
, q12.survey_response_created_by response_created_by_12
, q12.response_created_by_name response_created_by_name_12
, q12.response_updated_by_name response_updated_by_name_12
, q12.survey_response_create_ts response_created_date_12
, q12.survey_answer_Comments response_comments_12
, q13.group_text qsection_13
, q13.question_number Qnumber_13
, q13.question_text qtext_13
, q13.survey_answer_text qanswer_13
, q13.survey_answer_score qscore_13
, q13.survey_response_created_by response_created_by_13
, q13.response_created_by_name response_created_by_name_13
, q13.response_updated_by_name response_updated_by_name_13
, q13.survey_response_create_ts response_created_date_13
, q13.survey_answer_Comments response_comments_13
, q14.group_text qsection_14
, q14.question_number Qnumber_14
, q14.question_text qtext_14
, q14.survey_answer_text qanswer_14
, q14.survey_answer_score qscore_14
, q14.survey_response_created_by response_created_by_14
, q14.response_created_by_name response_created_by_name_14
, q14.response_updated_by_name response_updated_by_name_14
, q14.survey_response_create_ts response_created_date_14
, q14.survey_answer_Comments response_comments_14
, q15.group_text qsection_15
, q15.question_number Qnumber_15
, q15.question_text qtext_15
, q15.survey_answer_text qanswer_15
, q15.survey_answer_score qscore_15
, q15.survey_response_created_by response_created_by_15
, q15.response_created_by_name response_created_by_name_15
, q15.response_updated_by_name response_updated_by_name_15
, q15.survey_response_create_ts response_created_date_15
, q15.survey_answer_Comments response_comments_15
, q16.group_text qsection_16
, q16.question_number Qnumber_16
, q16.question_text qtext_16
, q16.survey_answer_text qanswer_16
, q16.survey_answer_score qscore_16
, q16.survey_response_created_by response_created_by_16
, q16.response_created_by_name response_created_by_name_16
, q16.response_updated_by_name response_updated_by_name_16
, q16.survey_response_create_ts response_created_date_16
, q16.survey_answer_Comments response_comments_16
, q17.group_text qsection_17
, q17.question_number Qnumber_17
, q17.question_text qtext_17
, q17.survey_answer_text qanswer_17
, q17.survey_answer_score qscore_17
, q17.survey_response_created_by response_created_by_17
, q17.response_created_by_name response_created_by_name_17
, q17.response_updated_by_name response_updated_by_name_17
, q17.survey_response_create_ts response_created_date_17
, q17.survey_answer_Comments response_comments_17
, q18.group_text qsection_18
, q18.question_number Qnumber_18
, q18.question_text qtext_18
, q18.survey_answer_text qanswer_18
, q18.survey_answer_score qscore_18
, q18.survey_response_created_by response_created_by_18
, q18.response_created_by_name response_created_by_name_18
, q18.response_updated_by_name response_updated_by_name_18
, q18.survey_response_create_ts response_created_date_18
, q18.survey_answer_Comments response_comments_18
, q19.group_text qsection_19
, q19.question_number Qnumber_19
, q19.question_text qtext_19
, q19.survey_answer_text qanswer_19
, q19.survey_answer_score qscore_19
, q19.survey_response_created_by response_created_by_19
, q19.survey_response_create_ts response_created_date_19
, q19.response_created_by_name response_created_by_name_19
, q19.response_updated_by_name response_updated_by_name_19
, q19.survey_answer_Comments response_comments_19
, q20.group_text qsection_20
, q20.question_number Qnumber_20
, q20.question_text qtext_20
, q20.survey_answer_text qanswer_20
, q20.survey_answer_score qscore_20
, q20.survey_response_created_by response_created_by_20
, q20.response_created_by_name response_created_by_name_20
, q20.response_updated_by_name response_updated_by_name_20
, q20.survey_response_create_ts response_created_date_20
, q20.survey_answer_Comments response_comments_20
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
, q21.group_text qsection_21
, q21.question_number Qnumber_21
, q21.question_text qtext_21
, q21.survey_answer_text qanswer_21
, q21.survey_answer_score qscore_21
, q21.survey_response_created_by response_created_by_21
, q21.response_created_by_name response_created_by_name_21
, q21.response_updated_by_name response_updated_by_name_21
, q21.survey_response_create_ts response_created_date_21
, q21.survey_answer_Comments response_comments_21
, q22.group_text qsection_22
, q22.question_number Qnumber_22
, q22.question_text qtext_22
, q22.survey_answer_text qanswer_22
, q22.survey_answer_score qscore_22
, q22.survey_response_created_by response_created_by_22
, q22.response_created_by_name response_created_by_name_22
, q22.response_updated_by_name response_updated_by_name_22
, q22.survey_response_create_ts response_created_date_22
, q22.survey_answer_Comments response_comments_22
, q23.group_text qsection_23
, q23.question_number Qnumber_23
, q23.question_text qtext_23
, q23.survey_answer_text qanswer_23
, q23.survey_answer_score qscore_23
, q23.survey_response_created_by response_created_by_23
, q23.response_created_by_name response_created_by_name_23
, q23.response_updated_by_name response_updated_by_name_23
, q23.survey_response_create_ts response_created_date_23
, q23.survey_answer_Comments response_comments_23
, q24.group_text qsection_24
, q24.question_number Qnumber_24
, q24.question_text qtext_24
, q24.survey_answer_text qanswer_24
, q24.survey_answer_score qscore_24
, q24.survey_response_created_by response_created_by_24
, q24.response_created_by_name response_created_by_name_24
, q4.response_updated_by_name response_updated_by_name_24
, q24.survey_response_create_ts response_created_date_24
, q24.survey_answer_Comments response_comments_24
, q25.group_text qsection_25
, q25.question_number Qnumber_25
, q25.question_text qtext_25
, q25.survey_answer_text qanswer_25
, q25.survey_answer_score qscore_25
, q25.survey_response_created_by response_created_by_25
, q25.response_created_by_name response_created_by_name_25
, q25.response_updated_by_name response_updated_by_name_25
, q25.survey_response_create_ts response_created_date_25
, q25.survey_answer_Comments response_comments_25
, q26.group_text qsection_26
, q26.question_number Qnumber_26
, q26.question_text qtext_26
, q26.survey_answer_text qanswer_26
, q26.survey_answer_score qscore_26
, q26.survey_response_created_by response_created_by_26
, q26.response_created_by_name response_created_by_name_26
, q26.response_updated_by_name response_updated_by_name_26
, q26.survey_response_create_ts response_created_date_26
, q26.survey_answer_Comments response_comments_26
, q27.group_text qsection_27
, q27.question_number Qnumber_27
, q27.question_text qtext_27
, q27.survey_answer_text qanswer_27
, q27.survey_answer_score qscore_27
, q27.survey_response_created_by response_created_by_27
, q27.response_created_by_name response_created_by_name_27
, q27.response_updated_by_name response_updated_by_name_27
, q27.survey_response_create_ts response_created_date_27
, q27.survey_answer_Comments response_comments_27
, q28.group_text qsection_28
, q28.question_number Qnumber_28
, q28.question_text qtext_28
, q28.survey_answer_text qanswer_28
, q28.survey_answer_score qscore_28
, q28.survey_response_created_by response_created_by_28
, q28.response_created_by_name response_created_by_name_28
, q28.response_updated_by_name response_updated_by_name_28
, q28.survey_response_create_ts response_created_date_28
, q28.survey_answer_Comments response_comments_28
, q29.group_text qsection_29
, q29.question_number Qnumber_29
, q29.question_text qtext_29
, q29.survey_answer_text qanswer_29
, q29.survey_answer_score qscore_29
, q29.survey_response_created_by response_created_by_29
, q29.response_created_by_name response_created_by_name_29
, q29.response_updated_by_name response_updated_by_name_29
, q29.survey_response_create_ts response_created_date_29
, q29.survey_answer_Comments response_comments_29
, q30.group_text qsection_30
, q30.question_number Qnumber_30
, q30.question_text qtext_30
, q30.survey_answer_text qanswer_30
, q30.survey_answer_score qscore_30
, q30.survey_response_created_by response_created_by_30
, q30.response_created_by_name response_created_by_name_30
, q30.response_updated_by_name response_updated_by_name_30
, q30.survey_response_create_ts response_created_date_30
, q30.survey_answer_Comments response_comments_30
, q31.group_text qsection_31
, q31.question_number Qnumber_31
, q31.question_text qtext_31
, q31.survey_answer_text qanswer_31
, q31.survey_answer_score qscore_31
, q31.survey_response_created_by response_created_by_31
, q31.response_created_by_name response_created_by_name_31
, q31.response_updated_by_name response_updated_by_name_31
, q31.survey_response_create_ts response_created_date_31
, q31.survey_answer_Comments response_comments_31
, q32.group_text qsection_32
, q32.question_number Qnumber_32
, q32.question_text qtext_32
, q32.survey_answer_text qanswer_32
, q32.survey_answer_score qscore_32
, q32.survey_response_created_by response_created_by_32
, q32.response_created_by_name response_created_by_name_32
, q32.response_updated_by_name response_updated_by_name_32
, q32.survey_response_create_ts response_created_date_32
, q32.survey_answer_Comments response_comments_32
, q33.group_text qsection_33
, q33.question_number Qnumber_33
, q33.question_text qtext_33
, q33.survey_answer_text qanswer_33
, q33.survey_answer_score qscore_33
, q33.survey_response_created_by response_created_by_33
, q33.response_created_by_name response_created_by_name_33
, q33.response_updated_by_name response_updated_by_name_33
, q33.survey_response_create_ts response_created_date_33
, q33.survey_answer_Comments response_comments_33
, q34.group_text qsection_34
, q34.question_number Qnumber_34
, q34.question_text qtext_34
, q34.survey_answer_text qanswer_34
, q34.survey_answer_score qscore_34
, q34.survey_response_created_by response_created_by_34
, q34.response_created_by_name response_created_by_name_34
, q34.response_updated_by_name response_updated_by_name_34
, q34.survey_response_create_ts response_created_date_34
, q34.survey_answer_Comments response_comments_34
, q35.group_text qsection_35
, q35.question_number Qnumber_35
, q35.question_text qtext_35
, q35.survey_answer_text qanswer_35
, q35.survey_answer_score qscore_35
, q35.survey_response_created_by response_created_by_35
, q35.response_created_by_name response_created_by_name_35
, q35.response_updated_by_name response_updated_by_name_35
, q35.survey_response_create_ts response_created_date_35
, q35.survey_answer_Comments response_comments_35
, q36.group_text qsection_36
, q36.question_number Qnumber_36
, q36.question_text qtext_36
, q36.survey_answer_text qanswer_36
, q36.survey_answer_score qscore_36
, q36.survey_response_created_by response_created_by_36
, q36.response_created_by_name response_created_by_name_36
, q36.response_updated_by_name response_updated_by_name_36
, q36.survey_response_create_ts response_created_date_36
, q36.survey_answer_Comments response_comments_36
, q37.group_text qsection_37
, q37.question_number Qnumber_37
, q37.question_text qtext_37
, q37.survey_answer_text qanswer_37
, q37.survey_answer_score qscore_37
, q37.survey_response_created_by response_created_by_37
, q37.response_created_by_name response_created_by_name_37
, q37.response_updated_by_name response_updated_by_name_37
, q37.survey_response_create_ts response_created_date_37
, q37.survey_answer_Comments response_comments_37
, q38.group_text qsection_38
, q38.question_number Qnumber_38
, q38.question_text qtext_38
, q38.survey_answer_text qanswer_38
, q38.survey_answer_score qscore_38
, q38.survey_response_created_by response_created_by_38
, q38.response_created_by_name response_created_by_name_38
, q38.response_updated_by_name response_updated_by_name_38
, q38.survey_response_create_ts response_created_date_38
, q38.survey_answer_Comments response_comments_38
, q39.group_text qsection_39
, q39.question_number Qnumber_39
, q39.question_text qtext_39
, q39.survey_answer_text qanswer_39
, q39.survey_answer_score qscore_39
, q39.survey_response_created_by response_created_by_39
, q39.survey_response_create_ts response_created_date_39
, q39.response_created_by_name response_created_by_name_39
, q39.response_updated_by_name response_updated_by_name_39
, q39.survey_answer_Comments response_comments_39
, q40.group_text qsection_40
, q40.question_number Qnumber_40
, q40.question_text qtext_40
, q40.survey_answer_text qanswer_40
, q40.survey_answer_score qscore_40
, q40.survey_response_created_by response_created_by_40
, q40.response_created_by_name response_created_by_name_40
, q40.response_updated_by_name response_updated_by_name_40
, q40.survey_response_create_ts response_created_date_40
, q40.survey_answer_Comments response_comments_40
, qc.CONTACT_LANGUAGE
, qc.DCN
, qc.REVIEW_TYPE
, qc.ENTRY_DATE
, qc.MEDICAID_CHIP_ID
from qc_reviews_sv qc
left join QC_REVIEW_QUESTION_ANSWER q1 on q1.survey_id = qc.survey_id and trim(q1.question_number) = '1' and q1.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q2 on q2.survey_id = qc.survey_id and trim(q2.question_number) = '2' and q2.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q3 on q3.survey_id = qc.survey_id and trim(q3.question_number) = '3' and q3.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q4 on q4.survey_id = qc.survey_id and trim(q4.question_number) = '4' and q4.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q5 on q5.survey_id = qc.survey_id and trim(q5.question_number) = '5' and q5.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q6 on q6.survey_id = qc.survey_id and trim(q6.question_number) = '6' and q6.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q7 on q7.survey_id = qc.survey_id and trim(q7.question_number) = '7' and q7.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q8 on q8.survey_id = qc.survey_id and trim(q8.question_number) = '8' and q8.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q9 on q9.survey_id = qc.survey_id and trim(q9.question_number) = '9' and q9.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q10 on q10.survey_id = qc.survey_id and trim(q10.question_number) = '10' and q10.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q11 on q11.survey_id = qc.survey_id and trim(q11.question_number) = '11' and q11.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q12 on q12.survey_id = qc.survey_id and trim(q12.question_number) = '12' and q12.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q13 on q13.survey_id = qc.survey_id and trim(q13.question_number) = '13' and q13.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q14 on q14.survey_id = qc.survey_id and trim(q14.question_number) = '14' and q14.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q15 on q15.survey_id = qc.survey_id and trim(q15.question_number) = '15' and q15.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q16 on q16.survey_id = qc.survey_id and trim(q16.question_number) = '16' and q16.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q17 on q17.survey_id = qc.survey_id and trim(q17.question_number) = '17' and q17.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q18 on q18.survey_id = qc.survey_id and trim(q18.question_number) = '18' and q18.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q19 on q19.survey_id = qc.survey_id and trim(q19.question_number) = '19' and q19.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q20 on q20.survey_id = qc.survey_id and trim(q20.question_number) = '20' and q20.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q21 on q21.survey_id = qc.survey_id and trim(q21.question_number) = '21' and q21.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q22 on q22.survey_id = qc.survey_id and trim(q22.question_number) = '22' and q22.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q23 on q23.survey_id = qc.survey_id and trim(q23.question_number) = '23' and q23.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q24 on q24.survey_id = qc.survey_id and trim(q24.question_number) = '24' and q24.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q25 on q25.survey_id = qc.survey_id and trim(q25.question_number) = '25' and q25.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q26 on q26.survey_id = qc.survey_id and trim(q26.question_number) = '26' and q26.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q27 on q27.survey_id = qc.survey_id and trim(q27.question_number) = '27' and q27.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q28 on q28.survey_id = qc.survey_id and trim(q28.question_number) = '28' and q28.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q29 on q29.survey_id = qc.survey_id and trim(q29.question_number) = '29' and q29.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q30 on q30.survey_id = qc.survey_id and trim(q30.question_number) = '30' and q30.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q31 on q31.survey_id = qc.survey_id and trim(q31.question_number) = '31' and q31.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q32 on q32.survey_id = qc.survey_id and trim(q32.question_number) = '32' and q32.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q33 on q33.survey_id = qc.survey_id and trim(q33.question_number) = '33' and q33.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q34 on q34.survey_id = qc.survey_id and trim(q34.question_number) = '34' and q34.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q35 on q35.survey_id = qc.survey_id and trim(q35.question_number) = '35' and q35.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q36 on q36.survey_id = qc.survey_id and trim(q36.question_number) = '36' and q36.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q37 on q37.survey_id = qc.survey_id and trim(q37.question_number) = '37' and q37.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q38 on q38.survey_id = qc.survey_id and trim(q38.question_number) = '38' and q38.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q39 on q39.survey_id = qc.survey_id and trim(q39.question_number) = '39' and q39.survey_template_id = qc.survey_template_id
left join QC_REVIEW_QUESTION_ANSWER q40 on q40.survey_id = qc.survey_id and trim(q40.question_number) = '40' and q40.survey_template_id = qc.survey_template_id
left join qc_scores_sv qs1 on (qs1.survey_id = qc.survey_id and qs1.sort_order = 0)
left join qc_scores_sv qs2 on (qs2.survey_id = qc.survey_id and qs2.sort_order = 1)
left join qc_scores_sv qs3 on (qs3.survey_id = qc.survey_id and qs3.sort_order = 2);

GRANT SELECT ON MAXDAT.QC_REVIEW_PIVOT_SV TO maxdat_read_only;
GRANT SELECT ON MAXDAT.QC_REVIEW_PIVOT_SV TO maxdat_reports;