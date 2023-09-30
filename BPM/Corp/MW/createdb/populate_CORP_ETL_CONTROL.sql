/*
Created on 13-Oct-2017 by Guy T.
Description: Created for MW Rel 6 

*/
set define off;

insert into CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) 
values ('MW_LOAD_START_DATE', 'D', '2014/09/1 00:00:00', 'Variable used to load MW tasks based on create date.',sysdate,sysdate);

insert into CORP_ETL_CONTROL (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS) 
values ('MW_LOAD_END_DATE', 'D', '2014/09/30 00:00:00', 'Variable used to load MW tasks based on create date.',sysdate,sysdate);

-- Mismatched task status update for NYEC and NYHIX.
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) 
values ('MW_BATCH_MISMATCH_LAST_UPDATE','D',TO_CHAR(SYSDATE-1,'YYYY/MM/DD'),'Last date the MW Task status mismatch job ran (format YYYY/MM/DD). Initially scheduled every week on Sunday.');

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION) 
values ('MW_BATCH_MISMATCH_DAY','V','MON, TUE, WED, THU, FRI, SAT, SUN','Batch scheduled to run only during the weekend. This control originally set for SAT and SUN.');

insert into CORP_ETL_CONTROL
values ('MW_SCHEDULE_START','V','00:00:00','MW ETL to run once daily. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MW_SCHEDULE_END','V','11:00:00','MW ETL to run once daily. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('DELTEK_FILENAME','V','<Name of Deltek Input file>','Name of DELTEK extract file to load.', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('DELTEK_INPUT_DIR','V','<Name of Deltek Input file Directory>','Name of DELTEK extract file Directory.', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('DELTEK_DATE_FORMAT','V','<DELTEK Date Format>','Format for Date fields in Deltek File.', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('DELTEK_INPUT_ARCHIVE_DIR','V','<Name of Deltek Input file Archive Directory>','Name of DELTEK extract file Archive Directory.', sysdate, sysdate);

INSERT INTO CORP_ETL_CONTROL 
SELECT  'MAX_UPDATE_TS_INCIDENT_ERROR_REASON' 
,'V'
,to_char((SYSDATE - 180),'YYYY/MM/DD HH24:MI:SS')
,'Max Incident Error Reason Timestamp'
,SYSDATE
,SYSDATE
 FROM DUAL;

INSERT INTO CORP_ETL_CONTROL 
SELECT  'MAX_UPDATE_TS_INCIDENT_STTAUS_HIST' INC_CNTRL_NAME
,'V'
,to_char((SYSDATE - 180),'YYYY/MM/DD HH24:MI:SS')
,'Max Incident Status Timestamp'
,SYSDATE
,SYSDATE
 FROM DUAL;

INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'LOOK_BACK_INCIDENT_STATUS_HIST'
    , 'N'
    , '1'
    , 'Number of days to look back'
    , to_date ('2015-06-24 16:06:22', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2015-06-24 16:06:22', 'YYYY-MM-DD HH24:MI:SS')
    );
    
INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'STEP_INST_HIST_MISSING_REC_LOOKBACK'
    , 'N'
    , '30000'
    , 'Used to set number of task history to look back and catch missing records '
    , to_date ('2013-09-12 10:54:42', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2014-04-21 18:45:15', 'YYYY-MM-DD HH24:MI:SS')
    );

INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'STP_INST_CORRECTION_DAYS'
    , 'N'
    , '2.0'
    , 'Number of days to look backward and forward for corrections. Program can handle fractional day(s). I.e, 1.5 or 3.5. Default is 2 days.'
    , to_date ('2014-04-21 18:45:15', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2014-04-21 18:45:15', 'YYYY-MM-DD HH24:MI:SS')
    );

INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'STP_INST_CORRECTION_END_DATE'
    , 'D'
    , '2017/10/19'
    , 'Set to the date of the last correction process or any day you wish to check, you can span multiple days if needed'
    , to_date ('2014-04-21 18:45:15', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2017-10-19 00:09:30', 'YYYY-MM-DD HH24:MI:SS')
    );

INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'STP_INST_CORRECTION_START_DATE'
    , 'D'
    , '2017/10/19'
    , 'Set to the date of the last correction process or any day wishing to check. Cannot be same as system date. Double-check kettle handles this.'
    , to_date ('2014-04-21 18:45:15', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2017-10-19 00:09:30', 'YYYY-MM-DD HH24:MI:SS')
    );

INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'MW_LAST_STEP_INST_HIST_ID'
    , 'N'
    , '6918707'
    , 'Used to fetch task history records from OLTP for MW process'
    , to_date ('2013-09-12 10:54:42', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2015-01-16 12:13:58', 'YYYY-MM-DD HH24:MI:SS')
    );

------------------------
INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'LETTERS_LAST_UPDATE_DATE'
    , 'D'
    , '2017/10/19 16:42:57'
    , 'This is the timestamp of the letter_request.update_ts from the previous run. update_ts of the most recent letter record from the previous run.'
    , to_date ('2014-07-17 18:03:54', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2017-10-19 17:07:34', 'YYYY-MM-DD HH24:MI:SS')
    );

INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'LETTERS_STG_LOOK_BACK_DAYS'
    , 'N'
    , '2'
    , 'Number of days to look back when inserting/updating letters so records will not be missed'
    , to_date ('2015-03-10 17:53:02', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2015-03-10 17:53:02', 'YYYY-MM-DD HH24:MI:SS')
    );

------------------
INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'MAX_UPDATE_TS_NOTE'
    , 'D'
    , '2017/10/19 16:14:14'
    , 'Max Update Date for the D_NOTE table'
    , to_date ('2015-03-12 13:24:01', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2017-10-19 18:00:49', 'YYYY-MM-DD HH24:MI:SS')
    );

INSERT INTO CORP_ETL_CONTROL
    (
    NAME
    , VALUE_TYPE
    , VALUE
    , DESCRIPTION
    , CREATED_TS
    , UPDATED_TS
    )
VALUES
    (
    'HIGH_LIMIT_TASK_HISTORY_ID'
    , 'N'
    , '999999999'
    , 'Used to set task history High limit, rarely used'
    , to_date ('2013-09-12 10:54:42', 'YYYY-MM-DD HH24:MI:SS')
    , to_date ('2013-09-12 10:54:42', 'YYYY-MM-DD HH24:MI:SS')
    );


commit;
