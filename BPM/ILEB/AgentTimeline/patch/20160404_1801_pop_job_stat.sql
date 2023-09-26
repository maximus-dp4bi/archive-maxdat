/*
Created on 04/04/2016 by Raj A.
Description: Created for ILEB-5734. After meeting with Brendon and Devin, decided to reload (for older records, update)data 
from 15-Mar-2016.
*/
INSERT INTO CORP_ETL_JOB_STATISTICS (JOB_ID, JOB_NAME, JOB_STATUS_CD, RECORD_COUNT, PROCESSED_COUNT, ERROR_COUNT, WARNING_COUNT, RECORD_INSERTED_COUNT, RECORD_UPDATED_COUNT, JOB_START_DATE, JOB_END_DATE) 
VALUES (SEQ_JOB_ID.nextval, 'PP_WFM_RUNALL', 'COMPLETED', 0, 0, 0, 0, 0, 0, to_date('15-MAR-2016','DD-MON-YYYY'), to_date('04-APR-2016','DD-MON-YYYY'));

commit;