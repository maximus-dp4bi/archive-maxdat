ALTER TABLE corp_etl_mw modify case_id VARCHAR2(20 CHAR);
ALTER TABLE corp_etl_mw_wip modify case_id VARCHAR2(20 CHAR);
ALTER TABLE GTT_MW_TASK_INSTANCE modify case_id VARCHAR2(20 CHAR);

alter table corp_etl_mw add (ROLE VARCHAR2(50 BYTE));
alter table corp_etl_mw_wip add (ROLE VARCHAR2(50 BYTE));
alter table GTT_MW_TASK_INSTANCE add (ROLE VARCHAR2(50 BYTE));

alter table corp_etl_mw add (PART VARCHAR2(255 BYTE));
alter table corp_etl_mw_wip add (PART VARCHAR2(255 BYTE));
alter table GTT_MW_TASK_INSTANCE add (PART VARCHAR2(255 BYTE));

alter table corp_etl_mw add (RECEIVED_DATE date);
alter table corp_etl_mw_wip add (RECEIVED_DATE date);
alter table GTT_MW_TASK_INSTANCE add (RECEIVED_DATE date);


alter table corp_etl_mw add (last_action_end_date date);
alter table corp_etl_mw_wip add (last_action_end_date date);
alter table GTT_MW_TASK_INSTANCE add (last_action_end_date date);

--------------------------------------------------------
alter table D_MW_TASK_INSTANCE add (appeal_stage NUMBER(10, 0));

alter table D_MW_TASK_INSTANCE add (task_claimed_time NUMBER);
alter table D_MW_TASK_INSTANCE add (task_unclaimed_time NUMBER);
alter table D_MW_TASK_INSTANCE add (previous_task_type_id NUMBER);
alter table D_MW_TASK_INSTANCE add (non_standard_work_flag varchar(1));