ALTER TABLE DP_SCORECARD.SC_PERFORMANCE_TRACKER_AUDIT MODIFY COMMENTS VARCHAR2(1100 BYTE);
ALTER TABLE DP_SCORECARD.SC_PERFORMANCE_TRACKER MODIFY COMMENTS VARCHAR2(1100 BYTE);
ALTER TABLE DP_SCORECARD.SC_CORRECTIVE_ACTION_AUDIT MODIFY UNSATISFACTORY_BEHAVIOR VARCHAR2(275 BYTE);
ALTER TABLE DP_SCORECARD.SC_CORRECTIVE_ACTION_AUDIT MODIFY COMMENTS VARCHAR2(1100 BYTE);
ALTER TABLE DP_SCORECARD.SC_CORRECTIVE_ACTION MODIFY UNSATISFACTORY_BEHAVIOR VARCHAR2(275 BYTE);
ALTER TABLE DP_SCORECARD.SC_CORRECTIVE_ACTION MODIFY COMMENTS VARCHAR2(1100 BYTE);
ALTER TABLE DP_SCORECARD.SC_GOAL MODIFY GOAL_DESCRIPTION VARCHAR2(110 BYTE);
ALTER TABLE DP_SCORECARD.SC_GOAL MODIFY PROGRESS_NOTE VARCHAR2(550 BYTE);
ALTER TABLE DP_SCORECARD.SC_GOAL_AUDIT MODIFY GOAL_DESCRIPTION VARCHAR2(110 BYTE);
ALTER TABLE DP_SCORECARD.SC_GOAL_AUDIT MODIFY PROGRESS_NOTE VARCHAR2(550 BYTE);
ALTER TABLE DP_SCORECARD.SC_EXCLUSION MODIFY EXCLUSION_COMMENT VARCHAR2(440 BYTE);