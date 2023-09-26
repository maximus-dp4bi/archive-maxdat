alter session set current_schema = MAXDAT;

CREATE INDEX idx01_survey_template ON survey_template(survey_template_category_cd) TABLESPACE MAXDAT_INDX;

CREATE INDEX idx01_survey ON survey(survey_template_id) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx02_survey ON survey(created_by) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx03_survey ON survey(status_cd) TABLESPACE MAXDAT_INDX; 

CREATE INDEX idx01_survey_hdr ON survey_header_info(supervisor_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx02_survey_hdr ON survey_header_info(TO_CHAR(agent_id)) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx03_survey_hdr ON survey_header_info(review_date) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx04_survey_hdr ON survey_header_info(date_of_call) TABLESPACE MAXDAT_INDX;
CREATE INDEX idx05_survey_hdr ON survey_header_info(calibration) TABLESPACE MAXDAT_INDX; 

CREATE INDEX idx01_survey_cntxt ON survey_template_context(survey_template_id) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx02_survey_cntxt ON survey_template_context(ref_type) TABLESPACE MAXDAT_INDX; 

CREATE UNIQUE INDEX xpk_survey_score_hist ON survey_score_hist(survey_score_hist_id) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx01_survey_score_hist ON survey_score_hist(survey_id) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx02_survey_score_hist ON survey_score_hist(survey_template_group_id) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx03_survey_score_hist ON survey_score_hist(created_by) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx04_survey_score_hist ON survey_score_hist(TRUNC(create_ts,'MI')) TABLESPACE MAXDAT_INDX; 

CREATE INDEX idx01_survey_grptext ON svey_tmpl_group_text(survey_template_group_id) TABLESPACE MAXDAT_INDX; 

CREATE INDEX idx01_survey_response ON survey_response(template_question_id) TABLESPACE MAXDAT_INDX; 
CREATE INDEX idx02_survey_response ON survey_response(survey_template_answer_id) TABLESPACE MAXDAT_INDX; 

