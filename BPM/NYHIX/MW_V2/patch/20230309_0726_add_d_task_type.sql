-- USER STORY 25711
INSERT INTO MAXDAT.D_TASK_TYPES
	(
	TASK_TYPE_ID
	, TASK_NAME
	, TASK_DESCRIPTION
	, OPERATIONS_GROUP
	, SLA_DAYS
	, SLA_DAYS_TYPE
	, SLA_TARGET_DAYS
	, SLA_JEOPARDY_DAYS
	, UNIT_OF_WORK
	)
VALUES
	(
	2022001
	, 'Linking Assessment'
	, 'Linking Assessment'
	, 'Research'
	, 5
	, 'B'
	, null
	, 2
	, null
	)
;
COMMIT;