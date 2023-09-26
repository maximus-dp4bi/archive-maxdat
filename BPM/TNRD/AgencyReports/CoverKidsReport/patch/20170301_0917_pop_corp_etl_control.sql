
DELETE FROM corp_etl_control
WHERE name IN('COVERKIDS_WKLY_XLS_FILENAME','COVERKIDS_WKLY_TEXT_FILENAME');

insert into CORP_ETL_CONTROL
values ('COVERKIDS_WKLY_XLS_FILENAME','V','CoverKidsWeeklyReport','Filename for the text file output for Cumulative 
reporting', sysdate, sysdate);  

insert into CORP_ETL_CONTROL
values ('COVERKIDS_WKLY_TEXT_FILENAME','V','CoverKids_Weekly_Records','Filename for the text file output for Cumulative reporting', sysdate, sysdate);  


insert into CORP_ETL_CONTROL
values ('COVERKIDS_WKLY_RPT_END_DATE','D','2015/10/01 00:00:00','Start date parameter for the CoverKids Cumulative Report', sysdate, sysdate);


insert into CORP_ETL_CONTROL
values ('COVERKIDS_AGGR_XLS_FILENAME','V','CoverKidsCumulativeReport','Filename for the text file output for Cumulative 
reporting', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('COVERKIDS_AGGR_TEXT_FILENAME','V','CoverKids_Cumulative_Records','Filename for the text file output for Cumulative reporting', sysdate, sysdate);  

insert into CORP_ETL_CONTROL
values ('COVERKIDS_AGGR_RPT_START_DATE','D','2015/10/01 00:00:00','Start date parameter for the CoverKids Cumulative Report', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('COVERKIDS_AGGR_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the Cumulative report should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);         

commit;