insert into CORP_ETL_CONTROL
values ('LTSSMSP_RPT_START_DATE','D','2018/01/03 00:00:00','Start date parameter for the LTSS MSP Report', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('LTSSMSP_RPT_END_DATE','D','2018/01/03 23:59:59','End date parameter for the LTSS MSP Report', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('LTSSMSP_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('LTSSMSP_INITIAL_RUN','V','Y','Valid values Y for Initial Run, N for daily run.  Indicates whether the report should list all referrals or for specific date range only', sysdate, sysdate);

commit;