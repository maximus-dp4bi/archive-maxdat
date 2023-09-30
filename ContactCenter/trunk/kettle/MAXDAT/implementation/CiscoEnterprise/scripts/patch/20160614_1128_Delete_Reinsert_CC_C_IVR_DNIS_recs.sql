/*
Created on 06/14/2016 by Raj A.
Description:  *** For deployment to UAT only ***
MAXDAT-3655 deployed configuration to UAT but it did not yet have all the needed config at the time.
Now, UAT has the config. So, deleting and re-inserting the CC_C_IVR_DNIS records.
*/
alter session set current_schema = CISCO_ENTERPRISE_CC;

DELETE CC_C_IVR_DNIS
WHERE c_dnis_uow_id IN (68,67,66,65,64,63,62,61);
COMMIT;

insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4091, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='CCC IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4092, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='Medallion IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4093, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB Test') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4094, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4095, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4096, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4097, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (SEQ_CC_C_IVR_DNIS.nextval, 4098, (SELECT UOW_ID FROM cc_d_unit_of_work WHERE unit_of_work_name ='VAEB IVR') );
COMMIT;