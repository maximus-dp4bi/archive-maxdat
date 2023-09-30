
/*select * from CC_D_ACTIVITY_TYPE
where activity_type_name in (
'Health and Safety Audit',
'I/EDR Case Note',
'Employee Survey'
);

select * from CC_C_ACTIVITY_TYPE
where activity_type_name in (
'Health and Safety Audit',
'I/EDR Case Note',
'Employee Survey'
);*/



update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY ='Other Not Ready' ,IS_PAID_FLAG=1 , IS_AVAILABLE_FLAG=0 ,IS_READY_FLAG=0 ,IS_ABSENCE_FLAG=0  where ACTIVITY_TYPE_NAME= 'Health and Safety Audit';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY ='Other Not Ready' ,IS_PAID_FLAG=1 , IS_AVAILABLE_FLAG=0 ,IS_READY_FLAG=0 ,IS_ABSENCE_FLAG=0  where ACTIVITY_TYPE_NAME= 'I/EDR Case Note';
update cc_c_activity_type set ACTIVITY_TYPE_CATEGORY ='Other Not Ready' ,IS_PAID_FLAG=1 , IS_AVAILABLE_FLAG=0 ,IS_READY_FLAG=0 ,IS_ABSENCE_FLAG=0  where ACTIVITY_TYPE_NAME= 'Employee Survey';

commit;

update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY ='Other Not Ready' ,IS_PAID_FLAG=1 , IS_AVAILABLE_FLAG=0 ,IS_READY_FLAG=0 ,IS_ABSENCE_FLAG=0  where ACTIVITY_TYPE_NAME= 'Health and Safety Audit';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY ='Other Not Ready' ,IS_PAID_FLAG=1 , IS_AVAILABLE_FLAG=0 ,IS_READY_FLAG=0 ,IS_ABSENCE_FLAG=0  where ACTIVITY_TYPE_NAME= 'I/EDR Case Note';
update cc_d_activity_type set ACTIVITY_TYPE_CATEGORY ='Other Not Ready' ,IS_PAID_FLAG=1 , IS_AVAILABLE_FLAG=0 ,IS_READY_FLAG=0 ,IS_ABSENCE_FLAG=0  where ACTIVITY_TYPE_NAME= 'Employee Survey';

commit;


