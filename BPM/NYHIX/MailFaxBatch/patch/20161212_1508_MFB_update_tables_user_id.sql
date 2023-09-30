alter table corp_etl_mfb_batch_oltp add (aspb_validate_data_user_id varchar2(32));
alter table corp_etl_mfb_batch add (aspb_validate_data_user_id varchar2(32));
alter table corp_etl_mfb_batch_stg add (aspb_validate_data_user_id varchar2(32));
alter table corp_etl_mfb_batch_wip add (aspb_validate_data_user_id varchar2(32));
alter table d_mfb_current add (validate_data_perf_by_user_id varchar2(32));
alter table corp_etl_mfb_batch_events_oltp add (user_id varchar2(32));
alter table corp_etl_mfb_batch_events add (user_id varchar2(32));
alter table corp_etl_mfb_batch_events_stg add (user_id varchar2(32));
alter table corp_etl_mfb_batch_events_wip add (user_id varchar2(32));


Commit;
