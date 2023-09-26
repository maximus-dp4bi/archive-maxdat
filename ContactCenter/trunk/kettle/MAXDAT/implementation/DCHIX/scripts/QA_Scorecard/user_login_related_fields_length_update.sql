-- Audit
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_AUDIT MODIFY QA_ANALYST_ID VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_AUDIT MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_AUDIT MODIFY LAST_UPDATED_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_AUDIT MODIFY QA_ANALYST_ID VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_AUDIT MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_AUDIT MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- Audit Question Answer
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_AUDIT_QUESTION_ANSWER MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_AUDIT_QUESTION_ANSWER MODIFY LAST_UPDATED_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_AUDIT_QUESTION_ANSWER MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_AUDIT_QUESTION_ANSWER MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- QA Agent
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QA_AGENT MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QA_AGENT MODIFY LAST_UPDATED_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QA_AGENT MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QA_AGENT MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- QA Question
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QA_QUESTION MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QA_QUESTION MODIFY LAST_UPDATED_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QA_QUESTION MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QA_QUESTION MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- QA Supervisor
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QA_SUPERVISOR MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QA_SUPERVISOR MODIFY LAST_UPDATED_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QA_SUPERVISOR MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QA_SUPERVISOR MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- QA Question Answer Details
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QUEST_ANSWER_DETAIL MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QUEST_ANSWER_DETAIL MODIFY LAST_UPDATED_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QUEST_ANSWER_DETAIL MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QUEST_ANSWER_DETAIL MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- QA Question Details
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QUESTION_DETAIL MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.AIU_TS_QUESTION_DETAIL MODIFY LAST_UPDATED_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QUESTION_DETAIL MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_QUESTION_DETAIL MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- QA Audit Questions
ALTER TABLE DP_SCORECARD_DCHIX.TS_AUDIT_QUESTION MODIFY CREATE_BY VARCHAR2(100);
ALTER TABLE DP_SCORECARD_DCHIX.TS_AUDIT_QUESTION MODIFY LAST_UPDATED_BY VARCHAR2(100);

-- QA Analyst
ALTER TABLE DP_SCORECARD_DCHIX.TS_QA_ANALYST MODIFY QA_ANALYST_ID VARCHAR2(100);