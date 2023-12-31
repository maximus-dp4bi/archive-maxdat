ALTER TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
ADD (
    AGENT_DISCONNECTED_SHORT_CALLS   NUMBER(5),
    CONSUMER_DISCONNECTED_SHORT_CALLS  NUMBER(5)
    );
	
ALTER TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
ADD (
	CURRENT_MONTH_EVENTS_SCHEDULED       NUMBER(5),
	CURRENT_MONTH_EVENTS_MET             NUMBER(5)
);

ALTER TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
ADD (
	FIRST_PRIOR_MONTH_EVENTS_SCHEDULED       NUMBER(5),
	FIRST_PRIOR_MONTH_EVENTS_MET             NUMBER(5),
	SECOND_PRIOR_MONTH_EVENTS_SCHEDULED       NUMBER(5),
	SECOND_PRIOR_MONTH_EVENTS_MET             NUMBER(5)
);	


ALTER TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP
ADD (
	FIRST_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME		NUMBER,
	FIRST_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME		NUMBER,
	FIRST_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME		NUMBER,
	SECOND_PRIOR_MONTH_ADHERENCE_TOT_LOGGED_IN_TIME		NUMBER,
	SECOND_PRIOR_MONTH_ADHERENCE_TOT_NOT_READY_TIME		NUMBER,
	SECOND_PRIOR_MONTH_ADHERENCE_LAG_TIME_TOT_SCHED_PROD_TIME		NUMBER
);

ALTER TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP 
ADD 
(
	THREE_MONTH_CONFORMANCE_MISSED_COUNT  NUMBER(6),
	THREE_MONTH_AVG_ADHERENCE			NUMBER,
	THREE_MONTH_ADHERENCE_FLAG			NUMBER(2)
);
	
ALTER TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP 
ADD 
(
	MONTHLY_CONFORMANCE_FLAG   			NUMBER(2)
);
	