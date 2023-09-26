insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_FILE_START_DATE','D','2017/08/21 00:00:00','Start date parameter for the Redetermination Daily Status File', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_FILE_END_DATE','D','2017/08/21 23:59:59','Start date parameter for the Redetermination Daily Status File', sysdate, sysdate);


insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_FILE_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_LTR_START_DATE','D','2017/08/21 00:00:00','Start date parameter for the Redetermination Daily Status File', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_LTR_END_DATE','D','2017/08/21 23:59:59','Start date parameter for the Redetermination Daily Status File', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_CK_START_DATE','D','2017/08/21 00:00:00','Start date parameter for the Redetermination Daily Status File', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_CK_END_DATE','D','2017/08/21 23:59:59','Start date parameter for the Redetermination Daily Status File', sysdate, sysdate);


insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_FILE_INITIAL_RUN','V','N','Valid values Y for Initial Run, N for daily run.  Indicates whether the report should list all redetermination status file records or for specific date range only', sysdate, sysdate);


insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_FILE_TEXT_FILENAME','V','rMAX_redetdailystat','Filename for the text file output for daily reporting', sysdate, sysdate);  

insert into CORP_ETL_CONTROL
values ('REDETDLYSTAT_FILE_XLS_FILENAME','V','rMAX_redetdailystat','Filename for the text file output for daily reporting', sysdate, 
sysdate); 


commit;