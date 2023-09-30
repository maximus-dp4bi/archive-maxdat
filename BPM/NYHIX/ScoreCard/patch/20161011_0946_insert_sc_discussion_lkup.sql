INSERT INTO DP_SCORECARD.SC_DISCUSSION_LKUP
	(
	DL_ID
	, DISCUSSION_TOPIC
	, END_DATE
	, CREATE_BY
	, CREATE_DATETIME
	)
VALUES
	(
	SEQ_SCDL_ID.nextval
	, 'QC Dispute'
	, to_date('07/07/2077','dd/mm/yyyy')
	, 'script'
	, sysdate
	);
	
commit;
