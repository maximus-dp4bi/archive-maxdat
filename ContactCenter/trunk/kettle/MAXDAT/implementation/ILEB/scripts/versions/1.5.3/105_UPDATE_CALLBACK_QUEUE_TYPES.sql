update CC_C_CONTACT_QUEUE set queue_type='Outbound' where queue_number in(10014,10015);

update CC_D_CONTACT_QUEUE set queue_type='Outbound' where queue_number in(10014,10015);

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('1.5.3','105','105_UPDATE_CALLBACK_QUEUE_TYPES');

commit;


