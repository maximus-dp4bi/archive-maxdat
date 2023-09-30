/*
Created on 01/24/2017 by Raj A.
Description: Per ILEB-6353, cleaning up Process Letters ETL stage tables and reloading from 12/25/2016.
*/
--All the below is for Letters.
/* Start cleaning up tables.  */
TRUNCATE TABLE CORP_ETL_PROC_LETTERS;
TRUNCATE TABLE CORP_ETL_PROC_LETTERS_OLTP;
TRUNCATE TABLE CORP_ETL_PROC_LETTERS_WIP_BPM;
TRUNCATE TABLE F_PL_BY_DATE;
ALTER TABLE F_PL_BY_DATE DISABLE CONSTRAINT FPLBD_DPLCUR_FK;
TRUNCATE TABLE D_PL_CURRENT;
ALTER TABLE F_PL_BY_DATE ENABLE CONSTRAINT FPLBD_DPLCUR_FK;
TRUNCATE TABLE BPM_UPDATE_EVENT_QUEUE;
TRUNCATE TABLE BPM_UPDATE_EVENT_QUEUE_ARCHIVE;
/* End cleaning up tables. */

--SELECT MIN(lmreq_id)
--FROM letter_request
--WHERE create_ts >= to_date('12/25/2016','mm/dd/yyyy');

UPDATE CORP_ETL_CONTROL
   SET VALUE = '11913502'
 WHERE NAME = 'PL_LAST_LMREQ_ID';
 
 UPDATE CORP_ETL_CONTROL
 SET VALUE = to_char(sysdate-1,'yyyy/mm/dd')
 WHERE NAME = 'PROCESSLETTERS_RUN_RUNALL_TODAY';
 
 UPDATE CORP_ETL_CONTROL
  SET VALUE = '05:00:00'
 WHERE NAME = 'PL_SCHEDULE_END'; 
UPDATE CORP_ETL_CONTROL
  SET VALUE = '23:59:59'
 WHERE NAME = 'PL_SCHEDULE_END';
  
INSERT INTO CORP_ETL_JOB_STATISTICS
(
JOB_ID,
JOB_NAME,
JOB_STATUS_CD,
JOB_START_DATE,
JOB_END_DATE
)
VALUES 
(
SEQ_JOB_ID.NEXTVAL,
'Process_Letters_runall',
'COMPLETED',
TO_DATE('2016/12/25','YYYY/MM/DD'),
TO_DATE('2016/12/25','YYYY/MM/DD')
);
COMMIT;