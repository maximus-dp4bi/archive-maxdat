update cc_d_activity_type
set ACTIVITY_TYPE_CATEGORY='Working Contact'
where ACTIVITY_TYPE_NAME='ES CHIP Outbound';

update cc_c_activity_type
set ACTIVITY_TYPE_CATEGORY='Unscheduled PTO'
where ACTIVITY_TYPE_NAME='Unscheduled Absence';

update cc_c_activity_type
set IS_READY_FLAG=1
where ACTIVITY_TYPE_NAME='ES CHIP Outbound';

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.1','104','104_UPDATE_CC_C&CC_D_ACTIVITY_TYPE');

commit;