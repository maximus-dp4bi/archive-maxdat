CREATE OR REPLACE FORCE VIEW CC_HCO_F_CALL_BACK_SV (F_CALL_BACK_ID,D_DATE_ID,D_CONTACT_QUEUE_ID,D_PROJECT_ID,D_PROGRAM_ID,
CALL_BACK_DATE, QUEUE_NUMBER, CALL_BACK_ENTER_DATETIME, CALL_BACK_ENTER_HOUR, CALL_BACK_EXIT_DATETIME, CALL_BACK_EXIT_HOUR,
CALL_BACK_DURATION, CALL_BACK_RESULT, CALL_BACK_STATUS, CUSTOMER_NUMBER, CALL_BACK_EST_WAIT, CALL_BACK_ATTEMPTS, TALK_TIME)
AS 
SELECT CC_F_CALL_BACK.F_CALL_BACK_ID,CC_F_CALL_BACK.D_DATE_ID,CC_F_CALL_BACK.D_CONTACT_QUEUE_ID,CC_D_CONTACT_QUEUE.D_PROJECT_ID,CC_D_CONTACT_QUEUE.D_PROGRAM_ID, 
CC_F_CALL_BACK.CALL_BACK_DATE,CC_F_CALL_BACK.QUEUE_NUMBER,CC_F_CALL_BACK.CALL_BACK_ENTER_DATETIME,
CC_F_CALL_BACK.CALL_BACK_ENTRY_HOUR,CC_F_CALL_BACK.CALL_BACK_EXIT_DATETIME,CC_F_CALL_BACK.CALL_BACK_EXIT_HOUR,CC_F_CALL_BACK.CALL_BACK_DURATION, CC_F_CALL_BACK.CALL_BACK_RESULT,CC_F_CALL_BACK.CALL_BACK_STATUS,
CC_F_CALL_BACK.CUSTOMER_NUMBER, CC_F_CALL_BACK.CALL_BACK_EST_WAIT, CC_F_CALL_BACK.CALL_BACK_ATTEMPTS, CC_F_CALL_BACK.TALK_TIME
FROM CC_F_CALL_BACK
INNER JOIN CC_D_CONTACT_QUEUE ON CC_F_CALL_BACK.D_CONTACT_QUEUE_ID = CC_D_CONTACT_QUEUE.D_CONTACT_QUEUE_ID
INNER JOIN CC_D_PROJECT  ON CC_D_CONTACT_QUEUE.D_PROJECT_ID = CC_D_PROJECT.PROJECT_ID
WHERE CC_D_PROJECT.PROJECT_NAME = 'CA HCO';

GRANT SELECT ON CC_HCO_F_CALL_BACK_SV TO MAXDAT_READ_ONLY;