insert into CORP_ETL_CONTROL
values ('ADDRESSCHANGE_RPT_START_DATE','D','2015/10/01','Start date parameter for the Address Change Report', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('ADDRESSCHANGE_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('ADDRESSCHANGE_INITRUN','V','Y','Valid values Y for Initial Run, N for daily run.  Indicates whether the report should list all active addresses or address changes for specific date range only', sysdate, sysdate);

commit;