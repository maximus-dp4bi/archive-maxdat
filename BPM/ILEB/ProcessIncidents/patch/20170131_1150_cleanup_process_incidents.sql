/*
Created on 01/31/2017 by Raj A.
per ILEB-6353, cleaning up Process incidents Stage tables.
As the volume is very low in ILEBUAT, not setting global controls; just cleaning old data (coming from ilebstby data)
*/

TRUNCATE TABLE CORP_ETL_PROCESS_INCIDENTS;
TRUNCATE TABLE PROCESS_INCIDENTS_OLTP;
TRUNCATE TABLE PROCESS_INCIDENTS_WIP_BPM;
TRUNCATE TABLE F_PI_BY_DATE;
ALTER TABLE F_PI_BY_DATE DISABLE CONSTRAINT FPIBD_DPICUR_FK;
TRUNCATE TABLE D_PI_CURRENT;
ALTER TABLE F_PI_BY_DATE ENABLE CONSTRAINT FPIBD_DPICUR_FK;

DELETE BPM_UPDATE_EVENT_QUEUE WHERE BSL_ID = 10;
DELETE BPM_UPDATE_EVENT_QUEUE_ARCHIVE where BSL_ID = 10;

COMMIT;