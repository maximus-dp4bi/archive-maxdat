
--  UPDATE UNIT OF WORK IN CONTACT QUEUE CONFIGURATION TABLE
update cc_c_contact_queue
set unit_of_work_name = 'WebChat'
where queue_name = 'Webchat';

--  UPDATE UNIT OF WORK IN CONTACT QUEUE STAGING TABLE
update cc_s_contact_queue
set unit_of_work_id = (
  select unit_of_work_id
  from cc_c_unit_of_work
  where unit_of_work_name = 'WebChat'
)
where queue_name = 'Webchat';

--  UPDATE UNIT OF WORK IN FACT TABLE 
update cc_f_actuals_queue_interval
set d_unit_of_work_id = (
    select uow_id
    from cc_d_unit_of_work
    where unit_of_work_name = 'WebChat'
)
where d_contact_queue_id = (
  select d_contact_queue_id
  from cc_d_contact_queue 
  where queue_name = 'Webchat'
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.7','100','100_UPDATE_WEBCHAT_UNIT_OF_WORK');

COMMIT;
