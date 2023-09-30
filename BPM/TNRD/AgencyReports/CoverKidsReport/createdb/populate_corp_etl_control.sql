insert into CORP_ETL_CONTROL
values ('COVERKIDS_RPT_START_DATE','D','2015/10/01 00:00:00','Start date parameter for the CoverKids Report', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('COVERKIDS_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('COVERKIDS_INITIAL_RUN','V','N','Valid values Y for Initial Run, N for daily run.  Indicates whether the report should list all coverkids approvals or for specific date range only', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('COVERKIDS_WKLY_RPT_START_DATE','D','2015/10/01 00:00:00','Start date parameter for the CoverKids Cumulative Report', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('COVERKIDS_WKLY_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the Cumulative report should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);         

insert into CORP_ETL_CONTROL
values ('COVERKIDS_TEXT_FILENAME','V','CoverKids_Records','Filename for the text file output for daily reporting', sysdate, sysdate);  

insert into CORP_ETL_CONTROL
values ('COVERKIDS_XLS_FILENAME','V','CoverKidsReport','Filename for the text file output for daily reporting', sysdate, 
sysdate); 

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


insert into CORP_ETL_CONTROL
values ('COVERKIDS_AGGR_RPT_END_DATE','D','2017/05/19 23:00:00','Start date parameter for the CoverKids Cumulative Report', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('COVERKIDS_AGE19_TEXT_FILENAME','V','CoverKids_Age19_Records','Filename for the text file output for daily reporting', sysdate, sysdate);  

insert into CORP_ETL_CONTROL
values ('COVERKIDS_AGE19_XLS_FILENAME','V','CoverKidsReport-Ageout','Filename for the text file output for daily reporting', sysdate, 
sysdate); 


commit;