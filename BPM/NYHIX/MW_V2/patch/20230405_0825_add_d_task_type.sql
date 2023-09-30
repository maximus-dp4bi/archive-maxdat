-- User Story 28176 UAT 
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
	2022003
	, 'Pending AOP/Bad Number Cancellation'
	, 'Pending AOP/Bad Number Cancellation'
	, 'Account Review'
	, 60
	, 'C'
	, NULL
	, 17
	, NULL
	);
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
	2022002
	, 'AOP/Bad Number Cancellation'
	, 'AOP/Bad Number Cancellation'
	, 'Account Review'
	, 60
	, 'C'
	, NULL
	, 17
	, NULL
	);
COMMIT;