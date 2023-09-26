
/* CC_F_ACTUALS_QUEUE_INTERVAL */

-- Remove NOT NULL constraint

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACTS_RECEIVED_FROM_IVR NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_TOTAL NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_WAITING NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY_JEOPARDY NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACTS_TRANSFERRED NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_ON_HOLD NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( SHORT_ABANDONS NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACTS_BLOCKED NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( ICR_DEFAULT_ROUTED NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( NETWORK_DEFAULT_ROUTED NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( RETURN_BUSY NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_RONA NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( RETURN_RELEASE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_ROUTED_NON_AGENT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( ERROR_COUNT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( AGENT_ERROR_COUNT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( RETURN_RING NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( INCOMPLETE_CALLS NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_FORCE_DISCONNECT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_ROUTE_TO NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_ABANDON_TIME NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( ABANDON_THRESHOLD NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( SHORT_CALLS NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_CALLS_QUEUED NULL );

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_AVAILABLE NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( HEADCOUNT_TOTAL NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( HEADCOUNT_UNAVAILABLE NULL );



-- Default to NULL

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACTS_RECEIVED_FROM_IVR DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_TOTAL DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_WAITING DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY_JEOPARDY DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MIN_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEAN_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MEDIAN_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( STDDEV_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACTS_TRANSFERRED DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_ON_HOLD DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( SHORT_ABANDONS DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CONTACTS_BLOCKED DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( ICR_DEFAULT_ROUTED DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( NETWORK_DEFAULT_ROUTED DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( RETURN_BUSY DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_RONA DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( RETURN_RELEASE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_ROUTED_NON_AGENT DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( ERROR_COUNT DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( AGENT_ERROR_COUNT DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( RETURN_RING DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( INCOMPLETE_CALLS DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_FORCE_DISCONNECT DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_ROUTE_TO DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_ABANDON_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( ABANDON_THRESHOLD DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( SHORT_CALLS DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( MAX_CALLS_QUEUED DEFAULT NULL );

ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_AVAILABLE DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( HEADCOUNT_TOTAL DEFAULT NULL );
ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY ( HEADCOUNT_UNAVAILABLE DEFAULT NULL );



/* CC_F_ACD_QUEUE_INTERVAL */


-- Remove NOT NULL constraint

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACTS_RECEIVED_FROM_IVR NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_TO_HANDLE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_OF_ANSWER NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_TOTAL NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_WAITING NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY_JEOPARDY NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_CONTACT_INVENTORY_AGE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACTS_TRANSFERRED NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_ON_HOLD NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( SHORT_ABANDONS NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACTS_BLOCKED NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( ICR_DEFAULT_ROUTED NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( NETWORK_DEFAULT_ROUTED NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( RETURN_BUSY NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_RONA NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( RETURN_RELEASE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_ROUTED_NON_AGENT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( ERROR_COUNT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( AGENT_ERROR_COUNT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( RETURN_RING NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( INCOMPLETE_CALLS NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_FORCE_DISCONNECT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_ROUTE_TO NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_ABANDON_TIME NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( ABANDON_THRESHOLD NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( SHORT_CALLS NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_CALLS_QUEUED NULL );

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_AVAILABLE NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( HEADCOUNT_TOTAL NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( HEADCOUNT_UNAVAILABLE NULL );

-- Default to NULL

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACTS_RECEIVED_FROM_IVR DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_TO_HANDLE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_SPEED_OF_ANSWER DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_TOTAL DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_WAITING DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACT_INVENTORY_JEOPARDY DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MIN_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEAN_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MEDIAN_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( STDDEV_CONTACT_INVENTORY_AGE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACTS_TRANSFERRED DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_ON_HOLD DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( SHORT_ABANDONS DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CONTACTS_BLOCKED DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( ICR_DEFAULT_ROUTED DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( NETWORK_DEFAULT_ROUTED DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( RETURN_BUSY DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_RONA DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( RETURN_RELEASE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_ROUTED_NON_AGENT DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( ERROR_COUNT DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( AGENT_ERROR_COUNT DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( RETURN_RING DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( INCOMPLETE_CALLS DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_FORCE_DISCONNECT DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( CALLS_GIVEN_ROUTE_TO DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_ABANDON_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( ABANDON_THRESHOLD DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( SHORT_CALLS DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( MAX_CALLS_QUEUED DEFAULT NULL );

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( LABOR_MINUTES_AVAILABLE DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( HEADCOUNT_TOTAL DEFAULT NULL );
ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY ( HEADCOUNT_UNAVAILABLE DEFAULT NULL );


/* CC_F_ACD_AGENT_INTERVAL */

-- Remove NOT NULL constraint

ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( CONTACTS_TRANSFERRED NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MIN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MAX_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MEAN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MEDIAN_HANDLE_TIME NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( STDDEV_HANDLE_TIME NULL );

-- Default to NULL

ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( CONTACTS_TRANSFERRED DEFAULT NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MIN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MAX_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MEAN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( MEDIAN_HANDLE_TIME DEFAULT NULL );
ALTER TABLE CC_F_ACD_AGENT_INTERVAL MODIFY ( STDDEV_HANDLE_TIME DEFAULT NULL );




/* CC_F_AGENT_BY_DATE */


-- Remove NOT NULL constraint

ALTER TABLE CC_F_AGENT_BY_DATE MODIFY ( SCHEDULED_SHIFT_MINUTES NULL );
ALTER TABLE CC_F_AGENT_BY_DATE MODIFY ( ACTUAL_OVERTIME_MINUTES NULL );


-- Default to NULL

ALTER TABLE CC_F_AGENT_BY_DATE MODIFY ( SCHEDULED_SHIFT_MINUTES DEFAULT NULL );
ALTER TABLE CC_F_AGENT_BY_DATE MODIFY ( ACTUAL_OVERTIME_MINUTES DEFAULT NULL );


