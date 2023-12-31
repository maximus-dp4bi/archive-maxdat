ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL MODIFY (MIN_HANDLE_TIME NUMBER(11,2),MAX_HANDLE_TIME NUMBER(11,2),MEAN_HANDLE_TIME NUMBER(11,2),
						MEDIAN_HANDLE_TIME NUMBER(11,2),STDDEV_HANDLE_TIME NUMBER(11,2),
						MIN_SPEED_TO_HANDLE NUMBER(11,2),MAX_SPEED_TO_HANDLE NUMBER(12,2),
						MEAN_SPEED_TO_HANDLE NUMBER(12,2),MEDIAN_SPEED_TO_HANDLE NUMBER(12,2),STDDEV_SPEED_TO_HANDLE NUMBER(11,2),
						MIN_SPEED_OF_ANSWER NUMBER(11,2),MAX_SPEED_OF_ANSWER NUMBER(12,2),MEAN_SPEED_OF_ANSWER NUMBER(12,2),
						MEDIAN_SPEED_OF_ANSWER NUMBER(12,2),STDDEV_SPEED_OF_ANSWER NUMBER(11,2));     

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('1.9.0','005','005_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL');

COMMIT;

