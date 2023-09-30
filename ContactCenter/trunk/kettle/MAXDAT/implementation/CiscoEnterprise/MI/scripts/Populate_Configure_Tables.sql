/*
Created by Raj A on 02/03/2016.
Description: Populating the config tables per the document (MI MAXDAT Contact Center Configuration_Cisco Enterprise_v2.0)
As the UOW_ID is populated by a sequence in each environment, UOW_ID will be different in dev, uat and prd; so does 
this script too.
*/
INSERT INTO CC_C_IVR_CALL_RESULT 
(C_IVR_CALL_RES_ID, COMPLETION_CODE, COUNT_CREATED, COUNT_OFFERED_TO_ACD, COUNT_CONTAINED)
values (1, 'H','Y','N','Y');
INSERT INTO CC_C_IVR_CALL_RESULT 
(C_IVR_CALL_RES_ID, COMPLETION_CODE, COUNT_CREATED, COUNT_OFFERED_TO_ACD, COUNT_CONTAINED)
values (2, 'N','Y','N','Y');
INSERT INTO CC_C_IVR_CALL_RESULT 
(C_IVR_CALL_RES_ID, COMPLETION_CODE, COUNT_CREATED, COUNT_OFFERED_TO_ACD, COUNT_CONTAINED)
values (3, 'T','Y','Y','N');
INSERT INTO CC_C_IVR_CALL_RESULT 
(C_IVR_CALL_RES_ID, COMPLETION_CODE, COUNT_CREATED, COUNT_OFFERED_TO_ACD, COUNT_CONTAINED)
values (4, 'C','Y','N','Y');
commit;

--2300	Healthcare Helpline
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2300,
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Healthcare Helpline' )
);
--2324	Phone App
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2324, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Phone App' )
 );
--2302	Phone App
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2302, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Phone App' )
);
--2871	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2871, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
 );
--2872	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2872, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
);
--2873	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2873, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
 );
--2874	Enrolls
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2874, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Enrolls' )
);
--2303	Beneficiary Helpline
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval, 
2303, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'Beneficiary Helpline' )
 );
--4246	MIChild
insert into CC_C_IVR_DNIS
(C_DNIS_UOW_ID, DESTINATION_DNIS, UOW_ID)
values (
SEQ_CC_C_IVR_DNIS.nextval,
4246, 
(SELECT uow_id FROM CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK WHERE unit_of_work_name = 'MIChild' )
);
commit;

UPDATE CISCO_ENTERPRISE_CC.CC_D_UNIT_OF_WORK
   SET IVR = 1
 WHERE unit_of_work_name IN  
(
'Phone App',  --24
'Healthcare Helpline',  --61
'Enrolls', --63
'Beneficiary Helpline', --62
'MIChild' --64
);   
COMMIT;