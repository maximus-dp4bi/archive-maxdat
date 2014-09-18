update cc_c_contact_queue
set queue_type='Outbound'
,unit_of_work_name='ES Outbound'
where queue_number in (5040
,5734
,5735
);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','105','105_UPDATE_ES_OUTBOUND_QUEUES_CC_C_CONTACT_QUEUE');

commit;
