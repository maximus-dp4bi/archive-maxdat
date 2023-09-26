insert into CORP_ETL_CONTROL
values ('RFIFILE_AUDIT_RPT_START_DATE','D','2015/10/01','Start date parameter for the RFI File Audit Report', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('RFIFILE_AUDIT_RPT_END_DATE','D','2015/10/31','End date parameter for the RFI File Audit Report', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('RFIFILE_AUDIT_MOVE_OR_REVIEW','V','R','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);

commit;