insert into CORP_ETL_CONTROL
values ('REFEXTRACT_RPT_START_DATE','D','2015/10/01','Start date parameter for the Referral Extract Report', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('REFEXTRACT_MOVE_OR_REVIEW','V','M','Valid values R for Review, M for MoveIt.  Indicates whether the file should be moved directly to moveit folder or to be reviewed', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('REFEXTRACT_INITIAL_RUN','V','Y','Valid values Y for Initial Run, N for daily run.  Indicates whether the report should list all referrals or for specific date range only', sysdate, sysdate);

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
,'HCFA_REFERRAL_TASKS'
,'HCFA_REFERRAL_TASKS'
,'Referral Tasks'
,'''Voluntary Terminations'',''LTSS+'',''Other Non-MAGI+'',''MSP Only'',''Medically Eligible Review'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;


insert into CORP_ETL_CONTROL
values ('REFEXTRACT_RUN_OLD_LOGIC','V','Y','Valid values for running old code is Y/N.  Indicates whether the report should get data from the old table or not', sysdate, sysdate);
 insert into CORP_ETL_CONTROL
values ('REFEXTRACT_OLD_RPT_START_DATE','D','2017/10/07 00:00:00','Start date parameter for the Referral Extract Report', sysdate, sysdate);
 

commit;