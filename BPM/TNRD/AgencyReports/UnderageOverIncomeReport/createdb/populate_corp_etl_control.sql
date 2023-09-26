insert into CORP_ETL_CONTROL
values ('UNDERAGE_OI_RPT_START_DATE','D','2015/10/01 00:00:00','Start date parameter for the Underage but Denied for Over Income Report', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('UNDERAGE_OI_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'OVER_INCOME_DENIAL_REASONS'
,'OVER_INCOME_DENIAL_REASONS'
,'Various Over Income denial reasons'
,'''OVER_INCOME_TRUST'',''OVER_INCOME_QDWI'',''OVER_INCOME_QI1'',''OVER_INCOME_QMB'',''OVER_INCOME'',''OVER_INCOME_SLMB'',''OVER_INCOME_MED'',''OVER_INCOME_CHIP'',''OVER_INCOME_NON'',''OVER_INCOME_STD'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

commit;
