ALTER TABLE CC_F_ACD_QUEUE_INTERVAL MODIFY (MIN_HANDLE_TIME NUMBER(11,2),MAX_HANDLE_TIME NUMBER(11,2),MEAN_HANDLE_TIME NUMBER(11,2),
						MEDIAN_HANDLE_TIME NUMBER(11,2),STDDEV_HANDLE_TIME NUMBER(11,2),
						MIN_SPEED_TO_HANDLE NUMBER(11,2),MAX_SPEED_TO_HANDLE NUMBER(11,2),
						MEAN_SPEED_TO_HANDLE NUMBER(11,2),MEDIAN_SPEED_TO_HANDLE NUMBER(11,2),STDDEV_SPEED_TO_HANDLE NUMBER(11,2),
						MIN_SPEED_OF_ANSWER NUMBER(11,2),MAX_SPEED_OF_ANSWER NUMBER(11,2),MEAN_SPEED_OF_ANSWER NUMBER(11,2),
						MEDIAN_SPEED_OF_ANSWER NUMBER(11,2),STDDEV_SPEED_OF_ANSWER NUMBER(11,2));   
						
commit;