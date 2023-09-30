--Update Contact queue configuration for WebChat Kokua queue

UPDATE cc_c_contact_queue
SET queue_type = 'Web Chat'
,unit_of_work_name = 'WebChat Kokua'
WHERE queue_name='Webchat_Kokua';

--Update contact queue dimension for WebChat Kokua queue

UPDATE cc_d_contact_queue
SET queue_type = 'Web Chat' 
WHERE queue_name='Webchat_Kokua';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.5','100','100_UPDATE_CONTACT_QUEUE');

COMMIT;